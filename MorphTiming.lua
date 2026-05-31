local TARGET_SOUND_ID = "96182964301191"

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SoundClicker"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = game.CoreGui
end)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(260, 100)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "Sound Clicker"
Title.Parent = Frame

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(25, 25)
Close.Position = UDim2.new(1, -25, 0, 0)
Close.Text = "X"
Close.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -10, 0, 50)
Status.Position = UDim2.new(0, 5, 0, 35)
Status.BackgroundTransparency = 1
Status.TextWrapped = true
Status.Text = "Ожидание звука..."
Status.Parent = Frame

Close.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Insert для открытия/закрытия
local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, gp)
    if gp then
        return
    end

    if input.KeyCode == Enum.KeyCode.Insert then
        Frame.Visible = not Frame.Visible
    end
end)

local function setStatus(text)
    Status.Text = text
end

local function normalize(id)
    return tostring(id):match("%d+") or ""
end

local function rightClick()
    if mouse2press and mouse2release then
        mouse2press()
        task.wait(0.03)
        mouse2release()
    end
end

local function connectSound(sound)
    sound.Played:Connect(function()
        if normalize(sound.SoundId) == TARGET_SOUND_ID then
            setStatus("Найден звук!\nПКМ нажата")
            rightClick()

            task.delay(1.5, function()
                if Status.Text == "Найден звук!\nПКМ нажата" then
                    setStatus("Ожидание звука...")
                end
            end)
        end
    end)
end

for _, v in ipairs(game:GetDescendants()) do
    if v:IsA("Sound") then
        connectSound(v)
    end
end

game.DescendantAdded:Connect(function(v)
    if v:IsA("Sound") then
        connectSound(v)
    end
end)

setStatus("Ожидание звука...")
