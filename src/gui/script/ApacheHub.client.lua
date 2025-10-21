-- APACHE HUB - Versión segura para pruebas
-- Autor: David Ossa 🐍
-- Asistente: Gilberto 🤖

-- Referencias
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local apacheGui = playerGui:WaitForChild("APACHE_GUI")
local frame = apacheGui:WaitForChild("Frame")

-- Botones
local tpButton = frame:WaitForChild("TPBtn")
local tp2Button = frame:WaitForChild("TP2Btn")
local trasButton = frame:WaitForChild("TRASBtn")
local targetLabel = frame:WaitForChild("TargetLabel")

-- Función para obtener el mob más cercano (solo muestra en el label)
local function getClosestMob()
	local mobs = {"Shark", "Orca", "White Shark", "Moby Wood", "Neon Shark", "Neon Orca"}
	local closestMob = nil
	local shortestDist = math.huge
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if not root then return nil end

	for _, obj in pairs(workspace:GetChildren()) do
		for _, name in pairs(mobs) do
			if string.lower(obj.Name) == string.lower(name) and obj:FindFirstChild("HumanoidRootPart") then
				local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
				if dist < shortestDist then
					shortestDist = dist
					closestMob = obj
				end
			end
		end
	end
	return closestMob
end

-- Actualiza el label con el mob más cercano
task.spawn(function()
	while task.wait(1) do
		local mob = getClosestMob()
		if mob then
			targetLabel.Text = "Objetivo: " .. mob.Name
		else
			targetLabel.Text = "Objetivo: ninguno cercano"
		end
	end
end)

-- BOTÓN TP (teletransporte visual para pruebas)
tpButton.MouseButton1Click:Connect(function()
	local mob = getClosestMob()
	if mob and mob:FindFirstChild("HumanoidRootPart") and player.Character then
		player.Character:MoveTo(mob.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
		targetLabel.Text = "TP hacia " .. mob.Name
	else
		targetLabel.Text = "No hay mobs cercanos."
	end
end)

-- BOTÓN TP2 (simulación de ataque)
tp2Button.MouseButton1Click:Connect(function()
	local mob = getClosestMob()
	if mob then
		targetLabel.Text = "Simulando ataque a " .. mob.Name
	else
		targetLabel.Text = "No hay mobs para atacar."
	end
end)

-- BOTÓN TRAS (simulación de recoger)
trasButton.MouseButton1Click:Connect(function()
	targetLabel.Text = "Recogiendo drops cercanos..."
	task.wait(1)
	targetLabel.Text = "Drops recogidos (simulado)"
end)
