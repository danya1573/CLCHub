local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local Enabled = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CLC_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 700, 0, 420)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -210)
MainFrame.Parent = ScreenGui

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.Parent = MainFrame

-- Индикатор состояния
local Status = Instance.new("Frame")
Status.Size = UDim2.fromOffset(12,12)
Status.Position = UDim2.new(0,8,0.5,-6)
Status.Parent = TopBar

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1,0)
Corner.Parent = Status

-- Название
local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,-60,1,0)
Title.Position = UDim2.new(0,28,0,0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "CLC Hub | "..GameName
Title.Parent = TopBar

-- Кнопка закрытия
local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(32,32)
Close.Position = UDim2.new(1,-32,0,0)
Close.Text = "X"
Close.Parent = TopBar

-- Левая панель (15%)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0.15,0,1,-32)
Sidebar.Position = UDim2.new(0,0,0,32)
Sidebar.Parent = MainFrame

-- Правая часть
local Content = Instance.new("Frame")
Content.Size = UDim2.new(0.85,0,1,-32)
Content.Position = UDim2.new(0.15,0,0,32)
Content.Parent = MainFrame

-- Кнопки вкладок
local MainTab = Instance.new("TextButton")
MainTab.Size = UDim2.new(1,0,0,35)
MainTab.Text = "Main"
MainTab.Parent = Sidebar

local LogsTab = Instance.new("TextButton")
LogsTab.Size = UDim2.new(1,0,0,35)
LogsTab.Position = UDim2.new(0,0,0,35)
LogsTab.Text = "Logs"
LogsTab.Parent = Sidebar

-- Страницы
local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1,0,1,0)
MainPage.Parent = Content

local LogsPage = Instance.new("Frame")
LogsPage.Size = UDim2.new(1,0,1,0)
LogsPage.Visible = false
LogsPage.Parent = Content

MainTab.MouseButton1Click:Connect(function()
 MainPage.Visible = true
 LogsPage.Visible = false
end)

LogsTab.MouseButton1Click:Connect(function()
 MainPage.Visible = false
 LogsPage.Visible = true
end)

-- Обновление индикатора
local function UpdateStatus()
 Status.BackgroundColor3 = Enabled
  and Color3.fromRGB(0,255,0)
  or Color3.fromRGB(255,0,0)
end

UpdateStatus()

-- Закрытие
Close.MouseButton1Click:Connect(function()
 ScreenGui:Destroy()
end)

-- INS
UIS.InputBegan:Connect(function(Input, GP)
 if GP then return end

 if Input.KeyCode == Enum.KeyCode.Insert then
  MainFrame.Visible = not MainFrame.Visible
 end
end)

-- Sound Detector Toggle

local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, -20, 0, 50)
ToggleFrame.Position = UDim2.new(0, 10, 0, 10)
ToggleFrame.BackgroundTransparency = 1
ToggleFrame.Parent = MainPage

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Text = "Sound Detector"
ToggleLabel.Parent = ToggleFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(60, 28)
ToggleButton.Position = UDim2.new(1, -70, 0.5, -14)
ToggleButton.Text = ""
ToggleButton.Parent = ToggleFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1,0)
ToggleCorner.Parent = ToggleButton

local Knob = Instance.new("Frame")
Knob.Size = UDim2.fromOffset(22,22)
Knob.Position = UDim2.new(0,3,0.5,-11)
Knob.Parent = ToggleButton

local KnobCorner = Instance.new("UICorner")
KnobCorner.CornerRadius = UDim.new(1,0)
KnobCorner.Parent = Knob

local function UpdateToggle()
 if Enabled then
  ToggleButton.BackgroundColor3 = Color3.fromRGB(0,170,0)

  Knob:TweenPosition(
   UDim2.new(1,-25,0.5,-11),
   Enum.EasingDirection.Out,
   Enum.EasingStyle.Quad,
   0.15,
   true
  )
 else
  ToggleButton.BackgroundColor3 = Color3.fromRGB(80,80,80)

  Knob:TweenPosition(
   UDim2.new(0,3,0.5,-11),
   Enum.EasingDirection.Out,
   Enum.EasingStyle.Quad,
   0.15,
   true
  )
 end

 UpdateStatus()
