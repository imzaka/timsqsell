-- ============================================
-- TIMSQ SELL v1.1
-- ============================================

local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local remote = char:WaitForChild("RemoteEvent")
local vim = game:GetService("VirtualInputManager")

local oldGui = player.PlayerGui:FindFirstChild("TIMSQ_Sell_Menu")
if oldGui then oldGui:Destroy() end

-- ============================================
-- СПИСОК ПРЕДМЕТОВ
-- ============================================
local SELL_LIST = {
    ["Diamond"] = true,
    ["Gold Coin"] = true,
    ["Quinton's Glove"] = true,
    ["Ancient Scroll"] = true,
    ["Steel Ball"] = true,
    ["Green Baby"] = true,
    ["Dio's Diary"] = true,
    ["Pelvis of The Saint's Corpse"] = true,
    ["Heart of The Saint's Corpse"] = true,
    ["Left Arm of The Saint's Corpse"] = true,
    ["Rib Cage of The Saint's Corpse"] = true,
    ["Pure Rokakaka"] = true,
    ["Rokakaka"] = true,
    ["Stone Mask"] = true,
    ["Mysterious Arrow"] = true,
    ["Caesar's Headband"] = true,
    ["Clackers"] = true,
    ["Zeppeli's Hat"] = true,
    ["Алмаз"] = true,
    ["Золотая монета"] = true,
    ["Перчатка Квинтона"] = true,
    ["Древний свиток"] = true,
    ["Стальной шар"] = true,
    ["Зелёный младенец"] = true,
    ["Дневник Дио"] = true,
    ["Таз трупа Святого"] = true,
    ["Сердце трупа Святого"] = true,
    ["Левая рука трупа Святого"] = true,
    ["Грудная клетка трупа Святого"] = true,
    ["Чистая Рокакака"] = true,
    ["Рокакака"] = true,
    ["Каменная маска"] = true,
    ["Таинственная стрела"] = true,
    ["Повязка Цезаря"] = true,
    ["Клакеры"] = true,
    ["Шляпа Цеппели"] = true,
}

-- ============================================
-- КОНФИГ
-- ============================================
local Config = {
    coord1 = {x = 1240, y = 620},
    coord2 = {x = 1240, y = 620},
    coord3 = {x = 1240, y = 680},
    useMiddleClick = true,
    middleCoord = {x = 1240, y = 580},
    clicks1 = 3,
    clicks2 = 3,
    clicks3 = 3,
    delayAfterOpen = 0.5,
    delayAfterMiddle = 0.05,
    delayBetween12 = 0.1,
    delayBetween23 = 0.1,
    delayAfterSell = 0.5,
    delayBetweenClicks = 0.02,
    autoLoop = false,
    loopDelay = 1,
    
    equipBeforeSell = true,
    equipDelay = 0.8,
    equipCheckDelay = 0.1,
    equipMaxWait = 3,
    
    showHighlight = true,
    highlightSize = 30,
    highlightDuration = 1,
    
    color1 = {r = 255, g = 255, b = 0},
    color2 = {r = 0, g = 100, b = 255},
    color3 = {r = 255, g = 0, b = 0},
    colorMid = {r = 255, g = 140, b = 0},
    
    inventoryCheckDelay = 2
}

-- ============================================
-- GUI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TIMSQ_Sell_Menu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 540, 0, 720)
main.Position = UDim2.new(0, 50, 0, 50)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 10)
mc.Parent = main
local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(0, 220, 120)
ms.Thickness = 1.5
ms.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
header.BorderSizePixel = 0
header.Parent = main
local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 10)
hc.Parent = header
local hf = Instance.new("Frame")
hf.Size = UDim2.new(1, 0, 0, 15)
hf.Position = UDim2.new(0, 0, 1, -15)
hf.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
hf.BorderSizePixel = 0
hf.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TIMSQ SELL"
title.TextColor3 = Color3.fromRGB(0, 255, 140)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 6)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
minimizeBtn.Text = "—"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = header
local minc = Instance.new("UICorner")
minc.CornerRadius = UDim.new(0, 6)
minc.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header
local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = closeBtn

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -105)
content.Position = UDim2.new(0, 10, 0, 52)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(0, 220, 120)
content.Parent = main
local cl = Instance.new("UIListLayout")
cl.Padding = UDim.new(0, 5)
cl.Parent = content

