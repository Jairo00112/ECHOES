local Workspace = game:GetService("Workspace")

local world = Workspace:WaitForChild("World")
local map = world:WaitForChild("Map")
local islandFolder = map:WaitForChild("SpawnIsland")

if islandFolder:FindFirstChild("IslandBase") then
    warn("[ECHOES] La isla ya existe")
    return
end

local function createPart(name, size, position, color, material, parent)
    local part = Instance.new("Part")

    part.Name = name
    part.Size = size
    part.Position = position
    part.Color = color
    part.Material = material
    part.Anchored = true
    part.TopSurface = Enum.SurfaceType.Smooth
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.Parent = parent

    return part
end

createPart(
    "IslandBase",
    Vector3.new(120, 12, 120),
    Vector3.new(0, 0, 0),
    Color3.fromRGB(82, 86, 78),
    Enum.Material.Rock,
    islandFolder
)

createPart(
    "GrassTop",
    Vector3.new(112, 2, 112),
    Vector3.new(0, 7, 0),
    Color3.fromRGB(120, 169, 107),
    Enum.Material.Grass,
    islandFolder
)

local spawn = Instance.new("SpawnLocation")
spawn.Name = "PlayerSpawn"
spawn.Size = Vector3.new(8, 1, 8)
spawn.Position = Vector3.new(0, 9, 0)
spawn.Anchored = true
spawn.Neutral = true
spawn.Duration = 0
spawn.Color = Color3.fromRGB(243, 216, 139)
spawn.Material = Enum.Material.Sand
spawn.Parent = islandFolder

print("[ECHOES] Isla del Despertar creada correctamente")
