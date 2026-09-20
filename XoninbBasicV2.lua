-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "Xon1nbBasicV2"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 520)
Main.Position = UDim2.new(0.5, -160, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(0, 255, 150)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "XON1NB BASIC v2"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = Enum.Font.Code
Title.TextSize = 18

-- Target Player TextBox
local TargetInput = Instance.new("TextBox", Main)
TargetInput.Size = UDim2.new(0.9, 0, 0, 30)
TargetInput.Position = UDim2.new(0.05, 0, 0, 45)
TargetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TargetInput.PlaceholderText = "Enter Player Name..."
TargetInput.TextColor3 = Color3.new(1,1,1)
TargetInput.Font = Enum.Font.SourceSans
TargetInput.Text = ""

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -85)
Scroll.Position = UDim2.new(0, 5, 0, 80)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 4, 0)
Scroll.ScrollBarThickness = 4

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Helper to make buttons
local function AddButton(name, color, func)
	local btn = Instance.new("TextButton", Scroll)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.BackgroundColor3 = color
	btn.Text = name
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 14
	btn.MouseButton1Click:Connect(func)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
end

-- Logic Variables
local flinging = false
local noclip = false

-- Find Player Logic
local function getTarget()
	local text = TargetInput.Text:lower()
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #text) == text or p.DisplayName:lower():sub(1, #text) == text then
			return p
		end
	end
	return nil
end

-----------------------------------------------------------
-- THE NEW BUTTONS
-----------------------------------------------------------

-- 1. FLING TOGGLE
AddButton("Fling (Toggle)", Color3.fromRGB(200, 0, 0), function()
	flinging = not flinging
	local char = Player.Character
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if flinging and hrp then
		local bav = Instance.new("BodyAngularVelocity", hrp)
		bav.Name = "XonFling"
		bav.MaxTorque = Vector3.new(0, math.huge, 0)
		bav.AngularVelocity = Vector3.new(0, 99999, 0)
	else
		if hrp:FindFirstChild("XonFling") then hrp.XonFling:Destroy() end
	end
end)

-- 2. TELEPORT TO TARGET
AddButton("Teleport to Target", Color3.fromRGB(0, 100, 200), function()
	local target = getTarget()
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
	end
end)

-- 3. ESP (Box style)
AddButton("ESP (Boxes)", Color3.fromRGB(0, 150, 0), function()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= Player and p.Character then
			local box = Instance.new("Highlight", p.Character)
			box.FillColor = Color3.new(1, 0, 0)
			box.OutlineColor = Color3.new(1, 1, 1)
			box.AlwaysOnTop = true
		end
	end
end)

-- 4. AVATAR CHANGER (Target Stealer)
AddButton("Copy Target Avatar", Color3.fromRGB(150, 0, 150), function()
	local target = getTarget()
	if target then
		Player.CharacterAppearanceId = target.UserId
		Player:LoadCharacter() -- Refreshes your character with their look
	end
end)

-- 5. NOCLIP
AddButton("Noclip (Toggle)", Color3.fromRGB(100, 0, 200), function()
	noclip = not noclip
	RunService.Stepped:Connect(function()
		if noclip and Player.Character then
			for _, v in pairs(Player.Character:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide = false end
			end
		end
	end)
end)

-- 6-20. BASIC UTILS
AddButton("Speed Boost (25)", Color3.fromRGB(50, 50, 50), function() Player.Character.Humanoid.WalkSpeed = 25 end)
AddButton("Jump Boost (75)", Color3.fromRGB(50, 50, 50), function() Player.Character.Humanoid.JumpPower = 75 end)
AddButton("FOV 100", Color3.fromRGB(50, 50, 50), function() workspace.CurrentCamera.FieldOfView = 100 end)
AddButton("Full Bright", Color3.fromRGB(150, 150, 0), function() game.Lighting.Brightness = 2; game.Lighting.GlobalShadows = false end)
AddButton("Low Gravity", Color3.fromRGB(100, 100, 100), function() workspace.Gravity = 80 end)
AddButton("Reset Gravity", Color3.fromRGB(100, 100, 100), function() workspace.Gravity = 196.2 end)
AddButton("Reset Character", Color3.fromRGB(150, 0, 0), function() Player.Character:BreakJoints() end)
AddButton("Infinite Jump", Color3.fromRGB(50, 50, 200), function() UIS.JumpRequest:Connect(function() Player.Character.Humanoid:ChangeState("Jumping") end) end)
AddButton("Clear Fog", Color3.fromRGB(0, 150, 150), function() game.Lighting.FogEnd = 100000 end)
AddButton("Night Vision", Color3.fromRGB(0, 100, 0), function() local c = Instance.new("ColorCorrectionEffect", game.Lighting); c.TintColor = Color3.fromRGB(100, 255, 100) end)
AddButton("Remove Textures (Lag)", Color3.fromRGB(50, 50, 50), function() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("Texture") then v:Destroy() end end end)
AddButton("Static Camera", Color3.fromRGB(50, 50, 50), function() Player.Character.Humanoid.CameraOffset = Vector3.new(0,0,0) end)
AddButton("Neon Players", Color3.fromRGB(200, 0, 200), function() for _,p in pairs(Players:GetPlayers()) do if p.Character then for _,v in pairs(p.Character:GetChildren()) do if v:IsA("BasePart") then v.Material = Enum.Material.Neon end end end end end)
AddButton("TP to Center", Color3.fromRGB(0, 150, 150), function() Player.Character:MoveTo(Vector3.new(0, 50, 0)) end)
AddButton("Close Menu", Color3.fromRGB(0, 0, 0), function() Main.Visible = false end)

-- Key Toggle
UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		Main.Visible = not Main.Visible
	end
end)
