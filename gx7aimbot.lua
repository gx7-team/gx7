local loadstring, game, getgenv, setclipboard = loadstring, game, getgenv, setclipboard

if getgenv().Aimbot then return end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Raw%20Main.lua"))()

local Aimbot = getgenv().Aimbot
local Settings, FOVSettings, Functions = Aimbot.Settings, Aimbot.FOVSettings, Aimbot.Functions
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Parts = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}

local BlockedHotkeys = {
	W = true, A = true, S = true, D = true
}

local Themes = {
	["Dark"] = {
		Background = Color3.fromRGB(0, 0, 0),
		Secondary = Color3.fromRGB(60, 60, 60),
		Accent = Color3.fromRGB(100, 100, 100),
		Text = Color3.fromRGB(255, 255, 255),
		TextDim = Color3.fromRGB(180, 180, 180),
		Border = Color3.fromRGB(80, 80, 80),
		Success = Color3.fromRGB(0, 200, 100),
		Warning = Color3.fromRGB(255, 165, 0),
		Error = Color3.fromRGB(220, 50, 50)
	},
	["Light"] = {
		Background = Color3.fromRGB(255, 255, 255),
		Secondary = Color3.fromRGB(220, 220, 220),
		Accent = Color3.fromRGB(180, 180, 180),
		Text = Color3.fromRGB(30, 30, 30),
		TextDim = Color3.fromRGB(100, 100, 100),
		Border = Color3.fromRGB(160, 160, 160),
		Success = Color3.fromRGB(0, 180, 80),
		Warning = Color3.fromRGB(235, 145, 0),
		Error = Color3.fromRGB(200, 30, 30)
	},
	["Midnight"] = {
		Background = Color3.fromRGB(15, 15, 35),
		Secondary = Color3.fromRGB(25, 25, 50),
		Accent = Color3.fromRGB(100, 100, 200),
		Text = Color3.fromRGB(220, 220, 255),
		TextDim = Color3.fromRGB(150, 150, 200),
		Border = Color3.fromRGB(50, 50, 100),
		Success = Color3.fromRGB(100, 200, 150),
		Warning = Color3.fromRGB(255, 180, 50),
		Error = Color3.fromRGB(255, 100, 120)
	},
	["Ocean"] = {
		Background = Color3.fromRGB(15, 25, 35),
		Secondary = Color3.fromRGB(20, 35, 50),
		Accent = Color3.fromRGB(0, 180, 216),
		Text = Color3.fromRGB(220, 240, 255),
		TextDim = Color3.fromRGB(130, 160, 180),
		Border = Color3.fromRGB(30, 50, 70),
		Success = Color3.fromRGB(0, 230, 180),
		Warning = Color3.fromRGB(255, 200, 100),
		Error = Color3.fromRGB(255, 80, 100)
	},
	["Forest"] = {
		Background = Color3.fromRGB(15, 25, 15),
		Secondary = Color3.fromRGB(25, 40, 25),
		Accent = Color3.fromRGB(60, 140, 60),
		Text = Color3.fromRGB(220, 255, 220),
		TextDim = Color3.fromRGB(140, 180, 140),
		Border = Color3.fromRGB(40, 80, 40),
		Success = Color3.fromRGB(100, 220, 100),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54)
	},
	["Sunset"] = {
		Background = Color3.fromRGB(30, 20, 25),
		Secondary = Color3.fromRGB(40, 28, 35),
		Accent = Color3.fromRGB(255, 87, 34),
		Text = Color3.fromRGB(255, 240, 230),
		TextDim = Color3.fromRGB(200, 170, 160),
		Border = Color3.fromRGB(60, 40, 50),
		Success = Color3.fromRGB(255, 193, 7),
		Warning = Color3.fromRGB(255, 152, 0),
		Error = Color3.fromRGB(211, 47, 47)
	},
	["Neon"] = {
		Background = Color3.fromRGB(10, 0, 20),
		Secondary = Color3.fromRGB(20, 0, 40),
		Accent = Color3.fromRGB(255, 0, 255),
		Text = Color3.fromRGB(255, 100, 255),
		TextDim = Color3.fromRGB(200, 50, 200),
		Border = Color3.fromRGB(150, 0, 150),
		Success = Color3.fromRGB(0, 255, 150),
		Warning = Color3.fromRGB(255, 255, 0),
		Error = Color3.fromRGB(255, 50, 150)
	},
	["Cyberpunk"] = {
		Background = Color3.fromRGB(5, 10, 15),
		Secondary = Color3.fromRGB(15, 20, 30),
		Accent = Color3.fromRGB(0, 255, 255),
		Text = Color3.fromRGB(0, 255, 255),
		TextDim = Color3.fromRGB(0, 180, 180),
		Border = Color3.fromRGB(0, 150, 150),
		Success = Color3.fromRGB(255, 0, 255),
		Warning = Color3.fromRGB(255, 200, 0),
		Error = Color3.fromRGB(255, 0, 100)
	}
}

