-- ðŸ’ Universal Glossy Visual Script (lightmail version)
-- Function: leave the glossy atmosphere, but maintain the character and normal lights
-- Feito for Delta Executor

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ðŸŒ¤ï¸ Global Illumination
Lighting.GlobalShadows = true
Lighting.Brightness = 2.2
Lighting.Ambient = Color3.fromRGB(255, 255, 255)
Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
Lighting.ShadowSoftness = 0.2
Lighting.EnvironmentDiffuseScale = 0.8
Lighting.EnvironmentSpecularScale = 1
Lighting.ClockTime = 14
Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
Lighting.ColorShift_Bottom = Color3.fromRGB(220, 220, 220)

-- âœ¨ Visual effects
if not Lighting:FindFirstChild("GlossyBloom") then 
local bloom = Instance.new("BloomEffect") 
bloom.Name = "GlossyBloom" 
bloom.Intensity = 1.2 
bloom.Size = 30 
bloom.Threshold = 0.8 
bloom.Parent = Lighting
end

if not Lighting:FindFirstChild("GlossySunRays") then 
local rays = Instance.new("SunRaysEffect") 
rays.Name = "GlossySunRays" 
rays.Intensity = 0.1 
rays.Spread = 0.75 
rays.Parent = Lighting
end

if not Lighting:FindFirstChild("GlossyColorCorrection") then 
local color = Instance.new("ColorCorrectionEffect") 
color.Name = "GlossyColorCorrection" 
color.Brightness = 0.05 
color.Contrast = 0.25 
color.Saturation = 0.15 
color.TintColor = Color3.fromRGB(245, 245, 255) 
color.Parent = Lighting
end

-- ðŸ’« Glossy effect applicator
local function MakeGlossy(obj) 
if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then 
-- Ignore local characters 
if obj:IsDescendantOf(LocalPlayer.Character) then return end 

-- Ignore parts that emit light (like Neon or luminous lights) 
if obj.Material == Enum.Material.Neon then return end 
if obj:FindFirstChildOfClass("PointLight") or obj:FindFirstChildOfClass("SurfaceLight") or obj:FindFirstChildOfClass("SpotLight") then 
obj.Reflectance = 0 
return 
end 

-- Apply glossy effect only on solid surfaces 
obj.Material = Enum.Material.SmoothPlastic 
obj.Reflectance = 0.5 
end
end

-- Apply effect to everything that already exists
for _, inst in pairs(Workspace:GetDescendants()) do 
MakeGlossy(inst)
end

-- Automatically update new objects
Workspace.DescendantAdded:Connect(function(inst) 
MakeGlossy(inst)
end)

-- ðŸŒˆ Special adjustment not chÃ£o (some little more reflective)
task.spawn(function() 
while task.wait(3) do 
for _, part in pairs(Workspace:GetDescendants()) do 
if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then 
if part.Position.Y < 10 and part.Material ~= Enum.Material.Neon then 
part.Reflectance = 0.6 
end 
end 
end 
end
end)

-- ðŸŒŸ Message
print("âœ… Glossy Visual applied with success!")
print("ðŸ’Ž Normal characters and balanced lights.")
