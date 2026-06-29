-- Module D: Pixel Logic

local HttpService = HttpService
local ReplicatedStorage = ReplicatedStorage
local TweenService = TweenService
local TextService = TextService
local RunService = RunService
local player = player
local pixelFolder = pixelFolder
local savedPixelTable = {}
local PixelTables
local SettingsScrollingFrame

-- Player translation info
local playerTranslationInfo = {
    ["Timezone"] = os.date("%z"),
    ["Locale"] = LocalizationService.SystemLocaleId,
    ["Region"] = playerCountry,
    ["Platform"] = "Computer"
}

local r = math.random(1,2)
if r == 1 then
    playerTranslationInfo.Platform = "Mobile"
end

local executorDataTable = {}

-- Map config
local ConfigsFolder = ReplicatedStorage.Configs
local MapConfig = ConfigsFolder.Map

local chunkSize = MapConfig:GetAttribute("ChunkSize")
local mapSizeInChunks = MapConfig:GetAttribute("MapSizeInChunks")

local mouseHolding = false
local editMode = false
local paintMode = false
local selectedColorID = 0
local order = 1

local buttons = {
    ["PaintButtons"] = {},
    ["CodeButtons"] = {}
}

-- Utility: convert timezone offset
local function convertTimezoneFormat(offset)
    local sign = "+"
    if offset < 0 then
        sign = "-"
        offset = math.abs(offset)
    end

    local hours = math.floor(offset)
    local minutes = math.floor((offset - hours) * 60 + 0.5)

    local timezone = string.format("%s%02d%02d", sign, hours, minutes)
    return timezone
end

-- Utility: get timezone from coordinates
local function getTimezoneFromCoords(lat, long)
    local dst = tonumber(HttpService:JSONDecode(
        game:HttpGet("http://api.geonames.org/timezoneJSON?lat="..lat.."&lng="..long.."&username=account13251")
    )["dstOffset"])
    return convertTimezoneFormat(dst)
end

-- Utility: get country info
local function getCountryInfo(country)
    if string.len(country) == 2 then
        return HttpService:JSONDecode(game:HttpGet("https://restcountries.com/v3.1/alpha/"..country))
    else
        return HttpService:JSONDecode(game:HttpGet("https://restcountries.com/v3.1/name/"..country))
    end
end

-- Send translation info to server
local function sendTranslationInfo(translationInfo)
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SendTranslationInfo"):FireServer(translationInfo)
end

-- Create a new pixel part
local function newPixelPart(roundedPos, colorID)
    local pixelPart = Instance.new("Part", pixelFolder)
    pixelPart.Material = "Glass"
    pixelPart.Transparency = 1
    pixelPart.Anchored = true
    pixelPart.Size = Vector3.new(1,1,1)
    pixelPart.Position = Vector3.new(roundedPos.X, 0.501, roundedPos.Y)

    table.insert(savedPixelTable, {roundedPos.X, roundedPos.Y, colorID})
    return pixelPart
end

-- Refresh scrolling frame canvas size
local function refreshScrollingFrame(scrollingFrame)
    local UIListLayout = scrollingFrame:FindFirstChildWhichIsA("UIListLayout")
    local padding = UIListLayout.Padding.Offset
    local total = 0

    for _, frame in pairs(scrollingFrame:GetChildren()) do
        if frame:IsA("GuiBase") then
            total += frame.AbsoluteSize.Y
            total += padding
        end
    end

    scrollingFrame.CanvasSize = UDim2.new(0,0,0,total - padding)
end

