--// Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local LINKS = {
	PlayerProfile = function(userId)
		return "https://www.roblox.com/users/" .. userId .. "/profile"
	end,

	TypeSoul = "https://www.roblox.com/games/126884695634066/TYPE-SOUL",
	Universal = "https://www.roblox.com/games"
}

local Scripts = {
	TypeSoul = {
		{
			Name = "MorphTimings",
			URL = "https://raw.githubusercontent.com/danya1573/CLCHub/refs/heads/main/MorphTiming.lua"
		}
	},

	Universal = {
		{
			Name = "Infinity Yield",
			URL = "https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua"
		},

		{
			Name = "Reviz Admin",
			URL = "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/refs/heads/master/Reviz%20Admin%20v2.lua"
		},

		{
			Name = "ESP",
			URL = "https://pastebin.com/raw/CmyR7fct"
		}
	}
}

--==================================================
-- WEBHOOK
--==================================================

local function SendWebhook(modeName, scriptName)
	task.spawn(function()
			
		local currentGameLink =
    		"https://www.roblox.com/games/" .. game.PlaceId
			
		local modeLink =
			modeName == "Type://Soul"
			and LINKS.TypeSoul
			or LINKS.Universal

		local payload = {
			username = "Loader Logger",

			embeds = {
				{
					title = "Script Executed",
					description = "**Игрок запустил скрипт**",

					color = 3092790,

					fields = {
    {
        name = "Игрок",
        value = LocalPlayer.Name,
        inline = true
    },

    {
        name = "Режим",
        value = modeName,
        inline = true
    },

    {
        name = "Скрипт",
        value = scriptName,
        inline = false
    },

    {
        name = "Профиль игрока",
        value = "[Открыть профиль](" ..
            LINKS.PlayerProfile(LocalPlayer.UserId) ..
            ")",
        inline = false
    },

    {
        name = "Текущая игра",
        value = "[Открыть игру](" ..
            currentGameLink ..
            ")",
        inline = false
    }
},

					footer = {
						text = "Loader Analytics"
					}
				}
			},
		}

		pcall(function()
			request({
				Url = WEBHOOK_URL,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = HttpService:JSONEncode(payload)
			})
		end)
	end)
end

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoaderGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, -325, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,12)
UICorner.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.Size = UDim2.new(1,0,0,40)
TopBar.BackgroundColor3 = Color3.fromRGB(24,24,24)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0,12)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,1,0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Custom Loader"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 18

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.AnchorPoint = Vector2.new(1,0)
CloseButton.Position = UDim2.new(1,-8,0,6)
CloseButton.Size = UDim2.new(0,28,0,28)

CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14

CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.BackgroundColor3 = Color3.fromRGB(220,40,40)
CloseButton.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--[[Вырезано
-- Warning

local Warning = Instance.new("TextLabel")
Warning.Parent = Main
Warning.Position = UDim2.new(0,15,0,50)
Warning.Size = UDim2.new(1,-30,0,40)
Warning.BackgroundTransparency = 1
Warning.Font = Enum.Font.Gotham
Warning.TextColor3 = Color3.fromRGB(255,170,0)
Warning.TextWrapped = true
Warning.Text =
"Внимание: запуск скриптов отправляет ваш ник, режим и название запущенного скрипта в систему аналитики."
Warning.TextSize = 13
]]

-- Tabs

local TabHolder = Instance.new("Frame")
TabHolder.Parent = Main
TabHolder.Position = UDim2.new(0,15,0,95)
TabHolder.Size = UDim2.new(0,180,1,-110)
TabHolder.BackgroundTransparency = 1

local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.new(0,205,0,95)
Content.Size = UDim2.new(1,-220,1,-110)
Content.BackgroundColor3 = Color3.fromRGB(24,24,24)
Content.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner")
ContentCorner.Parent = Content

local CurrentPage

local function ClearContent()
	for _,v in pairs(Content:GetChildren()) do
		if not v:IsA("UICorner") then
			v:Destroy()
		end
	end
end

local WEBHOOK_URL = "https://discord.com/api/webhooks/1511061279911973004/ZY4jK41vpt5wpGeharPud9itsH1_VmmST2s4_9zJTm9cYc5_Y8tF8ZtppBpzWE2Lj3Vr"
local function CreateButton(parent,text,callback)

	local Btn = Instance.new("TextButton")
	Btn.Parent = parent
	Btn.Size = UDim2.new(1,-10,0,40)
	Btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.Font = Enum.Font.GothamMedium
	Btn.TextSize = 14
	Btn.Text = text

	local C = Instance.new("UICorner")
	C.Parent = Btn

	Btn.MouseButton1Click:Connect(callback)

	return Btn
end

local function OpenPage(modeName)

	CurrentPage = modeName
	ClearContent()

	local list = Instance.new("UIListLayout")
	list.Parent = Content
	list.Padding = UDim.new(0,8)

	local padding = Instance.new("UIPadding")
	padding.Parent = Content
	padding.PaddingTop = UDim.new(0,10)
	padding.PaddingLeft = UDim.new(0,10)
	padding.PaddingRight = UDim.new(0,10)

	local data

	if modeName == "Type://Soul" then
		data = Scripts.TypeSoul
	else
		data = Scripts.Universal
	end

	for _,scriptInfo in ipairs(data) do

		CreateButton(
			Content,
			scriptInfo.Name,

			function()

				SendWebhook(
					modeName,
					scriptInfo.Name
				)

				loadstring(
					game:HttpGet(
						scriptInfo.URL
					)
				)()
			end
		)
	end
end

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = TabHolder
tabLayout.Padding = UDim.new(0,8)

CreateButton(
	TabHolder,
	"Type://Soul",

	function()
		OpenPage("Type://Soul")
	end
)

CreateButton(
	TabHolder,
	"Universal",

	function()
		OpenPage("Universal")
	end
)

OpenPage("Type://Soul")

--==================================================
-- DRAGGING
--==================================================

local UIS = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPos

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,

			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
