-- =============================================================================
-- DELTA MASTER v6.2.0
-- =============================================================================

if game.CoreGui:FindFirstChild("DeltaCheatMenuV5") then
    game.CoreGui.DeltaCheatMenuV5:Destroy()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local _G = getgenv and getgenv() or _G
_G.SpeedValue = 16
_G.JumpValue = 50
_G.GravityValue = 196.2
_G.FovValue = 70
_G.HitboxSize = 2
_G.FlySpeed = 50
_G.AimFov = 200
_G.AimSmooth = 0.25
_G.AimStrength = 50
_G.AimPart = "Head"
_G.AutoShoot = false
_G.FireDelay = 100
_G.InfJump = false
_G.Aimbot = false
_G.TeamCheck = false
_G.WallCheck = false
_G.Esp = false
_G.Nametags = false
_G.Noclip = false
_G.Fullbright = false
_G.FpsBypass = false
_G.AutoClicker = false
_G.AntiAfk = false
_G.HitboxExpand = false
_G.SpinBot = false
_G.InfiniteZoom = false
_G.FlingEngine = false
_G.AdminChat = false
_G.MapSuck = false
_G.Fly = false
_G.ClickTP = false
_G.Invisible = false
_G.FlyCursor = false
_G.FreezeSelf = false
_G.AutoJump = false
_G.AutoPickup = false
_G.RainbowChar = false
_G.WeatherMode = 0
_G.Trail = false
_G.XRay = false
_G.FlingObjects = false
_G.FlingRadius = 50
_G.FlingForce = 200
_G.Ragdoll = false
_G.Helicopter = false
_G.HeliSpin = 30
_G.HeliLift = 50
_G.GiantMode = false
_G.SoundSpam = false
_G.Opacity = 1
_G.SilentAim = false
_G.TriggerBot = false
_G.AimAssist = false
_G.AimTargetPriority = "Nearest"
_G.BoxEsp = false
_G.Chams = false
_G.TracerLines = false
_G.HealthBarEsp = false
_G.TeamColorEsp = false
_G.EspDistanceFilter = 99999
_G.PlayerListOverlay = false
_G.CrosshairMode = 0
_G.AutoRespawn = false
_G.AutoEquipBest = false
_G.AutoInteract = false
_G.AutoChatMsg = false
_G.AutoChatText = "Hello"
_G.AutoChatDelay = 5
_G.Sprint = false
_G.Dash = false
_G.DoubleJump = false
_G.NoFallDamage = false
_G.TouchFling = false
_G.TouchFlingPower = 300
_G.TouchFlingRange = 4
_G.ForceSit = false
_G.FlingRadiusPlayers = false
_G.RagdollAll = false
_G.GravityFlip = false
_G.CharacterClone = false
_G.FlingPlayersRadius = 20
_G.DisableParticles = false
_G.DisableShadows = false
_G.ShowFpsCounter = false
_G.LagServer = false

local LightBackup = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    GlobalShadows = Lighting.GlobalShadows
}

local CurrentThemeColor = Color3.fromHex("#00F5FF")
local Presets = {
    ["Cyber Cyan"] = "#00F5FF",
    ["Neon Purple"] = "#BF00FF",
    ["Laser Green"] = "#39FF14",
    ["Neon Red"] = "#FF1744",
    ["Plasma Gold"] = "#FFD000",
    ["Hot Pink"] = "#FF00AA"
}

local DEVELOPER_ACCOUNT = "alheard45_gamernew"
local IsDeveloper = (LocalPlayer.Name == DEVELOPER_ACCOUNT)
local LICENSE_FILE = "DeltaV5_license.json"

local b64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local b64Lookup = {}
for i = 1, #b64Chars do
    b64Lookup[b64Chars:sub(i, i)] = i - 1
end

local function b64Encode(data)
    local out = {}
    local i = 1
    while i <= #data do
        local b1 = data:byte(i) or 0
        local b2 = data:byte(i + 1)
        local b3 = data:byte(i + 2)
        local c1 = math.floor(b1 / 4)
        local c2 = (b1 % 4) * 16 + (b2 and math.floor(b2 / 16) or 0)
        local c3 = b2 and ((b2 % 16) * 4 + (b3 and math.floor(b3 / 64) or 0)) or 0
        local c4 = b3 and (b3 % 64) or 0
        out[#out + 1] = b64Chars:sub(c1 + 1, c1 + 1)
        out[#out + 1] = b64Chars:sub(c2 + 1, c2 + 1)
        out[#out + 1] = b2 and b64Chars:sub(c3 + 1, c3 + 1) or '='
        out[#out + 1] = b3 and b64Chars:sub(c4 + 1, c4 + 1) or '='
        i = i + 3
    end
    return table.concat(out)
end

local function b64Decode(data)
    data = data:gsub('[^' .. b64Chars .. '=]', '')
    local out = {}
    local i = 1
    while i <= #data do
        local c1 = b64Lookup[data:sub(i, i)] or 0
        local c2 = b64Lookup[data:sub(i + 1, i + 1)] or 0
        local c3 = b64Lookup[data:sub(i + 2, i + 2)] or 0
        local c4 = b64Lookup[data:sub(i + 3, i + 3)] or 0
        local b1 = c1 * 4 + math.floor(c2 / 16)
        local b2 = (c2 % 16) * 16 + math.floor(c3 / 4)
        local b3 = (c3 % 4) * 64 + c4
        out[#out + 1] = string.char(b1)
        if data:sub(i + 2, i + 2) ~= '=' then out[#out + 1] = string.char(b2) end
        if data:sub(i + 3, i + 3) ~= '=' then out[#out + 1] = string.char(b3) end
        i = i + 4
    end
    return table.concat(out)
end

local function VerifyKeyToken(pastedToken)
    if type(pastedToken) ~= "string" or pastedToken == "" then return false end
    local success, result = pcall(function()
        local decrypted = b64Decode(pastedToken)
        local phrase, expireStr = decrypted:match("^([^|]+)||(%d+)$")
        if not phrase or not expireStr then return false end
        if phrase ~= "6769420" then return false end
        local expireTime = tonumber(expireStr)
        if not expireTime then return false end
        return os.time() < expireTime
    end)
    return (success and result == true)
end

local function SaveLicense(token)
    if not writefile then return end
    pcall(function()
        local payload = b64Encode(token .. "|UID|" .. tostring(LocalPlayer.UserId))
        writefile(LICENSE_FILE, payload)
    end)
end

local function LoadLicense()
    if not readfile or not isfile then return nil end
    local ok, raw = pcall(readfile, LICENSE_FILE)
    if not ok or not raw or raw == "" then return nil end
    local ok2, decoded = pcall(b64Decode, raw)
    if not ok2 or not decoded then return nil end
    local token, uidStr = decoded:match("^(.-)|UID|(%d+)$")
    if not token or not uidStr then return nil end
    if tonumber(uidStr) ~= LocalPlayer.UserId then return nil end
    if VerifyKeyToken(token) then return token end
    return nil
end

local function ClearLicense()
    if delfile then pcall(delfile, LICENSE_FILE) end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaCheatMenuV5"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = ScreenGui
MinimizeBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
MinimizeBtn.Size = UDim2.new(0, 60, 0, 35)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MinimizeBtn.Text = "MENU"
MinimizeBtn.TextColor3 = CurrentThemeColor
MinimizeBtn.TextSize = 12
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Active = true
MinimizeBtn.Visible = false

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local MinStroke = Instance.new("UIStroke")
MinStroke.Color = CurrentThemeColor
MinStroke.Thickness = 2
MinStroke.Parent = MinimizeBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 420, 0, 380)
MainFrame.Active = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentThemeColor
MainStroke.Thickness = 2
MainStroke.Transparency = 0
MainStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "DELTA MASTER v6.2.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0.35, 0, 0, 25)
SearchBox.Position = UDim2.new(0.62, 0, 0, 7)
SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchBox.Text = ""
SearchBox.PlaceholderText = "Search..."
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.TextSize = 11
SearchBox.Parent = Header
local sbC = Instance.new("UICorner")
sbC.CornerRadius = UDim.new(0, 4)
sbC.Parent = SearchBox

local TabBar = Instance.new("Frame")
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.Size = UDim2.new(0, 100, 1, -40)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabBar.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 110, 0, 50)
Container.Size = UDim2.new(1, -120, 1, -60)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local function CreatePageFrame()
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.ScrollBarThickness = 0
    f.CanvasSize = UDim2.new(0, 0, 0, 2000)
    f.Parent = Container
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = f
    return f
end

local P_Movement = CreatePageFrame()
local P_Aimbot = CreatePageFrame()
local P_Combat = CreatePageFrame()
local P_Automation = CreatePageFrame()
local P_Troll = CreatePageFrame()
local P_FpsBoost = CreatePageFrame()
local P_Settings = CreatePageFrame()
local P_Search = CreatePageFrame()
local P_KeyMaker = IsDeveloper and CreatePageFrame() or nil

local FeatureRegistry = {}

local function SetupTabLink(btnName, targetPage, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 20)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.Text = btnName
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 9
    btn.Parent = TabBar
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    btn.MouseButton1Click:Connect(function()
        P_Movement.Visible = false; P_Aimbot.Visible = false; P_Combat.Visible = false
        P_Automation.Visible = false; P_Troll.Visible = false; P_FpsBoost.Visible = false
        P_Settings.Visible = false; P_Search.Visible = false
        if P_KeyMaker then P_KeyMaker.Visible = false end
        targetPage.Visible = true
    end)
    return btn
end

SetupTabLink("Movement", P_Movement, 4)
SetupTabLink("Combat Aimbot", P_Aimbot, 28)
SetupTabLink("Visuals/ESP", P_Combat, 52)
SetupTabLink("Automation", P_Automation, 76)
SetupTabLink("Troll / Chaos", P_Troll, 100)
SetupTabLink("Performance", P_FpsBoost, 124)
SetupTabLink("Settings", P_Settings, 148)
SetupTabLink("Search", P_Search, 172)
if IsDeveloper and P_KeyMaker then
    SetupTabLink("👑 Admin", P_KeyMaker, 196)
end

P_Movement.Visible = true

local function ApplyNewThemeColor(hexColor)
    CurrentThemeColor = hexColor
    MainStroke.Color = hexColor; MinStroke.Color = hexColor; MinimizeBtn.TextColor3 = hexColor
end

local function AddToggleComponent(targetPage, labelText, varName, callback)
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, 0, 0, 35)
    item.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = item
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = item
    local action = Instance.new("TextButton")
    action.Size = UDim2.new(0, 50, 0, 22)
    action.Position = UDim2.new(1, -60, 0, 6)
    action.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
    action.Text = _G[varName] and "ON" or "OFF"
    action.TextColor3 = Color3.fromRGB(255, 255, 255)
    action.Font = Enum.Font.GothamBold
    action.TextSize = 10
    action.Parent = item
    local acCorner = Instance.new("UICorner")
    acCorner.CornerRadius = UDim.new(0, 4)
    acCorner.Parent = action
    action.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        action.Text = _G[varName] and "ON" or "OFF"
        action.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
        if callback then callback(_G[varName]) end
    end)
    item.Parent = targetPage
    table.insert(FeatureRegistry, {name = string.lower(labelText), element = item, page = targetPage})
end

local function AddInputComponent(targetPage, labelText, defaultText, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 6)
    sc.Parent = frame
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 60, 0, 25)
    box.Position = UDim2.new(1, -70, 0, 7)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.Text = defaultText
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.GothamBold
    box.TextSize = 12
    box.ClearTextOnFocus = false
    box.Parent = frame
    local sbc = Instance.new("UICorner")
    sbc.CornerRadius = UDim.new(0, 4)
    sbc.Parent = box
    box.FocusLost:Connect(function(enterPressed)
        if not enterPressed then return end
        local val = tonumber(box.Text)
        if val then callback(val) else box.Text = defaultText end
    end)
    frame.Parent = targetPage
    table.insert(FeatureRegistry, {name = string.lower(labelText), element = frame, page = targetPage})
end

local function AddButtonRow(targetPage, buttons, defaultLabel)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 35)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 6); rc.Parent = row
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.4, 0, 1, 0); lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = defaultLabel
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240); lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = row
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0.55, -10, 0, 25); holder.Position = UDim2.new(0.42, 0, 0, 5)
    holder.BackgroundTransparency = 1; holder.Parent = row
    local hl = Instance.new("UIListLayout", holder)
    hl.FillDirection = Enum.FillDirection.Horizontal; hl.Padding = UDim.new(0, 4)
    for _, cfg in ipairs(buttons) do
        local b = Instance.new("TextButton", holder)
        b.Size = UDim2.new(0, 55, 1, 0)
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        b.Text = cfg.label
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold; b.TextSize = 10
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
        b.MouseButton1Click:Connect(function()
            _G[cfg.varName or "AimPart"] = cfg.value
        end)
    end
    row.Parent = targetPage
    table.insert(FeatureRegistry, {name = string.lower(defaultLabel), element = row, page = targetPage})
end

local function AddSectionHeader(targetPage, labelText)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 16)
    frame.BackgroundTransparency = 1
    frame.Parent = targetPage
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 4, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = string.upper(labelText)
    lbl.TextColor3 = CurrentThemeColor
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 1, -1)
    line.BackgroundColor3 = CurrentThemeColor
    line.BackgroundTransparency = 0.5
    line.Parent = frame
end

local function EnableDragModule(targetUi)
    local dragToggle = false
    local dragStart, startPos
    targetUi.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true; dragStart = input.Position; startPos = targetUi.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            targetUi.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

EnableDragModule(MainFrame)
EnableDragModule(MinimizeBtn)

local menuOpen = false
local animating = false
local baseSize = UDim2.new(0, 420, 0, 380)
local basePos = UDim2.new(0.2, 0, 0.2, 0)

local function TweenNumber(instance, prop, target, duration, easingStyle, easingDir)
    local TweenService = game:GetService("TweenService")
    local info = TweenInfo.new(duration, easingStyle or Enum.EasingStyle.Quad, easingDir or Enum.EasingDirection.Out)
    local goal = {}
    goal[prop] = target
    local tween = TweenService:Create(instance, info, goal)
    tween:Play()
    return tween
end

