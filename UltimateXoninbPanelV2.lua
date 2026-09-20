local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local selectedTargetPlayer = nil

-- Screen Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XoninbModernPanel"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Container Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 440, 0, 580)
mainFrame.Position = UDim2.new(0.5, -220, 0.5, -290)
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

--------------------------------------------------------------------------------
-- WINDOWS 11 TITLE BAR & CONTROL BUTTONS
--------------------------------------------------------------------------------

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
windowTitle.Text = "XONINB CONTROL PANEL"
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
local defaultSize = UDim2.new(0, 440, 0, 580)
local defaultPos = UDim2.new(0.5, -220, 0.5, -290)

minBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 440, 0, 30)
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

--------------------------------------------------------------------------------
-- HEADER PROFILE SECTION
--------------------------------------------------------------------------------

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
subLabel.Text = "Hotkey: Right Control | Version 3.1"
subLabel.TextColor3 = Color3.fromRGB(140, 140, 155)
subLabel.TextSize = 11
subLabel.Font = Enum.Font.Gotham
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.Parent = header

-- Sidebar Navigation
local navBar = Instance.new("Frame")
navBar.Name = "NavBar"
navBar.Size = UDim2.new(0, 110, 1, -110)
navBar.Position = UDim2.new(0, 8, 0, 90)
navBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
navBar.BorderSizePixel = 0
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
navPadding.PaddingLeft = UDim.new(0, 6)
navPadding.PaddingRight = UDim.new(0, 6)
navPadding.Parent = navBar

-- Content Display Area
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, -134, 1, -110)
contentContainer.Position = UDim2.new(0, 126, 0, 90)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- Footer Status Bar
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

--------------------------------------------------------------------------------
-- HELPER FUNCTIONS
--------------------------------------------------------------------------------

local tabs = {}

local function updateStatus(text, color)
	statusLabel.Text = " " .. text
	statusLabel.TextColor3 = color or Color3.fromRGB(200, 200, 200)
end

local function createTab(name, order)
	local navBtn = Instance.new("TextButton")
	navBtn.Name = name .. "TabBtn"
	navBtn.Size = UDim2.new(1, 0, 0, 32)
	navBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	navBtn.BorderSizePixel = 0
	navBtn.Text = name
	navBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
	navBtn.TextSize = 12
	navBtn.Font = Enum.Font.GothamBold
	navBtn.LayoutOrder = order
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

	tabs[name] = {Button = navBtn, Page = page}

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

	return page
end

local function createButton(text, parent, order, customColor)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -6, 0, 34)
	button.BackgroundColor3 = customColor or Color3.fromRGB(30, 30, 40)
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = Color3.fromRGB(230, 230, 240)
	button.TextSize = 11
	button.Font = Enum.Font.GothamBold
	button.LayoutOrder = order
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
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
		TweenService:Create(button, tweenInfo, {BackgroundColor3 = customColor or Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(50, 50, 65)}):Play()
	end)

	return button
end

--------------------------------------------------------------------------------
-- TABS CREATION
--------------------------------------------------------------------------------

local localPage = createTab("Local", 1)
local targetPage = createTab("Target", 2)
local settingsPage = createTab("Settings", 3)

tabs["Local"].Page.Visible = true
tabs["Local"].Button.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
tabs["Local"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

--------------------------------------------------------------------------------
-- LOCAL TAB (FLY, GOD MODE & LOCAL CONTROLS)
--------------------------------------------------------------------------------

local flyBtn = createButton("TOGGLE FLY MODE", localPage, 1, Color3.fromRGB(0, 150, 180))
local godModeBtn = createButton("TOGGLE GOD MODE", localPage, 2, Color3.fromRGB(0, 120, 180))
local noclipBtn = createButton("TOGGLE NOCLIP", localPage, 3)
local spinFlingBtn = createButton("TOGGLE LOCAL SPIN FLING", localPage, 4, Color3.fromRGB(180, 40, 60))
local speedBtn = createButton("TOGGLE SPEED BOOST", localPage, 5)
local jumpBtn = createButton("TOGGLE JUMP BOOST", localPage, 6)
local respawnBtn = createButton("RESPAWN CHARACTER", localPage, 7, Color3.fromRGB(140, 35, 45))

local isFlying = false
local flySpeed = 50
local flyConnection = nil
local bv, bg = nil, nil

local isGodMode = false
local godConnection = nil
local noclipping = false
local spinFlinging = false
local speedBoost = false
local jumpBoost = false
local noclipConnection = nil
local spinFlingConnection = nil

-- FLY LOGIC
flyBtn.MouseButton1Click:Connect(function()
	isFlying = not isFlying
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if isFlying and root and hum then
		flyBtn.Text = "FLY MODE: ACTIVE"
		flyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
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
		flyBtn.Text = "TOGGLE FLY MODE"
		flyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 180)
		updateStatus("Fly Mode Disabled", Color3.fromRGB(255, 90, 90))

		if flyConnection then
			flyConnection:Disconnect()
			flyConnection = nil
		end
		if bv then bv:Destroy() bv = nil end
		if bg then bg:Destroy() bg = nil end
		if hum then hum.PlatformStand = false end
	end
end)

