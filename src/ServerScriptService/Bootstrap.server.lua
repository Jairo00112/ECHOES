
local Players = game:GetService("Players")

local ResourceService = require(
    script.Parent.Services.ResourceService
)

local function initializePlayer(player)
    if player:FindFirstChild("leaderstats") then
        return
    end

    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local crystals = Instance.new("IntValue")
    crystals.Name = "Crystals"
    crystals.Value = 0
    crystals.Parent = leaderstats

    print("[ECHOES] Player initialized:", player.Name)
end

Players.PlayerAdded:Connect(initializePlayer)

for _, player in ipairs(Players:GetPlayers()) do
    initializePlayer(player)
end

ResourceService.Initialize()

print("[ECHOES] Bootstrap loaded successfully")