-- ============================================
-- ХРАНИЛИЩЕ INPUT-ПОЛЕЙ
-- ============================================
local Inputs = {}

-- ============================================
-- ХЕЛПЕРЫ
-- ============================================
local function makeSection(text)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 26)
    section.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    section.BorderSizePixel = 0
    section.Parent = content
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = section
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(0, 255, 140)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = section
    return section
end

local function makeInput(id, labelText, default, callback, isNumber)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    row.BorderSizePixel = 0
    row.Parent = content
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = row
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 260, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row
    
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 110, 0, 20)
    box.Position = UDim2.new(1, -120, 0, 4)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    box.Text = tostring(default)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Parent = row
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 4)
    bc.Parent = box
    
    box.FocusLost:Connect(function()
        local val = box.Text
        if isNumber then val = tonumber(val) or default end
        callback(val)
    end)
    
    if id then
        Inputs[id] = box
    end
    return row
end

-- Функция обновления всех полей из Config
local function refreshInputs()
    if Inputs.coord1x then Inputs.coord1x.Text = tostring(Config.coord1.x) end
    if Inputs.coord1y then Inputs.coord1y.Text = tostring(Config.coord1.y) end
    if Inputs.coord2x then Inputs.coord2x.Text = tostring(Config.coord2.x) end
    if Inputs.coord2y then Inputs.coord2y.Text = tostring(Config.coord2.y) end
    if Inputs.coord3x then Inputs.coord3x.Text = tostring(Config.coord3.x) end
    if Inputs.coord3y then Inputs.coord3y.Text = tostring(Config.coord3.y) end
    if Inputs.midx then Inputs.midx.Text = tostring(Config.middleCoord.x) end
    if Inputs.midy then Inputs.midy.Text = tostring(Config.middleCoord.y) end
    if Inputs.clicks1 then Inputs.clicks1.Text = tostring(Config.clicks1) end
    if Inputs.clicks2 then Inputs.clicks2.Text = tostring(Config.clicks2) end
    if Inputs.clicks3 then Inputs.clicks3.Text = tostring(Config.clicks3) end
    if Inputs.delayOpen then Inputs.delayOpen.Text = tostring(Config.delayAfterOpen) end
    if Inputs.delayMid then Inputs.delayMid.Text = tostring(Config.delayAfterMiddle) end
    if Inputs.delay12 then Inputs.delay12.Text = tostring(Config.delayBetween12) end
    if Inputs.delay23 then Inputs.delay23.Text = tostring(Config.delayBetween23) end
    if Inputs.delaySell then Inputs.delaySell.Text = tostring(Config.delayAfterSell) end
    if Inputs.delayClick then Inputs.delayClick.Text = tostring(Config.delayBetweenClicks) end
    if Inputs.loopDelay then Inputs.loopDelay.Text = tostring(Config.loopDelay) end
    if Inputs.equipDelay then Inputs.equipDelay.Text = tostring(Config.equipDelay) end
    if Inputs.equipMax then Inputs.equipMax.Text = tostring(Config.equipMaxWait) end
    if Inputs.checkDelay then Inputs.checkDelay.Text = tostring(Config.inventoryCheckDelay) end
    if Inputs.hlSize then Inputs.hlSize.Text = tostring(Config.highlightSize) end
    if Inputs.hlDur then Inputs.hlDur.Text = tostring(Config.highlightDuration) end
    if Inputs.c1r then Inputs.c1r.Text = tostring(Config.color1.r) end
    if Inputs.c1g then Inputs.c1g.Text = tostring(Config.color1.g) end
    if Inputs.c1b then Inputs.c1b.Text = tostring(Config.color1.b) end
    if Inputs.c2r then Inputs.c2r.Text = tostring(Config.color2.r) end
    if Inputs.c2g then Inputs.c2g.Text = tostring(Config.color2.g) end
    if Inputs.c2b then Inputs.c2b.Text = tostring(Config.color2.b) end
    if Inputs.c3r then Inputs.c3r.Text = tostring(Config.color3.r) end
    if Inputs.c3g then Inputs.c3g.Text = tostring(Config.color3.g) end
    if Inputs.c3b then Inputs.c3b.Text = tostring(Config.color3.b) end
    if Inputs.cmr then Inputs.cmr.Text = tostring(Config.colorMid.r) end
    if Inputs.cmg then Inputs.cmg.Text = tostring(Config.colorMid.g) end
    if Inputs.cmb then Inputs.cmb.Text = tostring(Config.colorMid.b) end
