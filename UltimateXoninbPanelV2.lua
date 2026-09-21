local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()

local selectedTargetPlayer = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XoninbModernPanelV5"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 620)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -310)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 180, 255)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

local windowBar = Instance.new("Frame")
windowBar.Name = "WindowBar"
windowBar.Size = UDim2.new(1, 0, 0, 30)
windowBar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
windowBar.BorderSizePixel = 0
windowBar.Parent = mainFrame

local windowTitle = Instance.new("TextLabel")
windowTitle.Size = UDim2.new(1, -140, 1, 0)
windowTitle.Position = UDim2.new(0, 10, 0, 0)
windowTitle.BackgroundTransparency = 1
windowTitle.Text = "XONINB CONTROL PANEL v5.0"
windowTitle.TextColor3 = Color3.fromRGB(180, 180, 190)
windowTitle.TextSize = 11
windowTitle.Font = Enum.Font.GothamBold
windowTitle.TextXAlignment = Enum.TextXAlignment.Left
windowTitle.Parent = windowBar

local controlsFrame = Instance.new("Frame")
controlsFrame.Name = "ControlsFrame"
controlsFrame.Size = UDim2.new(0, 120, 1, 0)
controlsFrame.Position = UDim2.new(1, -120, 0, 0)
controlsFrame.BackgroundTransparency = 1
controlsFrame.Parent = windowBar

local controlsLayout = Instance.new("UIListLayout")
controlsLayout.FillDirection = Enum.FillDirection.Horizontal
controlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
controlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
controlsLayout.Parent = controlsFrame

local function createWinButton(symbol, order, isClose)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 40, 1, 0)
	btn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
	btn.BorderSizePixel = 0
	btn.Text = symbol
	btn.TextColor3 = Color3.fromRGB(200, 200, 210)
	btn.TextSize = 12
	btn.Font = Enum.Font.GothamMedium
	btn.LayoutOrder = order
	btn.Parent = controlsFrame

	local hoverColor = isClose and Color3.fromRGB(232, 17, 35) or Color3.fromRGB(35, 35, 45)
	local textColor = isClose and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 210)

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = hoverColor
		btn.TextColor3 = textColor
	end)

	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
		btn.TextColor3 = Color3.fromRGB(200, 200, 210)
	end)

	return btn
end

local minBtn = createWinButton("—", 1, false)
local maxBtn = createWinButton("□", 2, false)
local closeBtn = createWinButton("✕", 3, true)

local isMinimized = false
local isMaximized = false
local defaultSize = UDim2.new(0, 520, 0, 620)
local defaultPos = UDim2.new(0.5, -260, 0.5, -310)

minBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 520, 0, 30)
		}):Play()
	else
		TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = isMaximized and UDim2.new(1, -40, 1, -40) or defaultSize
		}):Play()
	end
end)

maxBtn.MouseButton1Click:Connect(function()
	if isMinimized then return end
	isMaximized = not isMaximized
	if isMaximized then
		maxBtn.Text = "❐"
		TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, -40, 1, -40),
			Position = UDim2.new(0, 20, 0, 20)
		}):Play()
	else
		maxBtn.Text = "□"
		TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = defaultSize,
			Position = defaultPos
		}):Play()
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	}):Play()
	task.wait(0.2)
	mainFrame.Visible = false
end)

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 55)
header.Position = UDim2.new(0, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
header.BorderSizePixel = 0
header.Parent = mainFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(0, 38, 0, 38)
avatarImage.Position = UDim2.new(0, 10, 0, 8.5)
avatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
avatarImage.BorderSizePixel = 0
avatarImage.Parent = header

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarImage

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Color = Color3.fromRGB(0, 180, 255)
avatarStroke.Thickness = 1
avatarStroke.Parent = avatarImage

task.spawn(function()
	local content, isLoaded = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	if isLoaded then
		avatarImage.Image = content
	end
end)

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, -60, 0, 20)
welcomeLabel.Position = UDim2.new(0, 56, 0, 8)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Welcome back, " .. player.DisplayName
welcomeLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
welcomeLabel.TextSize = 14
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
welcomeLabel.Parent = header

local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, -60, 0, 18)
subLabel.Position = UDim2.new(0, 56, 0, 28)
subLabel.BackgroundTransparency = 1
subLabel.Text = "Hotkey: Right Control | Dynamic System Loaded"
subLabel.TextColor3 = Color3.fromRGB(140, 140, 155)
subLabel.TextSize = 11
subLabel.Font = Enum.Font.Gotham
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.Parent = header

local navBar = Instance.new("ScrollingFrame")
navBar.Name = "NavBar"
navBar.Size = UDim2.new(0, 120, 1, -110)
navBar.Position = UDim2.new(0, 8, 0, 90)
navBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
navBar.BorderSizePixel = 0
navBar.ScrollBarThickness = 2
navBar.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
navBar.Parent = mainFrame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 8)
navCorner.Parent = navBar

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 6)
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Parent = navBar

local navPadding = Instance.new("UIPadding")
navPadding.PaddingTop = UDim.new(0, 6)
navPadding.PaddingLeft = UDim.new(0, 4)
navPadding.PaddingRight = UDim.new(0, 4)
navPadding.Parent = navBar

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, -144, 1, -110)
contentContainer.Position = UDim2.new(0, 136, 0, 90)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 1, -20)
statusLabel.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
statusLabel.BorderSizePixel = 0
statusLabel.Text = " System Ready"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local tabs = {}
local tabOrderCount = 0

local function updateStatus(text, color)
	statusLabel.Text = " " .. text
	statusLabel.TextColor3 = color or Color3.fromRGB(200, 200, 200)
end

