-- Module E: Buttons + Tweens + Settings + Paint Mode

local TweenService = TweenService
local UserInputService = UserInputService
local ReplicatedStorage = ReplicatedStorage

local PaintBar = PaintBar
local ColorPanel = ColorPanel
local UIPaintStroke = UIPaintStroke
local NamingPanel = NamingPanel
local NamingTextBox = NamingTextBox
local BlurEffect = BlurEffect
local pixelFolder = pixelFolder

local PaintButton = PaintButton
local EraseButton = EraseButton
local AreaButton = AreaButton
local ConfirmButton = ConfirmButton

local SideButtons = SideButtons
local Tabs = Tabs
local gradients = gradients

local savedPixelTable = savedPixelTable
local newPixelPart = newPixelPart
local refreshScrollingFrame = refreshScrollingFrame
local newPixelTable = newPixelTable

local s_hover = s_hover
local s_pop = s_pop
local playSound = playSound

local paintMode = false
local editMode = false
local mouse = mouse
local player = player

local SideButtonActivationSpeed = 0.2

-- Show paint bar animation
local function showPaintBar()
    paintMode = true

    if not RunService:IsStudio() then
        player.PlayerGui.ScreenGui.Enabled = false
    end

    TweenService:Create(PanelHolder, TweenInfo.new(0.25), {Position = UDim2.new(0.5,0,-1,0)}):Play()
    task.wait(0.25)

    TweenService:Create(PaintBar, TweenInfo.new(0.1), {Position = UDim2.new(0.5,0,1,-10)}):Play()
    TweenService:Create(PaintBar, TweenInfo.new(0.1), {Size = UDim2.new(0,142,0,50)}):Play()

    task.wait(0.1)

    TweenService:Create(ColorPanel, TweenInfo.new(0.2), {Position = UDim2.new(0,0,0.5,0)}):Play()
    task.wait(0.2)

    TweenService:Create(UIPaintStroke, TweenInfo.new(0.25), {Thickness = 2}):Play()
    task.wait(0.25)

    task.spawn(function()
        task.wait(0.25)
        for i = 0, #ReplicatedStorage.Colors:GetChildren() - 1 do
            local button = ColorPanelScrollingFrame[i]
            if button and button:IsA("Frame") then
                button = button.ImageButton
                local originalSize = button.Size

                task.wait(0.1)

                task.spawn(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        Size = UDim2.new(originalSize.X.Scale * 1.1, 0, originalSize.Y.Scale * 1.1, 0)
                    }):Play()

                    task.wait(0.2)

                    TweenService:Create(button, TweenInfo.new(0.2), {
                        Size = UDim2.new(originalSize.X.Scale, 0, originalSize.Y.Scale, 0)
                    }):Play()
                end)
            end
        end
    end)
end

-- Deactivate all tabs
local function DeactiveTabs()
    for _, Tab in pairs(Tabs:GetChildren()) do
        if Tab:IsA("Frame") and Tab.Name ~= "Frame" then
            Tab.Visible = false
        end
    end
end

-- Deactivate all side buttons
local function DeactiveAllSideButtons()
    for _, Button in pairs(SideButtons:GetChildren()) do
        if Button:IsA("ImageButton") then
            TweenService:Create(Button.UIStroke, TweenInfo.new(SideButtonActivationSpeed), {Thickness = 0}):Play()
            TweenService:Create(Button.overlay, TweenInfo.new(SideButtonActivationSpeed), {ImageTransparency = 1}):Play()
        end
    end
    DeactiveTabs()
end

-- Activate a side button
local function ActivateSideButton(Button)
    DeactiveAllSideButtons()

    TweenService:Create(Button.UIStroke, TweenInfo.new(SideButtonActivationSpeed), {Thickness = 1}):Play()
    TweenService:Create(Button.overlay, TweenInfo.new(SideButtonActivationSpeed), {ImageTransparency = 0}):Play()

    Tabs[Button.Name].Visible = true