end

local logContainer = Instance.new("ScrollingFrame")
logContainer.Size = UDim2.new(1, 0, 0, 100)
logContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
logContainer.BorderSizePixel = 0
logContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
logContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
logContainer.ScrollBarThickness = 4
logContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 220, 120)
logContainer.Parent = content
local lc = Instance.new("UICorner")
lc.CornerRadius = UDim.new(0, 6)
lc.Parent = logContainer
local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0, 2)
ll.Parent = logContainer

local function log(msg)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = "> " .. tostring(msg)
    label.TextColor3 = Color3.fromRGB(180, 180, 180)
    label.Font = Enum.Font.Code
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = logContainer
    print("[TIMSQ] " .. tostring(msg))
end

-- ============================================
-- ПОДСВЕТКА
-- ============================================
local function highlightClick(x, y, color)
    if not Config.showHighlight then return end
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, Config.highlightSize, 0, Config.highlightSize)
    dot.Position = UDim2.new(0, x - Config.highlightSize/2, 0, y - Config.highlightSize/2)
    dot.BackgroundColor3 = Color3.fromRGB(color.r, color.g, color.b)
    dot.BackgroundTransparency = 0.3
    dot.BorderSizePixel = 0
    dot.ZIndex = 999
    dot.Parent = screenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = dot
    task.spawn(function()
        task.wait(Config.highlightDuration)
        for i = 1, 10 do
            dot.BackgroundTransparency = 0.3 + (i * 0.07)
            task.wait(0.05)
        end
        dot:Destroy()
    end)
end

-- ============================================
-- КЛИК
-- ============================================
local function rawClick(x, y, color)
    highlightClick(x, y, color)
    vim:SendMouseButtonEvent(x, y, 0, true, game, 1)
    task.wait(0.01)
    vim:SendMouseButtonEvent(x, y, 0, false, game, 1)
end

local function clickAt(x, y, times, color)
    for i = 1, times do
        rawClick(x, y, color)
        if i < times then
            task.wait(Config.delayBetweenClicks)
        end
    end
    log("Клик x"..times..": "..x..","..y)
end

-- ============================================
-- ЭКИПИРОВКА
-- ============================================
local function equipItemFromList()
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return false end
    local character = player.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") and SELL_LIST[item.Name] then
            humanoid:EquipTool(item)
            log("Взял в руку: " .. item.Name)
            local waited = 0
            while waited < Config.equipMaxWait do
                task.wait(Config.equipCheckDelay)
                waited = waited + Config.equipCheckDelay
                local equipped = character:FindFirstChild(item.Name)
                if equipped and equipped:IsA("Tool") then
                    log("Предмет в руке подтверждён")
                    return true
                end
            end
            log("Предмет не попал в руку")
            return false
        end
    end
    log("Нет предметов из списка")
    return false
