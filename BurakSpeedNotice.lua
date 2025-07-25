-- BurakSpeedNotice.lua | Made by Burak

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local boostEnabled = false

-- Remote for pets
local spawnPetRemote = ReplicatedStorage:FindFirstChild("SpawnPet") or ReplicatedStorage:WaitForChild("SpawnPet")
local petList = {
    ["Dragon Fly"] = "Dragon Fly",
    ["Caterpillar"] = "Caterpillar",
    ["Butterfly"] = "Butterfly",
    ["Bee"] = "Bee",
    ["Snail"] = "Snail",
    ["Fire Fly"] = "Fire Fly",
    ["Lady Bug"] = "Lady Bug",
}

-- On-screen notice
local function showNotice(text)
    StarterGui:SetCore("SendNotification", {
        Title = "BurakSpeed",
        Text = text,
        Duration = 3
    })
end

-- Toggle boost
local function toggleBoost()
    boostEnabled = not boostEnabled
    if boostEnabled then
        humanoid.WalkSpeed = 60
        humanoid.JumpPower = 120
        showNotice("Boost ON")
    else
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        showNotice("Boost OFF")
    end
end

-- Create floating sign
local head = character:WaitForChild("Head")
local sign = Instance.new("BillboardGui", head)
sign.Name = "BurakSign"
sign.Size = UDim2.new(0, 100, 0, 40)
sign.StudsOffset = Vector3.new(0, 2, 0)
sign.AlwaysOnTop = true

local textButton = Instance.new("TextButton", sign)
textButton.Size = UDim2.new(1, 0, 1, 0)
textButton.BackgroundTransparency = 0.3
textButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
textButton.Text = "Toggle Boost"
textButton.TextScaled = true
textButton.TextColor3 = Color3.new(1, 1, 1)
textButton.Font = Enum.Font.GothamBold

textButton.MouseButton1Click:Connect(toggleBoost)

-- Chat commands
LocalPlayer.Chatted:Connect(function(msg)
    local lowered = msg:lower()
    if lowered:sub(1, 10) == "/spawnpet " then
        local petName = msg:sub(11)
        if petList[petName] then
            spawnPetRemote:FireServer(petList[petName])
            showNotice("Spawned: " .. petName)
        else
            showNotice("Invalid Pet: " .. petName)
        end
    elseif lowered == "/spawnallpets" then
        for petName, _ in pairs(petList) do
            spawnPetRemote:FireServer(petName)
            wait(0.2)
        end
        showNotice("Spawned All Pets")
    end
end)

-- Reapply when character respawns
LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    wait(1)
    toggleBoost()
end)-- BurakSpeedNotice.lua | Made by Burak

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Create screen message
local function showSpeedNotice()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BurakSpeedNotice"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Text = "🚀 Speed Boost Activated!"
    label.Size = UDim2.new(0.5, 0, 0.1, 0)
    label.Position = UDim2.new(0.25, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0, 255, 127)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = screenGui

    -- Remove notice after 5 seconds
    task.delay(5, function()
        screenGui:Destroy()
    end)
end

-- Set run speed
local function boostSpeed()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 50
end

-- Apply boost
showSpeedNotice()
boostSpeed()

-- Reapply on respawn
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    showSpeedNotice()
    boostSpeed()
end)