end

-- Create a new tab
local function NewTab(name)
    local Tab = Instance.new("Frame", Tabs)
    Tab.BackgroundTransparency = 1
    Tab.Name = name
    Tab.Size = UDim2.new(1,0,1,0)
    Tab.Visible = false
    return Tab
end

-- Create a new side button
local function NewButton(Tab, IconID)
    local Button = Instance.new("ImageButton", SideButtons)
    Button.LayoutOrder = order
    order += 1

    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1,0,1,0)
    Button.Name = Tab.Name

    local AspectRatio = Instance.new("UIAspectRatioConstraint", Button)

    local UICorner = Instance.new("UICorner", Button)
    UICorner.CornerRadius = UDim.new(0,4)

    local UIStroke = Instance.new("UIStroke", Button)
    UIStroke.Thickness = 0
    UIStroke.Color = Color3.fromRGB(255,255,255)

    local OutlineGradient = Instance.new("UIGradient", UIStroke)
    OutlineGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(246,104,0)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,149,67)),
    }
    table.insert(gradients, OutlineGradient)

    local Icon = Instance.new("ImageLabel", Button)
    Icon.AnchorPoint = Vector2.new(0.5,0.5)
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0.5,0,0.5,0)
    Icon.Size = UDim2.new(0.8,0,0.8,0)
    Icon.Image = IconID

    local overlay = Icon:Clone()
    overlay.Name = "overlay"
    overlay.Parent = Button
    overlay.ImageTransparency = 1

    local IconGradient = Instance.new("UIGradient", overlay)
    IconGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(246,104,0)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,149,67)),
    }
    table.insert(gradients, IconGradient)

    Button.MouseButton1Down:Connect(function()
        s_pop.PlaybackSpeed = 1 + Button.LayoutOrder / 4
        playSound(s_pop)
        ActivateSideButton(Button)
    end)

    return Button
end

-- Button hover/click effect
local function ButtonEffect(event, button, hoverColor, clickColor)
    local speed = 0.1
    local enabled = false
    local originalColor = button.BackgroundColor3
    local hovering = false

    button.MouseEnter:Connect(function()
        hovering = true
        if not enabled then
            TweenService:Create(button, TweenInfo.new(speed), {BackgroundColor3 = hoverColor}):Play()
        end
        playSound(s_hover)
    end)

    button.MouseLeave:Connect(function()
        hovering = false
        if not enabled then
            TweenService:Create(button, TweenInfo.new(speed), {BackgroundColor3 = originalColor}):Play()
        end
    end)

    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(speed), {BackgroundColor3 = clickColor}):Play()
        enabled = false
        event()
    end)

    button.MouseButton1Up:Connect(function()
        if hovering then
            TweenService:Create(button, TweenInfo.new(speed), {BackgroundColor3 = hoverColor}):Play()
        else
            TweenService:Create(button, TweenInfo.new(speed), {BackgroundColor3 = originalColor}):Play()
        end
        enabled = false
    end)
end

-- Button events (toggle logic)
local function ButtonEvents(button, index, buttonsType)
    local enabled = false
    local db = true

    local function toggle()
        if db then
            db = false

            for _, b in pairs(buttonsType) do
                b.Enabled = false
                if b.DeactivateFunction then
                    task.spawn(function()
                        b.DeactivateFunction()
                    end)
                end
            end

            enabled = not enabled

            if enabled then
                if buttonsType[index].ActivateFunction then
                    task.spawn(function()
                        buttonsType[index].ActivateFunction()
                    end)
                end
            else
                if buttonsType[index].DeactivateFunction then
                    task.spawn(function()
                        buttonsType[index].DeactivateFunction()
                    end)
                end
            end

            buttonsType[index].Enabled = enabled
            db = true
        end
    end

    button.MouseButton1Down:Connect(toggle)

    button.MouseEnter:Connect(function()
        buttonsType[index].Hovering = true
        playSound(s_hover)
    end)

    button.MouseLeave:Connect(function()
        buttonsType[index].Hovering = false
    end)

    UserInputService.InputBegan:Connect(function(input, isTyping)
        if not isTyping and paintMode and input.KeyCode == buttonsType[index].Keybind then
            toggle()
        end
    end)