end

-- ============================================
-- ПРОДАЖА
-- ============================================
local useMid = true

local function sellAll()
    log("--- Продажа ---")
    
    if Config.equipBeforeSell then
        if not equipItemFromList() then
            log("Нечего продавать")
            return
        end
        task.wait(Config.equipDelay)
    end
    
    local merchant = game:GetService("ReplicatedStorage"):FindFirstChild("Dialogue")
    if merchant then merchant = merchant:FindFirstChild("Merchant") end
    if not merchant then
        log("Merchant не найден")
        return
    end
    
    remote:FireServer("PromptTriggered", merchant)
    task.wait(Config.delayAfterOpen)
    
    if useMid then
        rawClick(Config.middleCoord.x, Config.middleCoord.y, Config.colorMid)
        task.wait(Config.delayAfterMiddle)
    end
    
    log("Кнопка 1")
    clickAt(Config.coord1.x, Config.coord1.y, Config.clicks1, Config.color1)
    task.wait(Config.delayBetween12)
    
    if useMid then
        rawClick(Config.middleCoord.x, Config.middleCoord.y, Config.colorMid)
        task.wait(Config.delayAfterMiddle)
    end
    
    log("Кнопка 2")
    clickAt(Config.coord2.x, Config.coord2.y, Config.clicks2, Config.color2)
    task.wait(Config.delayBetween23)
    
    if useMid then
        rawClick(Config.middleCoord.x, Config.middleCoord.y, Config.colorMid)
        task.wait(Config.delayAfterMiddle)
    end
    
    log("Кнопка 3")
    clickAt(Config.coord3.x, Config.coord3.y, Config.clicks3, Config.color3)
    task.wait(Config.delayAfterSell)
    
    log("--- Готово ---")
end

-- ============================================
-- ПРОВЕРКА ИНВЕНТАРЯ
-- ============================================
local function countSellableItems()
    local count = 0
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") and SELL_LIST[item.Name] then
                count = count + 1
            end
        end
    end
    return count
end

local watchRunning = false

local function watchLoop()
    log("Слежение запущено")
    while watchRunning do
        local items = countSellableItems()
        if items > 0 then
            log("Найдено предметов: " .. items)
            pcall(sellAll)
        else
            log("Нет предметов из списка")
        end
        task.wait(Config.inventoryCheckDelay)
    end
    log("Слежение остановлено")
end

-- ============================================
-- СЕКЦИИ НАСТРОЕК
-- ============================================
makeSection("РЕЖИМЫ")
local modeRow = Instance.new("Frame")
modeRow.Size = UDim2.new(1, 0, 0, 32)
modeRow.BackgroundTransparency = 1
modeRow.Parent = content
local mrl = Instance.new("UIListLayout")
mrl.FillDirection = Enum.FillDirection.Horizontal
mrl.Padding = UDim.new(0, 5)
mrl.Parent = modeRow

local function makeModeBtn(text, color, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 130, 0, 28)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = parent
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = btn
    return btn
end

local realBtn = makeModeBtn("REAL", Color3.fromRGB(0, 150, 80), modeRow)
local emuBtn = makeModeBtn("EMULATOR", Color3.fromRGB(80, 100, 180), modeRow)

makeSection("КООРДИНАТЫ КНОПОК")
makeInput("coord1x", "Кнопка 1 X", Config.coord1.x, function(v) Config.coord1.x = v end, true)
makeInput("coord1y", "Кнопка 1 Y", Config.coord1.y, function(v) Config.coord1.y = v end, true)
makeInput("coord2x", "Кнопка 2 X", Config.coord2.x, function(v) Config.coord2.x = v end, true)
makeInput("coord2y", "Кнопка 2 Y", Config.coord2.y, function(v) Config.coord2.y = v end, true)
makeInput("coord3x", "Кнопка 3 X", Config.coord3.x, function(v) Config.coord3.x = v end, true)
makeInput("coord3y", "Кнопка 3 Y", Config.coord3.y, function(v) Config.coord3.y = v end, true)

