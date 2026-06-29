-- Module B2: PaintBar + Paint/Erase/Area/Confirm Buttons

local PaintHolder = PaintHolder
local TweenService = TweenService
local gradients = gradients

-- PaintBar container
local PaintBar = Instance.new("Frame", PaintHolder)
PaintBar.AnchorPoint = Vector2.new(0.5,1)
PaintBar.BackgroundTransparency = 1
PaintBar.Position = UDim2.new(0.5,0,1.1,0)
PaintBar.Size = UDim2.new(0,0,0,0)

local UIListLayout = Instance.new("UIListLayout", PaintBar)
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ButtonsHolder (container for paint/erase/area buttons)
local ButtonsHolder = Instance.new("Frame", PaintBar)
ButtonsHolder.BackgroundColor3 = Color3.fromRGB(29,30,42)
ButtonsHolder.Size = UDim2.new(1,0,1,0)

local UICorner = Instance.new("UICorner", ButtonsHolder)
UICorner.CornerRadius = UDim.new(0,8)

local UIListLayout2 = Instance.new("UIListLayout", ButtonsHolder)
UIListLayout2.Padding = UDim.new(0,4)
UIListLayout2.FillDirection = Enum.FillDirection.Horizontal

local UIPadding = Instance.new("UIPadding", ButtonsHolder)
UIPadding.PaddingBottom = UDim.new(0,4)
UIPadding.PaddingLeft = UDim.new(0,4)
UIPadding.PaddingRight = UDim.new(0,4)
UIPadding.PaddingTop = UDim.new(0,4)

-- Paint Button
local PaintButton = Instance.new("ImageButton", ButtonsHolder)
PaintButton.AutoButtonColor = false
PaintButton.BackgroundColor3 = Color3.fromRGB(35,36,49)
PaintButton.Size = UDim2.new(1,0,1,0)
PaintButton.ImageTransparency = 1

local AspectRatio = Instance.new("UIAspectRatioConstraint", PaintButton)
local UICorner2 = Instance.new("UICorner", PaintButton)
UICorner2.CornerRadius = UDim.new(0,4)

local Icon = Instance.new("ImageLabel", PaintButton)
Icon.AnchorPoint = Vector2.new(0.5,0.5)
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0.5,0,0.5,0)
Icon.Size = UDim2.new(0,30,0,30)
Icon.Image = "rbxassetid://10910211661"

local ShortcutInfo = Instance.new("TextLabel", PaintButton)
ShortcutInfo.BackgroundTransparency = 1
ShortcutInfo.Position = UDim2.new(0,2,0,2)
ShortcutInfo.Size = UDim2.new(0,10,0,10)
ShortcutInfo.Font = Enum.Font.SourceSansBold
ShortcutInfo.Text = "1"
ShortcutInfo.TextColor3 = Color3.fromRGB(255,255,255)
ShortcutInfo.TextScaled = true

-- Erase Button
local EraseButton = Instance.new("ImageButton", ButtonsHolder)
EraseButton.AutoButtonColor = false
EraseButton.BackgroundColor3 = Color3.fromRGB(35,36,49)
EraseButton.Size = UDim2.new(1,0,1,0)
EraseButton.ImageTransparency = 1

local AspectRatio2 = Instance.new("UIAspectRatioConstraint", EraseButton)
local UICorner3 = Instance.new("UICorner", EraseButton)
UICorner3.CornerRadius = UDim.new(0,4)

local Icon2 = Instance.new("ImageLabel", EraseButton)
Icon2.AnchorPoint = Vector2.new(0.5,0.5)
Icon2.BackgroundTransparency = 1
Icon2.Position = UDim2.new(0.5,0,0.5,0)
Icon2.Size = UDim2.new(0,30,0,30)
Icon2.Image = "rbxassetid://16346922164"