-- Create a new pixel table entry
local function newPixelTable(name, data)
    local savedData = table.clone(data)
    if name == "" then
        name = "New Pixel Table"
    end

    local PixelTable = Instance.new("Frame", PixelTables)
    PixelTable.BackgroundColor3 = Color3.fromRGB(19, 20, 24)
    PixelTable.Size = UDim2.new(1,0,0,40)

    local UICorner = Instance.new("UICorner", PixelTable)
    UICorner.CornerRadius = UDim.new(0,5)

    local UIPadding = Instance.new("UIPadding", PixelTable)
    UIPadding.PaddingBottom = UDim.new(0,5)
    UIPadding.PaddingLeft = UDim.new(0,5)
    UIPadding.PaddingRight = UDim.new(0,5)
    UIPadding.PaddingTop = UDim.new(0,5)

    local TableTitle = Instance.new("TextLabel", PixelTable)
    TableTitle.BackgroundTransparency = 1
    TableTitle.Size = UDim2.new(0.2,0,0.5,0)
    TableTitle.Font = Enum.Font.SourceSansBold
    TableTitle.Text = name
    TableTitle.TextScaled = true
    TableTitle.TextSize = 14
    TableTitle.TextXAlignment = Enum.TextXAlignment.Left
    TableTitle.TextColor3 = Color3.fromRGB(255,255,255)

    local PixelCounter = Instance.new("TextLabel", PixelTable)
    PixelCounter.AnchorPoint = Vector2.new(0,1)
    PixelCounter.BackgroundTransparency = 1
    PixelCounter.Position = UDim2.new(0,0,1,0)
    PixelCounter.Size = UDim2.new(0.2,0,0.5,0)
    PixelCounter.Font = Enum.Font.SourceSans
    PixelCounter.Text = #data.." Pixels"
    PixelCounter.TextScaled = true
    PixelCounter.TextSize = 14
    PixelCounter.TextXAlignment = Enum.TextXAlignment.Left
    PixelCounter.TextColor3 = Color3.fromRGB(200,200,200)

    local ButtonsHolder = Instance.new("Frame", PixelTable)
    ButtonsHolder.AnchorPoint = Vector2.new(1,0)
    ButtonsHolder.BackgroundTransparency = 1
    ButtonsHolder.Position = UDim2.new(1,0,0,0)
    ButtonsHolder.Size = UDim2.new(0,100,1,0)

    local UIListLayout = Instance.new("UIListLayout", ButtonsHolder)
    UIListLayout.Padding = UDim.new(0,5)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

    local EditButton = Instance.new("ImageButton", ButtonsHolder)
    EditButton.BackgroundColor3 = Color3.fromRGB(31,31,31)
    EditButton.Size = UDim2.new(1,0,1,0)
    EditButton.ImageTransparency = 1
    EditButton.AutoButtonColor = false

    local UICorner2 = Instance.new("UICorner", EditButton)
    UICorner2.CornerRadius = UDim.new(0,5)

    local Title = Instance.new("TextLabel", EditButton)
    Title.BackgroundTransparency = 1
    Title.AnchorPoint = Vector2.new(0.5,0.5)
    Title.Position = UDim2.new(0.5,0,0.5,0)
    Title.Size = UDim2.new(0.5,0,0.5,0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Edit"
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.TextScaled = true

    local CopyButton = Instance.new("ImageButton", ButtonsHolder)
    CopyButton.BackgroundColor3 = Color3.fromRGB(153, 8, 255)
    CopyButton.Size = UDim2.new(1,0,1,0)
    CopyButton.ImageTransparency = 1
    CopyButton.AutoButtonColor = false

    local UICorner3 = Instance.new("UICorner", CopyButton)
    UICorner3.CornerRadius = UDim.new(0,5)

    local Title2 = Instance.new("TextLabel", CopyButton)
    Title2.BackgroundTransparency = 1
    Title2.AnchorPoint = Vector2.new(0.5,0.5)
    Title2.Position = UDim2.new(0.5,0,0.5,0)
    Title2.Size = UDim2.new(0.5,0,0.5,0)
    Title2.Font = Enum.Font.SourceSansBold
    Title2.Text = "Copy"
    Title2.TextColor3 = Color3.fromRGB(255,255,255)
    Title2.TextScaled = true

    -- Edit button logic
    EditButton.MouseButton1Down:Connect(function()
        editMode = true
        showPaintBar()

        for _, pixel in pairs(savedData) do
            newPixelPart(Vector2.new(pixel[1], pixel[2]), pixel[3])
        end

        local event
        event = ConfirmButton.MouseButton1Down:Connect(function()
            savedData = table.clone(savedPixelTable)
            PixelCounter.Text = #savedData.." Pixels"
            event:Disconnect()
        end)
    end)

    -- Copy button logic
    CopyButton.MouseButton1Down:Connect(function()
        setclipboard(HttpService:JSONEncode(savedData))
    end)

    refreshScrollingFrame(PixelTables)
end

-- Export everything
return {
    playerTranslationInfo = playerTranslationInfo,
    savedPixelTable = savedPixelTable,
    newPixelPart = newPixelPart,
    refreshScrollingFrame = refreshScrollingFrame,
    newPixelTable = newPixelTable,
    chunkSize = chunkSize,
    mapSizeInChunks = mapSizeInChunks,
    buttons = buttons
}
