-- Module A: Core + Services + Root UI (PlayerGui Patched + Polished)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local playerCountry = LocalizationService:GetCountryRegionForPlayerAsync(player)
local gradients = {}

-- ⭐ ALWAYS parent UI to PlayerGui (fixes Delta overlay + visibility issues)
local UI = Instance.new("ScreenGui")
UI.Name = "PixelPlaceUI"
UI.Parent = player:WaitForChild("PlayerGui")
UI.IgnoreGuiInset = true
UI.ResetOnSpawn = false
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Root Panel Holder
local PanelHolder = Instance.new("Frame", UI)
PanelHolder.AnchorPoint = Vector2.new(0.5,0.5)
PanelHolder.BackgroundTransparency = 1
PanelHolder.Position = UDim2.new(0.5,0,0.5,0)
PanelHolder.Size = UDim2.new(0,800,0,500)

-- Shadow
local PanelShadow = Instance.new("ImageLabel", PanelHolder)
PanelShadow.AnchorPoint = Vector2.new(0.5,0.5)
PanelShadow.BackgroundTransparency = 1
PanelShadow.Position = UDim2.new(0.5,0,0.5,0)
PanelShadow.Size = UDim2.new(1,49,1,49)
PanelShadow.Image = "rbxassetid://6014261993"
PanelShadow.ImageTransparency = 0.5
PanelShadow.ScaleType = Enum.ScaleType.Slice
PanelShadow.SliceCenter = Rect.new(49,49,450,450)

local UIGradient = Instance.new("UIGradient", PanelShadow)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(246,104,0)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(255,149,67)),
}
table.insert(gradients, UIGradient)

-- Main Panel
local Panel = Instance.new("Frame", PanelHolder)
Panel.BackgroundColor3 = Color3.fromRGB(29,30,42)
Panel.Size = UDim2.new(1,0,1,0)
Panel.ZIndex = 2

local UICorner = Instance.new("UICorner", Panel)
UICorner.CornerRadius = UDim.new(0,12)

local UIStroke = Instance.new("UIStroke", Panel)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255,255,255)

local UIGradient2 = Instance.new("UIGradient", UIStroke)
UIGradient2.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(246,104,0)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(255,149,67)),
}
table.insert(gradients, UIGradient2)

-- Bottom Bar
local PanelBottomBar = Instance.new("Frame", Panel)
PanelBottomBar.AnchorPoint = Vector2.new(0,1)
PanelBottomBar.BackgroundColor3 = Color3.fromRGB(20,22,28)
PanelBottomBar.Position = UDim2.new(0,0,1,0)
PanelBottomBar.Size = UDim2.new(1,0,0.05,0)

local UICorner2 = Instance.new("UICorner", PanelBottomBar)
UICorner2.CornerRadius = UDim.new(0,12)

local Bar = Instance.new("Frame", PanelBottomBar)
Bar.BackgroundColor3 = Color3.fromRGB(20,22,28)
Bar.Size = UDim2.new(1,0,0.5,0)
Bar.BorderSizePixel = 0

local v = Instance.new("TextLabel", PanelBottomBar)
v.AnchorPoint = Vector2.new(1,0)
v.BackgroundTransparency = 1
v.Position = UDim2.new(1,-5,0,0)
v.Size = UDim2.new(0.1,0,1,0)
v.Font = Enum.Font.SourceSansBold
v.TextColor3 = Color3.fromRGB(255,255,255)
v.TextSize = 10
v.Text = "v3.0"

local AspectRatio = Instance.new("UIAspectRatioConstraint", v)

-- Sidebar
local PanelSideBar = Instance.new("Frame", Panel)
PanelSideBar.BackgroundColor3 = Color3.fromRGB(20,22,28)
PanelSideBar.Size = UDim2.new(0,50,1,0)
PanelSideBar.ZIndex = 2

local UICorner3 = Instance.new("UICorner", PanelSideBar)
UICorner3.CornerRadius = UDim.new(0,12)

local Bar2 = Instance.new("Frame", PanelSideBar)
Bar2.AnchorPoint = Vector2.new(1,0)
Bar2.BackgroundColor3 = Color3.fromRGB(20,22,28)
Bar2.Size = UDim2.new(0.5,0,1,0)
Bar2.Position = UDim2.new(1,0,0,0)
Bar2.BorderSizePixel = 0

local StatusHolder = Instance.new("Frame", PanelSideBar)
StatusHolder.AnchorPoint = Vector2.new(0.5,1)
StatusHolder.BackgroundColor3 = Color3.fromRGB(29,30,42)
StatusHolder.BackgroundTransparency = 1
StatusHolder.Position = UDim2.new(0.5,0,1,-10)
StatusHolder.Size = UDim2.new(1,-20,1,-20)

local AspectRatio2 = Instance.new("UIAspectRatioConstraint", StatusHolder)