local function OpenMenu()
    if menuOpen or animating then return end
    animating = true
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(basePos.X.Scale, basePos.X.Offset, basePos.Y.Scale, basePos.Y.Offset)
    MainFrame.BackgroundTransparency = 1
    TweenNumber(MainFrame, "Size", baseSize, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenNumber(MainFrame, "BackgroundTransparency", 0.25, 0.2)
    task.wait(0.26)
    animating = false
    menuOpen = true
end

local function CloseMenu()
    if not menuOpen or animating then return end
    animating = true
    TweenNumber(MainFrame, "Size", UDim2.new(0, 0, 0, 0), 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    TweenNumber(MainFrame, "BackgroundTransparency", 1, 0.2)
    task.wait(0.21)
    MainFrame.Visible = false
    MainFrame.Size = baseSize
    MainFrame.BackgroundTransparency = 0.25
    animating = false
    menuOpen = false
end

MinimizeBtn.MouseButton1Click:Connect(function()
    if menuOpen then CloseMenu() else OpenMenu() end
end)

if UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then
    local resizeHandle = Instance.new("TextButton")
    resizeHandle.Size = UDim2.new(0, 16, 0, 16)
    resizeHandle.Position = UDim2.new(1, -16, 1, -16)
    resizeHandle.BackgroundColor3 = CurrentThemeColor
    resizeHandle.BackgroundTransparency = 0.5
    resizeHandle.Text = ""
    resizeHandle.Parent = MainFrame
    Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(0, 3)

    local resizing = false
    local resizeStart, startSize
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStart = input.Position
            startSize = MainFrame.Size
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStart
            local newX = math.clamp(startSize.X.Offset + delta.X, 320, 900)
            local newY = math.clamp(startSize.Y.Offset + delta.Y, 250, 700)
            MainFrame.Size = UDim2.new(0, newX, 0, newY)
            baseSize = MainFrame.Size
        end
    end)
end

local function DoSearch(query)
    query = string.lower(query)
    for _, child in ipairs(P_Search:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    if query == "" then return end
    for _, feat in ipairs(FeatureRegistry) do
        if string.find(feat.name, query, 1, true) then
            local clone = feat.element:Clone()
            clone.Parent = P_Search
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    if SearchBox.Text ~= "" then
        P_Movement.Visible = false; P_Aimbot.Visible = false; P_Combat.Visible = false
        P_Automation.Visible = false; P_Troll.Visible = false; P_FpsBoost.Visible = false; P_Settings.Visible = false
        if P_KeyMaker then P_KeyMaker.Visible = false end
        P_Search.Visible = true
        DoSearch(SearchBox.Text)
    else
        P_Search.Visible = false
        P_Movement.Visible = true
    end
end)

-- MOVEMENT
AddSectionHeader(P_Movement, "Flight")
AddToggleComponent(P_Movement, "Fly Engine", "Fly")
AddToggleComponent(P_Movement, "Fly to Cursor", "FlyCursor")
AddToggleComponent(P_Movement, "Freeze Self", "FreezeSelf")
AddInputComponent(P_Movement, "Fly Speed:", "50", function(val) _G.FlySpeed = val end)
AddSectionHeader(P_Movement, "Movement")
AddToggleComponent(P_Movement, "Infinite Jump", "InfJump")
AddToggleComponent(P_Movement, "Sprint (Hold LShift)", "Sprint")
AddToggleComponent(P_Movement, "Dash (Q Key)", "Dash")
AddToggleComponent(P_Movement, "Double Jump", "DoubleJump")
AddToggleComponent(P_Movement, "No Fall Damage", "NoFallDamage")
AddToggleComponent(P_Movement, "Noclip Engine", "Noclip")
AddToggleComponent(P_Movement, "Spin Bot Engine", "SpinBot")
AddSectionHeader(P_Movement, "Teleport")
AddToggleComponent(P_Movement, "Click Teleport", "ClickTP")
AddSectionHeader(P_Movement, "Values")
AddInputComponent(P_Movement, "Speed Value:", "16", function(val) _G.SpeedValue = val end)
AddInputComponent(P_Movement, "Jump Power:", "50", function(val) _G.JumpValue = val end)
AddInputComponent(P_Movement, "Gravity Mod:", "196", function(val) _G.GravityValue = val workspace.Gravity = val end)

-- AIMBOT
AddSectionHeader(P_Aimbot, "Aimbot")
AddToggleComponent(P_Aimbot, "Camera Aimbot", "Aimbot")
AddToggleComponent(P_Aimbot, "Silent Aim", "SilentAim")
AddToggleComponent(P_Aimbot, "Trigger Bot", "TriggerBot")
AddToggleComponent(P_Aimbot, "Aim Assist (Soft)", "AimAssist")
AddSectionHeader(P_Aimbot, "Filters")
AddToggleComponent(P_Aimbot, "Team Check", "TeamCheck")
AddToggleComponent(P_Aimbot, "Wall Check", "WallCheck")
AddSectionHeader(P_Aimbot, "Targeting")
AddButtonRow(P_Aimbot, {
    {label = "Head", value = "Head"},
    {label = "Torso", value = "Torso"},
    {label = "HRP", value = "HumanoidRootPart"}
}, "Aim Part:")
AddButtonRow(P_Aimbot, {
    {label = "Near", value = "Nearest", varName = "AimTargetPriority"},
    {label = "LowHP", value = "LowestHP", varName = "AimTargetPriority"}
}, "Priority:")
AddSectionHeader(P_Aimbot, "Tuning")
AddInputComponent(P_Aimbot, "FOV Radius:", "200", function(val) _G.AimFov = val end)
AddInputComponent(P_Aimbot, "Smoothing:", "0.25", function(val) _G.AimSmooth = val end)
AddInputComponent(P_Aimbot, "Aim Strength (0-100):", "50", function(val)
    _G.AimStrength = math.clamp(val, 0, 100)
    _G.AimSmooth = _G.AimStrength / 100
end)
AddToggleComponent(P_Aimbot, "Auto Shoot", "AutoShoot")
AddInputComponent(P_Aimbot, "Fire Delay (ms):", "100", function(val) _G.FireDelay = math.max(0, val) end)

-- VISUALS
AddSectionHeader(P_Combat, "ESP")
AddToggleComponent(P_Combat, "Player ESP Core", "Esp")
AddToggleComponent(P_Combat, "Box ESP", "BoxEsp")
AddToggleComponent(P_Combat, "Chams", "Chams")
AddToggleComponent(P_Combat, "Tracer Lines", "TracerLines")
AddToggleComponent(P_Combat, "Health Bar ESP", "HealthBarEsp")
AddToggleComponent(P_Combat, "Team Color ESP", "TeamColorEsp")
AddToggleComponent(P_Combat, "Dynamic Nametags", "Nametags")
AddInputComponent(P_Combat, "ESP Distance:", "99999", function(val) _G.EspDistanceFilter = val end)
AddSectionHeader(P_Combat, "Appearance")
AddToggleComponent(P_Combat, "Invisibility (Ghost)", "Invisible")
AddToggleComponent(P_Combat, "Rainbow Character", "RainbowChar")
AddToggleComponent(P_Combat, "X-Ray Mode", "XRay")
AddToggleComponent(P_Combat, "Character Trail", "Trail")
AddToggleComponent(P_Combat, "Player List Overlay", "PlayerListOverlay")
AddToggleComponent(P_Combat, "Crosshair", "CrosshairMode")
AddSectionHeader(P_Combat, "Lighting")
AddToggleComponent(P_Combat, "Fullbright Module", "Fullbright", function(state)
    if not state then
        Lighting.Ambient = LightBackup.Ambient; Lighting.OutdoorAmbient = LightBackup.OutdoorAmbient
        Lighting.Brightness = LightBackup.Brightness; Lighting.GlobalShadows = LightBackup.GlobalShadows
    end
end)
AddToggleComponent(P_Combat, "Infinite Zoom Hack", "InfiniteZoom", function(state) LocalPlayer.CameraMaxZoomDistance = state and 99999 or 400 end)
AddButtonRow(P_Combat, {
    {label = "Norm", value = 0, varName = "WeatherMode"},
    {label = "Night", value = 1, varName = "WeatherMode"},
    {label = "Fog", value = 2, varName = "WeatherMode"},
    {label = "Blood", value = 3, varName = "WeatherMode"}
}, "Weather:")
AddInputComponent(P_Combat, "Camera FOV:", "70", function(val) _G.FovValue = val Camera.FieldOfView = val end)

-- AUTOMATION
AddSectionHeader(P_Automation, "Idle")
AddToggleComponent(P_Automation, "Anti-AFK Engine", "AntiAfk")
AddToggleComponent(P_Automation, "Auto-Respawn", "AutoRespawn")
AddSectionHeader(P_Automation, "Clicks")
AddToggleComponent(P_Automation, "Auto-Touch Clicker", "AutoClicker")
AddToggleComponent(P_Automation, "Auto-Interact", "AutoInteract")
AddToggleComponent(P_Automation, "Auto-Pickup", "AutoPickup")
AddSectionHeader(P_Automation, "Movement")
AddToggleComponent(P_Automation, "Auto-Jump", "AutoJump")
AddSectionHeader(P_Automation, "Other")
AddToggleComponent(P_Automation, "Auto-Equip Best Tool", "AutoEquipBest")
AddToggleComponent(P_Automation, "Auto-Chat Message", "AutoChatMsg")
AddInputComponent(P_Automation, "Chat Message:", "Hello", function(val) _G.AutoChatText = tostring(val) end)
AddInputComponent(P_Automation, "Chat Delay (s):", "5", function(val) _G.AutoChatDelay = val end)
AddSectionHeader(P_Automation, "Combat")
AddToggleComponent(P_Automation, "Hitbox Expander", "HitboxExpand")
AddInputComponent(P_Automation, "Hitbox Factor:", "2", function(val) _G.HitboxSize = val end)

-- TROLL
AddSectionHeader(P_Troll, "Lag Server (Others Only)")
AddToggleComponent(P_Troll, "Lag Server", "LagServer")
AddSectionHeader(P_Troll, "Physics")
AddToggleComponent(P_Troll, "Physics Fling Engine", "FlingEngine", function(state) if state then _G.SpinBot = true end end)
AddToggleComponent(P_Troll, "Suck Unanchored Objects", "MapSuck")
AddToggleComponent(P_Troll, "Fling Unanchored Objects", "FlingObjects")
AddInputComponent(P_Troll, "Fling Radius:", "50", function(val) _G.FlingRadius = val end)
AddInputComponent(P_Troll, "Fling Force:", "200", function(val) _G.FlingForce = val end)
AddToggleComponent(P_Troll, "Touch Fling", "TouchFling")
AddInputComponent(P_Troll, "Touch Fling Power:", "300", function(val) _G.TouchFlingPower = val end)
AddInputComponent(P_Troll, "Touch Range:", "4", function(val) _G.TouchFlingRange = val end)
AddSectionHeader(P_Troll, "Body")
AddToggleComponent(P_Troll, "Ragdoll", "Ragdoll")
AddToggleComponent(P_Troll, "Helicopter", "Helicopter")
AddInputComponent(P_Troll, "Heli Spin Speed:", "30", function(val) _G.HeliSpin = val end)
AddInputComponent(P_Troll, "Heli Lift Speed:", "50", function(val) _G.HeliLift = val end)
AddToggleComponent(P_Troll, "Giant Mode", "GiantMode")
AddToggleComponent(P_Troll, "Character Clone", "CharacterClone")
AddSectionHeader(P_Troll, "Mass Chaos")
AddToggleComponent(P_Troll, "Force Sit All", "ForceSit")
AddToggleComponent(P_Troll, "Ragdoll All", "RagdollAll")
AddToggleComponent(P_Troll, "Fling Players in Radius", "FlingRadiusPlayers")
AddToggleComponent(P_Troll, "Gravity Flip", "GravityFlip")
AddToggleComponent(P_Troll, "Rainbow [ADMIN] Chat", "AdminChat")
AddSectionHeader(P_Troll, "Audio")
AddToggleComponent(P_Troll, "Explosion Spam", "SoundSpam")

local FlingAllBtn = Instance.new("TextButton")
FlingAllBtn.Size = UDim2.new(1, 0, 0, 32)
FlingAllBtn.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
FlingAllBtn.Text = "⚡ FLING LOBBY"
FlingAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingAllBtn.Font = Enum.Font.GothamBold
FlingAllBtn.TextSize = 10
local fac = Instance.new("UICorner")
fac.CornerRadius = UDim.new(0, 6); fac.Parent = FlingAllBtn

FlingAllBtn.MouseButton1Click:Connect(function()
    FlingAllBtn.Text = "Flinging..."
    local oldPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.CFrame
    _G.FlingEngine = true; _G.SpinBot = true
    task.spawn(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                for i = 1, 12 do
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.4, 0)
                    end
                    RunService.Heartbeat:Wait()
                end
            end
        end
        if oldPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos end
        _G.FlingEngine = false; FlingAllBtn.Text = "⚡ FLING LOBBY"
    end)
end)
FlingAllBtn.Parent = P_Troll

local GearFrame = Instance.new("Frame")
GearFrame.Size = UDim2.new(1, 0, 0, 45)
GearFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
local gCorner = Instance.new("UICorner"); gCorner.CornerRadius = UDim.new(0, 6); gCorner.Parent = GearFrame
local GearInput = Instance.new("TextBox")
GearInput.Size = UDim2.new(1, -20, 0, 25); GearInput.Position = UDim2.new(0, 10, 0, 10)
GearInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40); GearInput.Text = "Scan & Give Tool Name"
GearInput.TextColor3 = Color3.fromRGB(200, 200, 200); GearInput.Font = Enum.Font.GothamBold; GearInput.TextSize = 11; GearInput.Parent = GearFrame
GearInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local targetName = string.lower(GearInput.Text)
        local searchTargets = {game:GetService("ReplicatedStorage"), game:GetService("Lighting"), workspace}
        for _, folder in pairs(searchTargets) do
            for _, obj in pairs(folder:GetDescendants()) do
                if obj:IsA("Tool") and string.find(string.lower(obj.Name), targetName) then
                    obj:Clone().Parent = LocalPlayer:WaitForChild("Backpack")
                end
            end
        end
        GearInput.Text = "Scan Complete"
    end
end)
GearFrame.Parent = P_Troll

-- PERFORMANCE
AddSectionHeader(P_FpsBoost, "FPS")
AddToggleComponent(P_FpsBoost, "FPS Unlock Bypass", "FpsBypass", function(state)
    local capFunc = setfpscap or set_fps_cap
    if capFunc then capFunc(state and 999 or 60) end
end)
AddSectionHeader(P_FpsBoost, "Rendering")
AddToggleComponent(P_FpsBoost, "Disable Particles", "DisableParticles")
AddToggleComponent(P_FpsBoost, "Disable Shadows", "DisableShadows")
AddSectionHeader(P_FpsBoost, "Monitoring")
AddToggleComponent(P_FpsBoost, "Show FPS Counter", "ShowFpsCounter")

-- SETTINGS
AddSectionHeader(P_Settings, "Server")
local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(1, 0, 0, 32); RejoinBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 45)
RejoinBtn.Text = "Server Rejoin Connect"; RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255); RejoinBtn.Font = Enum.Font.GothamBold; RejoinBtn.TextSize = 11
local rjc = Instance.new("UICorner"); rjc.CornerRadius = UDim.new(0, 6); rjc.Parent = RejoinBtn
RejoinBtn.MouseButton1Click:Connect(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
RejoinBtn.Parent = P_Settings

local HopBtn = Instance.new("TextButton")
HopBtn.Size = UDim2.new(1, 0, 0, 32); HopBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 45)
HopBtn.Text = "Server Hop (Different Server)"; HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255); HopBtn.Font = Enum.Font.GothamBold; HopBtn.TextSize = 11
local hbc = Instance.new("UICorner"); hbc.CornerRadius = UDim.new(0, 6); hbc.Parent = HopBtn
HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = "Finding server..."
    local ok, servers = pcall(function()
        local req = request or http_request or (syn and syn.request)
        if not req then return nil end
        local resp = req({Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100", Method = "GET"})
        return resp and game:GetService("HttpService"):JSONDecode(resp.Body)
    end)
    if ok and servers and servers.data then
        for _, srv in ipairs(servers.data) do
            if srv.id ~= game.JobId and srv.playing < srv.maxPlayers then
                pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, LocalPlayer) end)
                return
            end
        end
    end
    HopBtn.Text = "Server Hop (Failed)"
    task.wait(2); HopBtn.Text = "Server Hop (Different Server)"
end)
HopBtn.Parent = P_Settings

AddSectionHeader(P_Settings, "License")
local ForgetBtn = Instance.new("TextButton")
ForgetBtn.Size = UDim2.new(1, 0, 0, 32); ForgetBtn.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
ForgetBtn.Text = "Forget Saved Key"; ForgetBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ForgetBtn.Font = Enum.Font.GothamBold; ForgetBtn.TextSize = 11
local fbc = Instance.new("UICorner"); fbc.CornerRadius = UDim.new(0, 6); fbc.Parent = ForgetBtn
ForgetBtn.MouseButton1Click:Connect(function()
    ClearLicense()
    ForgetBtn.Text = "Key Forgotten — Rejoin to Re-Lock"
    task.wait(2)
    ForgetBtn.Text = "Forget Saved Key"
end)
ForgetBtn.Parent = P_Settings

AddSectionHeader(P_Settings, "Appearance")
AddInputComponent(P_Settings, "UI Opacity (0-1):", "1", function(val) _G.Opacity = math.clamp(val, 0, 1) end)

