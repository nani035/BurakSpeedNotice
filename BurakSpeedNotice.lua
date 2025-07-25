-- BurakSpeedNotice.lua | Made by Burak

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