local ShortcutInfo2 = Instance.new("TextLabel", EraseButton)
ShortcutInfo2.BackgroundTransparency = 1
ShortcutInfo2.Position = UDim2.new(0,2,0,2)
ShortcutInfo2.Size = UDim2.new(0,10,0,10)
ShortcutInfo2.Font = Enum.Font.SourceSansBold
ShortcutInfo2.Text = "2"
ShortcutInfo2.TextColor3 = Color3.fromRGB(255,255,255)
ShortcutInfo2.TextScaled = true

-- Area Button
local AreaButton = Instance.new("ImageButton", ButtonsHolder)
AreaButton.AutoButtonColor = false
AreaButton.BackgroundColor3 = Color3.fromRGB(35,36,49)
AreaButton.Size = UDim2.new(1,0,1,0)
AreaButton.ImageTransparency = 1

local AspectRatio3 = Instance.new("UIAspectRatioConstraint", AreaButton)
local UICorner4 = Instance.new("UICorner", AreaButton)
UICorner4.CornerRadius = UDim.new(0,4)

local Icon3 = Instance.new("ImageLabel", AreaButton)
Icon3.AnchorPoint = Vector2.new(0.5,0.5)
Icon3.BackgroundTransparency = 1
Icon3.Position = UDim2.new(0.5,0,0.5,0)
Icon3.Size = UDim2.new(0,30,0,30)
Icon3.Image = "rbxassetid://11772695039"

local ShortcutInfo3 = Instance.new("TextLabel", AreaButton)
ShortcutInfo3.BackgroundTransparency = 1
ShortcutInfo3.Position = UDim2.new(0,2,0,2)
ShortcutInfo3.Size = UDim2.new(0,10,0,10)
ShortcutInfo3.Font = Enum.Font.SourceSansBold
ShortcutInfo3.Text = "3"
ShortcutInfo3.TextColor3 = Color3.fromRGB(255,255,255)
ShortcutInfo3.TextScaled = true

-- Confirm Button Holder
local ButtonHolder = Instance.new("Frame", PaintBar)
ButtonHolder.BackgroundColor3 = Color3.fromRGB(29,30,42)
ButtonHolder.Size = UDim2.new(1,0,1,0)

local UICorner5 = Instance.new("UICorner", ButtonHolder)
UICorner5.CornerRadius = UDim.new(0,8)

local UIListLayout3 = Instance.new("UIListLayout", ButtonHolder)
UIListLayout3.Padding = UDim.new(0,4)

local UIPadding3 = Instance.new("UIPadding", ButtonHolder)
UIPadding3.PaddingBottom = UDim.new(0,4)
UIPadding3.PaddingLeft = UDim.new(0,4)
UIPadding3.PaddingRight = UDim.new(0,4)
UIPadding3.PaddingTop = UDim.new(0,4)

local AspectRatio4 = Instance.new("UIAspectRatioConstraint", ButtonHolder)

-- Confirm Button
local ConfirmButton = Instance.new("ImageButton", ButtonHolder)
ConfirmButton.BackgroundColor3 = Color3.fromRGB(35,36,49)
ConfirmButton.Size = UDim2.new(1,0,1,0)
ConfirmButton.ImageTransparency = 1

local UICorner6 = Instance.new("UICorner", ConfirmButton)
UICorner6.CornerRadius = UDim.new(0,4)

local Icon4 = Instance.new("ImageLabel", ConfirmButton)
Icon4.AnchorPoint = Vector2.new(0.5,0.5)
Icon4.BackgroundTransparency = 1
Icon4.Position = UDim2.new(0.5,0,0.5,0)
Icon4.Size = UDim2.new(0,30,0,30)
Icon4.Image = "rbxassetid://12690727184"

return {
    PaintBar = PaintBar,
    PaintButton = PaintButton,
    EraseButton = EraseButton,
    AreaButton = AreaButton,
    ConfirmButton = ConfirmButton,
    ButtonsHolder = ButtonsHolder
}