local scaleLabel = Instance.new("TextLabel")
scaleLabel.Size = UDim2.new(1, 0, 0, 20)
scaleLabel.BackgroundTransparency = 1
scaleLabel.Text = "UI Size Preset:"
scaleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
scaleLabel.Font = Enum.Font.GothamMedium
scaleLabel.TextSize = 12
scaleLabel.TextXAlignment = Enum.TextXAlignment.Left
scaleLabel.Parent = P_Settings

local scaleRow = Instance.new("Frame")
scaleRow.Size = UDim2.new(1, 0, 0, 28)
scaleRow.BackgroundTransparency = 1
scaleRow.Parent = P_Settings
local scaleHolder = Instance.new("UIListLayout")
scaleHolder.FillDirection = Enum.FillDirection.Horizontal
scaleHolder.Padding = UDim.new(0, 6)
scaleHolder.Parent = scaleRow

local function ApplyScalePreset(sizeX, sizeY, textDelta)
    baseSize = UDim2.new(0, sizeX, 0, sizeY)
    MainFrame.Size = baseSize
    for _, obj in ipairs(MainFrame:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local baseSizeNum = obj:GetAttribute("BaseTextSize") or obj.TextSize
            obj:SetAttribute("BaseTextSize", baseSizeNum)
            obj.TextSize = math.max(7, baseSizeNum + textDelta)
        end
    end
end

for _, preset in pairs({
    {name="Small",  sizeX=340, sizeY=300, delta=-2},
    {name="Normal", sizeX=420, sizeY=380, delta=0},
    {name="Large",  sizeX=550, sizeY=480, delta=2}
}) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.31, 0, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = preset.name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.Parent = scaleRow
    b.MouseButton1Click:Connect(function()
        ApplyScalePreset(preset.sizeX, preset.sizeY, preset.delta)
    end)
end

AddSectionHeader(P_Settings, "Theme")
local GridContainer = Instance.new("Frame")
GridContainer.Size = UDim2.new(1, 0, 0, 50); GridContainer.BackgroundTransparency = 1; GridContainer.Parent = P_Settings
local grid = Instance.new("UIGridLayout"); grid.CellSize = UDim2.new(0.48, 0, 0, 22); grid.CellPadding = UDim2.new(0, 4, 0, 4); grid.Parent = GridContainer

for name, hex in pairs(Presets) do
    local p = Instance.new("TextButton")
    p.BackgroundColor3 = Color3.fromHex(hex); p.Text = name; p.TextColor3 = Color3.fromRGB(20, 20, 20); p.Font = Enum.Font.GothamBold; p.TextSize = 9
    local pc = Instance.new("UICorner"); pc.CornerRadius = UDim.new(0, 4); pc.Parent = p
    p.MouseButton1Click:Connect(function() ApplyNewThemeColor(Color3.fromHex(hex)) end)
    p.Parent = GridContainer
end

if IsDeveloper and P_KeyMaker then
    AddSectionHeader(P_KeyMaker, "Token Builder")
    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(1, 0, 0, 20)
    KeyLabel.Text = "Secret Phrase:"
    KeyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    KeyLabel.Font = Enum.Font.GothamMedium; KeyLabel.TextSize = 11; KeyLabel.BackgroundTransparency = 1; KeyLabel.Parent = P_KeyMaker
    local KeyPhraseBox = Instance.new("TextBox")
    KeyPhraseBox.Size = UDim2.new(1, 0, 0, 30)
    KeyPhraseBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyPhraseBox.Text = "6769420"
    KeyPhraseBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyPhraseBox.Font = Enum.Font.GothamBold; KeyPhraseBox.TextSize = 12; KeyPhraseBox.Parent = P_KeyMaker
    local kpbC = Instance.new("UICorner"); kpbC.CornerRadius = UDim.new(0, 6); kpbC.Parent = KeyPhraseBox
    local DurLabel = Instance.new("TextLabel")
    DurLabel.Size = UDim2.new(1, 0, 0, 20)
    DurLabel.Text = "Duration:"
    DurLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    DurLabel.Font = Enum.Font.GothamMedium; DurLabel.TextSize = 11; DurLabel.BackgroundTransparency = 1; DurLabel.Parent = P_KeyMaker
    local TimeConfig = {
        {Name = "30m", Value = 1800},
        {Name = "1d", Value = 86400},
        {Name = "3d", Value = 259200},
        {Name = "7d", Value = 604800},
        {Name = "30d", Value = 2592000}
    }
    local ActiveSpan = 1800
    local SpanContainer = Instance.new("Frame")
    SpanContainer.Size = UDim2.new(1, 0, 0, 30); SpanContainer.BackgroundTransparency = 1; SpanContainer.Parent = P_KeyMaker
    local spanGrid = Instance.new("UIGridLayout"); spanGrid.CellSize = UDim2.new(0.18, 0, 0, 25); spanGrid.CellPadding = UDim2.new(0, 4, 0, 0); spanGrid.Parent = SpanContainer
    for _, config in pairs(TimeConfig) do
        local b = Instance.new("TextButton")
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.Text = config.Name; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.Font = Enum.Font.GothamBold; b.TextSize = 8
        local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 4); bc.Parent = b
        b.MouseButton1Click:Connect(function()
            ActiveSpan = config.Value
            b.BackgroundColor3 = CurrentThemeColor
            b.TextColor3 = Color3.fromRGB(20,20,20)
            task.wait(0.3)
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.TextColor3 = Color3.fromRGB(255,255,255)
        end)
        b.Parent = SpanContainer
    end
    local OutputBox = Instance.new("TextBox")
    OutputBox.Size = UDim2.new(1, 0, 0, 40)
    OutputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    OutputBox.Text = "Generated Token"
    OutputBox.TextColor3 = CurrentThemeColor; OutputBox.ClearTextOnFocus = false; OutputBox.Font = Enum.Font.Code; OutputBox.TextSize = 10; OutputBox.Parent = P_KeyMaker
    local opC = Instance.new("UICorner"); opC.CornerRadius = UDim.new(0, 6); opC.Parent = OutputBox
    local GenBtn = Instance.new("TextButton")
    GenBtn.Size = UDim2.new(1, 0, 0, 32); GenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    GenBtn.Text = "🔨 BUILD TOKEN"; GenBtn.TextColor3 = Color3.fromRGB(255, 255, 255); GenBtn.Font = Enum.Font.GothamBold; GenBtn.TextSize = 11; GenBtn.Parent = P_KeyMaker
    local gbc = Instance.new("UICorner"); gbc.CornerRadius = UDim.new(0, 6); gbc.Parent = GenBtn
    GenBtn.MouseButton1Click:Connect(function()
        local expirationTime = os.time() + ActiveSpan
        OutputBox.Text = b64Encode(KeyPhraseBox.Text .. "||" .. tostring(expirationTime))
    end)
    AddSectionHeader(P_KeyMaker, "Debug")
    local DebugBtn = Instance.new("TextButton")
    DebugBtn.Size = UDim2.new(1, 0, 0, 32); DebugBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
    DebugBtn.Text = "📋 Debug Console"; DebugBtn.TextColor3 = Color3.fromRGB(255, 255, 255); DebugBtn.Font = Enum.Font.GothamBold; DebugBtn.TextSize = 11; DebugBtn.Parent = P_KeyMaker
    local dbc = Instance.new("UICorner"); dbc.CornerRadius = UDim.new(0, 6); dbc.Parent = DebugBtn
    DebugBtn.MouseButton1Click:Connect(function()
        for k, v in pairs(_G) do if type(k) == "string" then print(k, "=", v) end end
    end)
end
local flyControls = nil
local flyOriginalCollide = {}
local flyMobileUp = false
local flyMobileDown = false
local invisCache = {}
local trailInstance = nil
local ragdollActive = false
local heliSpin = 0
local touchFlingCooldown = {}
local boxCache = {}
local healthCache = {}
local tracerCache = {}
local playerListOverlay = nil
local crosshairFrame = nil
local originalHitboxes = {}
local characterClone = nil
local originalGravity = workspace.Gravity
local fpsDisplay = nil
local frameCount = 0
local frameStart = tick()
local currentFps = 60
local lastChatSent = 0
local lagTick = 0

pcall(function() flyControls = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls() end)

local function restoreFlyCollide()
    for part, val in pairs(flyOriginalCollide) do
        if part and part.Parent then part.CanCollide = val end
    end
    flyOriginalCollide = {}
end

local function applyInvisibility()
    if not LocalPlayer.Character then return end
    invisCache = {}
    for _, obj in ipairs(LocalPlayer.Character:GetDescendants()) do
        if obj:IsA("BasePart") then
            invisCache[obj] = {t = obj.Transparency, l = obj.LocalTransparencyModifier}
            obj.Transparency = 0.9
            obj.LocalTransparencyModifier = 0.9
        elseif obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            invisCache[obj] = {v = obj.Visible}
            obj.Visible = false
        end
    end
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then invisCache[hum] = {d = hum.DisplayName}; hum.DisplayName = "" end
end

local function restoreInvisibility()
    for obj, data in pairs(invisCache) do
        if obj and obj.Parent then
            if data.t ~= nil then
                obj.Transparency = data.t
                obj.LocalTransparencyModifier = data.l
            elseif data.v ~= nil then
                obj.Visible = data.v
            elseif data.d ~= nil then
                obj.DisplayName = data.d
            end
        end
    end
    invisCache = {}
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if _G.Invisible then applyInvisibility() end
    if _G.AutoRespawn and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Died:Connect(function()
                task.wait(0.1)
                if _G.AutoRespawn and LocalPlayer.Character then
                    local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if h then h.Health = 0; LocalPlayer.Character:BreakJoints() end
                end
            end)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.Invisible and not next(invisCache) then applyInvisibility() end
    if not _G.Invisible and next(invisCache) then restoreInvisibility() end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if _G.ClickTP and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(ray.Origin, ray.Direction * 5000, rayParams)
        if result and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
        end
    end
    if _G.Dash and input.KeyCode == Enum.KeyCode.Q and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -20) end
    end
    if _G.DoubleJump and input.KeyCode == Enum.KeyCode.Space and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.FloorMaterial == Enum.Material.Air then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

