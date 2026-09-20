local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XoninbPanel"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 540)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -270)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderSizePixel = 0
title.Text = "XONINB PANEL"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

local flingBtn = Instance.new("TextButton")
flingBtn.Name = "FlingButton"
flingBtn.Size = UDim2.new(0, 150, 0, 35)
flingBtn.Position = UDim2.new(0, 10, 0, 50)
flingBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
flingBtn.BorderSizePixel = 0
flingBtn.Text = "START FLING"
flingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flingBtn.TextSize = 14
flingBtn.Font = Enum.Font.SourceSansBold
flingBtn.Parent = mainFrame

local stopBtn = Instance.new("TextButton")
stopBtn.Name = "StopButton"
stopBtn.Size = UDim2.new(0, 150, 0, 35)
stopBtn.Position = UDim2.new(0, 170, 0, 50)
stopBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
stopBtn.BorderSizePixel = 0
stopBtn.Text = "STOP FLING"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.TextSize = 14
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.Parent = mainFrame

local flingPowerLabel = Instance.new("TextLabel")
flingPowerLabel.Name = "FlingPowerLabel"
flingPowerLabel.Size = UDim2.new(0, 100, 0, 25)
flingPowerLabel.Position = UDim2.new(0, 10, 0, 95)
flingPowerLabel.BackgroundTransparency = 1
flingPowerLabel.Text = "Fling Power:"
flingPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
flingPowerLabel.TextSize = 12
flingPowerLabel.Font = Enum.Font.SourceSansBold
flingPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
flingPowerLabel.Parent = mainFrame

local flingPowerBox = Instance.new("TextBox")
flingPowerBox.Name = "FlingPowerBox"
flingPowerBox.Size = UDim2.new(0, 80, 0, 25)
flingPowerBox.Position = UDim2.new(0, 110, 0, 95)
flingPowerBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
flingPowerBox.BorderSizePixel = 1
flingPowerBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
flingPowerBox.Text = "99999"
flingPowerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
flingPowerBox.TextSize = 12
flingPowerBox.Font = Enum.Font.SourceSans
flingPowerBox.ClearTextOnFocus = false
flingPowerBox.Parent = mainFrame

local setPowerBtn = Instance.new("TextButton")
setPowerBtn.Name = "SetPowerButton"
setPowerBtn.Size = UDim2.new(0, 60, 0, 25)
setPowerBtn.Position = UDim2.new(0, 200, 0, 95)
setPowerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 150)
setPowerBtn.BorderSizePixel = 0
setPowerBtn.Text = "SET"
setPowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setPowerBtn.TextSize = 12
setPowerBtn.Font = Enum.Font.SourceSansBold
setPowerBtn.Parent = mainFrame

local currentPowerLabel = Instance.new("TextLabel")
currentPowerLabel.Name = "CurrentPowerLabel"
currentPowerLabel.Size = UDim2.new(0, 70, 0, 25)
currentPowerLabel.Position = UDim2.new(0, 270, 0, 95)
currentPowerLabel.BackgroundTransparency = 1
currentPowerLabel.Text = "99999"
currentPowerLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
currentPowerLabel.TextSize = 14
currentPowerLabel.Font = Enum.Font.SourceSansBold
currentPowerLabel.Parent = mainFrame

local noclipBtn = Instance.new("TextButton")
noclipBtn.Name = "NoclipButton"
noclipBtn.Size = UDim2.new(0, 150, 0, 35)
noclipBtn.Position = UDim2.new(0, 10, 0, 130)
noclipBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
noclipBtn.BorderSizePixel = 0
noclipBtn.Text = "NOCLIP: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextSize = 14
noclipBtn.Font = Enum.Font.SourceSansBold
noclipBtn.Parent = mainFrame

local canCollideBtn = Instance.new("TextButton")
canCollideBtn.Name = "CanCollideButton"
canCollideBtn.Size = UDim2.new(0, 150, 0, 35)
canCollideBtn.Position = UDim2.new(0, 170, 0, 130)
canCollideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
canCollideBtn.BorderSizePixel = 0
canCollideBtn.Text = "CANCOLLIDE: ON"
canCollideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
canCollideBtn.TextSize = 14
canCollideBtn.Font = Enum.Font.SourceSansBold
canCollideBtn.Parent = mainFrame

local speedBtn = Instance.new("TextButton")
speedBtn.Name = "SpeedButton"
speedBtn.Size = UDim2.new(0, 150, 0, 35)
speedBtn.Position = UDim2.new(0, 10, 0, 175)
speedBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
speedBtn.BorderSizePixel = 0
speedBtn.Text = "SPEED BOOST"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 14
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.Parent = mainFrame