end

-- Show main panel again
local function showPanel()
    TweenService:Create(NamingPanel, TweenInfo.new(0.25), {Position = UDim2.new(0.5,0,-0.5,0)}):Play()
    TweenService:Create(PanelHolder, TweenInfo.new(0.25), {Position = UDim2.new(0.5,0,0.5,0)}):Play()
    TweenService:Create(BlurEffect, TweenInfo.new(0.25), {Size = 0}):Play()
end

-- Process naming confirm
local function processNaming()
    editMode = false
    buttons.PaintButtons[4].Enabled = false

    table.clear(savedPixelTable)
    pixelFolder:ClearAllChildren()

    if not RunService:IsStudio() then
        player.PlayerGui.ScreenGui.Enabled = true
    end

    showPanel()
end

-- Paint mode confirm
local function paintModeConfirm()
    mouse.Icon = ""

    TweenService:Create(PaintBar, TweenInfo.new(0.1), {Position = UDim2.new(0.5,0,1.1,0)}):Play()
    TweenService:Create(PaintBar, TweenInfo.new(0.1), {Size = UDim2.new(0,0,0,0)}):Play()
    TweenService:Create(ColorPanel, TweenInfo.new(0.1), {Position = UDim2.new(-0.5,0,0.5,0)}):Play()
    TweenService:Create(UIPaintStroke, TweenInfo.new(0.1), {Thickness = 0}):Play()

    task.wait(0.1)

    NamingTextBox.Text = "New Pixel Table"

    TweenService:Create(NamingPanel, TweenInfo.new(0.1), {Position = UDim2.new(0.5,0,0.5,0)}):Play()
    TweenService:Create(BlurEffect, TweenInfo.new(0.1), {Size = 25}):Play()
end