function StartCheatEngineLoops()
    MinimizeBtn.Visible = true
    MainFrame.Visible = true
    MainFrame.Size = baseSize
    MainFrame.Position = basePos
    MainFrame.BackgroundTransparency = 0.25
    menuOpen = true
    animating = false

    LocalPlayer.Idled:Connect(function()
        if _G.AntiAfk then
            VirtualUser:Button2Down(Vector2.new(0, 0), Camera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), Camera.CFrame)
        end
    end)

    local TextChatService = game:GetService("TextChatService")
    local rainbowTick = 0
    RunService.Heartbeat:Connect(function() rainbowTick = rainbowTick + 0.02 end)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.OnIncomingMessage = function(message)
            local properties = Instance.new("TextChatMessageProperties")
            if _G.AdminChat and message.TextSource and message.TextSource.UserId == LocalPlayer.UserId then
                local r = math.floor(math.sin(rainbowTick) * 127 + 128)
                local g = math.floor(math.sin(rainbowTick + 2) * 127 + 128)
                local b = math.floor(math.sin(rainbowTick + 4) * 127 + 128)
                properties.PrefixText = "[ADMIN] " .. message.TextSource.Name .. ":"
            end
            return properties
        end
    end

    local function isWallBlocking(targetPart)
        local origin = Camera.CFrame.Position
        local dir = targetPart.Position - origin
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, targetPart.Parent}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(origin, dir, rayParams)
        return result ~= nil
    end

    local function getClosestPlayer()
        local target, bestDist = nil, math.huge
        local screenSize = Camera.ViewportSize
        local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local aimPart = p.Character:FindFirstChild(_G.AimPart)
                if hum and hum.Health > 0 and aimPart then
                    if _G.TeamCheck then
                        local myTeam = LocalPlayer.Team
                        local theirTeam = p.Team
                        if myTeam and theirTeam and myTeam == theirTeam then continue end
                    end
                    if _G.WallCheck and isWallBlocking(aimPart) then continue end
                    local pos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist <= _G.AimFov and dist < bestDist then target = p; bestDist = dist end
                    end
                end
            end
        end
        return target
    end

    -- Main physics heartbeat
    RunService.Heartbeat:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = LocalPlayer.Character.Humanoid
            local rootPart = LocalPlayer.Character.HumanoidRootPart

            if _G.FreezeSelf then
                rootPart.Anchored = true
            elseif rootPart.Anchored and not _G.Ragdoll and not _G.Helicopter then
                rootPart.Anchored = false
            end

            if _G.Ragdoll or _G.Helicopter then
                humanoid.PlatformStand = true
                pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Physics) end)
                for _, obj in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if obj:IsA("Motor6D") and obj.Name ~= "RootJoint" and obj.Name ~= "Root" and obj.Enabled then
                        obj.Enabled = false
                    end
                end
                ragdollActive = true
                if _G.Helicopter then
                    heliSpin = heliSpin + math.rad(_G.HeliSpin)
                    rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0, heliSpin, 0)
                    if _G.HeliLift > 0 then
                        rootPart.AssemblyLinearVelocity = Vector3.new(0, _G.HeliLift, 0)
                    end
                end
            elseif ragdollActive then
                humanoid.PlatformStand = false
                pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end)
                for _, obj in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if obj:IsA("Motor6D") and obj.Name ~= "RootJoint" and obj.Name ~= "Root" then
                        obj.Enabled = true
                    end
                end
                ragdollActive = false
            end

            if not _G.Ragdoll and not _G.Helicopter and not _G.FreezeSelf then
                if _G.Fly and not _G.FlingEngine and not _G.SpinBot then
                    humanoid.PlatformStand = true
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            if flyOriginalCollide[part] == nil then flyOriginalCollide[part] = part.CanCollide end
                            part.CanCollide = false
                        end
                    end
                    local moveVec = Vector3.new(0, 0, 0)
                    if flyControls then
                        local ok, v = pcall(function() return flyControls:GetMoveVector() end)
                        if ok and v then moveVec = v end
                    end
                    local camCF = Camera.CFrame
                    local moveDir = camCF.LookVector * -moveVec.Z + camCF.RightVector * moveVec.X
                    if moveDir.Magnitude > 0 then moveDir = moveDir.Unit else moveDir = Vector3.new(0, 0, 0) end
                    local vertical = 0
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical = vertical + 1 end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vertical = vertical - 1 end
                    if flyMobileUp then vertical = vertical + 1 end
                    if flyMobileDown then vertical = vertical - 1 end
                    rootPart.AssemblyLinearVelocity = moveDir * _G.FlySpeed + Vector3.new(0, vertical * _G.FlySpeed, 0)
                elseif _G.FlyCursor then
                    humanoid.PlatformStand = true
                    local mousePos = UserInputService:GetMouseLocation()
                    local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                    local result = workspace:Raycast(ray.Origin, ray.Direction * 5000, rayParams)
                    if result then
                        local target = result.Position
                        local dir = (target - rootPart.Position)
                        if dir.Magnitude > 3 then
                            rootPart.AssemblyLinearVelocity = dir.Unit * _G.FlySpeed
                        end
                    end
                else
                    if humanoid.PlatformStand then humanoid.PlatformStand = false end
                    if next(flyOriginalCollide) then restoreFlyCollide() end
                    local spd = _G.SpeedValue
                    if _G.Sprint and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then spd = spd * 2 end
                    if humanoid.MoveDirection.Magnitude > 0 and spd > 16 then
                        local velocityVector = humanoid.MoveDirection * spd
                        rootPart.AssemblyLinearVelocity = Vector3.new(velocityVector.X, rootPart.AssemblyLinearVelocity.Y, velocityVector.Z)
                    else
                        humanoid.WalkSpeed = spd
                    end
                    if humanoid.UseJumpPower then humanoid.JumpPower = _G.JumpValue else humanoid.JumpHeight = _G.JumpValue end
                    if _G.FlingEngine then
                        rootPart.Velocity = Vector3.new(99999, 99999, 99999)
                    elseif _G.SpinBot then
                        rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(25), 0)
                    end
                end
            end

            if _G.AutoJump and humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end

            if _G.NoFallDamage and rootPart.AssemblyLinearVelocity.Y < -50 then
                rootPart.AssemblyLinearVelocity = Vector3.new(rootPart.AssemblyLinearVelocity.X, -50, rootPart.AssemblyLinearVelocity.Z)
            end

            if _G.GiantMode then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        if not part:GetAttribute("DeltaOrigSize") then
                            part:SetAttribute("DeltaOrigSize", part.Size)
                        end
                        local orig = part:GetAttribute("DeltaOrigSize")
                        part.Size = orig * 3
                    end
                end
            elseif LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local orig = part:GetAttribute("DeltaOrigSize")
                        if orig then part.Size = orig end
                    end
                end
            end
        end

        if _G.Fullbright then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255); Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255); Lighting.Brightness = 2; Lighting.GlobalShadows = false
        end
        if _G.AutoClicker then VirtualUser:Button1Down(Vector2.new(0,0)) end

        if _G.TouchFling and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local myPos = LocalPlayer.Character.HumanoidRootPart.Position
            local now = tick()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local theirPos = p.Character.HumanoidRootPart.Position
                    if (theirPos - myPos).Magnitude <= _G.TouchFlingRange then
                        if not touchFlingCooldown[p] or (now - touchFlingCooldown[p]) > 0.5 then
                            touchFlingCooldown[p] = now
                            local dir = (theirPos - myPos).Unit
                            pcall(function()
                                p.Character.HumanoidRootPart.AssemblyLinearVelocity = dir * _G.TouchFlingPower + Vector3.new(0, _G.TouchFlingPower * 0.5, 0)
                            end)
                        end
                    end
                end
            end
        end

        if _G.MapSuck and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, p in pairs(workspace:GetDescendants()) do
                if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(LocalPlayer.Character) and not p.Parent:FindFirstChildOfClass("Humanoid") then
                    p.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4); p.Velocity = Vector3.new(0,0,0)
                end
            end
        end

        if _G.FlingObjects and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local now = tick()
            if not FlingObjTick or now - FlingObjTick > 0.15 then
                FlingObjTick = now
                local myPos = LocalPlayer.Character.HumanoidRootPart.Position
                local excluded = {}
                for _, pl in ipairs(Players:GetPlayers()) do if pl.Character then excluded[pl.Character] = true end end
                for _, p in pairs(workspace:GetDescendants()) do
                    if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(LocalPlayer.Character) then
                        local inChar = false
                        local ancestor = p.Parent
                        while ancestor and ancestor ~= workspace do
                            if excluded[ancestor] then inChar = true; break end
                            ancestor = ancestor.Parent
                        end
                        if not inChar then
                            local dist = (p.Position - myPos).Magnitude
                            if dist <= _G.FlingRadius then
                                local dir = (p.Position - myPos).Unit
                                pcall(function() p.AssemblyLinearVelocity = dir * _G.FlingForce + Vector3.new(0, _G.FlingForce * 0.5, 0) end)
                            end
                        end
                    end
                end
            end
        end

        if _G.XRay and LocalPlayer.Character then
            for _, p in pairs(workspace:GetDescendants()) do
                if p:IsA("BasePart") and not p:IsDescendantOf(LocalPlayer.Character) then
                    local isChar = false
                    for _, pl in ipairs(Players:GetPlayers()) do
                        if pl.Character and p:IsDescendantOf(pl.Character) then isChar = true; break end
                    end
                    if not isChar then p.LocalTransparencyModifier = 0.95 end
                end
            end
        end

        if _G.RainbowChar and LocalPlayer.Character then
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 1, 1)
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Color = color end
            end
        end

        if _G.WeatherMode == 1 then
            Lighting.ClockTime = 0; Lighting.Brightness = 0.5; Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 40)
        elseif _G.WeatherMode == 2 then
            Lighting.ClockTime = 14; Lighting.FogEnd = 100; Lighting.FogStart = 20; Lighting.FogColor = Color3.fromRGB(200, 200, 200)
        elseif _G.WeatherMode == 3 then
            Lighting.ClockTime = 0; Lighting.Ambient = Color3.fromRGB(80, 0, 0); Lighting.OutdoorAmbient = Color3.fromRGB(120, 20, 20); Lighting.Brightness = 0.5
        else
            Lighting.FogEnd = 100000; Lighting.FogStart = 0
        end

        if MainFrame then
            MainFrame.BackgroundTransparency = 1 - _G.Opacity
        end
    end)

    -- Automation + troll extras (AutoPickup, AutoEquip, AutoInteract, AutoChat, ForceSit, RagdollAll, FlingRadiusPlayers, CharacterClone, GravityFlip, LagServer)
    RunService.Heartbeat:Connect(function()
        -- Automation
        if _G.AutoPickup and LocalPlayer.Character then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and obj.Enabled then
                        local parent = obj.Parent
                        if parent and parent:IsA("BasePart") and (parent.Position - hrp.Position).Magnitude < 15 then
                            pcall(function() fireproximityprompt(obj) end)
                        end
                    end
                end
            end
        end

        if _G.AutoEquipBest and LocalPlayer.Character and LocalPlayer.Backpack then
            local bestTool, bestScore = nil, 0
            for _, t in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if t:IsA("Tool") then
                    local s = t:FindFirstChild("Damage") and 1 or 0
                    if s > bestScore then bestTool = t; bestScore = s end
                end
            end
            if bestTool then pcall(function() LocalPlayer.Character.Humanoid:EquipTool(bestTool) end) end
        end

        if _G.AutoInteract and LocalPlayer.Character then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ClickDetector") then
                        local pa = obj.Parent
                        if pa and pa:IsA("BasePart") and (pa.Position - hrp.Position).Magnitude < 10 then
                            pcall(function() fireclickdetector(obj) end)
                        end
                    end
                end
            end
        end

        if _G.AutoChatMsg and tick() - lastChatSent >= (_G.AutoChatDelay or 5) then
            lastChatSent = tick()
            pcall(function() game:GetService("TextChatService"):SendAsync(_G.AutoChatText or "Hello") end)
        end

        -- Troll extras
        if _G.ForceSit then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local h = p.Character:FindFirstChildOfClass("Humanoid")
                    if h then pcall(function() h.Sit = true end) end
                end
            end
        end

        if _G.RagdollAll then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local h = p.Character:FindFirstChildOfClass("Humanoid")
                    if h then pcall(function() h.PlatformStand = true; h:ChangeState(Enum.HumanoidStateType.Physics) end) end
                end
            end
        end

        if _G.FlingRadiusPlayers and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local mp = LocalPlayer.Character.HumanoidRootPart.Position
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (p.Character.HumanoidRootPart.Position - mp).Magnitude
                    if d < (_G.FlingPlayersRadius or 20) then
                        local dir = (p.Character.HumanoidRootPart.Position - mp).Unit
                        pcall(function() p.Character.HumanoidRootPart.AssemblyLinearVelocity = dir * 300 + Vector3.new(0, 200, 0) end)
                    end
                end
            end
        end

        if _G.GravityFlip and workspace.Gravity > 0 then
            workspace.Gravity = -originalGravity
        elseif not _G.GravityFlip and workspace.Gravity < 0 then
            workspace.Gravity = originalGravity
        end

        if _G.CharacterClone and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if not characterClone or not characterClone.Parent then
                characterClone = LocalPlayer.Character:Clone()
                characterClone.Name = "DeltaClone"
                characterClone.Parent = workspace
                local ch = characterClone:FindFirstChildOfClass("Humanoid")
                if ch then ch.WalkSpeed = 0; ch.DisplayName = " " end
            end
        elseif not _G.CharacterClone and characterClone then
            characterClone:Destroy(); characterClone = nil
        end

        if _G.LagServer and tick() - lagTick > 0.3 then
            lagTick = tick()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    for i = 1, 5 do
                        local pt = Instance.new("Part")
                        pt.Size = Vector3.new(2, 2, 2)
                        pt.Position = p.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), math.random(2, 10), math.random(-20, 20))
                        pt.Anchored = false; pt.CanCollide = false; pt.Transparency = 1
                        pt.Parent = workspace
                        task.delay(3, function() pcall(function() pt:Destroy() end) end)
                    end
                end
            end
        end

        -- Perf
        if _G.DisableParticles then
            for _, p in pairs(workspace:GetDescendants()) do if p:IsA("ParticleEmitter") then p.Enabled = false end end
        end
        if _G.DisableShadows then Lighting.GlobalShadows = false end
    end)

    -- Trails
    task.spawn(function()
        while true do
            task.wait(0.5)
            if _G.Trail and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if not trailInstance or not trailInstance.Parent then
                    local a0 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
                    local a1 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
                    a0.Position = Vector3.new(0, 1, 0); a1.Position = Vector3.new(0, -1, 0)
                    trailInstance = Instance.new("Trail", LocalPlayer.Character.HumanoidRootPart)
                    trailInstance.Attachment0 = a0; trailInstance.Attachment1 = a1
                    trailInstance.Color = ColorSequence.new(CurrentThemeColor)
                    trailInstance.Lifetime = 1
                end
            elseif not _G.Trail and trailInstance then
                pcall(function() trailInstance:Destroy() end)
                trailInstance = nil
            end
        end
    end)

    -- Sound spam
    task.spawn(function()
        while true do
            task.wait(2)
            if _G.SoundSpam and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local snd = Instance.new("Sound", LocalPlayer.Character.HumanoidRootPart)
                    snd.SoundId = "rbxassetid://142376088"
                    snd.Volume = 5
                    snd:Play()
                    task.wait(3)
                    snd:Destroy()
                end)
            end
        end
    end)

    -- FPS counter
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local n = tick()
        if n - frameStart >= 1 then currentFps = frameCount / (n - frameStart); frameCount = 0; frameStart = n end
        if _G.ShowFpsCounter then
            if not fpsDisplay then
                fpsDisplay = Instance.new("TextLabel", ScreenGui)
                fpsDisplay.Size = UDim2.new(0, 100, 0, 20)
                fpsDisplay.Position = UDim2.new(0, 10, 0, 10)
                fpsDisplay.BackgroundTransparency = 1
                fpsDisplay.TextColor3 = CurrentThemeColor
                fpsDisplay.Font = Enum.Font.GothamBold; fpsDisplay.TextSize = 12
                fpsDisplay.TextXAlignment = Enum.TextXAlignment.Left
            end
            fpsDisplay.Text = "FPS: " .. math.floor(currentFps)
        elseif fpsDisplay then
            fpsDisplay:Destroy(); fpsDisplay = nil
        end
    end)

    -- Silent Aim
    RunService.Heartbeat:Connect(function()
        if _G.SilentAim then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hd = p.Character:FindFirstChild("Head")
                    if hrp and hd then
                        if not originalHitboxes[p] then originalHitboxes[p] = {h=hrp.Size, hd=hd.Size, t=hd.Transparency} end
                        hrp.Size = Vector3.new(6, 6, 6)
                        hd.Size = Vector3.new(6, 6, 6)
                    end
                end
            end
        elseif next(originalHitboxes) then
            for p, d in pairs(originalHitboxes) do
                if p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hd = p.Character:FindFirstChild("Head")
                    if hrp then hrp.Size = d.h end
                    if hd then hd.Size = d.hd; hd.Transparency = d.t end
                end
            end
            originalHitboxes = {}
        end
    end)

    -- Aimbot
    local lastShot = 0
    RunService.RenderStepped:Connect(function()
        if not LocalPlayer.Character then return end
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if not h or h.Health <= 0 then return end
        local tgt = nil
        if _G.Aimbot or _G.AimAssist or _G.TriggerBot then
            tgt = getClosestPlayer()
        end
        if tgt then
            local tp = tgt.Character:FindFirstChild(_G.AimPart)
            if tp then
                if _G.Aimbot then
                    local pp = tp.Position
                    if tp.AssemblyLinearVelocity.Magnitude > 5 then pp = pp + tp.AssemblyLinearVelocity * 0.05 end
                    local tCF = CFrame.new(Camera.CFrame.Position, pp)
                    local al = math.clamp(_G.AimSmooth, 0.05, 1)
                    Camera.CFrame = Camera.CFrame:Lerp(tCF, al)
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then Camera.CFrame = tCF end
                    if _G.AutoShoot then
                        local td = (tp.Position - Camera.CFrame.Position).Unit
                        if Camera.CFrame.LookVector:Dot(td) > math.cos(math.rad(5)) then
                            local nw = tick()
                            if nw - lastShot >= _G.FireDelay / 1000 then
                                lastShot = nw
                                pcall(function() VirtualUser:Button1Down(Vector2.new(0, 0)); VirtualUser:Button1Up(Vector2.new(0, 0)) end)
                                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                                if tool then pcall(function() tool:Activate() end) end
                            end
                        end
                    end
                end
                if _G.AimAssist and not _G.Aimbot then
                    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, tp.Position), 0.05)
                end
                if _G.TriggerBot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then pcall(function() tool:Activate() end) end
                end
            end
        end
    end)

    -- FOV Circle
    local FovCircle = Instance.new("Frame", ScreenGui)
    FovCircle.Name = "FovCircle"
    FovCircle.BackgroundTransparency = 1
    FovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    FovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    FovCircle.Size = UDim2.new(0, _G.AimFov * 2, 0, _G.AimFov * 2)
    FovCircle.Visible = false
    local fovCorner = Instance.new("UICorner", FovCircle); fovCorner.CornerRadius = UDim.new(1, 0)
    local fovStroke = Instance.new("UIStroke", FovCircle); fovStroke.Color = Color3.fromRGB(255, 255, 255); fovStroke.Thickness = 1; fovStroke.Transparency = 0.5
    RunService.RenderStepped:Connect(function()
        FovCircle.Visible = _G.Aimbot
        FovCircle.Size = UDim2.new(0, _G.AimFov * 2, 0, _G.AimFov * 2)
    end)

    -- Noclip
    RunService.Stepped:Connect(function()
        if _G.Noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
            if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.NoClip)
            end
        end
    end)

    UserInputService.JumpRequest:Connect(function()
        if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)

    -- ESP Highlights + Nametags
    RunService.Heartbeat:Connect(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                if _G.HitboxExpand then
                    p.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    p.Character.HumanoidRootPart.Transparency = 0.7; p.Character.HumanoidRootPart.CanCollide = false
                else
                    p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1); p.Character.HumanoidRootPart.Transparency = 1
                end
                local hl = p.Character:FindFirstChild("DeltaEspHighlight")
                if _G.Esp then
                    if not hl then
                        hl = Instance.new("Highlight"); hl.Name = "DeltaEspHighlight"; hl.FillTransparency = 0.5; hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.Parent = p.Character
                    end
                    hl.FillColor = _G.TeamColorEsp and (p.TeamColor and p.TeamColor.Color or CurrentThemeColor) or CurrentThemeColor
                else
                    if hl then hl:Destroy() end
                end
                local head = p.Character.Head
                if _G.Nametags then
                    local tag = head:FindFirstChild("DeltaNametag")
                    if not tag then
                        tag = Instance.new("BillboardGui"); tag.Name = "DeltaNametag"; tag.AlwaysOnTop = true; tag.Size = UDim2.new(0, 100, 0, 30); tag.StudsOffset = Vector3.new(0, 2, 0)
                        local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10; lbl.Parent = tag; tag.Parent = head
                    end
                    local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude) or 0)
                    tag.TextLabel.Text = p.Name .. " [" .. tostring(dist) .. "s]"; tag.TextLabel.TextColor3 = CurrentThemeColor
                else
                    local oldTag = head:FindFirstChild("DeltaNametag")
                    if oldTag then oldTag:Destroy() end
                end
            end
        end
    end)

    -- Extended ESP rendering (Box, Chams, Tracers, HealthBar, PlayerList, Crosshair)
    local tracerGui = Instance.new("Frame", ScreenGui)
    tracerGui.Name = "DeltaTracers"
    tracerGui.Size = UDim2.new(1, 0, 1, 0)
    tracerGui.BackgroundTransparency = 1
    tracerGui.PointerEvents = Enum.PointerEvent.Ignore

    RunService.RenderStepped:Connect(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local h = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and h and h.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                    if _G.Chams then
                        for _, pt in ipairs(p.Character:GetDescendants()) do
                            if pt:IsA("BasePart") then
                                pt.Material = Enum.Material.Neon
                                pt.Color = CurrentThemeColor
                            end
                        end
                    end

                    if _G.BoxEsp and onScreen then
                        local d = (Camera.CFrame.Position - hrp.Position).Magnitude
                        local sz = math.clamp(2000 / math.max(d, 1), 15, 400)
                        local b = boxCache[p]
                        if not b or not b.Parent then
                            b = Instance.new("Frame", tracerGui)
                            b.BackgroundTransparency = 1; b.BorderSizePixel = 0
                            local s = Instance.new("UIStroke", b)
                            s.Color = CurrentThemeColor; s.Thickness = 1.5
                            boxCache[p] = b
                        end
                        b.Visible = true
                        b.Size = UDim2.new(0, sz * 0.5, 0, sz)
                        b.Position = UDim2.new(0, pos.X - sz * 0.25, 0, pos.Y - sz * 0.5)
                    elseif boxCache[p] then
                        boxCache[p].Visible = false
                    end

                    if _G.HealthBarEsp and onScreen then
                        local bar = healthCache[p]
                        if not bar or not bar.Parent then
                            bar = Instance.new("Frame", tracerGui)
                            bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            bar.BorderSizePixel = 0
                            local f = Instance.new("Frame", bar)
                            f.Name = "Fill"; f.BorderSizePixel = 0
                            healthCache[p] = bar
                        end
                        bar.Visible = true
                        local d = (Camera.CFrame.Position - hrp.Position).Magnitude
                        local hh = math.clamp(1500 / math.max(d, 1), 30, 200)
                        bar.Size = UDim2.new(0, 4, 0, hh)
                        bar.Position = UDim2.new(0, pos.X - 15, 0, pos.Y - hh / 2)
                        local fr = h.Health / h.MaxHealth
                        bar.Fill.Size = UDim2.new(1, 0, fr, 0)
                        bar.Fill.Position = UDim2.new(0, 0, 1 - fr, 0)
                        bar.Fill.BackgroundColor3 = Color3.fromRGB(255 * (1 - fr), 255 * fr, 0)
                    elseif healthCache[p] then
                        healthCache[p].Visible = false
                    end

                    if _G.TracerLines and onScreen then
                        local l = tracerCache[p]
                        if not l or not l.Parent then
                            l = Instance.new("Frame", tracerGui)
                            l.BackgroundColor3 = CurrentThemeColor; l.BorderSizePixel = 0
                            tracerCache[p] = l
                        end
                        l.Visible = true
                        local c = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 10)
                        local dv = Vector2.new(pos.X, pos.Y) - c
                        l.Position = UDim2.new(0, c.X, 0, c.Y)
                        l.Size = UDim2.new(0, dv.Magnitude, 0, 2)
                        l.Rotation = math.deg(math.atan2(dv.Y, dv.X))
                    elseif tracerCache[p] then
                        tracerCache[p].Visible = false
                    end
                end
            end
        end

        if _G.PlayerListOverlay then
            if not playerListOverlay then
                playerListOverlay = Instance.new("Frame", ScreenGui)
                playerListOverlay.Size = UDim2.new(0, 200, 0, 300)
                playerListOverlay.Position = UDim2.new(1, -210, 0, 60)
                playerListOverlay.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                playerListOverlay.BackgroundTransparency = 0.25
                Instance.new("UICorner", playerListOverlay).CornerRadius = UDim.new(0, 8)
                local s = Instance.new("UIStroke", playerListOverlay)
                s.Color = CurrentThemeColor; s.Thickness = 1.5
            end
            for _, c in ipairs(playerListOverlay:GetChildren()) do
                if c:IsA("TextLabel") then c:Destroy() end
            end
            local y = 5
            for _, p in ipairs(Players:GetPlayers()) do
                local l = Instance.new("TextLabel", playerListOverlay)
                l.Size = UDim2.new(1, -10, 0, 20)
                l.Position = UDim2.new(0, 5, 0, y)
                l.BackgroundTransparency = 1
                l.Text = p.Name .. (p == LocalPlayer and " (you)" or "")
                l.TextColor3 = p == LocalPlayer and CurrentThemeColor or Color3.fromRGB(220, 220, 220)
                l.Font = Enum.Font.GothamMedium; l.TextSize = 10
                l.TextXAlignment = Enum.TextXAlignment.Left
                y = y + 20
            end
        elseif playerListOverlay then
            playerListOverlay:Destroy(); playerListOverlay = nil
        end

        if _G.CrosshairMode ~= 0 then
            if not crosshairFrame then
                crosshairFrame = Instance.new("Frame", ScreenGui)
                crosshairFrame.Size = UDim2.new(0, 20, 0, 20)
                crosshairFrame.Position = UDim2.new(0.5, -10, 0.5, -10)
                crosshairFrame.BackgroundTransparency = 1
                local hh = Instance.new("Frame", crosshairFrame)
                hh.Size = UDim2.new(1, 0, 0, 2); hh.Position = UDim2.new(0, 0, 0.5, -1)
                hh.BorderSizePixel = 0; hh.BackgroundColor3 = CurrentThemeColor
                local v = Instance.new("Frame", crosshairFrame)
                v.Size = UDim2.new(0, 2, 1, 0); v.Position = UDim2.new(0.5, -1, 0, 0)
                v.BorderSizePixel = 0; v.BackgroundColor3 = CurrentThemeColor
            end
        elseif crosshairFrame then
            crosshairFrame:Destroy(); crosshairFrame = nil
        end
    end)

    -- Keybinds (PC only)
    if UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then
        local kb = {
            [Enum.KeyCode.F1]="Aimbot",[Enum.KeyCode.F2]="Fly",[Enum.KeyCode.F3]="Invisible",
            [Enum.KeyCode.F4]="Noclip",[Enum.KeyCode.F5]="ClickTP",[Enum.KeyCode.F6]="AutoClicker"
        }
        UserInputService.InputBegan:Connect(function(i, pr)
            if pr then return end
            local v = kb[i.KeyCode]
            if v and type(_G[v]) == "boolean" then _G[v] = not _G[v]; print("[Delta] "..v.." = "..tostring(_G[v])) end
        end)
    end

    -- Mobile fly buttons
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    if isMobile then
        local upBtn = Instance.new("TextButton", ScreenGui)
        upBtn.Size = UDim2.new(0, 60, 0, 60); upBtn.Position = UDim2.new(0.9, -140, 0.7, 0)
        upBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); upBtn.BackgroundTransparency = 0.3
        upBtn.Text = "↑"; upBtn.TextColor3 = CurrentThemeColor; upBtn.TextSize = 28
        upBtn.Font = Enum.Font.GothamBold; upBtn.Visible = false
        Instance.new("UICorner", upBtn).CornerRadius = UDim.new(0, 30)
        local downBtn = Instance.new("TextButton", ScreenGui)
        downBtn.Size = UDim2.new(0, 60, 0, 60); downBtn.Position = UDim2.new(0.9, -140, 0.7, 70)
        downBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); downBtn.BackgroundTransparency = 0.3
        downBtn.Text = "↓"; downBtn.TextColor3 = CurrentThemeColor; downBtn.TextSize = 28
        downBtn.Font = Enum.Font.GothamBold; downBtn.Visible = false
        Instance.new("UICorner", downBtn).CornerRadius = UDim.new(0, 30)
        upBtn.MouseButton1Down:Connect(function() flyMobileUp = true end)
        upBtn.MouseButton1Up:Connect(function() flyMobileUp = false end)
        upBtn.MouseLeave:Connect(function() flyMobileUp = false end)
        downBtn.MouseButton1Down:Connect(function() flyMobileDown = true end)
        downBtn.MouseButton1Up:Connect(function() flyMobileDown = false end)
        downBtn.MouseLeave:Connect(function() flyMobileDown = false end)
        RunService.Heartbeat:Connect(function()
            upBtn.Visible = _G.Fly
            downBtn.Visible = _G.Fly
        end)
    end