local function createTab(name)
	tabOrderCount = tabOrderCount + 1
	local navBtn = Instance.new("TextButton")
	navBtn.Name = name .. "TabBtn"
	navBtn.Size = UDim2.new(1, 0, 0, 32)
	navBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	navBtn.BorderSizePixel = 0
	navBtn.Text = name
	navBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
	navBtn.TextSize = 11
	navBtn.Font = Enum.Font.GothamBold
	navBtn.LayoutOrder = tabOrderCount
	navBtn.Parent = navBar

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = navBtn

	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
	page.Visible = false
	page.Parent = contentContainer

	local pageLayout = Instance.new("UIListLayout")
	pageLayout.Padding = UDim.new(0, 8)
	pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pageLayout.Parent = page

	pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		page.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 20)
	end)

	tabs[name] = {Button = navBtn, Page = page, Groups = {}}

	navBtn.MouseButton1Click:Connect(function()
		for _, tabData in pairs(tabs) do
			tabData.Page.Visible = false
			tabData.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
			tabData.Button.TextColor3 = Color3.fromRGB(180, 180, 190)
		end
		page.Visible = true
		navBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
		navBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	navBar.CanvasSize = UDim2.new(0, 0, 0, navLayout.AbsoluteContentSize.Y + 20)

	return page
end

local function createGroup(pageName, groupTitle)
	local page = tabs[pageName] and tabs[pageName].Page
	if not page then return end

	local groupFrame = Instance.new("Frame")
	groupFrame.Name = groupTitle .. "Group"
	groupFrame.Size = UDim2.new(1, -6, 0, 30)
	groupFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
	groupFrame.BorderSizePixel = 0
	groupFrame.Parent = page

	local groupCorner = Instance.new("UICorner")
	groupCorner.CornerRadius = UDim.new(0, 6)
	groupCorner.Parent = groupFrame

	local groupStroke = Instance.new("UIStroke")
	groupStroke.Color = Color3.fromRGB(40, 40, 55)
	groupStroke.Thickness = 1
	groupStroke.Parent = groupFrame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -10, 0, 24)
	titleLabel.Position = UDim2.new(0, 10, 0, 3)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = string.upper(groupTitle)
	titleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
	titleLabel.TextSize = 11
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = groupFrame

	local groupContent = Instance.new("Frame")
	groupContent.Name = "GroupContent"
	groupContent.Size = UDim2.new(1, -12, 0, 0)
	groupContent.Position = UDim2.new(0, 6, 0, 28)
	groupContent.BackgroundTransparency = 1
	groupContent.Parent = groupFrame

	local groupLayout = Instance.new("UIListLayout")
	groupLayout.Padding = UDim.new(0, 6)
	groupLayout.SortOrder = Enum.SortOrder.LayoutOrder
	groupLayout.Parent = groupContent

	groupLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		groupContent.Size = UDim2.new(1, -12, 0, groupLayout.AbsoluteContentSize.Y)
		groupFrame.Size = UDim2.new(1, -6, 0, groupLayout.AbsoluteContentSize.Y + 34)
	end)

	tabs[pageName].Groups[groupTitle] = groupContent
	return groupContent
end

local function createButton(text, parent, customColor, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 30)
	button.BackgroundColor3 = customColor or Color3.fromRGB(32, 32, 44)
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = Color3.fromRGB(230, 230, 240)
	button.TextSize = 11
	button.Font = Enum.Font.GothamBold
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(50, 50, 65)
	stroke.Thickness = 1
	stroke.Parent = button

	local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	button.MouseEnter:Connect(function()
		TweenService:Create(button, tweenInfo, {BackgroundColor3 = customColor and customColor:Lerp(Color3.fromRGB(255, 255, 255), 0.15) or Color3.fromRGB(45, 45, 60)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(0, 180, 255)}):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(button, tweenInfo, {BackgroundColor3 = customColor or Color3.fromRGB(32, 32, 44)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(50, 50, 65)}):Play()
	end)

	if callback then
		button.MouseButton1Click:Connect(callback)
	end

	return button
end

local localPage = createTab("Local")
local targetPage = createTab("Target")
local worldPage = createTab("World")
local cameraPage = createTab("Camera")
local miscPage = createTab("Misc")
local settingsPage = createTab("Settings")
local customPage = createTab("Custom")

tabs["Local"].Page.Visible = true
tabs["Local"].Button.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
tabs["Local"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local movementGrp = createGroup("Local", "Movement & Physics")
local characterGrp = createGroup("Local", "Character Attributes")

local isFlying = false
local flySpeed = 50
local flyConnection = nil
local bv, bg = nil, nil

createButton("TOGGLE FLY MODE", movementGrp, Color3.fromRGB(0, 150, 180), function()
	isFlying = not isFlying
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if isFlying and root and hum then
		updateStatus("Flying Enabled (WASD + Space/Shift)", Color3.fromRGB(0, 255, 150))
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1, 1, 1) * math.huge
		bv.Velocity = Vector3.zero
		bv.Parent = root

		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(1, 1, 1) * math.huge
		bg.CFrame = root.CFrame
		bg.Parent = root

		hum.PlatformStand = true

		flyConnection = RunService.RenderStepped:Connect(function()
			if not isFlying or not root or not hum then return end
			local cam = workspace.CurrentCamera
			local moveVector = Vector3.zero

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.new(0, 1, 0) end

			if moveVector.Magnitude > 0 then
				bv.Velocity = moveVector.Unit * flySpeed
			else
				bv.Velocity = Vector3.zero
			end
			bg.CFrame = cam.CFrame
		end)
	else
		updateStatus("Fly Mode Disabled", Color3.fromRGB(255, 90, 90))
		if flyConnection then flyConnection:Disconnect() flyConnection = nil end
		if bv then bv:Destroy() bv = nil end
		if bg then bg:Destroy() bg = nil end
		if hum then hum.PlatformStand = false end
	end
end)

local isGodMode = false
local godConnection = nil

createButton("TOGGLE GOD MODE", movementGrp, Color3.fromRGB(0, 120, 180), function()
	isGodMode = not isGodMode
	if isGodMode then
		updateStatus("God Mode Active", Color3.fromRGB(0, 255, 150))
		godConnection = RunService.Stepped:Connect(function()
			local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.MaxHealth = math.huge
				hum.Health = math.huge
				hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			end
		end)
	else
		updateStatus("God Mode Disabled", Color3.fromRGB(255, 90, 90))
		if godConnection then godConnection:Disconnect() godConnection = nil end
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.MaxHealth = 100
			hum.Health = 100
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
		end
	end
end)

local noclipping = false
local noclipConnection = nil

createButton("TOGGLE NOCLIP", movementGrp, nil, function()
	noclipping = not noclipping
	if noclipping then
		updateStatus("Noclip Enabled", Color3.fromRGB(0, 255, 150))
		noclipConnection = RunService.Stepped:Connect(function()
			if player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
			end
		end)
	else
		updateStatus("Noclip Disabled", Color3.fromRGB(255, 90, 90))
		if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
	end
end)

local spinFlinging = false
local spinFlingConnection = nil