end

ToggleButton.MouseButton1Click:Connect(function()
 Enabled = not Enabled
 UpdateToggle()
end)

UpdateToggle()

-- Верхняя панель логов

local LogsTop = Instance.new("Frame")
LogsTop.Size = UDim2.new(1, 0, 0, 35)
LogsTop.Parent = LogsPage

local LogsTitle = Instance.new("TextLabel")
LogsTitle.Size = UDim2.new(1, -90, 1, 0)
LogsTitle.BackgroundTransparency = 1
LogsTitle.TextXAlignment = Enum.TextXAlignment.Left
LogsTitle.Text = "Logs"
LogsTitle.Parent = LogsTop

local ClearButton = Instance.new("TextButton")
ClearButton.Size = UDim2.fromOffset(70, 25)
ClearButton.Position = UDim2.new(1, -80, 0.5, -12)
ClearButton.Text = "Clear"
ClearButton.Parent = LogsTop

-- Скролл логов

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Size = UDim2.new(1, -10, 1, -45)
LogScroll.Position = UDim2.new(0, 5, 0, 40)
LogScroll.CanvasSize = UDim2.new()
LogScroll.ScrollBarThickness = 6
LogScroll.Parent = LogsPage

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 2)
Layout.Parent = LogScroll

local LogCount = 0
local MaxLogs = 100

local function UpdateCanvas()
 LogScroll.CanvasSize =
  UDim2.new(
   0,
   0,
   0,
   Layout.AbsoluteContentSize.Y + 10
  )
end

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)

local function AddLog(Text, IsFound)
 LogCount += 1

 local Entry = Instance.new("TextLabel")
 Entry.Size = UDim2.new(1, -5, 0, 22)
 Entry.BackgroundTransparency = 1
 Entry.TextXAlignment = Enum.TextXAlignment.Left
 Entry.TextScaled = false

 if IsFound then
  Entry.TextColor3 = Color3.fromRGB(0,255,0)
 else
  Entry.TextColor3 = Color3.fromRGB(220,220,220)
 end

 Entry.Text = Text
 Entry.Parent = LogScroll

 -- удаляем старые записи
 while #LogScroll:GetChildren() > MaxLogs + 1 do
  for _, v in ipairs(LogScroll:GetChildren()) do
   if v:IsA("TextLabel") then
    v:Destroy()
    break
   end
  end
 end

 task.wait()

 LogScroll.CanvasPosition =
  Vector2.new(
   0,
   math.max(
    0,
    LogScroll.AbsoluteCanvasSize.Y
   )
  )
end

ClearButton.MouseButton1Click:Connect(function()
 for _, v in ipairs(LogScroll:GetChildren()) do
  if v:IsA("TextLabel") then
   v:Destroy()
  end
 end

 LogCount = 0
 UpdateCanvas()
end)

local TARGET_SOUND_ID = "96182964301191"
local DETECTION_DISTANCE = 500

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getCharacterPosition()
 local character = LocalPlayer.Character
 if not character then return nil end

 local hrp = character:FindFirstChild("HumanoidRootPart")
 if not hrp then return nil end

 return hrp.Position
end

local function isInRange(sound)
 local myPos = getCharacterPosition()
 if not myPos then
  return false
 end

 local parent = sound.Parent
 if not parent then
  return false
 end

 local part = parent:IsA("BasePart") and parent
  or parent:FindFirstAncestorWhichIsA("BasePart")

 if not part then
  return true
 end

 return (part.Position - myPos).Magnitude <= DETECTION_DISTANCE
end

local function connectSound(sound)
 sound.Played:Connect(function()
  if not isInRange(sound) then
   return
  end

  local id = tostring(sound.SoundId):match("%d+") or "Unknown"
  local time = os.date("%H:%M:%S")

  local state = (id == TARGET_SOUND_ID) and "Found" or "Detect"

  AddLog(
   string.format(
    "[%s] %s: %s | id: %s",
    time,
    state,
    sound.Name,
    id
   ),
   state == "Found"
  )
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