end
-- =============================================================================
-- EVASION PATCH (v6.2.1) — Jitter, Decoy, Auto-Dodge
-- Paste at bottom of v6.2.0 file, above the Key Gate (before `local savedToken`)
-- =============================================================================

_G.EvadeJitter = false
_G.EvadeDecoy = false
_G.EvadeDash = false

-- Add to Troll panel
AddSectionHeader(P_Troll, "Evasion")
AddToggleComponent(P_Troll, "Hitbox Jitter (3 studs)", "EvadeJitter")
AddToggleComponent(P_Troll, "Decoy Mind-Games", "EvadeDecoy")
AddToggleComponent(P_Troll, "Auto-Dash Dodge", "EvadeDash")

-- Evasion runtime state
local evadeOriginals = {}
local evadeDecoy = nil
local evadeLastDash = 0
local evadeDashDir = 1

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- Jitter: oscillate HRP ±3 studs perpendicular to movement
    if _G.EvadeJitter then
        local base = hrp.CFrame
        local offset = (evadeDashDir * math.sin(tick() * 30)) * 3
        local right = base.RightVector
        hrp.CFrame = base * CFrame.new(offset * right.X, 0, offset * right.Z)
    end

    -- Decoy: spawn a fake part where you were, leave it behind
    if _G.EvadeDecoy then
        if not evadeDecoy or not evadeDecoy.Parent then
            evadeDecoy = Instance.new("Part")
            evadeDecoy.Size = Vector3.new(2, 5, 1)
            evadeDecoy.CanCollide = false
            evadeDecoy.Anchored = true
            evadeDecoy.Transparency = 0.3
            evadeDecoy.Color = Color3.fromRGB(255, 100, 100)
            evadeDecoy.Parent = workspace
        end
        evadeDecoy.CFrame = hrp.CFrame * CFrame.new(0, 0, -2)
    elseif evadeDecoy and evadeDecoy.Parent then
        evadeDecoy:Destroy()
        evadeDecoy = nil
    end

    -- Auto-Dash: every 0.3s, hop 5 studs to the side
    if _G.EvadeDash and tick() - evadeLastDash > 0.3 then
        evadeLastDash = tick()
        evadeDashDir = -evadeDashDir
        local dash = hrp.CFrame.RightVector * (5 * evadeDashDir)
        hrp.CFrame = hrp.CFrame + dash
    end
end)

print("[Delta] Evasion patch loaded — Jitter, Decoy, Auto-Dash wired")

-- =============================================================================
-- CURSOR AIM PATCH (v6.2.2)
-- =============================================================================

_G.CursorAim = false
_G.CursorAutoClick = false
_G.CursorFov = 200
_G.CursorSpeed = 5

AddSectionHeader(P_Aimbot, "Cursor Aim")
AddToggleComponent(P_Aimbot, "Cursor Aimbot", "CursorAim")
AddToggleComponent(P_Aimbot, "Auto Click on Target", "CursorAutoClick")
AddInputComponent(P_Aimbot, "Cursor FOV:", "200", function(v) _G.CursorFov = v end)
AddInputComponent(P_Aimbot, "Cursor Speed:", "5", function(v) _G.CursorSpeed = v end)

local function hasCursorMove()
    return type(mousemoverel) == "function" or (syn and syn.mousemoverel ~= nil)
end

local function moveCursor(dx, dy)
    if type(mousemoverel) == "function" then
        pcall(mousemoverel, dx, dy)
    elseif syn and syn.mousemoverel then
        pcall(syn.mousemoverel, dx, dy)
    end
end

local lastCursorClick = 0

RunService.RenderStepped:Connect(function()
    if not _G.CursorAim then return end
    if not hasCursorMove() then return end

    local cursorPos = UserInputService:GetMouseLocation()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    local bestTarget = nil
    local bestDist = _G.CursorFov or 200

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if head and hum and hum.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                    local dist = (screenVec - cursorPos).Magnitude
                    if dist < bestDist then
                        bestTarget = {p = p, head = head, screen = screenVec}
                        bestDist = dist
                    end
                end
            end
        end
    end

    if bestTarget then
        local dx = bestTarget.screen.X - cursorPos.X
        local dy = bestTarget.screen.Y - cursorPos.Y
        local speed = math.clamp(_G.CursorSpeed or 5, 1, 50) / 5
        moveCursor(math.floor(dx * speed * 0.1), math.floor(dy * speed * 0.1))

        if _G.CursorAutoClick then
            local newCursor = UserInputService:GetMouseLocation()
            local remaining = (bestTarget.screen - newCursor).Magnitude
            if remaining < 20 then
                local now = tick()
                if now - lastCursorClick > 0.08 then
                    lastCursorClick = now
                    pcall(function()
                        VirtualUser:Button1Down(Vector2.new(0, 0))
                        VirtualUser:Button1Up(Vector2.new(0, 0))
                    end)
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then pcall(function() tool:Activate() end) end
                end
            end
        end
    end
end)

print("[Delta] Cursor Aim patch loaded — mousemoverel:", hasCursorMove())
-- =============================================================================
-- CLING PATCH (v6.2.3)
-- =============================================================================

_G.Cling = false
_G.ClingKill = false

AddSectionHeader(P_Troll, "Cling")
AddToggleComponent(P_Troll, "Cling to Player", "Cling")
AddToggleComponent(P_Troll, "Cling Auto-Kill", "ClingKill")

local clingTarget = nil
local lastClingShot = 0

RunService.Heartbeat:Connect(function()
    if not _G.Cling then
        clingTarget = nil
        return
    end

    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    -- Find nearest living player if we don't have one or target died
    if not clingTarget or not clingTarget.Character or not clingTarget.Character:FindFirstChild("HumanoidRootPart") 
       or not clingTarget.Character:FindFirstChildOfClass("Humanoid") 
       or clingTarget.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
        local bestTarget = nil
        local bestDist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChildOfClass("Humanoid")
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if h and h.Health > 0 and hrp then
                    local d = (hrp.Position - myHrp.Position).Magnitude
                    if d < bestDist then bestTarget = p; bestDist = d end
                end
            end
        end
        clingTarget = bestTarget
    end

    if clingTarget and clingTarget.Character then
        local theirHrp = clingTarget.Character:FindFirstChild("HumanoidRootPart")
        if theirHrp then
            myHrp.CFrame = theirHrp.CFrame
        end

        if _G.ClingKill then
            local theirHead = clingTarget.Character:FindFirstChild("Head")
            if theirHead then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, theirHead.Position)
                local now = tick()
                if now - lastClingShot > 0.1 then
                    lastClingShot = now
                    pcall(function()
                        VirtualUser:Button1Down(Vector2.new(0, 0))
                        VirtualUser:Button1Up(Vector2.new(0, 0))
                    end)
                    local tool = myChar:FindFirstChildOfClass("Tool")
                    if tool then pcall(function() tool:Activate() end) end
                end
            end
        end
    end
end)

print("[Delta] Cling patch loaded")
-- =============================================================================
-- CLING BURST PATCH (v6.2.4)
-- =============================================================================

_G.ClingBurst = false
_G.ClingBurstTarget = nil
_G.ClingBurstDuration = 1
_G.ClingBurstCooldown = 2
_G.ClingHideY = -10
_G.ClingBurstZ = 1
_G.ClingFireRate = 100

AddSectionHeader(P_Troll, "Cling Burst")
AddToggleComponent(P_Troll, "Cling Burst (Auto)", "ClingBurst")

-- Dropdown player selector
local ClingDropBtn = Instance.new("TextButton")
ClingDropBtn.Size = UDim2.new(1, 0, 0, 30)
ClingDropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ClingDropBtn.Text = "Select Target ▼ (Auto)"
ClingDropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClingDropBtn.Font = Enum.Font.GothamBold
ClingDropBtn.TextSize = 11
Instance.new("UICorner", ClingDropBtn).CornerRadius = UDim.new(0, 6)
ClingDropBtn.Parent = P_Troll