createButton("TOGGLE SPIN FLING", movementGrp, Color3.fromRGB(180, 40, 60), function()
	spinFlinging = not spinFlinging
	if spinFlinging then
		updateStatus("Spin Fling Active", Color3.fromRGB(0, 255, 150))
		spinFlingConnection = RunService.PostSimulation:Connect(function()
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if root then root.AssemblyAngularVelocity = Vector3.new(0, 10000, 0) end
		end)
	else
		updateStatus("Spin Fling Disabled", Color3.fromRGB(255, 90, 90))
		if spinFlingConnection then spinFlingConnection:Disconnect() spinFlingConnection = nil end
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if root then root.AssemblyAngularVelocity = Vector3.zero end
	end
end)

local speedBoost = false
createButton("TOGGLE SPEED BOOST (100)", characterGrp, nil, function()
	speedBoost = not speedBoost
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = speedBoost and 100 or 16 end
	updateStatus("WalkSpeed: " .. (speedBoost and 100 or 16), Color3.fromRGB(0, 180, 255))
end)

local highSpeed = false
createButton("TOGGLE EXTREME SPEED (300)", characterGrp, nil, function()
	highSpeed = not highSpeed
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = highSpeed and 300 or 16 end
	updateStatus("WalkSpeed: " .. (highSpeed and 300 or 16), Color3.fromRGB(0, 180, 255))
end)

local jumpBoost = false
createButton("TOGGLE JUMP BOOST (120)", characterGrp, nil, function()
	jumpBoost = not jumpBoost
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.JumpPower = jumpBoost and 120 or 50 end
	updateStatus("JumpPower: " .. (jumpBoost and 120 or 50), Color3.fromRGB(0, 180, 255))
end)

local infiniteJump = false
local jumpConnection = nil
createButton("TOGGLE INFINITE JUMP", characterGrp, nil, function()
	infiniteJump = not infiniteJump
	if infiniteJump then
		updateStatus("Infinite Jump Enabled", Color3.fromRGB(0, 255, 150))
		jumpConnection = UserInputService.JumpRequest:Connect(function()
			local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		end)
	else
		updateStatus("Infinite Jump Disabled", Color3.fromRGB(255, 90, 90))
		if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
	end
end)

createButton("TOGGLE NO GRAVITY", characterGrp, nil, function()
	workspace.Gravity = (workspace.Gravity == 0) and 196.2 or 0
	updateStatus("Gravity: " .. workspace.Gravity, Color3.fromRGB(0, 180, 255))
end)

createButton("RESPAWN CHARACTER", characterGrp, Color3.fromRGB(140, 35, 45), function()
	if player.Character then player.Character:BreakJoints() updateStatus("Respawning...", Color3.fromRGB(255, 200, 0)) end
end)

createButton("RESET CHARACTER SCALE", characterGrp, nil, function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		for _, v in pairs(hum:GetChildren()) do
			if v:IsA("NumberValue") then v.Value = 1 end
		end
		updateStatus("Reset Scale Values", Color3.fromRGB(0, 255, 150))
	end
end)

createButton("TOGGLE INVISIBILITY (CLIENT)", characterGrp, nil, function()
	if player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("Decal") then
				part.Transparency = (part.Transparency == 1) and 0 or 1
			end
		end
		updateStatus("Toggled Transparency", Color3.fromRGB(0, 180, 255))
	end
end)

createButton("SIT CHARACTER", characterGrp, nil, function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.Sit = true end
end)

createButton("LAY DOWN (PLATFORMSTAND)", characterGrp, nil, function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.PlatformStand = not hum.PlatformStand end
end)

local targetSelectionGrp = createGroup("Target", "Target Selection")
local targetActionsGrp = createGroup("Target", "Player Actions")
local targetTrollsGrp = createGroup("Target", "Troll & Control")

local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(1, 0, 0, 34)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
dropdownFrame.BorderSizePixel = 0
dropdownFrame.ClipsDescendants = false
dropdownFrame.Parent = targetSelectionGrp

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 6)
dropCorner.Parent = dropdownFrame

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, -40, 1, 0)
dropdownBtn.BackgroundTransparency = 1
dropdownBtn.Text = "  Select Target Player..."
dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
dropdownBtn.TextSize = 11
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
dropdownBtn.Parent = dropdownFrame

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 30, 0, 26)
refreshBtn.Position = UDim2.new(1, -32, 0, 4)
refreshBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
refreshBtn.BorderSizePixel = 0
refreshBtn.Text = "↻"
refreshBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
refreshBtn.TextSize = 14
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.Parent = dropdownFrame

local refreshCorner = Instance.new("UICorner")
refreshCorner.CornerRadius = UDim.new(0, 4)
refreshCorner.Parent = refreshBtn

local dropList = Instance.new("ScrollingFrame")
dropList.Size = UDim2.new(1, 0, 0, 120)
dropList.Position = UDim2.new(0, 0, 1, 4)
dropList.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
dropList.BorderSizePixel = 0
dropList.ScrollBarThickness = 3
dropList.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
dropList.Visible = false
dropList.ZIndex = 10
dropList.Parent = dropdownFrame

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 6)
listCorner.Parent = dropList

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = dropList

local isDropdownOpen = false
local function toggleDropdown()
	isDropdownOpen = not isDropdownOpen
	dropList.Visible = isDropdownOpen
end
dropdownBtn.MouseButton1Click:Connect(toggleDropdown)

local function populatePlayerList()
	for _, child in pairs(dropList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	local count = 0
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player then
			count = count + 1
			local itemBtn = Instance.new("TextButton")
			itemBtn.Size = UDim2.new(1, 0, 0, 28)
			itemBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
			itemBtn.BorderSizePixel = 0
			itemBtn.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
			itemBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
			itemBtn.TextSize = 11
			itemBtn.Font = Enum.Font.Gotham
			itemBtn.TextXAlignment = Enum.TextXAlignment.Left
			itemBtn.ZIndex = 11
			itemBtn.Parent = dropList

			itemBtn.MouseButton1Click:Connect(function()
				selectedTargetPlayer = p
				dropdownBtn.Text = "  " .. p.DisplayName
				toggleDropdown()
				updateStatus("Target Selected: " .. p.DisplayName, Color3.fromRGB(0, 180, 255))
			end)
		end
	end
	dropList.CanvasSize = UDim2.new(0, 0, 0, count * 28)
end

refreshBtn.MouseButton1Click:Connect(function()
	populatePlayerList()
	updateStatus("Player List Refreshed", Color3.fromRGB(0, 255, 150))
end)
populatePlayerList()

createButton("TELEPORT TO TARGET", targetActionsGrp, nil, function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = selectedTargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
			updateStatus("Teleported to " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 255, 150))
		end
	else
		updateStatus("Select a valid target!", Color3.fromRGB(255, 80, 80))
	end
end)