local StatusDot = Instance.new("Frame", StatusHolder)
StatusDot.AnchorPoint = Vector2.new(0.5,0.5)
StatusDot.BackgroundColor3 = Color3.fromRGB(234,73,101)
StatusDot.Position = UDim2.new(0.5,0,0.5,0)
StatusDot.Size = UDim2.new(0.3,0,0.3,0)

local UICorner4 = Instance.new("UICorner", StatusDot)
UICorner4.CornerRadius = UDim.new(1,0)

-- Sidebar Buttons
local SideButtonsHolder = Instance.new("Frame", PanelSideBar)
SideButtonsHolder.AnchorPoint = Vector2.new(0.5,0.5)
SideButtonsHolder.BackgroundTransparency = 1
SideButtonsHolder.Position = UDim2.new(0.5,0,0.5,0)
SideButtonsHolder.Size = UDim2.new(1,-20,1,-20)

local CloseButton = Instance.new("ImageButton", SideButtonsHolder)
CloseButton.BackgroundColor3 = Color3.fromRGB(150,150,150)
CloseButton.Size = UDim2.new(1,0,1,0)
CloseButton.AutoButtonColor = false

local AspectRatio3 = Instance.new("UIAspectRatioConstraint", CloseButton)

local UICorner5 = Instance.new("UICorner", CloseButton)
UICorner5.CornerRadius = UDim.new(1,0)

local UIGradient3 = Instance.new("UIGradient", CloseButton)
UIGradient3.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(246,104,0)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(255,149,67)),
}
table.insert(gradients, UIGradient3)

local CloseButtonInnerCircle = Instance.new("Frame", CloseButton)
CloseButtonInnerCircle.AnchorPoint = Vector2.new(0.5,0.5)
CloseButtonInnerCircle.BackgroundColor3 = Color3.fromRGB(20,22,28)
CloseButtonInnerCircle.Position = UDim2.new(0.5,0,0.5,0)
CloseButtonInnerCircle.Size = UDim2.new(0.8,0,0.8,0)

local AspectRatio4 = Instance.new("UIAspectRatioConstraint", CloseButtonInnerCircle)

local UICorner6 = Instance.new("UICorner", CloseButtonInnerCircle)
UICorner6.CornerRadius = UDim.new(1,0)

local SideButtons = Instance.new("Frame", SideButtonsHolder)
SideButtons.AnchorPoint = Vector2.new(0,0.5)
SideButtons.BackgroundTransparency = 1
SideButtons.Position = UDim2.new(0,0,0.5,0)
SideButtons.Size = UDim2.new(1,0,0.7,0)

local UIListLayout = Instance.new("UIListLayout", SideButtons)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,10)

-- Tabs Area
local Tabs = Instance.new("Frame", Panel)
Tabs.AnchorPoint = Vector2.new(1,0)
Tabs.BackgroundTransparency = 1
Tabs.Position = UDim2.new(1,0,0,0)
Tabs.Size = UDim2.new(1,-50,1,0)

local UIPadding = Instance.new("UIPadding", Tabs)
UIPadding.PaddingBottom = UDim.new(0,5)
UIPadding.PaddingLeft = UDim.new(0,5)
UIPadding.PaddingRight = UDim.new(0,5)
UIPadding.PaddingTop = UDim.new(0,5)

-- ⭐ FIXED GRADIENT (HD + Stretch + Mobile Safe)
local TabBackground = Instance.new("ImageLabel", Tabs)
TabBackground.BackgroundTransparency = 1
TabBackground.Size = UDim2.new(1,0,0,150)
TabBackground.Image = "rbxassetid://13160452107"
TabBackground.ImageTransparency = 0.1
TabBackground.ScaleType = Enum.ScaleType.Stretch

local UICorner7 = Instance.new("UICorner", TabBackground)
UICorner7.CornerRadius = UDim.new(0,7)

-- Top Panel
local PanelTop = Instance.new("Frame", Tabs)
PanelTop.BackgroundTransparency = 1
PanelTop.Position = UDim2.new(0,5,0,5)
PanelTop.Size = UDim2.new(1,-10,0.05,0)

local CountryIndicator = Instance.new("TextLabel", PanelTop)
CountryIndicator.AnchorPoint = Vector2.new(0,0.5)
CountryIndicator.BackgroundTransparency = 1
CountryIndicator.Position = UDim2.new(0,0,0.5,0)
CountryIndicator.Size = UDim2.new(1,-5,1,0)
CountryIndicator.Font = Enum.Font.SourceSansBold
CountryIndicator.Text = "Country: Not Detected"
CountryIndicator.TextSize = 14
CountryIndicator.TextColor3 = Color3.fromRGB(255,255,255)
CountryIndicator.TextXAlignment = Enum.TextXAlignment.Right

-- Search Bar
local SearchBarHolder = Instance.new("Frame", PanelTop)
SearchBarHolder.AnchorPoint = Vector2.new(0.5,0.5)
SearchBarHolder.BackgroundTransparency = 0.6
SearchBarHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
SearchBarHolder.Position = UDim2.new(0.5,0,0.5,0)
SearchBarHolder.Size = UDim2.new(0.2,0,1,0)