local jumpBtn = Instance.new("TextButton")
jumpBtn.Name = "JumpButton"
jumpBtn.Size = UDim2.new(0, 150, 0, 35)
jumpBtn.Position = UDim2.new(0, 170, 0, 175)
jumpBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
jumpBtn.BorderSizePixel = 0
jumpBtn.Text = "JUMP BOOST"
jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.TextSize = 14
jumpBtn.Font = Enum.Font.SourceSansBold
jumpBtn.Parent = mainFrame

local divider1 = Instance.new("Frame")
divider1.Size = UDim2.new(1, -20, 0, 2)
divider1.Position = UDim2.new(0, 10, 0, 220)
divider1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
divider1.BorderSizePixel = 0
divider1.Parent = mainFrame

local targetLabel = Instance.new("TextLabel")
targetLabel.Name = "TargetLabel"
targetLabel.Size = UDim2.new(1, -20, 0, 20)
targetLabel.Position = UDim2.new(0, 10, 0, 230)
targetLabel.BackgroundTransparency = 1
targetLabel.Text = "TARGET PLAYER"
targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
targetLabel.TextSize = 14
targetLabel.Font = Enum.Font.SourceSansBold
targetLabel.TextXAlignment = Enum.TextXAlignment.Left
targetLabel.Parent = mainFrame

local usernameBox = Instance.new("TextBox")
usernameBox.Name = "UsernameBox"
usernameBox.Size = UDim2.new(1, -20, 0, 35)
usernameBox.Position = UDim2.new(0, 10, 0, 255)
usernameBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
usernameBox.BorderSizePixel = 1
usernameBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
usernameBox.PlaceholderText = "Enter Username..."
usernameBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
usernameBox.Text = ""
usernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameBox.TextSize = 14
usernameBox.Font = Enum.Font.SourceSans
usernameBox.ClearTextOnFocus = false
usernameBox.Parent = mainFrame

local teleportBtn = Instance.new("TextButton")
teleportBtn.Name = "TeleportButton"
teleportBtn.Size = UDim2.new(0, 150, 0, 35)
teleportBtn.Position = UDim2.new(0, 10, 0, 300)
teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
teleportBtn.BorderSizePixel = 0
teleportBtn.Text = "TELEPORT TO"
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.TextSize = 14
teleportBtn.Font = Enum.Font.SourceSansBold
teleportBtn.Parent = mainFrame

local bringBtn = Instance.new("TextButton")
bringBtn.Name = "BringButton"
bringBtn.Size = UDim2.new(0, 150, 0, 35)
bringBtn.Position = UDim2.new(0, 170, 0, 300)
bringBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
bringBtn.BorderSizePixel = 0
bringBtn.Text = "BRING TO ME"
bringBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bringBtn.TextSize = 14
bringBtn.Font = Enum.Font.SourceSansBold
bringBtn.Parent = mainFrame

local explodeBtn = Instance.new("TextButton")
explodeBtn.Name = "ExplodeButton"
explodeBtn.Size = UDim2.new(0, 150, 0, 35)
explodeBtn.Position = UDim2.new(0, 10, 0, 345)
explodeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
explodeBtn.BorderSizePixel = 0
explodeBtn.Text = "EXPLODE"
explodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
explodeBtn.TextSize = 14
explodeBtn.Font = Enum.Font.SourceSansBold
explodeBtn.Parent = mainFrame

local flingTargetBtn = Instance.new("TextButton")
flingTargetBtn.Name = "FlingTargetButton"
flingTargetBtn.Size = UDim2.new(0, 150, 0, 35)
flingTargetBtn.Position = UDim2.new(0, 170, 0, 345)
flingTargetBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 100)
flingTargetBtn.BorderSizePixel = 0
flingTargetBtn.Text = "FLING TARGET"
flingTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flingTargetBtn.TextSize = 14
flingTargetBtn.Font = Enum.Font.SourceSansBold
flingTargetBtn.Parent = mainFrame

local viewBtn = Instance.new("TextButton")
viewBtn.Name = "ViewButton"
viewBtn.Size = UDim2.new(0, 150, 0, 35)
viewBtn.Position = UDim2.new(0, 10, 0, 390)
viewBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
viewBtn.BorderSizePixel = 0
viewBtn.Text = "VIEW PLAYER"
viewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
viewBtn.TextSize = 14
viewBtn.Font = Enum.Font.SourceSansBold
viewBtn.Parent = mainFrame