local ClingDropList = Instance.new("ScrollingFrame")
ClingDropList.Size = UDim2.new(1, 0, 0, 0)
ClingDropList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ClingDropList.BorderSizePixel = 0
ClingDropList.ScrollBarThickness = 4
ClingDropList.CanvasSize = UDim2.new(0, 0, 0, 0)
ClingDropList.Visible = false
Instance.new("UICorner", ClingDropList).CornerRadius = UDim.new(0, 6)
ClingDropList.Parent = P_Troll
local ClingDropLayout = Instance.new("UIListLayout", ClingDropList)
ClingDropLayout.Padding = UDim.new(0, 2)

local clingDropOpen = false

local function RefreshClingDropList()
    for _, c in ipairs(ClingDropList:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local autoBtn = Instance.new("TextButton", ClingDropList)
    autoBtn.Size = UDim2.new(1, -4, 0, 24)
    autoBtn.BackgroundColor3 = (_G.ClingBurstTarget == nil) and CurrentThemeColor or Color3.fromRGB(40, 40, 40)
    autoBtn.Text = "(Auto — nearest)"
    autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoBtn.Font = Enum.Font.GothamMedium
    autoBtn.TextSize = 10
    Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 4)
    autoBtn.MouseButton1Click:Connect(function()
        _G.ClingBurstTarget = nil
        ClingDropBtn.Text = "Select Target ▼ (Auto)"
        RefreshClingDropList()
        ClingDropList.Visible = false
        clingDropOpen = false
    end)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", ClingDropList)
            b.Size = UDim2.new(1, -4, 0, 24)
            b.BackgroundColor3 = (_G.ClingBurstTarget == p) and CurrentThemeColor or Color3.fromRGB(40, 40, 40)
            b.Text = p.Name
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.GothamMedium
            b.TextSize = 10
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
            b.MouseButton1Click:Connect(function()
                _G.ClingBurstTarget = p
                ClingDropBtn.Text = "Target: " .. p.Name
                RefreshClingDropList()
                ClingDropList.Visible = false
                clingDropOpen = false
            end)
        end
    end
    ClingDropList.CanvasSize = UDim2.new(0, 0, 0, ClingDropLayout.AbsoluteContentSize.Y + 4)
end

ClingDropBtn.MouseButton1Click:Connect(function()
    clingDropOpen = not clingDropOpen
    ClingDropList.Visible = clingDropOpen
    ClingDropList.Size = UDim2.new(1, 0, 0, clingDropOpen and 140 or 0)
    if clingDropOpen then
        RefreshClingDropList()
    end
end)

task.spawn(function()
    while true do
        task.wait(3)
        if clingDropOpen then pcall(RefreshClingDropList) end
    end
end)

AddInputComponent(P_Troll, "Burst Duration (s):", "1", function(v) _G.ClingBurstDuration = math.max(0.1, v) end)
AddInputComponent(P_Troll, "Burst Cooldown (s):", "2", function(v) _G.ClingBurstCooldown = math.max(0.2, v) end)
AddInputComponent(P_Troll, "Hide Depth (Y):", "-10", function(v) _G.ClingHideY = v end)
AddInputComponent(P_Troll, "Burst Offset (Z):", "1", function(v) _G.ClingBurstZ = v end)
AddInputComponent(P_Troll, "Fire Rate (ms):", "100", function(v) _G.ClingFireRate = math.max(20, v) end)

-- Burst runtime state
local clingBurstState = "hiding"
local clingBurstTarget = nil
local clingBurstStartTime = 0
local clingBurstOriginalPos = nil
local clingLastShot = 0

local function getBurstTarget()
    if _G.ClingBurstTarget and _G.ClingBurstTarget.Character then
        local h = _G.ClingBurstTarget.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Health > 0 then return _G.ClingBurstTarget end
    end
    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myHrp then return nil end
    local best, bestDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and hrp then
                local d = (hrp.Position - myHrp.Position).Magnitude
                if d < bestDist then best = p; bestDist = d end
            end
        end
    end
    return best
end

RunService.Heartbeat:Connect(function()
    if not _G.ClingBurst then
        clingBurstState = "idle"
        clingBurstTarget = nil
        return
    end

    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    -- Pick target if needed
    if not clingBurstTarget or not clingBurstTarget.Character or not clingBurstTarget.Character:FindFirstChild("HumanoidRootPart")
       or not clingBurstTarget.Character:FindFirstChildOfClass("Humanoid")
       or clingBurstTarget.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
        clingBurstTarget = getBurstTarget()
        if clingBurstState == "bursting" then
            -- Target died mid-burst — return to original position
            if clingBurstOriginalPos then
                myHrp.CFrame = clingBurstOriginalPos
            end
            clingBurstState = "hiding"
        end
        if not clingBurstTarget then return end
    end

    local theirHrp = clingBurstTarget.Character:FindFirstChild("HumanoidRootPart")
    if not theirHrp then return end

    if clingBurstState == "idle" then
        clingBurstState = "hiding"
    end

    if clingBurstState == "hiding" then
        -- Hide below target
        myHrp.CFrame = theirHrp.CFrame * CFrame.new(0, _G.ClingHideY or -10, 0)
        -- Record start position (real position for return)
        if not clingBurstOriginalPos then
            clingBurstOriginalPos = myHrp.CFrame
        end
        clingBurstStartTime = clingBurstStartTime + RunService.Heartbeat:Wait()
        if clingBurstStartTime >= (_G.ClingBurstCooldown or 2) then
            -- Save the current hide position as fallback original
            clingBurstOriginalPos = myHrp.CFrame
            clingBurstState = "bursting"
            clingBurstStartTime = 0
        end
    elseif clingBurstState == "bursting" then
        -- Burst behind target, aim at head
        myHrp.CFrame = theirHrp.CFrame * CFrame.new(0, 0, _G.ClingBurstZ or 1)
        local theirHead = clingBurstTarget.Character:FindFirstChild("Head")
        if theirHead then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, theirHead.Position)
            local now = tick()
            if now - clingLastShot >= (_G.ClingFireRate or 100) / 1000 then
                clingLastShot = now
                pcall(function()
                    VirtualUser:Button1Down(Vector2.new(0, 0))
                    VirtualUser:Button1Up(Vector2.new(0, 0))
                end)
                local tool = myChar:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate() end) end
            end
        end
        clingBurstStartTime = clingBurstStartTime + RunService.Heartbeat:Wait()
        if clingBurstStartTime >= (_G.ClingBurstDuration or 1) then
            clingBurstState = "returning"
            clingBurstStartTime = 0
        end
    elseif clingBurstState == "returning" then
        -- Return to original position (where we were before burst)
        if clingBurstOriginalPos then
            myHrp.CFrame = clingBurstOriginalPos
        end
        clingBurstStartTime = clingBurstStartTime + RunService.Heartbeat:Wait()
        if clingBurstStartTime >= 0.15 then
            clingBurstState = "hiding"
            clingBurstStartTime = 0
            clingBurstOriginalPos = nil
        end
    end
end)

print("[Delta] Cling Burst patch loaded")
-- =============================================================================
-- NOCLIP DASH PATCH (v6.2.5)
-- =============================================================================

_G.NoclipDashDistance = 10

AddSectionHeader(P_Movement, "Noclip Dash")

local dashRow1 = Instance.new("Frame")
dashRow1.Size = UDim2.new(1, 0, 0, 35)
dashRow1.BackgroundTransparency = 1
dashRow1.Parent = P_Movement
local dashRow1L = Instance.new("UIListLayout", dashRow1)
dashRow1L.FillDirection = Enum.FillDirection.Horizontal
dashRow1L.Padding = UDim.new(0, 4)

local dashRow2 = Instance.new("Frame")
dashRow2.Size = UDim2.new(1, 0, 0, 35)
dashRow2.BackgroundTransparency = 1
dashRow2.Parent = P_Movement
local dashRow2L = Instance.new("UIListLayout", dashRow2)
dashRow2L.FillDirection = Enum.FillDirection.Horizontal
dashRow2L.Padding = UDim.new(0, 4)

local function makeDashBtn(parent, label)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.49, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = label
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    return b
end

local function doNoclipDash(direction)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = _G.NoclipDashDistance or 10
    local camCF = Camera.CFrame

    local offset
    if direction == "left" then
        offset = camCF.RightVector * -dist
    elseif direction == "right" then
        offset = camCF.RightVector * dist
    elseif direction == "forward" then
        offset = camCF.LookVector * dist
    elseif direction == "back" then
        offset = camCF.LookVector * -dist
    end

    if offset then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
        hrp.CFrame = hrp.CFrame + offset
        task.delay(0.1, function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end)
    end
end

local dashLeft = makeDashBtn(dashRow1, "← Left")
local dashRight = makeDashBtn(dashRow1, "Right →")
local dashFwd = makeDashBtn(dashRow2, "↑ Forward")
local dashBack = makeDashBtn(dashRow2, "↓ Back")

dashLeft.MouseButton1Click:Connect(function() doNoclipDash("left") end)
dashRight.MouseButton1Click:Connect(function() doNoclipDash("right") end)
dashFwd.MouseButton1Click:Connect(function() doNoclipDash("forward") end)
dashBack.MouseButton1Click:Connect(function() doNoclipDash("back") end)

AddInputComponent(P_Movement, "Dash Distance:", "10", function(v) _G.NoclipDashDistance = math.max(1, v) end)

print("[Delta] Noclip Dash patch loaded")
-- =============================================================================
-- UTILITY PATCH (v6.2.6) — Waypoints, Item ESP, Auto-Interact+, Tracker, Chat
-- =============================================================================

-- ---- 1. WAYPOINT SYSTEM ----
_G.Waypoint1 = nil
_G.Waypoint2 = nil
_G.Waypoint3 = nil

AddSectionHeader(P_Movement, "Waypoints")

local function makeWaypointRow(index)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    row.Parent = P_Movement

    local saveBtn = Instance.new("TextButton", row)
    saveBtn.Size = UDim2.new(0.3, -4, 0, 24)
    saveBtn.Position = UDim2.new(0, 4, 0, 4)
    saveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    saveBtn.Text = "Save " .. index
    saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.TextSize = 10
    Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0, 4)

    local tpBtn = Instance.new("TextButton", row)
    tpBtn.Size = UDim2.new(0.3, -4, 0, 24)
    tpBtn.Position = UDim2.new(0.31, 0, 0, 4)
    tpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tpBtn.Text = "TP " .. index
    tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.TextSize = 10
    Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 4)

    local clrBtn = Instance.new("TextButton", row)
    clrBtn.Size = UDim2.new(0.3, -4, 0, 24)
    clrBtn.Position = UDim2.new(0.62, 0, 0, 4)
    clrBtn.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
    clrBtn.Text = "Clear " .. index
    clrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clrBtn.Font = Enum.Font.GothamBold
    clrBtn.TextSize = 10
    Instance.new("UICorner", clrBtn).CornerRadius = UDim.new(0, 4)

    local varName = "Waypoint" .. index
    saveBtn.MouseButton1Click:Connect(function()
        local c = LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            _G[varName] = hrp.CFrame
            saveBtn.Text = "Saved!"
            task.wait(1)
            saveBtn.Text = "Save " .. index
        end
    end)

    tpBtn.MouseButton1Click:Connect(function()
        local c = LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp and _G[varName] then
            hrp.CFrame = _G[varName]
        end
    end)

    clrBtn.MouseButton1Click:Connect(function()
        _G[varName] = nil
        clrBtn.Text = "Cleared"
        task.wait(1)
        clrBtn.Text = "Clear " .. index
    end)
end

makeWaypointRow(1)
makeWaypointRow(2)
makeWaypointRow(3)

-- ---- 2. ITEM ESP ----
_G.ItemEspKeys = false
_G.ItemEspDoors = false
_G.ItemEspItems = false
_G.ItemEspChests = false

AddSectionHeader(P_Combat, "Item ESP")
AddToggleComponent(P_Combat, "Key ESP", "ItemEspKeys")
AddToggleComponent(P_Combat, "Door ESP", "ItemEspDoors")
AddToggleComponent(P_Combat, "Item ESP", "ItemEspItems")
AddToggleComponent(P_Combat, "Chest ESP", "ItemEspChests")

local itemEspColors = {
    Keys = Color3.fromRGB(255, 215, 0),
    Doors = Color3.fromRGB(255, 100, 100),
    Items = Color3.fromRGB(100, 200, 255),
    Chests = Color3.fromRGB(255, 150, 255)
}

local itemEspKeywords = {
    Keys = {"key", "keycard", "card"},
    Doors = {"door"},
    Items = {"coin", "gem", "item", "pickup", "weapon", "tool"},
    Chests = {"chest", "crate", "box"}
}

RunService.Heartbeat:Connect(function()
    for _, p in pairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") or p:IsA("Model") or p:IsA("Tool") then
            local name = string.lower(p.Name)
            local matched = nil
            local varName = nil
            local color = nil

            if _G.ItemEspKeys then
                for _, kw in ipairs(itemEspKeywords.Keys) do
                    if string.find(name, kw, 1, true) then matched = "Keys"; varName = "Keys"; color = itemEspColors.Keys break end
                end
            end
            if not matched and _G.ItemEspDoors then
                for _, kw in ipairs(itemEspKeywords.Doors) do
                    if string.find(name, kw, 1, true) then matched = "Doors"; varName = "Doors"; color = itemEspColors.Doors break end
                end
            end
            if not matched and _G.ItemEspItems then
                for _, kw in ipairs(itemEspKeywords.Items) do
                    if string.find(name, kw, 1, true) then matched = "Items"; varName = "Items"; color = itemEspColors.Items break end
                end
            end
            if not matched and _G.ItemEspChests then
                for _, kw in ipairs(itemEspKeywords.Chests) do
                    if string.find(name, kw, 1, true) then matched = "Chests"; varName = "Chests"; color = itemEspColors.Chests break end
                end
            end

            local tagName = "DeltaItemEsp"
            local existing = p:FindFirstChild(tagName)

            if matched then
                if not existing then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = tagName
                    bill.Size = UDim2.new(0, 100, 0, 20)
                    bill.AlwaysOnTop = true
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    local lbl = Instance.new("TextLabel", bill)
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 0.3
                    lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    lbl.Text = p.Name
                    lbl.TextColor3 = color
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextSize = 9
                    local corner = Instance.new("UICorner", lbl)
                    corner.CornerRadius = UDim.new(0, 4)
                    bill.Parent = p
                end
            elseif existing then
                existing:Destroy()
            end
        end
    end
end)

-- ---- 3. AUTO-INTERACT EXPANDED ----
_G.AutoPromptRadius = 15

AddSectionHeader(P_Automation, "Interact Radius")
AddInputComponent(P_Automation, "Prompt Radius:", "15", function(v) _G.AutoPromptRadius = math.max(1, v) end)

