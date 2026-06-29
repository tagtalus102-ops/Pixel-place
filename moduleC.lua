-- Module C: Sounds

local SoundService = workspace -- sounds will be cloned into workspace when played

-- Sound objects
local sound1 = Instance.new("Sound")
sound1.SoundId = "rbxassetid://118952141529326"

local s_paste = Instance.new("Sound")
s_paste.SoundId = "rbxassetid://9117231552"
s_paste.PlaybackSpeed = 2
s_paste.Volume = 1.5

local s_new = Instance.new("Sound")
s_new.SoundId = "rbxassetid://107366908379453"
s_new.Volume = 2

local s_delete = Instance.new("Sound")
s_delete.SoundId = "rbxassetid://121238985608899"
s_delete.PlaybackSpeed = 1.5
s_delete.Volume = 1.5

local s_new2 = Instance.new("Sound")
s_new2.SoundId = "rbxassetid://140419294351439"

local s_hover = Instance.new("Sound")
s_hover.SoundId = "rbxassetid://139800881181209"
s_hover.PlaybackSpeed = 1.5
s_hover.Volume = 1.5

local s_draw = Instance.new("Sound")
s_draw.SoundId = "rbxassetid://9117215860"
s_draw.Volume = 1.5

local s_erase = Instance.new("Sound")
s_erase.SoundId = "rbxassetid://9119709598"
s_erase.Volume = 1.5

local s_copy = Instance.new("Sound")
s_copy.SoundId = "rbxassetid://2217513097"
s_copy.Volume = 1.5

local s_pop = Instance.new("Sound")
s_pop.SoundId = "rbxassetid://1289263994"

local s_scale = Instance.new("Sound")
s_scale.SoundId = "rbxassetid://134057288"
s_scale.PlaybackSpeed = 1.5

local s_changeColor = Instance.new("Sound")
s_changeColor.SoundId = "rbxassetid://9119523840"

-- PlaySound utility
local function playSound(sound)
    task.spawn(function()
        local clone = sound:Clone()
        clone.Parent = workspace
        clone:Play()
        task.wait(10)
        clone:Destroy()
    end)
end

-- Export all sounds + play function
return {
    sound1 = sound1,
    s_paste = s_paste,
    s_new = s_new,
    s_delete = s_delete,
    s_new2 = s_new2,
    s_hover = s_hover,
    s_draw = s_draw,
    s_erase = s_erase,
    s_copy = s_copy,
    s_pop = s_pop,
    s_scale = s_scale,
    s_changeColor = s_changeColor,
    playSound = playSound
}