-- GOD MODE LOGIC
godModeBtn.MouseButton1Click:Connect(function()
	isGodMode = not isGodMode
	if isGodMode then
		godModeBtn.Text = "GOD MODE: ACTIVE"
		godModeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
		updateStatus("God Mode Active", Color3.fromRGB(0, 255, 150))
		
		godConnection = RunService.Stepped:Connect(function()
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.MaxHealth = math.huge
				hum.Health = math.huge
				hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			end
		end)
	else
		godModeBtn.Text = "TOGGLE GOD MODE"
		godModeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
		updateStatus("God Mode Disabled", Color3.fromRGB(255, 90, 90))
		if godConnection then
			godConnection:Disconnect()
			godConnection = nil
		end
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.MaxHealth = 100
			hum.Health = 100
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
		end
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclipping = not noclipping
	if noclipping then
		noclipBtn.Text = "NOCLIP: ACTIVE"
		updateStatus("Noclip Enabled", Color3.fromRGB(0, 255, 150))
		noclipConnection = RunService.Stepped:Connect(function()
			if player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		noclipBtn.Text = "TOGGLE NOCLIP"
		updateStatus("Noclip Disabled", Color3.fromRGB(255, 90, 90))
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end
	end
end)

spinFlingBtn.MouseButton1Click:Connect(function()
	spinFlinging = not spinFlinging
	if spinFlinging then
		spinFlingBtn.Text = "LOCAL SPIN FLING: ACTIVE"
		spinFlingBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
		updateStatus("Local Spin Fling Active", Color3.fromRGB(0, 255, 150))
		
		spinFlingConnection = RunService.PostSimulation:Connect(function()
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				root.AssemblyAngularVelocity = Vector3.new(0, 10000, 0)
			end
		end)
	else
		spinFlingBtn.Text = "TOGGLE LOCAL SPIN FLING"
		spinFlingBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 60)
		updateStatus("Local Spin Fling Disabled", Color3.fromRGB(255, 90, 90))
		if spinFlingConnection then
			spinFlingConnection:Disconnect()
			spinFlingConnection = nil
		end
		local char = player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then
			root.AssemblyAngularVelocity = Vector3.zero
		end
	end
end)

speedBtn.MouseButton1Click:Connect(function()
	speedBoost = not speedBoost
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = speedBoost and 100 or 16
		speedBtn.Text = speedBoost and "SPEED: 100" or "TOGGLE SPEED BOOST"
		updateStatus("WalkSpeed: " .. hum.WalkSpeed, Color3.fromRGB(0, 180, 255))
	end
end)

jumpBtn.MouseButton1Click:Connect(function()
	jumpBoost = not jumpBoost
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.JumpPower = jumpBoost and 120 or 50
		jumpBtn.Text = jumpBoost and "JUMP POWER: 120" or "TOGGLE JUMP BOOST"
		updateStatus("JumpPower: " .. hum.JumpPower, Color3.fromRGB(0, 180, 255))
	end
end)

respawnBtn.MouseButton1Click:Connect(function()
	if player.Character then
		player.Character:BreakJoints()
		updateStatus("Respawning...", Color3.fromRGB(255, 200, 0))
	end
end)

--------------------------------------------------------------------------------
-- TARGET TAB (COPY AVATAR & WASD/MOUSE REMOTE CONTROL INCLUDED)
--------------------------------------------------------------------------------

local selectLabel = Instance.new("TextLabel")
selectLabel.Size = UDim2.new(1, -6, 0, 16)
selectLabel.BackgroundTransparency = 1
selectLabel.Text = "SELECT TARGET PLAYER:"
selectLabel.TextColor3 = Color3.fromRGB(160, 160, 175)
selectLabel.TextSize = 11
selectLabel.Font = Enum.Font.GothamBold
selectLabel.TextXAlignment = Enum.TextXAlignment.Left
selectLabel.LayoutOrder = 1
selectLabel.Parent = targetPage