local config = {
	currentTheme = "Dark",
	transparency = 0.05,
	menuLocked = false,
	minimized = false,
	currentPage = "Settings"
}
local configFile = "aimbot_modern_config.json"
local savedPosition
if isfile and isfile(configFile) then
	pcall(function()
		local savedConfig = HttpService:JSONDecode(readfile(configFile))
		for key, value in pairs(savedConfig) do
			if config[key] ~= nil then
				config[key] = value
			end
		end
		savedPosition = UDim2.new(savedConfig.positionXScale or 0.35, savedConfig.positionXOffset or 0, savedConfig.positionYScale or 0.2, savedConfig.positionYOffset or 0)
	end)
else
	savedPosition = UDim2.new(0.35, 0, 0.2, 0)
end

if isfile and isfile(configFile) then
	pcall(function()
		local savedConfig = HttpService:JSONDecode(readfile(configFile))
		for key, value in pairs(savedConfig) do
			if config[key] ~= nil then
				config[key] = value
			end
		end
	end)
end
local themeElements = {}
local function saveConfig(frame)
	local data = {}
	for key, value in pairs(config) do
		data[key] = value
	end
	data.positionXScale = frame.Position.X.Scale
	data.positionXOffset = frame.Position.X.Offset
	data.positionYScale = frame.Position.Y.Scale
	data.positionYOffset = frame.Position.Y.Offset
	if writefile then
		pcall(function()
			writefile(configFile, HttpService:JSONEncode(data))
		end)
	end
end
local function updateThemeColors(newThemeName, frame, elements)
	local newTheme = Themes[newThemeName]
	config.currentTheme = newThemeName
	saveConfig(frame)
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine)
	for _, element in ipairs(elements) do
		if element.type == "frame" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Background}):Play()
		elseif element.type == "header" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Secondary}):Play()
		elseif element.type == "border" then
			TweenService:Create(element.obj, tweenInfo, {Color = newTheme.Accent}):Play()
		elseif element.type == "text" then
			TweenService:Create(element.obj, tweenInfo, {TextColor3 = newTheme.Text}):Play()
		elseif element.type == "toggle_container" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Secondary}):Play()
		elseif element.type == "toggle_button" then
			local isOn = element.getValue()
			TweenService:Create(element.obj, tweenInfo, {
				BackgroundColor3 = isOn and newTheme.Success or newTheme.Border
			}):Play()
		elseif element.type == "toggle_indicator" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Text}):Play()
		elseif element.type == "slider_bg" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Border}):Play()
		elseif element.type == "slider_fill" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Accent}):Play()
		elseif element.type == "dropdown_bg" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Secondary}):Play()
		elseif element.type == "dropdown_button" then
			TweenService:Create(element.obj, tweenInfo, {BackgroundColor3 = newTheme.Border}):Play()
		elseif element.type == "page_button" then
			local isActive = element.pageName == config.currentPage
			TweenService:Create(element.obj, tweenInfo, {
				BackgroundColor3 = isActive and newTheme.Accent or newTheme.Secondary,
				TextColor3 = newTheme.Text
			}):Play()
		elseif element.type == "theme_card" then
			local isSelected = element.themeName == newThemeName
			TweenService:Create(element.border, tweenInfo, {
				Color = isSelected and newTheme.Accent or element.themeColors.Border,
				Thickness = isSelected and 3 or 1
			}):Play()
		elseif element.type == "button" then
			TweenService:Create(element.obj, tweenInfo, {
				BackgroundColor3 = newTheme.Accent,
				TextColor3 = newTheme.Text
			}):Play()
		end
	end