-- Create a new setting
local function NewSetting(name, tab, Type, text, func, en)
    local Setting
    local ToReturn

    if Type == "Button" then
        Setting = Instance.new("ImageButton", tab)
        Setting.AutoButtonColor = false
        Setting.ImageTransparency = 1

        local size = TextService:GetTextSize(text, 15, Enum.Font.SourceSansBold, Vector2.new(1000,1000))

        local button = Instance.new("TextLabel", Setting)
        button.AnchorPoint = Vector2.new(1,0.5)
        button.BackgroundColor3 = Color3.fromRGB(34,36,43)
        button.Position = UDim2.new(1,0,0.5,0)
        button.Size = UDim2.new(0, size.X + 26, 1, 0)
        button.Font = Enum.Font.SourceSansBold
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255,255,255)
        button.TextSize = 15

        local UICorner = Instance.new("UICorner", button)
        UICorner.CornerRadius = UDim.new(0,4)

        Setting.MouseButton1Down:Connect(function()
            func.a()
            TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(76,107,255)}):Play()
            task.wait(0.1)
            TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(34,36,43)}):Play()
        end)

    elseif Type == "Text" then
        Setting = Instance.new("Frame", tab)

        local size = TextService:GetTextSize(text, 15, Enum.Font.SourceSansBold, Vector2.new(1000,1000))

        local label = Instance.new("TextButton", Setting)
        label.BackgroundTransparency = 1
        label.AnchorPoint = Vector2.new(1,0.5)
        label.Position = UDim2.new(1,0,0.5,0)
        label.Size = UDim2.new(0, size.X + 26, 1, 0)
        label.Font = Enum.Font.SourceSansBold
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.TextSize = 15

        ToReturn = label

    elseif Type == "TextBox" then
        Setting = Instance.new("Frame", tab)

        local size = TextService:GetTextSize(text, 15, Enum.Font.SourceSansBold, Vector2.new(1000,1000))

        local textbox = Instance.new("TextBox", Setting)
        textbox.ClipsDescendants = true
        textbox.AnchorPoint = Vector2.new(1,0.5)
        textbox.BackgroundColor3 = Color3.fromRGB(14,15,18)
        textbox.Position = UDim2.new(1,0,0.5,0)
        textbox.Size = UDim2.new(0, size.X + 26, 1, 0)
        textbox.Font = Enum.Font.SourceSansBold
        textbox.PlaceholderText = text
        textbox.Text = ""
        textbox.PlaceholderColor3 = Color3.fromRGB(100,100,100)
        textbox.TextColor3 = Color3.fromRGB(255,255,255)
        textbox.TextSize = 15

        local UICorner = Instance.new("UICorner", textbox)
        UICorner.CornerRadius = UDim.new(0,4)

        textbox.Changed:Connect(function(property)
            if property == "Text" then
                local size = TextService:GetTextSize(textbox.Text, 15, Enum.Font.SourceSansBold, Vector2.new(1000,1000))
                textbox.Size = UDim2.new(0, size.X + 26, 1, 0)
                if textbox.Text == "" then
                    textbox.PlaceholderText = ""
                end
            end
        end)

        textbox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                func.a(textbox.Text)
            end

            if textbox.Text == "" then
                local size = TextService:GetTextSize(text, 15, Enum.Font.SourceSansBold, Vector2.new(1000,1000))
                textbox.Size = UDim2.new(0, size.X + 26, 1, 0)
                textbox.PlaceholderText = text
            end
        end)

    elseif Type == "Toggle" then
        Setting = Instance.new("ImageButton", tab)
        Setting.AutoButtonColor = false
        Setting.ImageTransparency = 1

        local holder = Instance.new("Frame", Setting)
        holder.BackgroundColor3 = Color3.fromRGB(14,15,18)
        holder.Size = UDim2.new(0, 40, 1, 0)

        local UICorner = Instance.new("UICorner", holder)
        UICorner.CornerRadius = UDim.new(0,4)

        local toggle = Instance.new("Frame", holder)
        toggle.AnchorPoint = Vector2.new(0,0.5)
        toggle.Position = UDim2.new(0, 4, 0.5, 0)
        toggle.Size = UDim2.new(0, 16, 0, 16)
        toggle.BackgroundColor3 = Color3.fromRGB(255,255,255)

        local UICorner2 = Instance.new("UICorner", toggle)
        UICorner2.CornerRadius = UDim.new(1,0)

        local enabled = en or false

        local function update()
            if enabled then
                TweenService:Create(toggle, TweenInfo.new(0.1), {Position = UDim2.new(1, -20, 0.5, 0)}):Play()
                TweenService:Create(holder, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(76,107,255)}):Play()
            else
                TweenService:Create(toggle, TweenInfo.new(0.1), {Position = UDim2.new(0, 4, 0.5, 0)}):Play()
                TweenService:Create(holder, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(14,15,18)}):Play()
            end
        end

        update()

        Setting.MouseButton1Down:Connect(function()
            enabled = not enabled
            update()
            func.a(enabled)
        end)

        ToReturn = Setting
    end

    return Setting, ToReturn
end

-- Export everything
return {
    showPaintBar = showPaintBar,
    DeactiveTabs = DeactiveTabs,
    DeactiveAllSideButtons = DeactiveAllSideButtons,
    ActivateSideButton = ActivateSideButton,
    NewTab = NewTab,
    NewButton = NewButton,
    ButtonEffect = ButtonEffect,
    ButtonEvents = ButtonEvents,
    showPanel = showPanel,
    processNaming = processNaming,
    paintMode
