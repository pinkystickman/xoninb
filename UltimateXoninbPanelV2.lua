local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Screen Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XoninbModernPanel"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Container
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 500)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 180, 255)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Header & Greeting
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
header.BorderSizePixel = 0
header.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 22)
titleLabel.Position = UDim2.new(0, 15, 0, 6)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XONINB CONTROL PANEL"
titleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = header

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, -20, 0, 18)
welcomeLabel.Position = UDim2.new(0, 15, 0, 28)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Welcome back, " .. player.DisplayName .. " [Toggle: Right Control]"
welcomeLabel.TextColor3 = Color3.fromRGB(160, 160, 175)
welcomeLabel.TextSize = 12
welcomeLabel.Font = Enum.Font.Gotham
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
welcomeLabel.Parent = header

-- Sidebar / Tab Navigation Bar
local navBar = Instance.new("Frame")
navBar.Name = "NavBar"
navBar.Size = UDim2.new(0, 110, 1, -80)
navBar.Position = UDim2.new(0, 8, 0, 60)
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
contentContainer.Size = UDim2.new(1, -134, 1, -80)
contentContainer.Position = UDim2.new(0, 126, 0, 60)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- Footer Status Bar
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 1, -20)
statusLabel.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
statusLabel.BorderSizePixel = 0
statusLabel.Text = " System Ready"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

--------------------------------------------------------------------------------
-- HELPER FUNCTIONS FOR ANIMATIONS & TAB SWITCHING
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
	button.TextSize = 12
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

	button.MouseButton1Down:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.05), {Size = UDim2.new(1, -10, 0, 30)}):Play()
	end)

	button.MouseButton1Up:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.05), {Size = UDim2.new(1, -6, 0, 34)}):Play()
	end)

	return button
end

local function createTextBox(placeholder, parent, order)
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, -6, 0, 34)
	box.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	box.BorderSizePixel = 0
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
	box.Text = ""
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.TextSize = 12
	box.Font = Enum.Font.Gotham
	box.ClearTextOnFocus = false
	box.LayoutOrder = order
	box.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = box

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(45, 45, 55)
	stroke.Thickness = 1
	stroke.Parent = box

	return box
end

--------------------------------------------------------------------------------
-- CREATING TABS
--------------------------------------------------------------------------------

local localPage = createTab("Local", 1)
local targetPage = createTab("Target", 2)
local settingsPage = createTab("Settings", 3)

tabs["Local"].Page.Visible = true
tabs["Local"].Button.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
tabs["Local"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

--------------------------------------------------------------------------------
-- LOCAL TAB FEATURES (INCLUDING SPIN FLING)
--------------------------------------------------------------------------------

local noclipBtn = createButton("TOGGLE NOCLIP", localPage, 1)
local spinFlingBtn = createButton("TOGGLE SPIN FLING", localPage, 2, Color3.fromRGB(180, 40, 60))
local speedBtn = createButton("TOGGLE SPEED BOOST", localPage, 3)
local jumpBtn = createButton("TOGGLE JUMP BOOST", localPage, 4)
local respawnBtn = createButton("RESPAWN CHARACTER", localPage, 5, Color3.fromRGB(140, 35, 45))

local noclipping = false
local spinFlinging = false
local speedBoost = false
local jumpBoost = false
local noclipConnection = nil
local spinFlingConnection = nil

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

-- Spin Fling Module (Continuous High Angular Velocity)
spinFlingBtn.MouseButton1Click:Connect(function()
	spinFlinging = not spinFlinging
	if spinFlinging then
		spinFlingBtn.Text = "SPIN FLING: ACTIVE"
		spinFlingBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
		updateStatus("Spin Fling Active - Walk into players to launch them", Color3.fromRGB(0, 255, 150))
		
		spinFlingConnection = RunService.PostSimulation:Connect(function()
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				root.AssemblyAngularVelocity = Vector3.new(0, 10000, 0)
			end
		end)
	else
		spinFlingBtn.Text = "TOGGLE SPIN FLING"
		spinFlingBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 60)
		updateStatus("Spin Fling Disabled", Color3.fromRGB(255, 90, 90))
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
-- TARGET TAB FEATURES (REMOTE TARGET FLING)
--------------------------------------------------------------------------------

local targetInput = createTextBox("Target Username...", targetPage, 1)
local tpBtn = createButton("TELEPORT TO TARGET", targetPage, 2)
local remoteFlingBtn = createButton("REMOTE TARGET FLING", targetPage, 3, Color3.fromRGB(180, 40, 60))
local viewBtn = createButton("VIEW TARGET", targetPage, 4)
local unviewBtn = createButton("RESET VIEW", targetPage, 5)

local isRemoteFlinging = false

local function getTarget()
	local query = targetInput.Text:lower()
	if query == "" then return nil end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and (p.Name:lower():find(query) or p.DisplayName:lower():find(query)) then
			return p
		end
	end
	return nil
end

tpBtn.MouseButton1Click:Connect(function()
	local target = getTarget()
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
			updateStatus("Teleported to " .. target.DisplayName, Color3.fromRGB(0, 255, 150))
		end
	else
		updateStatus("Target not found!", Color3.fromRGB(255, 80, 80))
	end
end)

-- Remote Teleport-Fling Routine
remoteFlingBtn.MouseButton1Click:Connect(function()
	local target = getTarget()
	if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
		updateStatus("Invalid target for remote fling!", Color3.fromRGB(255, 80, 80))
		return
	end

	if isRemoteFlinging then return end
	isRemoteFlinging = true
	updateStatus("Remote flinging " .. target.DisplayName .. "...", Color3.fromRGB(255, 180, 0))

	local myChar = player.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	local targetRoot = target.Character.HumanoidRootPart

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
			if tick() - startTime > 1.5 or not isRemoteFlinging or not target.Character then
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
	local target = getTarget()
	if target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
		workspace.CurrentCamera.CameraSubject = target.Character:FindFirstChildOfClass("Humanoid")
		updateStatus("Spectating " .. target.DisplayName, Color3.fromRGB(0, 180, 255))
	else
		updateStatus("Target invalid!", Color3.fromRGB(255, 80, 80))
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
-- HOTKEY TOGGLE & ANIMATIONS (RIGHT CONTROL)
--------------------------------------------------------------------------------

local isVisible = true
local isAnimating = false

local function toggleUI()
	if isAnimating then return end
	isAnimating = true
	isVisible = not isVisible

	if isVisible then
		mainFrame.Visible = true
		local tween = TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 420, 0, 500),
			Position = UDim2.new(0.5, -210, 0.5, -250)
		})
		tween:Play()
		tween.Completed:Connect(function()
			isAnimating = false
		end)
	else
		local tween = TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})
		tween:Play()
		tween.Completed:Connect(function()
			mainFrame.Visible = false
			isAnimating = false
		end)
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		toggleUI()
	end
end)

-- Initial Load Animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 420, 0, 500),
	Position = UDim2.new(0.5, -210, 0.5, -250)
}):Play()

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	speedBoost = false
	jumpBoost = false
	if spinFlinging and spinFlingConnection then
		spinFlingConnection:Disconnect()
		spinFlinging = false
		spinFlingBtn.Text = "TOGGLE SPIN FLING"
	end
	if noclipping and noclipConnection then
		noclipConnection:Disconnect()
		noclipping = false
		noclipBtn.Text = "TOGGLE NOCLIP"
	end
end)

print("Xoninb Panel Initialized!")
