-- EXYY HUB (完成合体版)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", game.CoreGui)

--====================--
-- メインUI
--====================--
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 300)
frame.Position = UDim2.new(0.5, -125, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true

-- タイトル
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.Text = "EXYY HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 0)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- サブタイトル
local subtitle = Instance.new("TextLabel", frame)
subtitle.Size = UDim2.new(1, 0, 0, 25)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "TIKTOK: @mirandacallruim"
subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subtitle.Font = Enum.Font.SourceSans
subtitle.TextScaled = true

-- ボタン作成関数
local function createButton(text, color, yPos, parent)
	local btn = Instance.new("TextButton", parent or frame)
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.Position = UDim2.new(0.05, 0, 0, yPos)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.TextScaled = true
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	return btn
end

--====================--
-- ESP 機能
--====================--
local espEnabled = false

local function addESP(plr)
	if plr.Character and not plr.Character:FindFirstChild("ESPHighlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "ESPHighlight"
		highlight.Parent = plr.Character
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
		highlight.OutlineTransparency = 0
	end
end

local function removeESP(plr)
	if plr.Character and plr.Character:FindFirstChild("ESPHighlight") then
		plr.Character.ESPHighlight:Destroy()
	end
end

local function toggleESP(state)
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= player then
			if state then addESP(plr) else removeESP(plr) end
		end
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		if espEnabled then addESP(plr) end
	end)
end)

-- ESPボタン
local espBtn = createButton("ESP OFF", Color3.fromRGB(200, 0, 50), 70)
espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		espBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		espBtn.Text = "ESP ON"
		toggleESP(true)
	else
		espBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
		espBtn.Text = "ESP OFF"
		toggleESP(false)
	end
end)

--====================--
-- Instant サブGUI
--====================--
local subGui = Instance.new("Frame", gui)
subGui.Size = UDim2.new(0, 250, 0, 200)
subGui.Position = UDim2.new(0.5, -125, 0.5, -100)
subGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
subGui.BorderSizePixel = 2
subGui.Visible = false
subGui.Active = true
subGui.Draggable = true  -- ✨ ドラッグ可

-- 位置変数
local customWarpEnabled = false
local targetPosition = nil -- 初期は指定なし

-- 赤ボタン（Warp to Pos）
local warpBtn = createButton("Warp to Pos: OFF", Color3.fromRGB(200, 0, 0), 20, subGui)
warpBtn.MouseButton1Click:Connect(function()
	customWarpEnabled = not customWarpEnabled
	if customWarpEnabled and targetPosition then
		warpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		warpBtn.Text = "Warp to Pos: ON"
	else
		customWarpEnabled = false
		warpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		warpBtn.Text = "Warp to Pos: OFF"
	end
end)

-- 青ボタン（Set Position）
local setBtn = createButton("Set Position", Color3.fromRGB(0, 0, 200), 80, subGui)
setBtn.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		targetPosition = player.Character.HumanoidRootPart.Position
		print("指定位置を設定:", targetPosition)
	end
end)

-- 緑ボタン（Reset Position）
local resetBtn = createButton("Reset Position", Color3.fromRGB(0, 200, 0), 140, subGui)
resetBtn.MouseButton1Click:Connect(function()
	targetPosition = nil
	customWarpEnabled = false
	warpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	warpBtn.Text = "Warp to Pos: OFF"
	print("指定位置をリセット")
end)

-- Instant ボタン（サブGUI開閉）
local btnInstant = createButton("Instant", Color3.fromRGB(100, 0, 0), 115)
btnInstant.MouseButton1Click:Connect(function()
	subGui.Visible = not subGui.Visible
end)

-- ワープ処理
game:GetService("RunService").Heartbeat:Connect(function()
	if customWarpEnabled and targetPosition and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		hrp.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
	end
end)

--====================--
-- その他ボタン（見た目だけ）
--====================--
local btn3 = createButton("2 Dash", Color3.fromRGB(200, 0, 50), 160)
local btn4 = createButton("Superman", Color3.fromRGB(150, 0, 0), 205)
local btn5 = createButton("Anti Hit", Color3.fromRGB(200, 0, 50), 250)