local unviewBtn = Instance.new("TextButton")
unviewBtn.Name = "UnviewButton"
unviewBtn.Size = UDim2.new(0, 150, 0, 35)
unviewBtn.Position = UDim2.new(0, 170, 0, 390)
unviewBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
unviewBtn.BorderSizePixel = 0
unviewBtn.Text = "UNVIEW"
unviewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unviewBtn.TextSize = 14
unviewBtn.Font = Enum.Font.SourceSansBold
unviewBtn.Parent = mainFrame

local divider2 = Instance.new("Frame")
divider2.Size = UDim2.new(1, -20, 0, 2)
divider2.Position = UDim2.new(0, 10, 0, 435)
divider2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
divider2.BorderSizePixel = 0
divider2.Parent = mainFrame

local respawnBtn = Instance.new("TextButton")
respawnBtn.Name = "RespawnButton"
respawnBtn.Size = UDim2.new(1, -20, 0, 35)
respawnBtn.Position = UDim2.new(0, 10, 0, 445)
respawnBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
respawnBtn.BorderSizePixel = 0
respawnBtn.Text = "RESPAWN"
respawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
respawnBtn.TextSize = 14
respawnBtn.Font = Enum.Font.SourceSansBold
respawnBtn.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 1, -25)
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
statusLabel.BorderSizePixel = 0
statusLabel.Text = "Ready"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.SourceSans
statusLabel.Parent = mainFrame

local flinging = false
local flingConnection
local noclipping = false
local speedBoost = false
local jumpBoost = false
local flingPower = 99999

local function updateStatus(text, color)
	statusLabel.Text = text
	statusLabel.TextColor3 = color or Color3.fromRGB(200, 200, 200)
end

local function findPlayer(username)
	if username == "" then
		return nil
	end

	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Name:lower():find(username:lower()) or plr.DisplayName:lower():find(username:lower()) then
			return plr
		end
	end

	return nil
end

local function startFling()
	if flinging then return end
	flinging = true

	local bambi = player.Character.HumanoidRootPart
	local velocity = Instance.new("BodyAngularVelocity")
	velocity.Parent = bambi
	velocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	velocity.AngularVelocity = Vector3.new(0, flingPower, 0)

	flingConnection = RunService.Heartbeat:Connect(function()
		bambi.CFrame = bambi.CFrame * CFrame.Angles(0, math.rad(500), 0)
	end)

	updateStatus("Fling Active! Power: " .. flingPower, Color3.fromRGB(0, 255, 0))
end

local function stopFling()
	if not flinging then return end
	flinging = false

	if flingConnection then
		flingConnection:Disconnect()
		flingConnection = nil
	end

	local bambi = player.Character.HumanoidRootPart
	for _, v in pairs(bambi:GetChildren()) do
		if v:IsA("BodyAngularVelocity") then
			v:Destroy()
		end
	end

	updateStatus("Fling Stopped", Color3.fromRGB(255, 0, 0))
end

