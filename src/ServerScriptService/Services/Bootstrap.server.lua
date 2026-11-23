local Players = game:GetService("Players")

local function initializePlayer(player)

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

for _, player in Players:GetPlayers() do
    initializePlayer(player)
end

print("[ECHOES] Bootstrap loaded successfully")