task.spawn(function()
    while true do
        task.wait(0.3)
        if _G.AutoInteract and LocalPlayer.Character then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local radius = _G.AutoPromptRadius or 15
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and obj.Enabled then
                        local parent = obj.Parent
                        if parent and parent:IsA("BasePart") then
                            if (parent.Position - hrp.Position).Magnitude < radius then
                                pcall(function() fireproximityprompt(obj) end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ---- 4. PLAYER TRACKER ARROW ----
_G.PlayerTracker = false

AddSectionHeader(P_Combat, "Player Tracker")
AddToggleComponent(P_Combat, "Nearest Player Arrow", "PlayerTracker")

local trackerGui = Instance.new("Frame", ScreenGui)
trackerGui.Name = "DeltaTracker"
trackerGui.Size = UDim2.new(0, 100, 0, 30)
trackerGui.Position = UDim2.new(0.5, -50, 0, 50)
trackerGui.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
trackerGui.BackgroundTransparency = 0.3
trackerGui.Visible = false
Instance.new("UICorner", trackerGui).CornerRadius = UDim.new(0, 6)

local trackerStroke = Instance.new("UIStroke", trackerGui)
trackerStroke.Color = CurrentThemeColor
trackerStroke.Thickness = 1.5

local trackerLabel = Instance.new("TextLabel", trackerGui)
trackerLabel.Size = UDim2.new(1, -10, 1, 0)
trackerLabel.Position = UDim2.new(0, 5, 0, 0)
trackerLabel.BackgroundTransparency = 1
trackerLabel.Text = "—"
trackerLabel.TextColor3 = CurrentThemeColor
trackerLabel.Font = Enum.Font.GothamBold
trackerLabel.TextSize = 11

RunService.RenderStepped:Connect(function()
    if not _G.PlayerTracker then
        trackerGui.Visible = false
        return
    end
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then
        trackerGui.Visible = false
        return
    end

    local best, bestDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - myHrp.Position).Magnitude
                if d < bestDist then best = p; bestDist = d end
            end
        end
    end

    trackerGui.Visible = true
    if best and best.Character and best.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = best.Character.HumanoidRootPart.Position
        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
        local distance = math.floor(bestDist)

        if onScreen then
            trackerLabel.Text = "→ " .. best.Name .. " (" .. distance .. "m)"
            trackerStroke.Color = CurrentThemeColor
        else
            local dir = (targetPos - myHrp.Position).Unit
            local relDir = Camera.CFrame:VectorToObjectSpace(dir)
            local angle = math.deg(math.atan2(relDir.X, -relDir.Z))
            local arrows = {"↑", "↗", "→", "↘", "↓", "↙", "←", "↖"}
            local idx = math.floor(((angle + 22.5) % 360) / 45) + 1
            trackerLabel.Text = (arrows[idx] or "?") .. " " .. best.Name .. " (" .. distance .. "m)"
            trackerStroke.Color = Color3.fromRGB(255, 150, 150)
        end
    else
        trackerLabel.Text = "No players"
    end
end)

-- ---- 5. CHAT SPAM ----
_G.ChatSpam = false
_G.ChatSpamText = "Hello"
_G.ChatSpamDelay = 5

AddSectionHeader(P_Automation, "Chat Spam")
AddToggleComponent(P_Automation, "Enable Chat Spam", "ChatSpam")
AddInputComponent(P_Automation, "Message:", "Hello", function(v) _G.ChatSpamText = tostring(v) end)
AddInputComponent(P_Automation, "Delay (s):", "5", function(v) _G.ChatSpamDelay = math.max(1, v) end)

local lastChatSpamSend = 0

task.spawn(function()
    while true do
        task.wait(1)
        if _G.ChatSpam and tick() - lastChatSpamSend >= (_G.ChatSpamDelay or 5) then
            lastChatSpamSend = tick()
            pcall(function()
                game:GetService("TextChatService"):SendAsync(_G.ChatSpamText or "Hello")
            end)
        end
    end
end)

print("[Delta] Utility patch loaded — Waypoints, Item ESP, Interact+, Tracker, Chat Spam")
-- =============================================================================
-- ON-SCREEN CONTROLS + SAVE/LOAD PATCH (v6.2.8)
-- =============================================================================

local SAVE_FILE = "DeltaV5_save.json"

-- Persistence helpers
local function saveAll()
    if not writefile then return end
    pcall(function()
        local data = {
            pads = {
                wasdPos = _G.WasdPadPos or {0.03, 0.7},
                actionPos = _G.ActionPadPos or {0.75, 0.7},
                wasdEnabled = _G.WasdPad,
                actionEnabled = _G.ActionPad,
                scale = _G.PadScale or 1
            },
            toggles = {},
            inputs = {}
        }
        local skip = {WasdPadPos=true, ActionPadPos=true, WasdPad=true, ActionPad=true, PadScale=true}
        for k, v in pairs(_G) do
            if type(k) == "string" and not skip[k] then
                if type(v) == "boolean" then data.toggles[k] = v
                elseif type(v) == "number" then data.inputs[k] = v
                end
            end
        end
        writefile(SAVE_FILE, game:GetService("HttpService"):JSONEncode(data))
    end)
end

local function loadAll()
    if not readfile or not isfile then return false end
    local ok, raw = pcall(readfile, SAVE_FILE)
    if not ok or not raw or raw == "" then return false end
    local ok2, data = pcall(function() return game:GetService("HttpService"):JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then return false end

    if data.pads then
        if data.pads.wasdPos then _G.WasdPadPos = data.pads.wasdPos end
        if data.pads.actionPos then _G.ActionPadPos = data.pads.actionPos end
        if data.pads.wasdEnabled ~= nil then _G.WasdPad = data.pads.wasdEnabled end
        if data.pads.actionEnabled ~= nil then _G.ActionPad = data.pads.actionEnabled end
        if data.pads.scale then _G.PadScale = data.pads.scale end
    end
    if data.toggles then
        for k, v in pairs(data.toggles) do _G[k] = v end
    end
    if data.inputs then
        for k, v in pairs(data.inputs) do _G[k] = v end
    end
    return true
end

local function clearSave()
    if delfile and isfile and isfile(SAVE_FILE) then
        pcall(delfile, SAVE_FILE)
    end
end

-- Initialize defaults
_G.AutoSave = true
_G.WasdPad = _G.WasdPad or false
_G.ActionPad = _G.ActionPad or false
_G.PadScale = _G.PadScale or 1
_G.WasdPadPos = _G.WasdPadPos or {0.03, 0.70}
_G.ActionPadPos = _G.ActionPadPos or {0.75, 0.70}

-- Auto-load on startup
if _G.AutoSave then
    pcall(loadAll)
end

-- Save/Load UI
AddSectionHeader(P_Settings, "Save / Load")
AddToggleComponent(P_Settings, "Auto-Save Enabled", "AutoSave", function(v)
    if v then pcall(saveAll) end
end)

local LoadBtn = Instance.new("TextButton", P_Settings)
LoadBtn.Size = UDim2.new(1, 0, 0, 30)
LoadBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 45)
LoadBtn.Text = "Load Saved Config"
LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadBtn.Font = Enum.Font.GothamBold
LoadBtn.TextSize = 11
Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 6)
LoadBtn.MouseButton1Click:Connect(function()
    if loadAll() then
        LoadBtn.Text = "Loaded! Re-run for full effect"
    else
        LoadBtn.Text = "No save file found"
    end
    task.wait(2)
    LoadBtn.Text = "Load Saved Config"
end)

local ResetBtn = Instance.new("TextButton", P_Settings)
ResetBtn.Size = UDim2.new(1, 0, 0, 30)
ResetBtn.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
ResetBtn.Text = "New Config (Reset)"
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.TextSize = 11
Instance.new("UICorner", ResetBtn).CornerRadius = UDim.new(0, 6)
ResetBtn.MouseButton1Click:Connect(function()
    local confirm = Instance.new("Frame", ScreenGui)
    confirm.Size = UDim2.new(0, 260, 0, 120)
    confirm.Position = UDim2.new(0.5, -130, 0.5, -60)
    confirm.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    confirm.ZIndex = 9999
    Instance.new("UICorner", confirm).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", confirm)
    s.Color = Color3.fromRGB(200, 50, 50)
    s.Thickness = 2

    local lbl = Instance.new("TextLabel", confirm)
    lbl.Size = UDim2.new(1, 0, 0, 50)
    lbl.Position = UDim2.new(0, 0, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Reset ALL toggles, inputs,\nand pad positions to default?"
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextWrapped = true
    lbl.ZIndex = 10000

    local yes = Instance.new("TextButton", confirm)
    yes.Size = UDim2.new(0.45, 0, 0, 30)
    yes.Position = UDim2.new(0.03, 0, 1, -40)
    yes.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    yes.Text = "YES, Reset"
    yes.TextColor3 = Color3.fromRGB(255, 255, 255)
    yes.Font = Enum.Font.GothamBold
    yes.TextSize = 11
    yes.ZIndex = 10000
    Instance.new("UICorner", yes).CornerRadius = UDim.new(0, 4)

    local no = Instance.new("TextButton", confirm)
    no.Size = UDim2.new(0.45, 0, 0, 30)
    no.Position = UDim2.new(0.52, 0, 1, -40)
    no.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    no.Text = "Cancel"
    no.TextColor3 = Color3.fromRGB(255, 255, 255)
    no.Font = Enum.Font.GothamBold
    no.TextSize = 11
    no.ZIndex = 10000
    Instance.new("UICorner", no).CornerRadius = UDim.new(0, 4)

    no.MouseButton1Click:Connect(function()
        confirm:Destroy()
    end)

    yes.MouseButton1Click:Connect(function()
        confirm:Destroy()
        clearSave()
        _G.SpeedValue = 16
        _G.JumpValue = 50
        _G.GravityValue = 196.2
        _G.FovValue = 70
        _G.HitboxSize = 2
        _G.FlySpeed = 50
        _G.AimFov = 200
        _G.AimSmooth = 0.25
        _G.AimStrength = 50
        _G.AimPart = "Head"
        _G.AutoShoot = false
        _G.Aimbot = false
        _G.Esp = false
        _G.Fly = false
        _G.Noclip = false
        _G.Invisible = false
        _G.Sprint = false
        _G.Dash = false
        _G.DoubleJump = false
        _G.NoFallDamage = false
        _G.TriggerBot = false
        _G.SilentAim = false
        _G.AimAssist = false
        _G.ClingBurst = false
        _G.ChatSpam = false
        _G.SoundSpam = false
        _G.LagServer = false
        _G.WasdPad = false
        _G.ActionPad = false
        _G.PadScale = 1
        _G.WasdPadPos = {0.03, 0.70}
        _G.ActionPadPos = {0.75, 0.70}
        ResetBtn.Text = "Reset — re-run script"
        task.wait(2)
        ResetBtn.Text = "New Config (Reset)"
    end)
end)

-- On-Screen Controls
AddSectionHeader(P_Settings, "On-Screen Controls")
AddToggleComponent(P_Settings, "Enable WASD Pad", "WasdPad", function(v)
    if v then _G.WasdPad = true else _G.WasdPad = false end
    if _G.AutoSave then pcall(saveAll) end
end)
AddToggleComponent(P_Settings, "Enable Action Pad", "ActionPad", function(v)
    if v then _G.ActionPad = true else _G.ActionPad = false end
    if _G.AutoSave then pcall(saveAll) end
end)
AddInputComponent(P_Settings, "Pad Scale (0.5-2):", "1", function(v)
    _G.PadScale = math.clamp(v, 0.5, 2)
    if _G.AutoSave then pcall(saveAll) end
end)

-- Pad UI builder
local function createPad(name, pos, size, children)
    local p = Instance.new("Frame", ScreenGui)
    p.Name = name
    p.Size = size
    p.Position = UDim2.new(pos[1], 0, pos[2], 0)
    p.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    p.BackgroundTransparency = 0.3
    p.Active = true
    p.Visible = false
    p.ZIndex = 500
    Instance.new("UICorner", p).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", p)
    s.Color = CurrentThemeColor
    s.Thickness = 1.5
    s.Transparency = 0.3
    s.ZIndex = 500

    -- Drag dot
    local dot = Instance.new("TextButton", p)
    dot.Size = UDim2.new(0, 22, 0, 22)
    dot.Position = UDim2.new(1, -26, 1, -26)
    dot.BackgroundColor3 = CurrentThemeColor
    dot.BackgroundTransparency = 0.2
    dot.Text = "⠿"
    dot.TextColor3 = Color3.fromRGB(20, 20, 20)
    dot.Font = Enum.Font.GothamBold
    dot.TextSize = 16
    dot.ZIndex = 510
    Instance.new("UICorner", dot).CornerRadius = UDim.new(0, 11)

    local dragging = false
    local dragStart
    local startPos
    dot.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = p.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if _G.AutoSave then pcall(saveAll) end
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = i.Position - dragStart
            p.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            if name == "DeltaWasdPad" then
                _G.WasdPadPos = {p.Position.X.Scale, p.Position.Y.Scale}
            else
                _G.ActionPadPos = {p.Position.X.Scale, p.Position.Y.Scale}
            end
        end
    end)

    -- Children (buttons)
    for _, child in ipairs(children) do
        local btn = Instance.new("TextButton", p)
        btn.Size = child.size
        btn.Position = child.pos
        btn.BackgroundColor3 = child.color or Color3.fromRGB(40, 40, 40)
        btn.Text = child.text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = child.textSize or 12
        btn.ZIndex = 505
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        if child.onDown then
            btn.MouseButton1Down:Connect(child.onDown)
        end
        if child.onUp then
            btn.MouseButton1Up:Connect(child.onUp)
            btn.MouseLeave:Connect(child.onUp)
        end
        if child.onClick then
            btn.MouseButton1Click:Connect(child.onClick)
        end
    end

    return p
end

-- WASD Pad
local wasdPad = createPad("DeltaWasdPad", _G.WasdPadPos, UDim2.new(0, 160, 0, 160), {
    {text = "W", size = UDim2.new(0, 50, 0, 50), pos = UDim2.new(0.5, -25, 0, 5),
     onDown = function() _G.WasdHeld = "W" end, onUp = function() if _G.WasdHeld == "W" then _G.WasdHeld = nil end end},
    {text = "A", size = UDim2.new(0, 50, 0, 50), pos = UDim2.new(0, 5, 0.5, -25),
     onDown = function() _G.WasdHeld = "A" end, onUp = function() if _G.WasdHeld == "A" then _G.WasdHeld = nil end end},
    {text = "S", size = UDim2.new(0, 50, 0, 50), pos = UDim2.new(0.5, -25, 0.5, -25),
     onDown = function() _G.WasdHeld = "S" end, onUp = function() if _G.WasdHeld == "S" then _G.WasdHeld = nil end end},
    {text = "D", size = UDim2.new(0, 50, 0, 50), pos = UDim2.new(1, -55, 0.5, -25),
     onDown = function() _G.WasdHeld = "D" end, onUp = function() if _G.WasdHeld == "D" then _G.WasdHeld = nil end end}
})

-- Action Pad
local actionPad = createPad("DeltaActionPad", _G.ActionPadPos, UDim2.new(0, 200, 0, 120), {
    {text = "Jump", size = UDim2.new(0, 90, 0, 40), pos = UDim2.new(0.5, -45, 0, 5),
     onClick = function()
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end},
    {text = "Sprint", size = UDim2.new(0, 90, 0, 30), pos = UDim2.new(0, 5, 1, -40),
     onDown = function() _G.SprintHeld = true end, onUp = function() _G.SprintHeld = false end},
    {text = "ShiftLock", size = UDim2.new(0, 95, 0, 30), pos = UDim2.new(1, -100, 1, -40),
     onClick = function()
        local UIS = UserInputService
        if UIS.MouseBehavior == Enum.MouseBehavior.LockCenter then
            UIS.MouseBehavior = Enum.MouseBehavior.Default
        else
            UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    end}
})

-- Tick loop for movement + sprint
RunService.Heartbeat:Connect(function()
    wasdPad.Visible = _G.WasdPad
    actionPad.Visible = _G.ActionPad

    local scale = _G.PadScale or 1
    wasdPad.Size = UDim2.new(0, 160 * scale, 0, 160 * scale)
    wasdPad.Position = UDim2.new(_G.WasdPadPos[1], 0, _G.WasdPadPos[2], 0)
    actionPad.Size = UDim2.new(0, 200 * scale, 0, 120 * scale)
    actionPad.Position = UDim2.new(_G.ActionPadPos[1], 0, _G.ActionPadPos[2], 0)

    local c = LocalPlayer.Character
    local h = c and c:FindFirstChildOfClass("Humanoid")
    if not h then return end

    if _G.WasdHeld then
        local moveVec = Vector3.new(0, 0, 0)
        if _G.WasdHeld == "W" then moveVec = Vector3.new(0, 0, -1) end
        if _G.WasdHeld == "S" then moveVec = Vector3.new(0, 0, 1) end
        if _G.WasdHeld == "A" then moveVec = Vector3.new(-1, 0, 0) end
        if _G.WasdHeld == "D" then moveVec = Vector3.new(1, 0, 0) end
        h:Move(moveVec, false)
    end

    if _G.SprintHeld and h.MoveDirection.Magnitude > 0 then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp then
            local spd = (_G.SpeedValue or 16) * 2
            hrp.AssemblyLinearVelocity = Vector3.new(h.MoveDirection.X * spd, hrp.AssemblyLinearVelocity.Y, h.MoveDirection.Z * spd)
        end
    end
end)