local function toggleNoclip()
	noclipping = not noclipping

	if noclipping then
		noclipBtn.Text = "NOCLIP: ON"
		noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		updateStatus("Noclip Enabled", Color3.fromRGB(0, 255, 0))

		RunService.Stepped:Connect(function()
			if noclipping and player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		noclipBtn.Text = "NOCLIP: OFF"
		noclipBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
		updateStatus("Noclip Disabled", Color3.fromRGB(255, 0, 0))

		if player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end

local function toggleCanCollide()
	if player.Character then
		local currentState = player.Character.HumanoidRootPart.CanCollide

		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = not currentState
			end
		end

		if not currentState then
			canCollideBtn.Text = "CANCOLLIDE: ON"
			canCollideBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			updateStatus("CanCollide ON", Color3.fromRGB(0, 255, 0))
		else
			canCollideBtn.Text = "CANCOLLIDE: OFF"
			canCollideBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			updateStatus("CanCollide OFF", Color3.fromRGB(255, 0, 0))
		end
	end
end

local function toggleSpeed()
	speedBoost = not speedBoost

	if player.Character and player.Character:FindFirstChild("Humanoid") then
		if speedBoost then
			player.Character.Humanoid.WalkSpeed = 100
			speedBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			updateStatus("Speed Boost ON", Color3.fromRGB(0, 255, 0))
		else
			player.Character.Humanoid.WalkSpeed = 16
			speedBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
			updateStatus("Speed Boost OFF", Color3.fromRGB(255, 150, 0))
		end
	end
end

local function toggleJump()
	jumpBoost = not jumpBoost

	if player.Character and player.Character:FindFirstChild("Humanoid") then
		if jumpBoost then
			player.Character.Humanoid.JumpPower = 120
			jumpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			updateStatus("Jump Boost ON", Color3.fromRGB(0, 255, 0))
		else
			player.Character.Humanoid.JumpPower = 50
			jumpBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
			updateStatus("Jump Boost OFF", Color3.fromRGB(255, 150, 0))
		end
	end
end

local function teleportToPlayer()
	local targetPlayer = findPlayer(usernameBox.Text)

	if not targetPlayer then
		updateStatus("Player not found!", Color3.fromRGB(255, 0, 0))
		return
	end

	if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Player has no character!", Color3.fromRGB(255, 0, 0))
		return
	end

	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
		updateStatus("Teleported to " .. targetPlayer.Name, Color3.fromRGB(0, 255, 0))
	end
end

local function bringPlayer()
	local targetPlayer = findPlayer(usernameBox.Text)

	if not targetPlayer then
		updateStatus("Player not found!", Color3.fromRGB(255, 0, 0))
		return
	end

	if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Player has no character!", Color3.fromRGB(255, 0, 0))
		return
	end

	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		targetPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
		updateStatus("Brought " .. targetPlayer.Name, Color3.fromRGB(0, 255, 0))
	end
end

local function explodePlayer()
	local targetPlayer = findPlayer(usernameBox.Text)

	if not targetPlayer then
		updateStatus("Player not found!", Color3.fromRGB(255, 0, 0))
		return
	end

	if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Player has no character!", Color3.fromRGB(255, 0, 0))
		return
	end

	local explosion = Instance.new("Explosion")
	explosion.Position = targetPlayer.Character.HumanoidRootPart.Position
	explosion.BlastRadius = 10
	explosion.BlastPressure = 500000
	explosion.Parent = workspace

	updateStatus("Exploded " .. targetPlayer.Name, Color3.fromRGB(255, 100, 0))
end

local function flingTarget()
	local targetPlayer = findPlayer(usernameBox.Text)

	if not targetPlayer then
		updateStatus("Player not found!", Color3.fromRGB(255, 0, 0))
		return
	end

	if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Player has no character!", Color3.fromRGB(255, 0, 0))
		return
	end

	local targetHRP = targetPlayer.Character.HumanoidRootPart
	local velocity = Instance.new("BodyVelocity")
	velocity.Velocity = Vector3.new(math.random(-100, 100), 200, math.random(-100, 100))
	velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	velocity.Parent = targetHRP

	task.wait(0.5)
	velocity:Destroy()

	updateStatus("Flung " .. targetPlayer.Name, Color3.fromRGB(255, 100, 0))
end

local function viewPlayer()
	local targetPlayer = findPlayer(usernameBox.Text)

	if not targetPlayer then
		updateStatus("Player not found!", Color3.fromRGB(255, 0, 0))
		return
	end

	if targetPlayer.Character then
		workspace.CurrentCamera.CameraSubject = targetPlayer.Character.Humanoid
		updateStatus("Viewing " .. targetPlayer.Name, Color3.fromRGB(0, 255, 255))
	end
end

local function unviewPlayer()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
		updateStatus("Unviewed", Color3.fromRGB(200, 200, 200))
	end
end

local function respawnPlayer()
	if player.Character then
		player.Character:BreakJoints()
		updateStatus("Respawning...", Color3.fromRGB(255, 255, 0))
	end
end

local function setFlingPower()
	local powerInput = tonumber(flingPowerBox.Text)
	if powerInput and powerInput > 0 then
		flingPower = powerInput
		currentPowerLabel.Text = tostring(flingPower)
		updateStatus("Fling power set to " .. flingPower, Color3.fromRGB(0, 255, 255))
	else
		updateStatus("Invalid power value!", Color3.fromRGB(255, 0, 0))
	end
end

flingBtn.MouseButton1Click:Connect(startFling)
stopBtn.MouseButton1Click:Connect(stopFling)
setPowerBtn.MouseButton1Click:Connect(setFlingPower)
noclipBtn.MouseButton1Click:Connect(toggleNoclip)
canCollideBtn.MouseButton1Click:Connect(toggleCanCollide)
speedBtn.MouseButton1Click:Connect(toggleSpeed)
jumpBtn.MouseButton1Click:Connect(toggleJump)
teleportBtn.MouseButton1Click:Connect(teleportToPlayer)
bringBtn.MouseButton1Click:Connect(bringPlayer)
explodeBtn.MouseButton1Click:Connect(explodePlayer)
flingTargetBtn.MouseButton1Click:Connect(flingTarget)
viewBtn.MouseButton1Click:Connect(viewPlayer)
unviewBtn.MouseButton1Click:Connect(unviewPlayer)
respawnBtn.MouseButton1Click:Connect(respawnPlayer)

player.CharacterAdded:Connect(function()
	stopFling()
	character = player.Character
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	speedBoost = false
	jumpBoost = false
end)

print("Xoninb Panel loaded!")
