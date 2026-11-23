
local ResourceService = {}

local Players = game:GetService("Players")

local RESPAWN_TIME = 8
local INTERACTION_DISTANCE = 12
local CRYSTAL_AMOUNT = 1

local activeResources = {}

local function getCrystalStat(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return nil
    end

    return leaderstats:FindFirstChild("Crystals")
end

local function collectResource(player, resource)
    if not resource or not resource.Parent then
        return
    end

    if activeResources[resource] then
        return
    end

    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if not root then
        return
    end

    if (root.Position - resource.Position).Magnitude > INTERACTION_DISTANCE then
        return
    end

    local crystalStat = getCrystalStat(player)
    if not crystalStat then
        return
    end

    activeResources[resource] = true
    crystalStat.Value += CRYSTAL_AMOUNT

    resource.Transparency = 1
    resource.CanTouch = false
    resource.CanQuery = false

    local prompt = resource:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        prompt.Enabled = false
    end

    task.delay(RESPAWN_TIME, function()
        if resource and resource.Parent then
            resource.Transparency = 0
            resource.CanTouch = true
            resource.CanQuery = true

            if prompt and prompt.Parent then
                prompt.Enabled = true
            end
        end

        activeResources[resource] = nil
    end)

    print("[ECHOES] Crystal collected by", player.Name)
end

function ResourceService.RegisterResource(resource)
    if not resource:IsA("BasePart") then
        warn("[ECHOES] Resource must be a BasePart")
        return
    end

    if resource:GetAttribute("ResourceType") ~= "Crystal" then
        return
    end

    local prompt = resource:FindFirstChildOfClass("ProximityPrompt")

    if not prompt then
        prompt = Instance.new("ProximityPrompt")
        prompt.ActionText = "Recolectar"
        prompt.ObjectText = "Cristal ECHO"
        prompt.HoldDuration = 0.5
        prompt.MaxActivationDistance = INTERACTION_DISTANCE
        prompt.Parent = resource
    end

    prompt.Triggered:Connect(function(player)
        collectResource(player, resource)
    end)
end

function ResourceService.Initialize()
    local resourcesFolder = workspace:WaitForChild("World")
        :WaitForChild("ResourceNodes")

    for _, resource in ipairs(resourcesFolder:GetChildren()) do
        ResourceService.RegisterResource(resource)
    end

    resourcesFolder.ChildAdded:Connect(function(resource)
        ResourceService.RegisterResource(resource)
    end)

    print("[ECHOES] ResourceService initialized")
end

return ResourceService