createButton("ATTACH TO TARGET (BEHIND)", targetActionsGrp, nil, function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local tRoot = selectedTargetPlayer.Character.HumanoidRootPart
		if myRoot and tRoot then
			myRoot.CFrame = tRoot.CFrame * CFrame.new(0, 0, 2)
			updateStatus("Attached behind target", Color3.fromRGB(0, 255, 150))
		end
	end
end)

createButton("ATTACH TO TARGET (HEAD)", targetActionsGrp, nil, function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("Head") then
		local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local tHead = selectedTargetPlayer.Character.Head
		if myRoot and tHead then
			myRoot.CFrame = tHead.CFrame * CFrame.new(0, 2.5, 0)
			updateStatus("Standing on target head", Color3.fromRGB(0, 255, 150))
		end
	end
end)

createButton("COPY TARGET'S AVATAR", targetActionsGrp, Color3.fromRGB(0, 120, 180), function()
	if not selectedTargetPlayer then updateStatus("Select a target first!", Color3.fromRGB(255, 80, 80)) return end
	local success, err = pcall(function()
		local humDesc = Players:GetHumanoidDescriptionFromUserId(selectedTargetPlayer.UserId)
		local myHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if myHum and humDesc then myHum:ApplyDescription(humDesc) end
	end)
	if success then updateStatus("Copied avatar!", Color3.fromRGB(0, 255, 150)) else updateStatus("Failed avatar copy", Color3.fromRGB(255, 80, 80)) end
end)

local isRemoteControlling = false
local remoteControlConnection = nil
createButton("TOGGLE REMOTE CONTROL (WASD)", targetTrollsGrp, Color3.fromRGB(0, 150, 120), function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a valid target first!", Color3.fromRGB(255, 80, 80))
		return
	end

	isRemoteControlling = not isRemoteControlling
	if isRemoteControlling then
		updateStatus("Controlling " .. selectedTargetPlayer.DisplayName .. " (WASD + Mouse)", Color3.fromRGB(0, 255, 150))
		workspace.CurrentCamera.CameraSubject = selectedTargetPlayer.Character:FindFirstChildOfClass("Humanoid")

		remoteControlConnection = RunService.RenderStepped:Connect(function()
			if not selectedTargetPlayer or not selectedTargetPlayer.Character then return end
			local targetRoot = selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
			local camera = workspace.CurrentCamera
			if not targetRoot or not camera then return end

			local moveDir = Vector3.zero
			local camLook = camera.CFrame.LookVector
			local camRight = camera.CFrame.RightVector

			camLook = Vector3.new(camLook.X, 0, camLook.Z).Unit
			camRight = Vector3.new(camRight.X, 0, camRight.Z).Unit

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camLook end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camLook end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camRight end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camRight end

			if moveDir.Magnitude > 0 then
				moveDir = moveDir.Unit * 0.75
				targetRoot.CFrame = CFrame.new(targetRoot.Position + moveDir, targetRoot.Position + moveDir + camLook)
			else
				targetRoot.CFrame = CFrame.new(targetRoot.Position, targetRoot.Position + camLook)
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				local hum = selectedTargetPlayer.Character:FindFirstChildOfClass("Humanoid")
				if hum then hum.Jump = true end
			end
		end)
	else
		updateStatus("Remote Control Disabled", Color3.fromRGB(255, 90, 90))
		if remoteControlConnection then remoteControlConnection:Disconnect() remoteControlConnection = nil end
		if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
			workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
		end
	end
end)

local isRemoteFlinging = false
createButton("REMOTE TARGET FLING", targetTrollsGrp, Color3.fromRGB(180, 40, 60), function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a valid target!", Color3.fromRGB(255, 80, 80))
		return
	end
	if isRemoteFlinging then return end
	isRemoteFlinging = true
	updateStatus("Flinging " .. selectedTargetPlayer.DisplayName .. "...", Color3.fromRGB(255, 180, 0))

	local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local targetRoot = selectedTargetPlayer.Character.HumanoidRootPart

	if myRoot then
		local attachment = Instance.new("Attachment", myRoot)
		local angVel = Instance.new("AngularVelocity")
		angVel.Attachment0 = attachment
		angVel.MaxTorque = math.huge
		angVel.AngularVelocity = Vector3.new(0, 99999, 0)
		angVel.Parent = myRoot

		local connection
		local startTime = tick()
		connection = RunService.Heartbeat:Connect(function()
			if tick() - startTime > 1.5 or not isRemoteFlinging or not selectedTargetPlayer.Character then
				connection:Disconnect()
				angVel:Destroy()
				attachment:Destroy()
				isRemoteFlinging = false
				updateStatus("Remote fling finished", Color3.fromRGB(0, 255, 150))
			else
				myRoot.CFrame = targetRoot.CFrame * CFrame.new(math.random(-1, 1), 0, math.random(-1, 1))
			end
		end)
	end
end)

local isTargetSpinning = false
local targetSpinConnection = nil
createButton("TOGGLE TARGET SPIN HACK", targetTrollsGrp, Color3.fromRGB(180, 40, 60), function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a valid target!", Color3.fromRGB(255, 80, 80))
		return
	end
	isTargetSpinning = not isTargetSpinning
	if isTargetSpinning then
		updateStatus("Spinning target: " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 255, 150))
		targetSpinConnection = RunService.PostSimulation:Connect(function()
			if selectedTargetPlayer and selectedTargetPlayer.Character then
				local targetRoot = selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
				if targetRoot then targetRoot.AssemblyAngularVelocity = Vector3.new(0, 10000, 0) end
			end
		end)
	else
		updateStatus("Target Spin Disabled", Color3.fromRGB(255, 90, 90))
		if targetSpinConnection then targetSpinConnection:Disconnect() targetSpinConnection = nil end
		if selectedTargetPlayer and selectedTargetPlayer.Character then
			local targetRoot = selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
			if targetRoot then targetRoot.AssemblyAngularVelocity = Vector3.zero end
		end
	end
end)

createButton("VIEW / SPECTATE TARGET", targetTrollsGrp, nil, function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChildOfClass("Humanoid") then
		workspace.CurrentCamera.CameraSubject = selectedTargetPlayer.Character:FindFirstChildOfClass("Humanoid")
		updateStatus("Spectating " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 180, 255))
	else
		updateStatus("Select a valid target!", Color3.fromRGB(255, 80, 80))
	end
end)

createButton("RESET CAMERA VIEW", targetTrollsGrp, nil, function()
	if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
		updateStatus("Camera Reset", Color3.fromRGB(200, 200, 200))
	end
end)