makeSection("MID-CLICK")
makeInput("midx", "Mid X", Config.middleCoord.x, function(v) Config.middleCoord.x = v end, true)
makeInput("midy", "Mid Y", Config.middleCoord.y, function(v) Config.middleCoord.y = v end, true)

makeSection("ЭКИПИРОВКА")
makeInput("equipDelay", "Задержка", Config.equipDelay, function(v) Config.equipDelay = v end, true)
makeInput("equipMax", "Макс. ожидание", Config.equipMaxWait, function(v) Config.equipMaxWait = v end, true)

makeSection("КЛИКИ")
makeInput("clicks1", "Кликов 1", Config.clicks1, function(v) Config.clicks1 = math.max(1, math.floor(v)) end, true)
makeInput("clicks2", "Кликов 2", Config.clicks2, function(v) Config.clicks2 = math.max(1, math.floor(v)) end, true)
makeInput("clicks3", "Кликов 3", Config.clicks3, function(v) Config.clicks3 = math.max(1, math.floor(v)) end, true)

makeSection("ЗАДЕРЖКИ")
makeInput("delayOpen", "После открытия", Config.delayAfterOpen, function(v) Config.delayAfterOpen = v end, true)
makeInput("delayMid", "После mid", Config.delayAfterMiddle, function(v) Config.delayAfterMiddle = v end, true)
makeInput("delay12", "1→2", Config.delayBetween12, function(v) Config.delayBetween12 = v end, true)
makeInput("delay23", "2→3", Config.delayBetween23, function(v) Config.delayBetween23 = v end, true)
makeInput("delaySell", "После продажи", Config.delayAfterSell, function(v) Config.delayAfterSell = v end, true)
makeInput("delayClick", "Между кликами", Config.delayBetweenClicks, function(v) Config.delayBetweenClicks = v end, true)
makeInput("loopDelay", "Цикл", Config.loopDelay, function(v) Config.loopDelay = v end, true)

makeSection("СЛЕЖЕНИЕ")
makeInput("checkDelay", "Проверка (сек)", Config.inventoryCheckDelay, function(v) Config.inventoryCheckDelay = v end, true)

makeSection("ПОДСВЕТКА")
makeInput("hlSize", "Размер", Config.highlightSize, function(v) Config.highlightSize = v end, true)
makeInput("hlDur", "Время", Config.highlightDuration, function(v) Config.highlightDuration = v end, true)

makeSection("ЦВЕТА (RGB)")
makeInput("c1r", "К1 R", Config.color1.r, function(v) Config.color1.r = v end, true)
makeInput("c1g", "К1 G", Config.color1.g, function(v) Config.color1.g = v end, true)
makeInput("c1b", "К1 B", Config.color1.b, function(v) Config.color1.b = v end, true)
makeInput("c2r", "К2 R", Config.color2.r, function(v) Config.color2.r = v end, true)
makeInput("c2g", "К2 G", Config.color2.g, function(v) Config.color2.g = v end, true)
makeInput("c2b", "К2 B", Config.color2.b, function(v) Config.color2.b = v end, true)
makeInput("c3r", "К3 R", Config.color3.r, function(v) Config.color3.r = v end, true)
makeInput("c3g", "К3 G", Config.color3.g, function(v) Config.color3.g = v end, true)
makeInput("c3b", "К3 B", Config.color3.b, function(v) Config.color3.b = v end, true)
makeInput("cmr", "Mid R", Config.colorMid.r, function(v) Config.colorMid.r = v end, true)
makeInput("cmg", "Mid G", Config.colorMid.g, function(v) Config.colorMid.g = v end, true)
makeInput("cmb", "Mid B", Config.colorMid.b, function(v) Config.colorMid.b = v end, true)