local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(1, -6, 0, 36)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
dropdownFrame.BorderSizePixel = 0
dropdownFrame.LayoutOrder = 2
dropdownFrame.ClipsDescendants = false
dropdownFrame.Parent = targetPage

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 6)
dropCorner.Parent = dropdownFrame

local dropStroke = Instance.new("UIStroke")
dropStroke.Color = Color3.fromRGB(45, 45, 60)
dropStroke.Thickness = 1
dropStroke.Parent = dropdownFrame

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, -40, 1, 0)
dropdownBtn.BackgroundTransparency = 1
dropdownBtn.Text = "  Select Player..."
dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
dropdownBtn.TextSize = 12
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
dropdownBtn.Parent = dropdownFrame

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 32, 0, 28)
refreshBtn.Position = UDim2.new(1, -34, 0, 4)
refreshBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
refreshBtn.BorderSizePixel = 0
refreshBtn.Text = "↻"
refreshBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
refreshBtn.TextSize = 16
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

local listStroke = Instance.new("UIStroke")
listStroke.Color = Color3.fromRGB(0, 180, 255)
listStroke.Thickness = 1
listStroke.Parent = dropList

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
		if child:IsA("TextButton") then
			child:Destroy()
		end
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

-- Target Action Buttons
local tpBtn = createButton("TELEPORT TO TARGET", targetPage, 3)
local copyAvatarBtn = createButton("COPY TARGET'S AVATAR", targetPage, 4, Color3.fromRGB(0, 120, 180))
local remoteControlBtn = createButton("TOGGLE WASD / MOUSE REMOTE CONTROL", targetPage, 5, Color3.fromRGB(0, 150, 120))
local remoteFlingBtn = createButton("REMOTE TARGET FLING", targetPage, 6, Color3.fromRGB(180, 40, 60))
local targetSpinBtn = createButton("TOGGLE TARGET SPIN HACK", targetPage, 7, Color3.fromRGB(180, 40, 60))
local viewBtn = createButton("VIEW TARGET", targetPage, 8)
local unviewBtn = createButton("RESET VIEW", targetPage, 9)

local isRemoteFlinging = false
local isTargetSpinning = false
local targetSpinConnection = nil
local isRemoteControlling = false
local remoteControlConnection = nil

-- COPY TARGET'S AVATAR LOGIC
copyAvatarBtn.MouseButton1Click:Connect(function()
	if not selectedTargetPlayer then
		updateStatus("Select a target player first!", Color3.fromRGB(255, 80, 80))
		return
	end

	local success, err = pcall(function()
		local humDesc = Players:GetHumanoidDescriptionFromUserId(selectedTargetPlayer.UserId)
		local myHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if myHum and humDesc then
			myHum:ApplyDescription(humDesc)
		end
	end)

	if success then
		updateStatus("Copied avatar of " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 255, 150))
	else
		updateStatus("Failed to copy avatar", Color3.fromRGB(255, 80, 80))
	end
end)

-- FULL WASD AND MOUSE REMOTE CONTROL LOGIC
remoteControlBtn.MouseButton1Click:Connect(function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a target player first!", Color3.fromRGB(255, 80, 80))
		return
	end

	isRemoteControlling = not isRemoteControlling

	if isRemoteControlling then
		remoteControlBtn.Text = "REMOTE CONTROL: ACTIVE"
		remoteControlBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
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
		remoteControlBtn.Text = "TOGGLE WASD / MOUSE REMOTE CONTROL"
		remoteControlBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 120)
		updateStatus("Remote Control Disabled", Color3.fromRGB(255, 90, 90))

		if remoteControlConnection then
			remoteControlConnection:Disconnect()
			remoteControlConnection = nil
		end

		if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
			workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
		end
	end
end)

-- Target Spin Logic
targetSpinBtn.MouseButton1Click:Connect(function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a target player first!", Color3.fromRGB(255, 80, 80))
		return
	end

	isTargetSpinning = not isTargetSpinning

	if isTargetSpinning then
		targetSpinBtn.Text = "TARGET SPIN: ACTIVE"
		targetSpinBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
		updateStatus("Spinning target: " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 255, 150))

		targetSpinConnection = RunService.PostSimulation:Connect(function()
			if selectedTargetPlayer and selectedTargetPlayer.Character then
				local targetRoot = selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
				if targetRoot then
					targetRoot.AssemblyAngularVelocity = Vector3.new(0, 10000, 0)
				end
			end
		end)
	else
		targetSpinBtn.Text = "TOGGLE TARGET SPIN HACK"
		targetSpinBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 60)
		updateStatus("Target Spin Disabled", Color3.fromRGB(255, 90, 90))
		if targetSpinConnection then
			targetSpinConnection:Disconnect()
			targetSpinConnection = nil
		end
		if selectedTargetPlayer and selectedTargetPlayer.Character then
			local targetRoot = selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
			if targetRoot then
				targetRoot.AssemblyAngularVelocity = Vector3.zero
			end
		end
	end