createButton("ORBIT AROUND TARGET", targetTrollsGrp, nil, function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a valid target!", Color3.fromRGB(255, 80, 80))
		return
	end
	local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local tRoot = selectedTargetPlayer.Character.HumanoidRootPart
	if myRoot and tRoot then
		task.spawn(function()
			for i = 1, 100 do
				local angle = i * 0.1
				myRoot.CFrame = tRoot.CFrame * CFrame.new(math.sin(angle) * 8, 0, math.cos(angle) * 8)
				task.wait(0.03)
			end
		end)
	end
end)

createButton("BRING TARGET TO ME (CLIENT)", targetTrollsGrp, nil, function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if myRoot then
			selectedTargetPlayer.Character.HumanoidRootPart.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
			updateStatus("Brought target (Client)", Color3.fromRGB(0, 255, 150))
		end
	end
end)

createButton("FREEZE TARGET (CLIENT)", targetTrollsGrp, nil, function()
	if selectedTargetPlayer and selectedTargetPlayer.Character then
		for _, part in pairs(selectedTargetPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.Anchored = not part.Anchored end
		end
		updateStatus("Toggled Anchored on Target", Color3.fromRGB(0, 180, 255))
	end
end)

createButton("PRINT TARGET USER ID", targetTrollsGrp, nil, function()
	if selectedTargetPlayer then
		print("Target UserId:", selectedTargetPlayer.UserId)
		updateStatus("Target UserId printed to console", Color3.fromRGB(0, 255, 150))
	end
end)

createButton("PRINT TARGET ACCOUNT AGE", targetTrollsGrp, nil, function()
	if selectedTargetPlayer then
		updateStatus(selectedTargetPlayer.DisplayName .. " Age: " .. selectedTargetPlayer.AccountAge .. " days", Color3.fromRGB(0, 180, 255))
	end
end)

local timeGrp = createGroup("World", "Environment & Time")
local lightingGrp = createGroup("World", "Lighting Effects")

createButton("SET TIME: DAY (12:00)", timeGrp, nil, function() Lighting.ClockTime = 12 updateStatus("Time set to Day", Color3.fromRGB(0, 180, 255)) end)
createButton("SET TIME: NIGHT (00:00)", timeGrp, nil, function() Lighting.ClockTime = 0 updateStatus("Time set to Night", Color3.fromRGB(0, 180, 255)) end)
createButton("SET TIME: SUNSET (18:00)", timeGrp, nil, function() Lighting.ClockTime = 18 updateStatus("Time set to Sunset", Color3.fromRGB(0, 180, 255)) end)

local fullbright = false
local originalBrightness = Lighting.Brightness
local originalClock = Lighting.ClockTime
createButton("TOGGLE FULLBRIGHT", lightingGrp, Color3.fromRGB(0, 150, 180), function()
	fullbright = not fullbright
	if fullbright then
		Lighting.Brightness = 3
		Lighting.ClockTime = 14
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		updateStatus("Fullbright Enabled", Color3.fromRGB(0, 255, 150))
	else
		Lighting.Brightness = originalBrightness
		Lighting.ClockTime = originalClock
		Lighting.GlobalShadows = true
		Lighting.Ambient = Color3.fromRGB(128, 128, 128)
		updateStatus("Fullbright Disabled", Color3.fromRGB(255, 90, 90))
	end
end)

createButton("TOGGLE SHADOWS", lightingGrp, nil, function()
	Lighting.GlobalShadows = not Lighting.GlobalShadows
	updateStatus("GlobalShadows: " .. tostring(Lighting.GlobalShadows), Color3.fromRGB(0, 180, 255))
end)

createButton("CLEAR ALL FOG", lightingGrp, nil, function()
	Lighting.FogEnd = 9e9
	updateStatus("Fog Cleared", Color3.fromRGB(0, 255, 150))
end)

createButton("ADD PINK ATMOSPHERE", lightingGrp, nil, function()
	Lighting.Ambient = Color3.fromRGB(255, 180, 220)
	Lighting.ColorShift_Top = Color3.fromRGB(255, 100, 150)
	updateStatus("Pink Atmosphere Applied", Color3.fromRGB(0, 255, 150))
end)

createButton("RESET LIGHTING TO DEFAULT", lightingGrp, Color3.fromRGB(140, 35, 45), function()
	Lighting.Brightness = 2
	Lighting.ClockTime = 14
	Lighting.GlobalShadows = true
	Lighting.FogEnd = 100000
	Lighting.Ambient = Color3.fromRGB(128, 128, 128)
	Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
	updateStatus("Lighting Reset", Color3.fromRGB(200, 200, 200))
end)

local freecamGrp = createGroup("Camera", "Freecam System")
local camOptsGrp = createGroup("Camera", "Camera Options")

local freecamActive = false
local freecamCam = nil
local freecamCF = CFrame.new()
local freecamSpeed = 1
local freecamConnection = nil

createButton("TOGGLE FREECAM (3D FLY CAM)", freecamGrp, Color3.fromRGB(0, 150, 180), function()
	freecamActive = not freecamActive
	local camera = workspace.CurrentCamera

	if freecamActive then
		updateStatus("Freecam Active (WASD + Q/E + Shift)", Color3.fromRGB(0, 255, 150))
		freecamCF = camera.CFrame
		camera.CameraType = Enum.CameraType.Scriptable

		freecamConnection = RunService.RenderStepped:Connect(function(dt)
			if not freecamActive then return end

			local speed = freecamSpeed * (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 3 or 1)
			local moveVector = Vector3.zero

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + freecamCF.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - freecamCF.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - freecamCF.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + freecamCF.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.E) then moveVector = moveVector + freecamCF.UpVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveVector = moveVector - freecamCF.UpVector end

			freecamCF = freecamCF + (moveVector * speed)
			camera.CFrame = freecamCF
		end)
	else
		updateStatus("Freecam Disabled", Color3.fromRGB(255, 90, 90))
		if freecamConnection then freecamConnection:Disconnect() freecamConnection = nil end
		camera.CameraType = Enum.CameraType.Custom
		if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
			camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
		end
	end
end)

createButton("INCREASE FREECAM SPEED", freecamGrp, nil, function()
	freecamSpeed = freecamSpeed + 0.5
	updateStatus("Freecam Speed: " .. freecamSpeed, Color3.fromRGB(0, 180, 255))
end)

createButton("DECREASE FREECAM SPEED", freecamGrp, nil, function()
	freecamSpeed = math.max(0.2, freecamSpeed - 0.5)
	updateStatus("Freecam Speed: " .. freecamSpeed, Color3.fromRGB(0, 180, 255))
end)