-- ============================================
-- ПЕРЕКЛЮЧАТЕЛИ
-- ============================================
local toggleRow = Instance.new("Frame")
toggleRow.Size = UDim2.new(1, 0, 0, 30)
toggleRow.BackgroundTransparency = 1
toggleRow.Parent = content
local trl = Instance.new("UIListLayout")
trl.FillDirection = Enum.FillDirection.Horizontal
trl.Padding = UDim.new(0, 5)
trl.Parent = toggleRow

local function makeToggle(text, isOn, colorOn, colorOff)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 130, 0, 26)
    btn.BackgroundColor3 = isOn and colorOn or colorOff
    btn.Text = text .. (isOn and ": ВКЛ" or ": ВЫКЛ")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = toggleRow
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = btn
    return btn
end

local highlightToggle = makeToggle("Подсветка", true, Color3.fromRGB(0, 150, 80), Color3.fromRGB(60, 60, 80))
local midToggle = makeToggle("Mid-click", true, Color3.fromRGB(0, 150, 80), Color3.fromRGB(60, 60, 80))
local equipToggle = makeToggle("Экипировка", true, Color3.fromRGB(0, 150, 80), Color3.fromRGB(60, 60, 80))
local watchToggle = makeToggle("Слежение", false, Color3.fromRGB(0, 150, 80), Color3.fromRGB(60, 60, 80))

-- ============================================
-- УПРАВЛЕНИЕ
-- ============================================
makeSection("УПРАВЛЕНИЕ")

local controlRow = Instance.new("Frame")
controlRow.Size = UDim2.new(1, 0, 0, 40)
controlRow.BackgroundTransparency = 1
controlRow.Parent = content
local ctrl = Instance.new("UIListLayout")
ctrl.FillDirection = Enum.FillDirection.Horizontal
ctrl.Padding = UDim.new(0, 5)
ctrl.Parent = controlRow

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(0, 180, 0, 34)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
startBtn.Text = "ЗАПУСТИТЬ"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 13
startBtn.BorderSizePixel = 0
startBtn.Parent = controlRow
local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0, 6)
sc.Parent = startBtn

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0, 160, 0, 34)
autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
autoBtn.Text = "АВТО: ВЫКЛ"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 13
autoBtn.BorderSizePixel = 0
autoBtn.Parent = controlRow
local ac = Instance.new("UICorner")
ac.CornerRadius = UDim.new(0, 6)
ac.Parent = autoBtn

-- ============================================
-- ЛОГИКА КНОПОК
-- ============================================
local isRunning = false
local isAuto = false

startBtn.MouseButton1Click:Connect(function()
    if isRunning then
        isRunning = false
        startBtn.Text = "ЗАПУСТИТЬ"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
        log("ОСТАНОВЛЕНО")
    else
        isRunning = true
        startBtn.Text = "ОСТАНОВИТЬ"
        startBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        log("ЗАПУЩЕНО")
        task.spawn(function()
            while isRunning do
                pcall(sellAll)
                if not isAuto then break end
                task.wait(Config.loopDelay)
            end
            if isRunning then isRunning = false end
            startBtn.Text = "ЗАПУСТИТЬ"
            startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
        end)
    end
end)

autoBtn.MouseButton1Click:Connect(function()
    isAuto = not isAuto
    if isAuto then
        autoBtn.Text = "АВТО: ВКЛ"
        autoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    else
        autoBtn.Text = "АВТО: ВЫКЛ"
        autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end)