end
local function createModernGUI()
	local theme = Themes[config.currentTheme]
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "AimbotModern_" .. math.random(10000, 999999)
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local frame = Instance.new("Frame")
	frame.Size = config.minimized and UDim2.new(0, 350, 0, 40) or UDim2.new(0, 350, 0, 580)
	frame.BackgroundColor3 = theme.Background
	frame.BackgroundTransparency = config.transparency
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = not config.menuLocked
	frame.Position = savedPosition
	frame.Parent = screenGui
	table.insert(themeElements, {type = "frame", obj = frame})
	local frameCorner = Instance.new("UICorner", frame)
	frameCorner.CornerRadius = UDim.new(0, 12)
	local border = Instance.new("UIStroke", frame)
	border.Color = theme.Accent
	border.Thickness = 2
	border.Transparency = 0.3
	table.insert(themeElements, {type = "border", obj = border})

	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundColor3 = theme.Secondary
	header.BackgroundTransparency = config.transparency
	header.BorderSizePixel = 0
	header.Parent = frame
	table.insert(themeElements, {type = "header", obj = header})
	local headerCorner = Instance.new("UICorner", header)
	headerCorner.CornerRadius = UDim.new(0, 12)
	local headerGradient = Instance.new("UIGradient", header)
	headerGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, theme.Accent),
		ColorSequenceKeypoint.new(1, theme.Secondary)
	})
	headerGradient.Rotation = 45
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -120, 1, 0)
	title.Position = UDim2.new(0, 15, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "AIMBOT BY GX7ツ"
	title.TextColor3 = theme.Text
	title.TextSize = 16
	title.Font = Enum.Font.GothamBold
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = header
	table.insert(themeElements, {type = "text", obj = title})

	local lockButton = Instance.new("TextButton")
	lockButton.Size = UDim2.new(0, 30, 0, 30)
	lockButton.Position = UDim2.new(1, -105, 0.5, -15)
	lockButton.BackgroundColor3 = config.menuLocked and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(0, 150, 255)
	lockButton.BackgroundTransparency = 0.2
	lockButton.BorderSizePixel = 0
	lockButton.Text = config.menuLocked and "🔒" or "🔓"
	lockButton.TextColor3 = theme.Text
	lockButton.TextSize = 14
	lockButton.Font = Enum.Font.GothamBold
	lockButton.Parent = header
	local lockCorner = Instance.new("UICorner", lockButton)
	lockCorner.CornerRadius = UDim.new(0, 8)
	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Size = UDim2.new(0, 30, 0, 30)
	minimizeButton.Position = UDim2.new(1, -68, 0.5, -15)
	minimizeButton.BackgroundColor3 = theme.Accent
	minimizeButton.BackgroundTransparency = 0.2
	minimizeButton.BorderSizePixel = 0
	minimizeButton.Text = config.minimized and "+" or "_"
	minimizeButton.TextColor3 = theme.Text
	minimizeButton.TextSize = 18
	minimizeButton.Font = Enum.Font.GothamBold
	minimizeButton.Parent = header
	local minCorner = Instance.new("UICorner", minimizeButton)
	minCorner.CornerRadius = UDim.new(0, 8)
	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -31, 0.5, -15)
	closeButton.BackgroundColor3 = theme.Error
	closeButton.BackgroundTransparency = 0.2
	closeButton.BorderSizePixel = 0
	closeButton.Text = "X"
	closeButton.TextColor3 = theme.Text
	closeButton.TextSize = 16
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Parent = header
	local closeCorner = Instance.new("UICorner", closeButton)
	closeCorner.CornerRadius = UDim.new(0, 8)

	local navContainer = Instance.new("Frame")
	navContainer.Size = UDim2.new(1, -20, 0, 40)
	navContainer.Position = UDim2.new(0, 10, 0, 50)
	navContainer.BackgroundTransparency = 1
	navContainer.Visible = not config.minimized
	navContainer.Parent = frame
	local navLayout = Instance.new("UIListLayout")
	navLayout.FillDirection = Enum.FillDirection.Horizontal
	navLayout.Padding = UDim.new(0, 8)
	navLayout.Parent = navContainer
	local pages = {"Settings", "FOV", "Themes", "Functions"}
	local pageButtons = {}
	for _, pageName in ipairs(pages) do
		local pageBtn = Instance.new("TextButton")
		pageBtn.Size = UDim2.new(0, 72, 1, 0)
		pageBtn.BackgroundColor3 = config.currentPage == pageName and theme.Accent or theme.Secondary
		pageBtn.BackgroundTransparency = 0.3
		pageBtn.BorderSizePixel = 0
		pageBtn.Text = pageName
		pageBtn.TextColor3 = theme.Text
		pageBtn.TextSize = 12
		pageBtn.Font = Enum.Font.GothamBold
		pageBtn.Parent = navContainer
		local btnCorner = Instance.new("UICorner", pageBtn)
		btnCorner.CornerRadius = UDim.new(0, 8)
		table.insert(themeElements, {type = "page_button", obj = pageBtn, pageName = pageName})
		pageButtons[pageName] = pageBtn
	end

	local contentFrame = Instance.new("Frame")
	contentFrame.Size = UDim2.new(1, -20, 1, -100)
	contentFrame.Position = UDim2.new(0, 10, 0, 95)
	contentFrame.BackgroundTransparency = 1
	contentFrame.Visible = not config.minimized
	contentFrame.Parent = frame

	local settingsPage = Instance.new("ScrollingFrame")
	settingsPage.Size = UDim2.new(1, 0, 1, 0)
	settingsPage.BackgroundTransparency = 1
	settingsPage.BorderSizePixel = 0
	settingsPage.ScrollBarThickness = 4
	settingsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	settingsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	settingsPage.Visible = config.currentPage == "Settings"
	settingsPage.Parent = contentFrame
	local settingsLayout = Instance.new("UIListLayout")
	settingsLayout.Padding = UDim.new(0, 8)
	settingsLayout.Parent = settingsPage
	local fovPage = Instance.new("ScrollingFrame")
	fovPage.Size = UDim2.new(1, 0, 1, 0)
	fovPage.BackgroundTransparency = 1
	fovPage.BorderSizePixel = 0
	fovPage.ScrollBarThickness = 4
	fovPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	fovPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	fovPage.Visible = config.currentPage == "FOV"
	fovPage.Parent = contentFrame
	local fovLayout = Instance.new("UIListLayout")
	fovLayout.Padding = UDim.new(0, 8)
	fovLayout.Parent = fovPage
	local themesPage = Instance.new("ScrollingFrame")
	themesPage.Size = UDim2.new(1, 0, 1, 0)
	themesPage.BackgroundTransparency = 1
	themesPage.BorderSizePixel = 0
	themesPage.ScrollBarThickness = 4
	themesPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	themesPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	themesPage.Visible = config.currentPage == "Themes"
	themesPage.Parent = contentFrame
	local themesGrid = Instance.new("UIGridLayout")
	themesGrid.CellSize = UDim2.new(0, 150, 0, 90)
	themesGrid.CellPadding = UDim2.new(0, 8, 0, 8)
	themesGrid.Parent = themesPage
	local functionsPage = Instance.new("ScrollingFrame")
	functionsPage.Size = UDim2.new(1, 0, 1, 0)
	functionsPage.BackgroundTransparency = 1
	functionsPage.BorderSizePixel = 0
	functionsPage.ScrollBarThickness = 4
	functionsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	functionsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	functionsPage.Visible = config.currentPage == "Functions"
	functionsPage.Parent = contentFrame
	local functionsLayout = Instance.new("UIListLayout")
	functionsLayout.Padding = UDim.new(0, 8)
	functionsLayout.Parent = functionsPage

	local function createToggle(parent, text, defaultValue, callback)
		local container = Instance.new("Frame")
		container.Size = UDim2.new(1, 0, 0, 35)
		container.BackgroundColor3 = theme.Secondary
		container.BackgroundTransparency = 0.5
		container.BorderSizePixel = 0
		container.Parent = parent
		table.insert(themeElements, {type = "toggle_container", obj = container})
		local corner = Instance.new("UICorner", container)
		corner.CornerRadius = UDim.new(0, 8)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -55, 1, 0)
		label.Position = UDim2.new(0, 10, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = text
		label.TextColor3 = theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.Gotham
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = container
		table.insert(themeElements, {type = "text", obj = label})
		local toggle = Instance.new("TextButton")
		toggle.Size = UDim2.new(0, 45, 0, 24)
		toggle.Position = UDim2.new(1, -50, 0.5, -12)
		toggle.BackgroundColor3 = defaultValue and theme.Success or theme.Border
		toggle.BackgroundTransparency = 0.2
		toggle.BorderSizePixel = 0
		toggle.Text = ""
		toggle.Parent = container
		local value = defaultValue
		table.insert(themeElements, {type = "toggle_button", obj = toggle, getValue = function() return value end})
		local toggleCorner = Instance.new("UICorner", toggle)
		toggleCorner.CornerRadius = UDim.new(1, 0)
		local indicator = Instance.new("Frame")
		indicator.Size = UDim2.new(0, 18, 0, 18)
		indicator.Position = defaultValue and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
		indicator.BackgroundColor3 = theme.Text
		indicator.BorderSizePixel = 0
		indicator.Parent = toggle
		table.insert(themeElements, {type = "toggle_indicator", obj = indicator})
		local indCorner = Instance.new("UICorner", indicator)
		indCorner.CornerRadius = UDim.new(1, 0)
		toggle.MouseButton1Click:Connect(function()
			value = not value
			local currentTheme = Themes[config.currentTheme]
			TweenService:Create(toggle, TweenInfo.new(0.2), {
				BackgroundColor3 = value and currentTheme.Success or currentTheme.Border
			}):Play()
			TweenService:Create(indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				Position = value and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
			}):Play()
			callback(value)
		end)
	end
	local function createSlider(parent, text, min, max, defaultValue, decimals, callback)
		local container = Instance.new("Frame")
		container.Size = UDim2.new(1, 0, 0, 60)
		container.BackgroundColor3 = theme.Secondary
		container.BackgroundTransparency = 0.5
		container.BorderSizePixel = 0
		container.Parent = parent
		table.insert(themeElements, {type = "toggle_container", obj = container})
		local corner = Instance.new("UICorner", container)
		corner.CornerRadius = UDim.new(0, 8)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -20, 0, 25)
		label.Position = UDim2.new(0, 10, 0, 5)
		label.BackgroundTransparency = 1
		label.Text = text .. ": " .. tostring(defaultValue)
		label.TextColor3 = theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = container
		table.insert(themeElements, {type = "text", obj = label})
		local sliderBg = Instance.new("Frame")
		sliderBg.Size = UDim2.new(1, -20, 0, 8)
		sliderBg.Position = UDim2.new(0, 10, 1, -18)
		sliderBg.BackgroundColor3 = theme.Border
		sliderBg.BackgroundTransparency = 0.3
		sliderBg.BorderSizePixel = 0
		sliderBg.Parent = container
		table.insert(themeElements, {type = "slider_bg", obj = sliderBg})
		local sliderCorner = Instance.new("UICorner", sliderBg)
		sliderCorner.CornerRadius = UDim.new(1, 0)
		local sliderFill = Instance.new("Frame")
		sliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
		sliderFill.BackgroundColor3 = theme.Accent
		sliderFill.BorderSizePixel = 0
		sliderFill.Parent = sliderBg
		table.insert(themeElements, {type = "slider_fill", obj = sliderFill})
		local fillCorner = Instance.new("UICorner", sliderFill)
		fillCorner.CornerRadius = UDim.new(1, 0)
		local dragging = false
		sliderBg.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				frame.Draggable = false
			end
		end)
		sliderBg.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
				frame.Draggable = not config.menuLocked
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local percent = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
				TweenService:Create(sliderFill, TweenInfo.new(0.1), {
					Size = UDim2.new(percent, 0, 1, 0)
				}):Play()
				local value = min + (max - min) * percent
				if decimals then
					value = math.floor(value * (10 ^ decimals)) / (10 ^ decimals)
				else
					value = math.floor(value)
				end
				label.Text = text .. ": " .. tostring(value)
				callback(value)
			end
		end)
	end
	local function createDropdown(parent, text, options, defaultValue, callback)
		local container = Instance.new("Frame")
		container.Size = UDim2.new(1, 0, 0, 35)
		container.BackgroundColor3 = theme.Secondary
		container.BackgroundTransparency = 0.5
		container.BorderSizePixel = 0
		container.Parent = parent
		table.insert(themeElements, {type = "dropdown_bg", obj = container})
		local corner = Instance.new("UICorner", container)
		corner.CornerRadius = UDim.new(0, 8)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.4, 0, 1, 0)
		label.Position = UDim2.new(0, 10, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = text
		label.TextColor3 = theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.Gotham
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = container
		table.insert(themeElements, {type = "text", obj = label})
		local dropdown = Instance.new("TextButton")
		dropdown.Size = UDim2.new(0.55, 0, 0, 28)
		dropdown.Position = UDim2.new(0.43, 0, 0.5, -14)
		dropdown.BackgroundColor3 = theme.Border
		dropdown.BackgroundTransparency = 0.3
		dropdown.BorderSizePixel = 0
		dropdown.Text = defaultValue
		dropdown.TextColor3 = theme.Text
		dropdown.TextSize = 12
		dropdown.Font = Enum.Font.Gotham
		dropdown.Parent = container
		table.insert(themeElements, {type = "dropdown_button", obj = dropdown})
		local dropCorner = Instance.new("UICorner", dropdown)
		dropCorner.CornerRadius = UDim.new(0, 6)
		local expanded = false
		local optionsList = Instance.new("Frame")
		optionsList.Size = UDim2.new(1, 0, 0, math.min(#options * 30, 150))
		optionsList.Position = UDim2.new(0, 0, 1, 5)
		optionsList.BackgroundColor3 = theme.Secondary
		optionsList.BorderSizePixel = 0
		optionsList.Visible = false
		optionsList.ZIndex = 10
		optionsList.Parent = dropdown
		local listCorner = Instance.new("UICorner", optionsList)
		listCorner.CornerRadius = UDim.new(0, 6)
		local optionsScroll = Instance.new("ScrollingFrame")
		optionsScroll.Size = UDim2.new(1, 0, 1, 0)
		optionsScroll.BackgroundTransparency = 1
		optionsScroll.BorderSizePixel = 0
		optionsScroll.ScrollBarThickness = 4
		optionsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		optionsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		optionsScroll.ZIndex = 11
		optionsScroll.Parent = optionsList
		local listLayout = Instance.new("UIListLayout")
		listLayout.Parent = optionsScroll
		for _, option in ipairs(options) do
			local optionBtn = Instance.new("TextButton")
			optionBtn.Size = UDim2.new(1, 0, 0, 30)
			optionBtn.BackgroundColor3 = theme.Secondary
			optionBtn.BackgroundTransparency = 0.5
			optionBtn.BorderSizePixel = 0
			optionBtn.Text = option
			optionBtn.TextColor3 = theme.Text
			optionBtn.TextSize = 12
			optionBtn.Font = Enum.Font.Gotham
			optionBtn.ZIndex = 12
			optionBtn.Parent = optionsScroll
			optionBtn.MouseButton1Click:Connect(function()
				dropdown.Text = option
				callback(option)
				optionsList.Visible = false
				expanded = false
			end)
		end
		dropdown.MouseButton1Click:Connect(function()
			expanded = not expanded
			optionsList.Visible = expanded
		end)
	end
	local function createButton(parent, text, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 0, 40)
		button.BackgroundColor3 = theme.Accent
		button.BackgroundTransparency = 0.2
		button.BorderSizePixel = 0
		button.Text = text
		button.TextColor3 = theme.Text
		button.TextSize = 14
		button.Font = Enum.Font.GothamBold
		button.Parent = parent
		table.insert(themeElements, {type = "button", obj = button})
		local btnCorner = Instance.new("UICorner", button)
		btnCorner.CornerRadius = UDim.new(0, 8)
		button.MouseButton1Click:Connect(callback)
		button.MouseEnter:Connect(function()
			TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
		end)
		button.MouseLeave:Connect(function()
			TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
		end)
	end
	local function createThemeCard(themeName, themeColors)
		local card = Instance.new("Frame")
		card.Size = UDim2.new(0, 150, 0, 90)
		card.BackgroundColor3 = themeColors.Background
		card.BorderSizePixel = 0
		card.Parent = themesPage
		local cardCorner = Instance.new("UICorner", card)
		cardCorner.CornerRadius = UDim.new(0, 10)
		local cardBorder = Instance.new("UIStroke", card)
		cardBorder.Color = config.currentTheme == themeName and theme.Accent or themeColors.Border
		cardBorder.Thickness = config.currentTheme == themeName and 3 or 1
		table.insert(themeElements, {
			type = "theme_card",
			border = cardBorder,
			themeName = themeName,
			themeColors = themeColors
		})
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, 0, 0, 30)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = themeName
		nameLabel.TextColor3 = themeColors.Text
		nameLabel.TextSize = 14
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.Parent = card
		local colorPreview = Instance.new("Frame")
		colorPreview.Size = UDim2.new(1, -20, 0, 45)
		colorPreview.Position = UDim2.new(0, 10, 0, 35)
		colorPreview.BackgroundColor3 = themeColors.Background
		colorPreview.BorderSizePixel = 0
		colorPreview.Parent = card
		local previewCorner = Instance.new("UICorner", colorPreview)
		previewCorner.CornerRadius = UDim.new(0, 6)
		local previewGradient = Instance.new("UIGradient", colorPreview)
		previewGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, themeColors.Background),
			ColorSequenceKeypoint.new(0.5, themeColors.Secondary),
			ColorSequenceKeypoint.new(1, themeColors.Accent)
		})
		previewGradient.Rotation = 90
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 1, 0)
		button.BackgroundTransparency = 1
		button.Text = ""
		button.Parent = card
		button.MouseButton1Click:Connect(function()
			updateThemeColors(themeName, frame, themeElements)
		end)
	end

	createToggle(settingsPage, "Enabled", Settings.Enabled, function(value)
		Settings.Enabled = value
	end)
	createToggle(settingsPage, "Toggle Mode", Settings.Toggle, function(value)
		Settings.Toggle = value
	end)
	createDropdown(settingsPage, "Lock Part", Parts, Settings.LockPart, function(value)
		Settings.LockPart = value
	end)

	local function createHotkeySelector(parent, text, defaultValue, callback)
		local container = Instance.new("Frame")
		container.Size = UDim2.new(1, 0, 0, 35)
		container.BackgroundColor3 = theme.Secondary
		container.BackgroundTransparency = 0.5
		container.BorderSizePixel = 0
		container.Parent = parent
		table.insert(themeElements, {type = "toggle_container", obj = container})
		local corner = Instance.new("UICorner", container)
		corner.CornerRadius = UDim.new(0, 8)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.4, 0, 1, 0)
		label.Position = UDim2.new(0, 10, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = text
		label.TextColor3 = theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.Gotham
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = container
		table.insert(themeElements, {type = "text", obj = label})
		local hotkeyButton = Instance.new("TextButton")
		hotkeyButton.Size = UDim2.new(0.55, 0, 0, 28)
		hotkeyButton.Position = UDim2.new(0.43, 0, 0.5, -14)
		hotkeyButton.BackgroundColor3 = theme.Border
		hotkeyButton.BackgroundTransparency = 0.3
		hotkeyButton.BorderSizePixel = 0
		hotkeyButton.Text = defaultValue
		hotkeyButton.TextColor3 = theme.Text
		hotkeyButton.TextSize = 12
		hotkeyButton.Font = Enum.Font.GothamBold
		hotkeyButton.Parent = container
		table.insert(themeElements, {type = "dropdown_button", obj = hotkeyButton})
		local btnCorner = Instance.new("UICorner", hotkeyButton)
		btnCorner.CornerRadius = UDim.new(0, 6)
		local listening = false
		hotkeyButton.MouseButton1Click:Connect(function()
			if listening then return end
			listening = true
			hotkeyButton.Text = "..."
			local connection
			connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					local keyName = input.KeyCode.Name

					if BlockedHotkeys[keyName] then
						task.wait(1)
						hotkeyButton.Text = "..."
						return 
					end
					hotkeyButton.Text = keyName
					callback(keyName)
					listening = false
					connection:Disconnect()
				elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
					hotkeyButton.Text = "MouseButton1"
					callback("MouseButton1")
					listening = false
					connection:Disconnect()
				elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
					hotkeyButton.Text = "MouseButton2"
					callback("MouseButton2")
					listening = false
					connection:Disconnect()
				elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
					hotkeyButton.Text = "MouseButton3"
					callback("MouseButton3")
					listening = false
					connection:Disconnect()
				end
			end)
		end)
	end
	createHotkeySelector(settingsPage, "Hotkey", Settings.TriggerKey, function(value)
		Settings.TriggerKey = value
	end)
	createSlider(settingsPage, "Smoothness", 0, 1, Settings.Sensitivity, 2, function(value)
		Settings.Sensitivity = value
	end)
	createToggle(settingsPage, "Team Check", Settings.TeamCheck, function(value)
		Settings.TeamCheck = value
	end)
	createToggle(settingsPage, "Wall Check", Settings.WallCheck, function(value)
		Settings.WallCheck = value
	end)
	createToggle(settingsPage, "Alive Check", Settings.AliveCheck, function(value)
		Settings.AliveCheck = value
	end)
	createToggle(settingsPage, "Third Person", Settings.ThirdPerson, function(value)
		Settings.ThirdPerson = value
	end)
	createSlider(settingsPage, "Third Person Sensitivity", 0.1, 5, Settings.ThirdPersonSensitivity, 1, function(value)
		Settings.ThirdPersonSensitivity = value
	end)

	createToggle(fovPage, "FOV Enabled", FOVSettings.Enabled, function(value)
		FOVSettings.Enabled = value
	end)
	createToggle(fovPage, "FOV Visible", FOVSettings.Visible, function(value)
		FOVSettings.Visible = value
	end)
	createSlider(fovPage, "FOV Amount", 10, 300, FOVSettings.Amount, 0, function(value)
		FOVSettings.Amount = value
	end)
	createToggle(fovPage, "FOV Filled", FOVSettings.Filled, function(value)
		FOVSettings.Filled = value
	end)
	createSlider(fovPage, "FOV Transparency", 0, 1, FOVSettings.Transparency, 1, function(value)
		FOVSettings.Transparency = value
	end)
	createSlider(fovPage, "FOV Thickness", 1, 50, FOVSettings.Thickness, 0, function(value)
		FOVSettings.Thickness = value
	end)

	for themeName, themeColors in pairs(Themes) do
		createThemeCard(themeName, themeColors)
	end

	createButton(functionsPage, "🔄 Reset Settings", function()

		Settings.Enabled = true
		Settings.Toggle = false
		Settings.LockPart = "Head"
		Settings.TriggerKey = "MouseButton2"
		Settings.Sensitivity = 0
		Settings.TeamCheck = false
		Settings.WallCheck = false
		Settings.AliveCheck = true
		Settings.ThirdPerson = false
		Settings.ThirdPersonSensitivity = 3

		local paginaAtual = config.currentPage
		config.currentTheme = "Dark"
		config.transparency = 0.05
		config.menuLocked = false
		config.minimized = false
		config.currentPage = paginaAtual

		if delfile then
			pcall(function()
				delfile(configFile)
			end)
		end

		themeElements = {}
		screenGui:Destroy()
		createModernGUI()
	end)
	createButton(functionsPage, "♻️ Restart Aimbot", function()
		screenGui:Destroy()
		Functions.Exit()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Raw%20Main.lua"))()
		createModernGUI()
	end)

	lockButton.MouseButton1Click:Connect(function()
		config.menuLocked = not config.menuLocked
		frame.Draggable = not config.menuLocked
		TweenService:Create(lockButton, TweenInfo.new(0.2), {
			BackgroundColor3 = config.menuLocked and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(0, 150, 255)
		}):Play()
		lockButton.Text = config.menuLocked and "🔒" or "🔓"
		saveConfig(frame)
	end)
	minimizeButton.MouseButton1Click:Connect(function()
		config.minimized = not config.minimized
		navContainer.Visible = not config.minimized
		contentFrame.Visible = not config.minimized
		TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			Size = config.minimized and UDim2.new(0, 350, 0, 40) or UDim2.new(0, 350, 0, 580)
		}):Play()
		minimizeButton.Text = config.minimized and "+" or "_"
		saveConfig(frame)
	end)
	closeButton.MouseButton1Click:Connect(function()

		if delfile then
			pcall(function()
				delfile(configFile)
			end)
		end

		screenGui:Destroy()

		pcall(function()
			Functions.Exit()
		end)

		getgenv().Aimbot = nil
		getgenv().AimbotSettings = nil
		getgenv().FOVSettings = nil
		getgenv().AimbotFunctions = nil
	end)
	for pageName, btn in pairs(pageButtons) do
		btn.MouseButton1Click:Connect(function()
			config.currentPage = pageName
			settingsPage.Visible = pageName == "Settings"
			fovPage.Visible = pageName == "FOV"
			themesPage.Visible = pageName == "Themes"
			functionsPage.Visible = pageName == "Functions"
			local currentTheme = Themes[config.currentTheme]
			for name, button in pairs(pageButtons) do
				TweenService:Create(button, TweenInfo.new(0.2), {
					BackgroundColor3 = name == pageName and currentTheme.Accent or currentTheme.Secondary
				}):Play()
			end
			saveConfig(frame)
		end)
	end
	screenGui.Parent = game:GetService("CoreGui")
	return frame
end

createModernGUI()