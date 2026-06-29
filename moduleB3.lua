-- Module B3: NamingPanel + Vignette + Blur + Highlight

local PaintHolder = PaintHolder
local UI = UI
local Lighting = Lighting
local ReplicatedStorage = ReplicatedStorage

-- Naming Panel
local NamingPanel = Instance.new("Frame", PaintHolder)
NamingPanel.AnchorPoint = Vector2.new(0.5,0.5)
NamingPanel.BackgroundColor3 = Color3.fromRGB(29, 30, 42)
NamingPanel.Position = UDim2.new(0.5,0,-0.5,0)
NamingPanel.Size = UDim2.new(0,300,0,76)

local UICorner = Instance.new("UICorner", NamingPanel)
UICorner.CornerRadius = UDim.new(0,8)

local UIPadding = Instance.new("UIPadding", NamingPanel)
UIPadding.PaddingBottom = UDim.new(0,4)
UIPadding.PaddingLeft = UDim.new(0,4)
UIPadding.PaddingRight = UDim.new(0,4)
UIPadding.PaddingTop = UDim.new(0,4)

-- Buttons Holder
local ButtonsHolder = Instance.new("Frame", NamingPanel)
ButtonsHolder.AnchorPoint = Vector2.new(0,1)
ButtonsHolder.BackgroundTransparency = 1
ButtonsHolder.Position = UDim2.new(0,0,1,0)
ButtonsHolder.Size = UDim2.new(1,0,0,32)

local UIListLayout = Instance.new("UIListLayout", ButtonsHolder)
UIListLayout.Padding = UDim.new(0,4)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal

-- Confirm Button
local NamingConfirmButton = Instance.new("ImageButton", ButtonsHolder)
NamingConfirmButton.BackgroundColor3 = Color3.fromRGB(76, 107, 255)
NamingConfirmButton.Size = UDim2.new(0.5,-2,1,0)
NamingConfirmButton.ImageTransparency = 1
NamingConfirmButton.AutoButtonColor = false

local UICorner2 = Instance.new("UICorner", NamingConfirmButton)
UICorner2.CornerRadius = UDim.new(0,4)

local Title = Instance.new("TextLabel", NamingConfirmButton)
Title.AnchorPoint = Vector2.new(0.5,0.5)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5,0,0.5,0)
Title.Size = UDim2.new(0.6,0,0.6,0)
Title.Text = "Confirm"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true

-- Cancel Button
local NamingCancelButton = Instance.new("ImageButton", ButtonsHolder)
NamingCancelButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
NamingCancelButton.Size = UDim2.new(0.5,-2,1,0)
NamingCancelButton.ImageTransparency = 1
NamingCancelButton.AutoButtonColor = false

local UICorner3 = Instance.new("UICorner", NamingCancelButton)
UICorner3.CornerRadius = UDim.new(0,4)

local Title2 = Instance.new("TextLabel", NamingCancelButton)
Title2.AnchorPoint = Vector2.new(0.5,0.5)
Title2.BackgroundTransparency = 1
Title2.Position = UDim2.new(0.5,0,0.5,0)
Title2.Size = UDim2.new(0.6,0,0.6,0)
Title2.Text = "Cancel"
Title2.Font = Enum.Font.SourceSansBold
Title2.TextColor3 = Color3.fromRGB(0,0,0)
Title2.TextScaled = true

-- Naming TextBox
local TextBoxHolder = Instance.new("Frame", NamingPanel)
TextBoxHolder.BackgroundColor3 = Color3.fromRGB(35, 36, 49)
TextBoxHolder.Size = UDim2.new(1,0,0,32)

local UICorner4 = Instance.new("UICorner", TextBoxHolder)
UICorner4.CornerRadius = UDim.new(0,4)

local NamingTextBox = Instance.new("TextBox", TextBoxHolder)
NamingTextBox.ClipsDescendants = true
NamingTextBox.BackgroundTransparency = 1
NamingTextBox.ClearTextOnFocus = false
NamingTextBox.AnchorPoint = Vector2.new(0.5,0.5)
NamingTextBox.Position = UDim2.new(0.5,0,0.5,0)
NamingTextBox.Size = UDim2.new(1,-16,0,14)
NamingTextBox.Font = Enum.Font.SourceSansBold
NamingTextBox.PlaceholderText = "Enter Name Here..."
NamingTextBox.TextColor3 = Color3.fromRGB(255,255,255)
NamingTextBox.TextXAlignment = Enum.TextXAlignment.Left
NamingTextBox.TextSize = 14
NamingTextBox.Text = ""

-- Screen Vignette
local screenVignette = Instance.new("ImageLabel", UI)
screenVignette.ZIndex = -1
screenVignette.BackgroundTransparency = 1
screenVignette.ImageTransparency = 1
screenVignette.Size = UDim2.new(1,0,1,0)
screenVignette.Image = "rbxassetid://18720210000"

-- Blur Effect
local BlurEffect = Instance.new("BlurEffect", Lighting)
BlurEffect.Size = 0

-- Highlight + Pixel Folder
local highlight = Instance.new("Highlight", workspace)
local pixelFolder = Instance.new("Model", workspace)

highlight.DepthMode = Enum.HighlightDepthMode.Occluded
highlight.Adornee = pixelFolder
highlight.FillColor = Color3.fromRGB(50,50,50)
highlight.FillTransparency = 0.2

-- Export references
return {
    NamingPanel = NamingPanel,
    NamingConfirmButton = NamingConfirmButton,
    NamingCancelButton = NamingCancelButton,
    NamingTextBox = NamingTextBox,
    screenVignette = screenVignette,
    BlurEffect = BlurEffect,
    highlight = highlight,
    pixelFolder = pixelFolder
}