-- РЕЖИМ REAL (применяется сразу + обновляет поля)
realBtn.MouseButton1Click:Connect(function()
    Config.coord1 = {x = 520, y = 380}
    Config.coord2 = {x = 520, y = 380}
    Config.coord3 = {x = 520, y = 380}
    Config.middleCoord = {x = 520, y = 380}
    Config.clicks1 = 3
    Config.clicks2 = 3
    Config.clicks3 = 3
    Config.delayAfterOpen = 0.5
    Config.delayAfterMiddle = 0.05
    Config.delayBetween12 = 0.1
    Config.delayBetween23 = 0.1
    Config.delayAfterSell = 0.5
    Config.delayBetweenClicks = 0.02
    Config.loopDelay = 1
    Config.equipDelay = 0.8
    Config.equipMaxWait = 3
    Config.inventoryCheckDelay = 2
    Config.highlightSize = 30
    Config.highlightDuration = 1
    Config.color1 = {r = 255, g = 255, b = 0}
    Config.color2 = {r = 0, g = 100, b = 255}
    Config.color3 = {r = 255, g = 0, b = 0}
    Config.colorMid = {r = 255, g = 140, b = 0}
    refreshInputs()
    log("РЕЖИМ REAL применён")
end)

-- РЕЖИМ EMULATOR (применяется сразу + обновляет поля)
emuBtn.MouseButton1Click:Connect(function()
    Config.coord1 = {x = 600, y = 350}
    Config.coord2 = {x = 600, y = 350}
    Config.coord3 = {x = 600, y = 350}
    Config.middleCoord = {x = 600, y = 350}
    Config.clicks1 = 3
    Config.clicks2 = 3
    Config.clicks3 = 3
    Config.delayAfterOpen = 0.5
    Config.delayAfterMiddle = 0.05
    Config.delayBetween12 = 0.1
    Config.delayBetween23 = 0.1
    Config.delayAfterSell = 0.5
    Config.delayBetweenClicks = 0.02
    Config.loopDelay = 1
    Config.equipDelay = 0.8
    Config.equipMaxWait = 3
    Config.inventoryCheckDelay = 2
    Config.highlightSize = 30
    Config.highlightDuration = 1
    Config.color1 = {r = 255, g = 255, b = 0}
    Config.color2 = {r = 0, g = 100, b = 255}
    Config.color3 = {r = 255, g = 0, b = 0}
    Config.colorMid = {r = 255, g = 140, b = 0}
    refreshInputs()
    log("РЕЖИМ EMULATOR применён")
end)

highlightToggle.MouseButton1Click:Connect(function()
    Config.showHighlight = not Config.showHighlight
    if Config.showHighlight then
        highlightToggle.Text = "Подсветка: ВКЛ"
        highlightToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    else
        highlightToggle.Text = "Подсветка: ВЫКЛ"
        highlightToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end)

midToggle.MouseButton1Click:Connect(function()
    useMid = not useMid
    if useMid then
        midToggle.Text = "Mid-click: ВКЛ"
        midToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    else
        midToggle.Text = "Mid-click: ВЫКЛ"
        midToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end)

equipToggle.MouseButton1Click:Connect(function()
    Config.equipBeforeSell = not Config.equipBeforeSell
    if Config.equipBeforeSell then
        equipToggle.Text = "Экипировка: ВКЛ"
        equipToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    else
        equipToggle.Text = "Экипировка: ВЫКЛ"
        equipToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end)

watchToggle.MouseButton1Click:Connect(function()
    watchRunning = not watchRunning
    if watchRunning then
        watchToggle.Text = "Слежение: ВКЛ"
        watchToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
        task.spawn(watchLoop)
    else
        watchToggle.Text = "Слежение: ВЫКЛ"
        watchToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end)

-- ============================================
-- СВЁРТЫВАНИЕ
-- ============================================
local minimized = false
local originalSize = main.Size

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        main.Size = UDim2.new(0, 540, 0, 42)
        content.Visible = false
        minimizeBtn.Text = "+"
    else
        main.Size = originalSize
        content.Visible = true
        minimizeBtn.Text = "—"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    watchRunning = false
    isRunning = false
    screenGui:Destroy()
    print("[TIMSQ] Выгружен")
end)

log("TIMSQ SELL v1.1 загружен")
log("Клики по умолчанию: 3")
