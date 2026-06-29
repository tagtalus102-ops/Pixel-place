-- Module B1: PaintHolder + ColorPanel

local UI = UI
local TweenService = TweenService
local ReplicatedStorage = ReplicatedStorage
local gradients = gradients

local PaintHolder = Instance.new("Frame", UI)
PaintHolder.AnchorPoint = Vector2.new(0.5,0.5)
PaintHolder.BackgroundTransparency = 1
PaintHolder.Position = UDim2.new(0.5,0,0.5,0)
PaintHolder.Size = UDim2.new(1,-12,1,-12)

local UIPadding = Instance.new("UIPadding", PaintHolder)
UIPadding.PaddingBottom = UDim.new(0,10)
UIPadding.PaddingLeft = UDim.new(0,10)
UIPadding.PaddingRight = UDim.new(0,10)
UIPadding.PaddingTop = UDim.new(0,10)

local UIPaintStroke = Instance.new("UIStroke", PaintHolder)
UIPaintStroke.Color = Color3.fromRGB(29, 30, 42)
UIPaintStroke.LineJoinMode = Enum.LineJoinMode.Miter
UIPaintStroke.Thickness = 0

local ColorPanel = Instance.new("Frame", PaintHolder)
ColorPanel.AnchorPoint = Vector2.new(0,0.5)
ColorPanel.BackgroundColor3 = Color3.fromRGB(29, 30, 42)
ColorPanel.Position = UDim2.new(-0.5,0,0.5,0)
ColorPanel.Size = UDim2.new(0,100,0,320)

local UICorner = Instance.new("UICorner", ColorPanel)
UICorner.CornerRadius = UDim.new(0,8)

local UIPadding2 = Instance.new("UIPadding", ColorPanel)
UIPadding2.PaddingBottom = UDim.new(0,4)
UIPadding2.PaddingLeft = UDim.new(0,4)
UIPadding2.PaddingRight = UDim.new(0,4)
UIPadding2.PaddingTop = UDim.new(0,4)

local Title = Instance.new("TextLabel", ColorPanel)
Title.AnchorPoint = Vector2.new(0.5,0)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5,0,0,0)
Title.Size = UDim2.new(1,-4,0,16)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Colors"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 14

local ButtonsHolder = Instance.new("Frame", ColorPanel)
ButtonsHolder.AnchorPoint = Vector2.new(0,1)
ButtonsHolder.BackgroundTransparency = 1
ButtonsHolder.Size = UDim2.new(1,-4,0,24)
ButtonsHolder.Position = UDim2.new(0,0,1,0)

local UIListLayout = Instance.new("UIListLayout", ButtonsHolder)
UIListLayout.Padding = UDim.new(0,0)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ColorPickerButton = Instance.new("ImageButton", ButtonsHolder)
ColorPickerButton.BackgroundTransparency = 1
ColorPickerButton.Size = UDim2.new(1,0,1,0)
ColorPickerButton.Image = "rbxassetid://6953984135"

local AspectRatio = Instance.new("UIAspectRatioConstraint", ColorPickerButton)

local ColorPanelScrollingFrame = Instance.new("ScrollingFrame", ColorPanel)
ColorPanelScrollingFrame.AnchorPoint = Vector2.new(0,0.5)
ColorPanelScrollingFrame.BackgroundTransparency = 1
ColorPanelScrollingFrame.Position = UDim2.new(0,0,0.5,-8)
ColorPanelScrollingFrame.Size = UDim2.new(1,0,1,-48)
ColorPanelScrollingFrame.ScrollBarThickness = 0
ColorPanelScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)

local UIListLayout2 = Instance.new("UIListLayout", ColorPanelScrollingFrame)
UIListLayout2.Wraps = true
UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder

return {
    PaintHolder = PaintHolder,
    ColorPanel = ColorPanel,
    ColorPanelScrollingFrame = ColorPanelScrollingFrame,
    UIPaintStroke = UIPaintStroke
}