createButton("SET FOV: 120 (WIDE)", camOptsGrp, nil, function() workspace.CurrentCamera.FieldOfView = 120 updateStatus("FOV set to 120", Color3.fromRGB(0, 180, 255)) end)
createButton("SET FOV: 70 (DEFAULT)", camOptsGrp, nil, function() workspace.CurrentCamera.FieldOfView = 70 updateStatus("FOV set to 70", Color3.fromRGB(0, 180, 255)) end)
createButton("SET FOV: 30 (ZOOM)", camOptsGrp, nil, function() workspace.CurrentCamera.FieldOfView = 30 updateStatus("FOV set to 30", Color3.fromRGB(0, 180, 255)) end)

local shakeConnection = nil
createButton("TOGGLE CAMERA SHAKE", camOptsGrp, nil, function()
	if shakeConnection then
		shakeConnection:Disconnect()
		shakeConnection = nil
		updateStatus("Camera Shake Off", Color3.fromRGB(255, 90, 90))
	else
		updateStatus("Camera Shake On", Color3.fromRGB(0, 255, 150))
		shakeConnection = RunService.RenderStepped:Connect(function()
			workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(
				math.rad(math.random(-1, 1) * 0.2),
				math.rad(math.random(-1, 1) * 0.2),
				0
			)
		end)
	end
end)

createButton("INVERT CAMERA X AXIS", camOptsGrp, nil, function()
	local cam = workspace.CurrentCamera
	cam.CFrame = cam.CFrame * CFrame.Angles(0, math.pi, 0)
	updateStatus("Inverted Camera", Color3.fromRGB(0, 180, 255))
end)

local partsGrp = createGroup("Misc", "Unanchored Parts")
local espToolsGrp = createGroup("Misc", "ESP & Visual Tools")
local utilGrp = createGroup("Misc", "Utilities & BTools")

local isCirclingParts = false
local circleConnection = nil
local circleAngle = 0

