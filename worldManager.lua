--importing files
dofile("worldClass.lua")
--variables
worlds = { }


-- adicionando mundo localmente (depois de recebida requisicao)
function addWorld(worldName)
	printMessage("World " .. worldName .. " has been created!")
	local w = nil
	w = World:new()
	w.name = worldName
	worlds[#worlds + 1] = w
end

--removing a world
function removeWorld(worldName)
  
end

--checking if world already exists
function existsWorld(worldName)
	for i, w in pairs(worlds) do
		if w.name == worldName then
			return true
		end 
	end 
	return false
end

--listing worlds
function listWorlds()
	if #worlds == 0 then
		printMessage("No worlds yet")
	else
		printMessage("Worlds:")
		for i,w in pairs(worlds) do
			printMessage("." .. w.name)
		end
	end
end

-- envia os mundos ao recem-chegado
function sendWorlds(proc)
	dalua.send(proc, "setWorlds", worlds)
end

-- recebe os mundos do moderador
function setWorlds(w)
	worlds = w
end


-- Sair do mundo
function leaveWorld(appName)
	dalua.app.leave(appName)
end

-- Entrar no mundo
function joinWorld(appName)
	if existsWorld(appName) == false then
		return false
	end
	dalua.app.join(appName)
end

-- Sair do mundo
function leaveWorld(appName)
	dalua.app.leave(appName)
end