-- Save on any toggle change (hook into existing addToggleComponent callbacks indirectly via heartbeat)
task.spawn(function()
    while true do
        task.wait(3)
        if _G.AutoSave then pcall(saveAll) end
    end
end)

print("[Delta] On-Screen Controls + Save/Load patch loaded")
-- =============================================================================
-- INSPECT PATCH (v6.2.7) — DevTools-style client-side inspector
-- =============================================================================

_G.InspectMode = false

AddSectionHeader(P_Settings, "Inspect")
AddToggleComponent(P_Settings, "Inspect Mode (click to inspect)", "InspectMode")

-- Highlight state
local inspectHighlight3D = nil
local inspectHighlightUI = nil
local inspectCurrent3D = nil
local inspectCurrentUI = nil
local inspectPanel = nil

local function clearInspectHighlight()
    if inspectHighlight3D then pcall(function() inspectHighlight3D:Destroy() end); inspectHighlight3D = nil end
    if inspectHighlightUI then pcall(function() inspectHighlightUI:Destroy() end); inspectHighlightUI = nil end
    inspectCurrent3D = nil
    inspectCurrentUI = nil
end

local function getMouseTarget()
    local mp = UserInputService:GetMouseLocation()
    local ray = Camera:ViewportPointToRay(mp.X, mp.Y)
    local rp = RaycastParams.new()
    rp.FilterDescendantsInstances = {ScreenGui}
    rp.FilterType = Enum.RaycastFilterType.Exclude
    local result = workspace:Raycast(ray.Origin, ray.Direction * 5000, rp)
    if result and result.Instance then
        return result.Instance
    end
    return nil
end

local function getUITarget()
    local mp = UserInputService:GetMouseLocation()
    local function contains(gui)
        if not gui.Visible then return false end
        local pos = gui.AbsolutePosition
        local size = gui.AbsoluteSize
        return mp.X >= pos.X and mp.X <= pos.X + size.X and mp.Y >= pos.Y and mp.Y <= pos.Y + size.Y
    end
    local candidates = {}
    for _, container in ipairs({game:GetService("CoreGui"), LocalPlayer:FindFirstChild("PlayerGui")}) do
        if container then
            for _, obj in ipairs(container:GetDescendants()) do
                if (obj:IsA("GuiObject") and obj ~= inspectPanel and not obj:IsDescendantOf(ScreenGui)) then
                    if contains(obj) then
                        table.insert(candidates, obj)
                    end
                end
            end
        end
    end
    table.sort(candidates, function(a, b)
        return #a:GetFullName() < #b:GetFullName()
    end)
    for i = #candidates, 1, -1 do
        local c = candidates[i]
        if c and c.Parent and c.Parent:IsA("GuiObject") then
            if not contains(c.Parent) then return c end
        else
            return c
        end
    end
    return nil
end

local function highlight3D(part)
    if inspectCurrent3D == part then return end
    clearInspectHighlight()
    if part and part:IsA("BasePart") then
        inspectHighlight3D = Instance.new("Highlight")
        inspectHighlight3D.Name = "DeltaInspect"
        inspectHighlight3D.FillColor = Color3.fromRGB(255, 255, 100)
        inspectHighlight3D.FillTransparency = 0.5
        inspectHighlight3D.OutlineColor = Color3.fromRGB(255, 255, 0)
        inspectHighlight3D.OutlineTransparency = 0
        inspectHighlight3D.Parent = part
        inspectCurrent3D = part
    end
end

local function highlightUI(gui)
    if inspectCurrentUI == gui then return end
    if inspectHighlightUI then pcall(function() inspectHighlightUI:Destroy() end); inspectHighlightUI = nil end
    if gui then
        inspectHighlightUI = Instance.new("UIStroke")
        inspectHighlightUI.Name = "DeltaInspectUI"
        inspectHighlightUI.Color = Color3.fromRGB(100, 200, 255)
        inspectHighlightUI.Thickness = 2
        inspectHighlightUI.Parent = gui
        inspectCurrentUI = gui
    end
end

RunService.RenderStepped:Connect(function()
    if not _G.InspectMode then
        if inspectCurrent3D or inspectCurrentUI then clearInspectHighlight() end
        return
    end
    local uiTarget = getUITarget()
    if uiTarget then
        highlightUI(uiTarget)
        if inspectHighlight3D then pcall(function() inspectHighlight3D:Destroy() end); inspectHighlight3D = nil; inspectCurrent3D = nil end
    else
        local partTarget = getMouseTarget()
        if partTarget then
            highlight3D(partTarget)
            if inspectHighlightUI then pcall(function() inspectHighlightUI:Destroy() end); inspectHighlightUI = nil; inspectCurrentUI = nil end
        else
            clearInspectHighlight()
        end
    end
end)

local function makeRow(parent, y)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -8, 0, 24)
    f.Position = UDim2.new(0, 4, 0, y)
    f.BackgroundTransparency = 1
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(0.4, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local box = Instance.new("TextBox", f)
    box.Size = UDim2.new(0.58, 0, 1, 0)
    box.Position = UDim2.new(0.42, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.GothamBold
    box.TextSize = 10
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)
    return lbl, box
end

local function buildPanel(target)
    if inspectPanel then inspectPanel:Destroy(); inspectPanel = nil end

    local isPart = target:IsA("BasePart")
    local isUI = target:IsA("GuiObject")

    local panel = Instance.new("Frame", ScreenGui)
    panel.Name = "DeltaInspectPanel"
    panel.Size = UDim2.new(0, 260, 0, isPart and 340 or 260)
    panel.Position = UDim2.new(0.65, 0, 0.2, 0)
    panel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    panel.BackgroundTransparency = 0.1
    panel.Active = true
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", panel)
    stroke.Color = CurrentThemeColor
    stroke.Thickness = 2
    inspectPanel = panel

    local header = Instance.new("Frame", panel)
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)
    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(1, -60, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "INSPECT: " .. target.ClassName
    title.TextColor3 = CurrentThemeColor
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0, 24, 0, 22)
    closeBtn.Position = UDim2.new(1, -28, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 11
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)
    closeBtn.MouseButton1Click:Connect(function()
        panel:Destroy()
        inspectPanel = nil
    end)

    EnableDragModule(panel)

    local scroll = Instance.new("ScrollingFrame", panel)
    scroll.Size = UDim2.new(1, -8, 1, -36)
    scroll.Position = UDim2.new(0, 4, 0, 32)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, 400)

    local y = 0

    local function addStatic(label, value)
        local lbl, box = makeRow(scroll, y)
        lbl.Text = label
        box.Text = tostring(value)
        box.TextEditable = false
        box.BackgroundTransparency = 0.5
        y = y + 26
    end

    addStatic("Name:", target.Name)
    addStatic("Class:", target.ClassName)
    addStatic("Path:", target:GetFullName())

    if isPart then
        local lbl, box = makeRow(scroll, y)
        lbl.Text = "Position:"
        box.Text = tostring(target.Position)
        box.FocusLost:Connect(function(ep)
            if ep then
                local parts = string.split(box.Text, ",")
                if #parts == 3 then
                    local x, y2, z = tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3])
                    if x and y2 and z then pcall(function() target.Position = Vector3.new(x, y2, z) end) end
                end
            end
        end)
        y = y + 26

        local lbl2, box2 = makeRow(scroll, y)
        lbl2.Text = "Size:"
        box2.Text = tostring(target.Size)
        box2.FocusLost:Connect(function(ep)
            if ep then
                local parts = string.split(box2.Text, ",")
                if #parts == 3 then
                    local x, y2, z = tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3])
                    if x and y2 and z then pcall(function() target.Size = Vector3.new(x, y2, z) end) end
                end
            end
        end)
        y = y + 26

        local lbl3, box3 = makeRow(scroll, y)
        lbl3.Text = "Color (r,g,b):"
        box3.Text = tostring(target.Color.R * 255) .. "," .. tostring(target.Color.G * 255) .. "," .. tostring(target.Color.B * 255)
        box3.FocusLost:Connect(function(ep)
            if ep then
                local parts = string.split(box3.Text, ",")
                if #parts == 3 then
                    local r, g, b = tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3])
                    if r and g and b then pcall(function() target.Color = Color3.fromRGB(r, g, b) end) end
                end
            end
        end)
        y = y + 26

        local lbl4, box4 = makeRow(scroll, y)
        lbl4.Text = "Transparency:"
        box4.Text = tostring(target.Transparency)
        box4.FocusLost:Connect(function(ep)
            if ep then
                local v = tonumber(box4.Text)
                if v then pcall(function() target.Transparency = math.clamp(v, 0, 1) end) end
            end
        end)
        y = y + 26

        local lbl5, box5 = makeRow(scroll, y)
        lbl5.Text = "Anchored (true/false):"
        box5.Text = tostring(target.Anchored)
        box5.FocusLost:Connect(function(ep)
            if ep then
                if box5.Text == "true" then pcall(function() target.Anchored = true end)
                elseif box5.Text == "false" then pcall(function() target.Anchored = false end) end
            end
        end)
        y = y + 26

        local lbl6, box6 = makeRow(scroll, y)
        lbl6.Text = "CanCollide:"
        box6.Text = tostring(target.CanCollide)
        box6.FocusLost:Connect(function(ep)
            if ep then
                if box6.Text == "true" then pcall(function() target.CanCollide = true end)
                elseif box6.Text == "false" then pcall(function() target.CanCollide = false end) end
            end
        end)
        y = y + 26
    elseif isUI then
        local lbl, box = makeRow(scroll, y)
        lbl.Text = "Position:"
        box.Text = tostring(target.Position)
        box.FocusLost:Connect(function(ep)
            if ep then
                local parts = string.split(box.Text, ",")
                if #parts == 2 then
                    local xs, ys = tonumber(parts[1]), tonumber(parts[2])
                    if xs and ys then pcall(function() target.Position = UDim2.new(0, xs, 0, ys) end) end
                end
            end
        end)
        y = y + 26

        local lbl2, box2 = makeRow(scroll, y)
        lbl2.Text = "Size:"
        box2.Text = tostring(target.Size)
        box2.FocusLost:Connect(function(ep)
            if ep then
                local parts = string.split(box2.Text, ",")
                if #parts == 2 then
                    local xs, ys = tonumber(parts[1]), tonumber(parts[2])
                    if xs and ys then pcall(function() target.Size = UDim2.new(0, xs, 0, ys) end) end
                end
            end
        end)
        y = y + 26

        local lbl3, box3 = makeRow(scroll, y)
        lbl3.Text = "BgColor (r,g,b):"
        box3.Text = tostring(target.BackgroundColor3.R * 255) .. "," .. tostring(target.BackgroundColor3.G * 255) .. "," .. tostring(target.BackgroundColor3.B * 255)
        box3.FocusLost:Connect(function(ep)
            if ep then
                local parts = string.split(box3.Text, ",")
                if #parts == 3 then
                    local r, g, b = tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3])
                    if r and g and b then pcall(function() target.BackgroundColor3 = Color3.fromRGB(r, g, b) end) end
                end
            end
        end)
        y = y + 26

        local lbl4, box4 = makeRow(scroll, y)
        lbl4.Text = "BgTransparency:"
        box4.Text = tostring(target.BackgroundTransparency)
        box4.FocusLost:Connect(function(ep)
            if ep then
                local v = tonumber(box4.Text)
                if v then pcall(function() target.BackgroundTransparency = math.clamp(v, 0, 1) end) end
            end
        end)
        y = y + 26

        if target:IsA("TextLabel") or target:IsA("TextButton") or target:IsA("TextBox") then
            local lbl5, box5 = makeRow(scroll, y)
            lbl5.Text = "Text:"
            box5.Text = tostring(target.Text)
            box5.FocusLost:Connect(function(ep)
                if ep then pcall(function() target.Text = box5.Text end) end
            end)
            y = y + 26

            local lbl6, box6 = makeRow(scroll, y)
            lbl6.Text = "Visible:"
            box6.Text = tostring(target.Visible)
            box6.FocusLost:Connect(function(ep)
                if ep then
                    if box6.Text == "true" then pcall(function() target.Visible = true end)
                    elseif box6.Text == "false" then pcall(function() target.Visible = false end) end
                end
            end)
            y = y + 26
        end
    end

    local copyBtn = Instance.new("TextButton", scroll)
    copyBtn.Size = UDim2.new(1, -8, 0, 28)
    copyBtn.Position = UDim2.new(0, 4, 0, y + 4)
    copyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    copyBtn.Text = "Copy Path"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextSize = 11
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 4)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard(target:GetFullName())
        end)
        copyBtn.Text = "Copied!"
        task.wait(1)
        copyBtn.Text = "Copy Path"
    end)
    y = y + 36

    scroll.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if not _G.InspectMode then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

    local uiTarget = getUITarget()
    if uiTarget then
        buildPanel(uiTarget)
        return
    end

    local partTarget = getMouseTarget()
    if partTarget then
        buildPanel(partTarget)
    end
end)

print("[Delta] Inspect patch loaded")
-- KEY GATE
local savedToken = LoadLicense()
if IsDeveloper or savedToken then
    StartCheatEngineLoops()
else
    local KeyGateFrame = Instance.new("Frame")
    KeyGateFrame.Name = "KeyGateFrame"
    KeyGateFrame.Parent = ScreenGui
    KeyGateFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    KeyGateFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    KeyGateFrame.Size = UDim2.new(0, 300, 0, 150)
    KeyGateFrame.Active = true
    EnableDragModule(KeyGateFrame)
    local kgC = Instance.new("UICorner"); kgC.CornerRadius = UDim.new(0, 8); kgC.Parent = KeyGateFrame
    local kgS = Instance.new("UIStroke"); kgS.Color = CurrentThemeColor; kgS.Thickness = 2; kgS.Parent = KeyGateFrame
    local GateTitle = Instance.new("TextLabel")
    GateTitle.Size = UDim2.new(1, 0, 0, 35)
    GateTitle.Text = "DELTA ACCESS VERIFICATION"
    GateTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    GateTitle.Font = Enum.Font.GothamBold; GateTitle.TextSize = 12; GateTitle.BackgroundTransparency = 1; GateTitle.Parent = KeyGateFrame
    local KeyInputBox = Instance.new("TextBox")
    KeyInputBox.Size = UDim2.new(0.9, 0, 0, 30)
    KeyInputBox.Position = UDim2.new(0.05, 0, 0.3, 0)
    KeyInputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    KeyInputBox.Text = "Paste Token Key String Here"
    KeyInputBox.TextColor3 = Color3.fromRGB(180, 180, 180)
    KeyInputBox.Font = Enum.Font.GothamMedium; KeyInputBox.TextSize = 11; KeyInputBox.Parent = KeyGateFrame
    local kibC = Instance.new("UICorner"); kibC.CornerRadius = UDim.new(0, 6); kibC.Parent = KeyInputBox
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.9, 0, 0, 32)
    SubmitBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    SubmitBtn.BackgroundColor3 = CurrentThemeColor
    SubmitBtn.Text = "SUBMIT ACCESS KEY"
    SubmitBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
    SubmitBtn.Font = Enum.Font.GothamBold; SubmitBtn.TextSize = 11; SubmitBtn.Parent = KeyGateFrame
    local sbc = Instance.new("UICorner"); sbc.CornerRadius = UDim.new(0, 6); sbc.Parent = SubmitBtn
    SubmitBtn.MouseButton1Click:Connect(function()
        if VerifyKeyToken(KeyInputBox.Text) then
            SaveLicense(KeyInputBox.Text)
            KeyGateFrame:Destroy()
            StartCheatEngineLoops()
        else
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            SubmitBtn.Text = "INVALID OR EXPIRED KEY TOKEN"
            task.wait(1.5)
            SubmitBtn.BackgroundColor3 = CurrentThemeColor
            SubmitBtn.Text = "SUBMIT ACCESS KEY"
        end
    end)
end