createButton("TOGGLE UNANCHORED PARTS CIRCLE", partsGrp, Color3.fromRGB(0, 150, 180), function()
	isCirclingParts = not isCirclingParts
	if isCirclingParts then
		updateStatus("Unanchored Parts Circling Active", Color3.fromRGB(0, 255, 150))
		circleConnection = RunService.RenderStepped:Connect(function(dt)
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if not root then return end

			circleAngle = circleAngle + dt * 2
			local unanchored = {}
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(player.Character) then
					table.insert(unanchored, v)
				end
			end

			local radius = 12 + (#unanchored * 0.2)
			for index, part in ipairs(unanchored) do
				local offsetAngle = circleAngle + ((index / #unanchored) * math.pi * 2)
				local targetPosition = root.Position + Vector3.new(math.cos(offsetAngle) * radius, 0, math.sin(offsetAngle) * radius)
				part.Velocity = Vector3.zero
				part.AssemblyLinearVelocity = Vector3.zero
				part.CFrame = CFrame.new(targetPosition, root.Position)
			end
		end)
	else
		updateStatus("Parts Circle Disabled", Color3.fromRGB(255, 90, 90))
		if circleConnection then circleConnection:Disconnect() circleConnection = nil end
	end
end)

createButton("BRING ALL UNANCHORED PARTS", partsGrp, nil, function()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local count = 0
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
			part.CFrame = root.CFrame * CFrame.new(0, 0, -5)
			part.Velocity = Vector3.zero
			part.AssemblyLinearVelocity = Vector3.zero
			count = count + 1
		end
	end
	updateStatus("Brought " .. count .. " unanchored parts!", Color3.fromRGB(0, 255, 150))
end)

createButton("UNANCHORED PARTS TORNADO", partsGrp, nil, function()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	task.spawn(function()
		for i = 1, 100 do
			for _, part in pairs(workspace:GetDescendants()) do
				if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
					part.CFrame = root.CFrame * CFrame.new(math.random(-15, 15), math.random(0, 20), math.random(-15, 15))
					part.AssemblyLinearVelocity = Vector3.new(0, 50, 0)
				end
			end
			task.wait(0.05)
		end
	end)
end)

createButton("FREEZE ALL UNANCHORED PARTS", partsGrp, nil, function()
	local count = 0
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
			part.Anchored = true
			count = count + 1
		end
	end
	updateStatus("Anchored " .. count .. " parts!", Color3.fromRGB(0, 255, 150))
end)

local isEspActive = false
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP_Container"
espFolder.Parent = screenGui

createButton("TOGGLE PLAYER HIGHLIGHT ESP", espToolsGrp, Color3.fromRGB(0, 180, 90), function()
	isEspActive = not isEspActive
	if isEspActive then
		updateStatus("Player ESP Enabled", Color3.fromRGB(0, 255, 150))
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local highlight = Instance.new("Highlight")
				highlight.Name = p.Name
				highlight.Adornee = p.Character
				highlight.FillColor = Color3.fromRGB(0, 180, 255)
				highlight.FillTransparency = 0.5
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.OutlineTransparency = 0
				highlight.Parent = espFolder
			end
		end
	else
		updateStatus("Player ESP Disabled", Color3.fromRGB(255, 90, 90))
		espFolder:ClearAllChildren()
	end
end)

local isTracersActive = false
local tracersConnection = nil

createButton("TOGGLE TRACERS TO PLAYERS", espToolsGrp, nil, function()
	isTracersActive = not isTracersActive
	if isTracersActive then
		updateStatus("Tracers Active", Color3.fromRGB(0, 255, 150))
		tracersConnection = RunService.RenderStepped:Connect(function()
			espFolder:ClearAllChildren()
			local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if not myRoot then return end

			for _, p in pairs(Players:GetPlayers()) do
				if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					local targetPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
					if onScreen then
						local line = Instance.new("Frame")
						line.Size = UDim2.new(0, 2, 0, 100)
						line.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
						line.BorderSizePixel = 0
						line.Position = UDim2.new(0, targetPos.X, 0, targetPos.Y)
						line.Parent = espFolder
					end
				end
			end
		end)
	else
		updateStatus("Tracers Disabled", Color3.fromRGB(255, 90, 90))
		if tracersConnection then tracersConnection:Disconnect() tracersConnection = nil end
		espFolder:ClearAllChildren()
	end
end)

createButton("GIVE CLIENT BTOOLS", utilGrp, nil, function()
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		for i = 1, 4 do
			local tool = Instance.new("HopperBin")
			tool.BinType = i
			tool.Parent = backpack
		end
		updateStatus("Client BTools Added", Color3.fromRGB(0, 255, 150))
	end
end)

createButton("REMOVE ALL DECAL TEXTURES", utilGrp, nil, function()
	local count = 0
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then
			v:Destroy()
			count = count + 1
		end
	end
	updateStatus("Removed " .. count .. " decals/textures!", Color3.fromRGB(0, 255, 150))
end)

createButton("REJOIN SAME SERVER", utilGrp, Color3.fromRGB(180, 120, 0), function()
	updateStatus("Rejoining Server...", Color3.fromRGB(255, 200, 0))
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

createButton("SERVER HOP (RANDOM)", utilGrp, Color3.fromRGB(180, 120, 0), function()
	updateStatus("Server Hopping...", Color3.fromRGB(255, 200, 0))
	TeleportService:Teleport(game.PlaceId, player)
end)

createButton("COPY CURRENT GAME PLACE ID", utilGrp, nil, function()
	if setclipboard then
		setclipboard(tostring(game.PlaceId))
		updateStatus("Place ID Copied to Clipboard!", Color3.fromRGB(0, 255, 150))
	else
		print("Place ID:", game.PlaceId)
		updateStatus("Place ID printed to console", Color3.fromRGB(0, 180, 255))
	end
end)

createButton("COPY CURRENT SERVER JOB ID", utilGrp, nil, function()
	if setclipboard then
		setclipboard(tostring(game.JobId))
		updateStatus("Job ID Copied to Clipboard!", Color3.fromRGB(0, 255, 150))
	else
		print("Job ID:", game.JobId)
		updateStatus("Job ID printed to console", Color3.fromRGB(0, 180, 255))
	end
end)

local protectGrp = createGroup("Settings", "Protections & Anti")
local uiSettingsGrp = createGroup("Settings", "UI Customization")

local antiFlingActive = false
local antiFlingConnection = nil

createButton("TOGGLE ANTI-FLING PROTECTION", protectGrp, Color3.fromRGB(0, 140, 80), function()
	antiFlingActive = not antiFlingActive
	if antiFlingActive then
		updateStatus("Anti-Fling Enabled", Color3.fromRGB(0, 255, 150))
		antiFlingConnection = RunService.Stepped:Connect(function()
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if root then
				if root.AssemblyAngularVelocity.Magnitude > 50 or root.AssemblyLinearVelocity.Magnitude > 250 then
					root.AssemblyAngularVelocity = Vector3.zero
					root.AssemblyLinearVelocity = Vector3.zero
				end
			end
			for _, otherPlr in pairs(Players:GetPlayers()) do
				if otherPlr ~= player and otherPlr.Character then
					for _, part in pairs(otherPlr.Character:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				end
			end
		end)
	else
		updateStatus("Anti-Fling Disabled", Color3.fromRGB(255, 90, 90))
		if antiFlingConnection then antiFlingConnection:Disconnect() antiFlingConnection = nil end
	end
end)

local antiAFKConnection = nil
createButton("TOGGLE ANTI-AFK SYSTEM", protectGrp, nil, function()
	if antiAFKConnection then
		antiAFKConnection:Disconnect()
		antiAFKConnection = nil
		updateStatus("Anti-AFK Disabled", Color3.fromRGB(255, 90, 90))
	else
		updateStatus("Anti-AFK Active", Color3.fromRGB(0, 255, 150))
		local VirtualUser = game:GetService("VirtualUser")
		antiAFKConnection = player.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
			updateStatus("Anti-AFK Prevented Disconnect", Color3.fromRGB(0, 255, 150))
		end)
	end
end)

createButton("SET PANEL COLOR: CYAN", uiSettingsGrp, nil, function() mainStroke.Color = Color3.fromRGB(0, 180, 255) end)
createButton("SET PANEL COLOR: PURPLE", uiSettingsGrp, nil, function() mainStroke.Color = Color3.fromRGB(180, 0, 255) end)
createButton("SET PANEL COLOR: GREEN", uiSettingsGrp, nil, function() mainStroke.Color = Color3.fromRGB(0, 255, 120) end)
createButton("SET PANEL COLOR: RED", uiSettingsGrp, nil, function() mainStroke.Color = Color3.fromRGB(255, 50, 50) end)

local builderTabGrp = createGroup("Custom", "Tab & Group Creator")
local customButtonsGrp = createGroup("Custom", "My Custom Buttons")

local tabNameInput = Instance.new("TextBox")
tabNameInput.Size = UDim2.new(1, 0, 0, 28)
tabNameInput.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
tabNameInput.BorderSizePixel = 0
tabNameInput.PlaceholderText = "  Enter New Tab Name..."
tabNameInput.Text = ""
tabNameInput.TextColor3 = Color3.fromRGB(220, 220, 230)
tabNameInput.TextSize = 11
tabNameInput.Font = Enum.Font.Gotham
tabNameInput.TextXAlignment = Enum.TextXAlignment.Left
tabNameInput.Parent = builderTabGrp

local tabInputCorner = Instance.new("UICorner")
tabInputCorner.CornerRadius = UDim.new(0, 5)
tabInputCorner.Parent = tabNameInput

createButton("CREATE NEW CUSTOM TAB", builderTabGrp, Color3.fromRGB(0, 140, 200), function()
	local name = tabNameInput.Text
	if name ~= "" and not tabs[name] then
		createTab(name)
		updateStatus("Created Tab: " .. name, Color3.fromRGB(0, 255, 150))
		tabNameInput.Text = ""
	else
		updateStatus("Invalid or Duplicate Tab Name!", Color3.fromRGB(255, 80, 80))
	end
end)

local groupTabTargetInput = Instance.new("TextBox")
groupTabTargetInput.Size = UDim2.new(1, 0, 0, 28)
groupTabTargetInput.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
groupTabTargetInput.BorderSizePixel = 0
groupTabTargetInput.PlaceholderText = "  Target Tab Name (e.g. Custom)..."
groupTabTargetInput.Text = "Custom"
groupTabTargetInput.TextColor3 = Color3.fromRGB(220, 220, 230)
groupTabTargetInput.TextSize = 11
groupTabTargetInput.Font = Enum.Font.Gotham
groupTabTargetInput.TextXAlignment = Enum.TextXAlignment.Left
groupTabTargetInput.Parent = builderTabGrp

local groupTabCorner = Instance.new("UICorner")
groupTabCorner.CornerRadius = UDim.new(0, 5)
groupTabCorner.Parent = groupTabTargetInput

local groupTitleInput = Instance.new("TextBox")
groupTitleInput.Size = UDim2.new(1, 0, 0, 28)
groupTitleInput.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
groupTitleInput.BorderSizePixel = 0
groupTitleInput.PlaceholderText = "  Enter Group Name..."
groupTitleInput.Text = ""
groupTitleInput.TextColor3 = Color3.fromRGB(220, 220, 230)
groupTitleInput.TextSize = 11
groupTitleInput.Font = Enum.Font.Gotham
groupTitleInput.TextXAlignment = Enum.TextXAlignment.Left
groupTitleInput.Parent = builderTabGrp

local groupTitleCorner = Instance.new("UICorner")
groupTitleCorner.CornerRadius = UDim.new(0, 5)
groupTitleCorner.Parent = groupTitleInput

createButton("CREATE NEW GROUP IN TAB", builderTabGrp, Color3.fromRGB(0, 140, 200), function()
	local targetTab = groupTabTargetInput.Text
	local gName = groupTitleInput.Text
	if tabs[targetTab] and gName ~= "" then
		createGroup(targetTab, gName)
		updateStatus("Created Group '" .. gName .. "' in " .. targetTab, Color3.fromRGB(0, 255, 150))
		groupTitleInput.Text = ""
	else
		updateStatus("Tab not found or Group name invalid!", Color3.fromRGB(255, 80, 80))
	end
end)

local btnNameInput = Instance.new("TextBox")
btnNameInput.Size = UDim2.new(1, 0, 0, 28)
btnNameInput.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
btnNameInput.BorderSizePixel = 0
btnNameInput.PlaceholderText = "  Button Title Text..."
btnNameInput.Text = ""
btnNameInput.TextColor3 = Color3.fromRGB(220, 220, 230)
btnNameInput.TextSize = 11
btnNameInput.Font = Enum.Font.Gotham
btnNameInput.TextXAlignment = Enum.TextXAlignment.Left
btnNameInput.Parent = customButtonsGrp

local btnNameCorner = Instance.new("UICorner")
btnNameCorner.CornerRadius = UDim.new(0, 5)
btnNameCorner.Parent = btnNameInput

local btnCodeInput = Instance.new("TextBox")
btnCodeInput.Size = UDim2.new(1, 0, 0, 28)
btnCodeInput.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
btnCodeInput.BorderSizePixel = 0
btnCodeInput.PlaceholderText = "  Lua Code (e.g. print('Hello'))..."
btnCodeInput.Text = ""
btnCodeInput.TextColor3 = Color3.fromRGB(220, 220, 230)
btnCodeInput.TextSize = 11
btnCodeInput.Font = Enum.Font.Gotham
btnCodeInput.TextXAlignment = Enum.TextXAlignment.Left
btnCodeInput.Parent = customButtonsGrp

local btnCodeCorner = Instance.new("UICorner")
btnCodeCorner.CornerRadius = UDim.new(0, 5)
btnCodeCorner.Parent = btnCodeInput

createButton("ADD DYNAMIC BUTTON", customButtonsGrp, Color3.fromRGB(0, 160, 100), function()
	local title = btnNameInput.Text
	local code = btnCodeInput.Text

	if title ~= "" and code ~= "" then
		createButton(string.upper(title), customButtonsGrp, Color3.fromRGB(40, 40, 55), function()
			local func, err = loadstring(code)
			if func then
				pcall(func)
				updateStatus("Executed: " .. title, Color3.fromRGB(0, 255, 150))
			else
				updateStatus("Code Error: " .. tostring(err), Color3.fromRGB(255, 80, 80))
			end
		end)
		updateStatus("Added Custom Button: " .. title, Color3.fromRGB(0, 255, 150))
		btnNameInput.Text = ""
		btnCodeInput.Text = ""
	else
		updateStatus("Provide Title and Code!", Color3.fromRGB(255, 80, 80))
	end
end)

local loadingOverlay = Instance.new("Frame")
loadingOverlay.Name = "LoadingOverlay"
loadingOverlay.Size = UDim2.new(1, 0, 1, 0)
loadingOverlay.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
loadingOverlay.BorderSizePixel = 0
loadingOverlay.ZIndex = 50
loadingOverlay.Parent = mainFrame

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, 0, 0, 24)
loadingTitle.Position = UDim2.new(0, 0, 0.38, 0)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "LOADING SYSTEM MODULES..."
loadingTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
loadingTitle.TextSize = 14
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.ZIndex = 51
loadingTitle.Parent = loadingOverlay

local loadingStatus = Instance.new("TextLabel")
loadingStatus.Size = UDim2.new(1, 0, 0, 20)
loadingStatus.Position = UDim2.new(0, 0, 0.44, 0)
loadingStatus.BackgroundTransparency = 1
loadingStatus.Text = "Initializing Freecam, Target Systems & Dynamic Creator"
loadingStatus.TextColor3 = Color3.fromRGB(150, 150, 165)
loadingStatus.TextSize = 11
loadingStatus.Font = Enum.Font.Gotham
loadingStatus.ZIndex = 51
loadingStatus.Parent = loadingOverlay

local spinner = Instance.new("Frame")
spinner.Size = UDim2.new(0, 36, 0, 36)
spinner.Position = UDim2.new(0.5, -18, 0.54, 0)
spinner.BackgroundTransparency = 1
spinner.ZIndex = 51
spinner.Parent = loadingOverlay

local spinnerRing = Instance.new("UIStroke")
spinnerRing.Color = Color3.fromRGB(0, 180, 255)
spinnerRing.Thickness = 3
spinnerRing.Parent = spinner

local spinnerCorner = Instance.new("UICorner")
spinnerCorner.CornerRadius = UDim.new(1, 0)
spinnerCorner.Parent = spinner

task.spawn(function()
	local spinTween = TweenService:Create(spinner, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
	spinTween:Play()

	task.wait(0.5)
	loadingStatus.Text = "Building UI Tabs & Groups..."
	task.wait(0.5)
	loadingStatus.Text = "Registering 50+ Custom Functions..."
	task.wait(0.4)

	spinTween:Cancel()
	TweenService:Create(loadingOverlay, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	TweenService:Create(loadingTitle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	TweenService:Create(loadingStatus, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	task.wait(0.4)
	loadingOverlay:Destroy()
end)

local isVisible = true
local function toggleUI()
	isVisible = not isVisible
	mainFrame.Visible = isVisible
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		toggleUI()
	end
end)

print("Xoninb Modern Panel v5.0 Loaded Successfully!")