end)

tpBtn.MouseButton1Click:Connect(function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = selectedTargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
			updateStatus("Teleported to " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 255, 150))
		end
	else
		updateStatus("Select a target player first!", Color3.fromRGB(255, 80, 80))
	end
end)

remoteFlingBtn.MouseButton1Click:Connect(function()
	if not selectedTargetPlayer or not selectedTargetPlayer.Character or not selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Select a target player first!", Color3.fromRGB(255, 80, 80))
		return
	end

	if isRemoteFlinging then return end
	isRemoteFlinging = true
	updateStatus("Remote flinging " .. selectedTargetPlayer.DisplayName .. "...", Color3.fromRGB(255, 180, 0))

	local myChar = player.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
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

viewBtn.MouseButton1Click:Connect(function()
	if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChildOfClass("Humanoid") then
		workspace.CurrentCamera.CameraSubject = selectedTargetPlayer.Character:FindFirstChildOfClass("Humanoid")
		updateStatus("Spectating " .. selectedTargetPlayer.DisplayName, Color3.fromRGB(0, 180, 255))
	else
		updateStatus("Select a target player first!", Color3.fromRGB(255, 80, 80))
	end
end)

unviewBtn.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
		updateStatus("Camera Reset", Color3.fromRGB(200, 200, 200))
	end
end)

--------------------------------------------------------------------------------
-- SETTINGS & ANTI-FLING MODULE
--------------------------------------------------------------------------------

local antiFlingBtn = createButton("ANTI-FLING: OFF", settingsPage, 1)
local antiFlingActive = false
local antiFlingConnection = nil

local function enableAntiFling()
	antiFlingConnection = RunService.Stepped:Connect(function()
		local char = player.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")

		if root then
			if root.AssemblyAngularVelocity.Magnitude > 50 or root.AssemblyLinearVelocity.Magnitude > 250 then
				root.AssemblyAngularVelocity = Vector3.zero
				root.AssemblyLinearVelocity = Vector3.zero
			end
		end

		for _, otherPlr in pairs(Players:GetPlayers()) do
			if otherPlr ~= player and otherPlr.Character then
				for _, part in pairs(otherPlr.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end
	end)
end

antiFlingBtn.MouseButton1Click:Connect(function()
	antiFlingActive = not antiFlingActive
	if antiFlingActive then
		antiFlingBtn.Text = "ANTI-FLING: ACTIVE"
		antiFlingBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
		updateStatus("Anti-Fling Protection Enabled", Color3.fromRGB(0, 255, 150))
		enableAntiFling()
	else
		antiFlingBtn.Text = "ANTI-FLING: OFF"
		antiFlingBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		updateStatus("Anti-Fling Protection Disabled", Color3.fromRGB(255, 90, 90))
		if antiFlingConnection then
			antiFlingConnection:Disconnect()
			antiFlingConnection = nil
		end
	end
end)

--------------------------------------------------------------------------------
-- ANIMATED LOADING SCREEN OVERLAY
--------------------------------------------------------------------------------

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
loadingTitle.Text = "INITIALIZING SYSTEM..."
loadingTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
loadingTitle.TextSize = 14
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.ZIndex = 51
loadingTitle.Parent = loadingOverlay

local loadingStatus = Instance.new("TextLabel")
loadingStatus.Size = UDim2.new(1, 0, 0, 20)
loadingStatus.Position = UDim2.new(0, 0, 0.44, 0)
loadingStatus.BackgroundTransparency = 1
loadingStatus.Text = "Loading Control Modules & Avatar Data"
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

	task.wait(0.6)
	loadingStatus.Text = "Connecting Modules..."
	task.wait(0.6)
	loadingStatus.Text = "Ready!"
	task.wait(0.4)

	spinTween:Cancel()
	
	TweenService:Create(loadingOverlay, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	TweenService:Create(loadingTitle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	TweenService:Create(loadingStatus, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	
	task.wait(0.4)
	loadingOverlay:Destroy()
end)

--------------------------------------------------------------------------------
-- HOTKEY TOGGLE (RIGHT CONTROL)
--------------------------------------------------------------------------------

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

print("Xoninb Panel Initialized Successfully!")