local UICorner8 = Instance.new("UICorner", SearchBarHolder)
UICorner8.CornerRadius = UDim.new(1,0)

local SearchBar = Instance.new("TextBox", SearchBarHolder)
SearchBar.AnchorPoint = Vector2.new(0,0.5)
SearchBar.BackgroundTransparency = 1
SearchBar.Position = UDim2.new(0,25,0.5,0)
SearchBar.Size = UDim2.new(1,-35,1,0)
SearchBar.PlaceholderColor3 = Color3.fromRGB(200,200,200)
SearchBar.Font = Enum.Font.SourceSans
SearchBar.PlaceholderText = "Search..."
SearchBar.TextColor3 = Color3.fromRGB(255,255,255)
SearchBar.Text = ""
SearchBar.TextSize = 14
SearchBar.TextXAlignment = Enum.TextXAlignment.Left
SearchBar.ClearTextOnFocus = false
SearchBar.ClipsDescendants = true

local SearchBarIconHolder = Instance.new("Frame", SearchBarHolder)
SearchBarIconHolder.BackgroundTransparency = 1
SearchBarIconHolder.Size = UDim2.new(1,0,1,0)

local SearchBarIcon = Instance.new("ImageLabel", SearchBarIconHolder)
SearchBarIcon.AnchorPoint = Vector2.new(0.5,0.5)
SearchBarIcon.BackgroundTransparency = 1
SearchBarIcon.Size = UDim2.new(0.66,0,0.66,0)
SearchBarIcon.Position = UDim2.new(0.5,0,0.5,0)
SearchBarIcon.Image = "rbxassetid://18195291644"

local AspectRatio5 = Instance.new("UIAspectRatioConstraint", SearchBarIconHolder)

-- User Info
local UserInfo = Instance.new("Frame", PanelTop)
UserInfo.BackgroundTransparency = 1
UserInfo.Size = UDim2.new(0.2,0,1,0)

local UserInfoDisplayName = Instance.new("TextLabel", UserInfo)
UserInfoDisplayName.BackgroundTransparency = 1
UserInfoDisplayName.Position = UDim2.new(0,30,0,0)
UserInfoDisplayName.Size = UDim2.new(1,-30,0.5,0)
UserInfoDisplayName.Font = Enum.Font.SourceSansBold
UserInfoDisplayName.Text = player.DisplayName
UserInfoDisplayName.TextColor3 = Color3.fromRGB(255,255,255)
UserInfoDisplayName.TextSize = 14
UserInfoDisplayName.TextScaled = true
UserInfoDisplayName.TextXAlignment = Enum.TextXAlignment.Left

local UserInfoUsername = Instance.new("TextLabel", UserInfo)
if player.Name == player.DisplayName then
    UserInfoUsername.Visible = false
end

UserInfoUsername.AnchorPoint = Vector2.new(0,1)
UserInfoUsername.BackgroundTransparency = 1
UserInfoUsername.Position = UDim2.new(0,30,1,0)
UserInfoUsername.Size = UDim2.new(1,-30,0.5,0)
UserInfoUsername.Font = Enum.Font.SourceSans
UserInfoUsername.Text = player.Name
UserInfoUsername.TextColor3 = Color3.fromRGB(200,200,200)
UserInfoUsername.TextSize = 14
UserInfoUsername.TextScaled = true
UserInfoUsername.TextXAlignment = Enum.TextXAlignment.Left

local UserInfoIconHolder = Instance.new("Frame", UserInfo)
UserInfoIconHolder.BackgroundTransparency = 1
UserInfoIconHolder.Size = UDim2.new(1,0,1,0)

local AspectRatio6 = Instance.new("UIAspectRatioConstraint", UserInfoIconHolder)

local UserInfoIcon = Instance.new("ImageLabel", UserInfoIconHolder)
UserInfoIcon.AnchorPoint = Vector2.new(0.5,0.5)
UserInfoIcon.BackgroundTransparency = 1
UserInfoIcon.Position = UDim2.new(0.5,0,0.5,0)
UserInfoIcon.Size = UDim2.new(0.8,0,0.8,0)
UserInfoIcon.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

local UICorner9 = Instance.new("UICorner", UserInfoIcon)
UICorner9.CornerRadius = UDim.new(1,0)

-- ⭐ Visibility Protection (prevents other modules from hiding UI)
UI.Enabled = true
PanelHolder.Visible = true
Panel.Visible = true
Tabs.Visible = true

-- Export references
return {
    UI = UI,
    PanelHolder = PanelHolder,
    SideButtons = SideButtons,
    Tabs = Tabs,
    gradients = gradients,
    player = player,
    mouse = mouse,
    ReplicatedStorage = ReplicatedStorage,
    TweenService = TweenService,
    UserInputService = UserInputService,
    Lighting = Lighting,
    TextService = TextService,
    RunService = RunService,
    HttpService = HttpService,
    playerCountry = playerCountry
}
