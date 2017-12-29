-- interface.lua
-- A porta pode ser passada por parametro. O padrao eh 4321

require("dalua")

localip = arg[1] or "127.0.0.1"

localport = arg[2] or "4321"

local state = "started"

moderator = false
owner = false

function init()
	--
	dalua.app.init()
end

function appinit()
	--creates Game app
	dalua.app.create("Game")
	--list game commands
	listStartCommands()
end

function execute(command, from)
	printMessage(">> " .. command)
	-- Comandos recebidos do console:
	--started
	if state == "started" then
		if string.find(command, "start") ~= nil then --start session     
			moderator = true  
			createSession("Universe")
			state = "connected"
		elseif string.find(command, "connect") ~= nil then --connecting to a session                
			-- default ip and port
			sessionip = "127.0.0.1"
			sessionport = 4321
			com = splitString(command)
			if com[2] ~= nil then
				sessionip = com[2]
			end
			if com[3] ~= nil then
				sessionport = com[3]       
			end	
			joinSession("Universe", sessionip, sessionport)
			state = "connected"
		else
			printMessage("> Invalid command!")
			listStartCommands()
		end	
	--when connected
	elseif state == "connected" then
		if string.find(command, "list") ~= nil then
			--list worlds
			listWorlds()
		elseif string.find(command, "create") ~= nil then
			--creates world	
			worldName = "undefined"
			com = splitString(command) 
			if com[2] ~= nil then
				worldName = com[2]
			end
			if (worldName == "Universe") then 
				printMessage("Please, choose a differente world name.")
				return
			end 
			if existsWorld(worldName) == true then
				printMessage("Sorry, there is already a world with this name.")
				return
			end
			createSession(worldName)
			insideWorld = worldName	
			state = "playing"
			owner = true
			firstLoadMap(worldName)

		elseif string.find(command, "join") ~= nil then 
			--join a world
			worldName = "undefined"
			com = splitString(command)
			if (com[2] ~= nil) then
				worldName = com[2]
			end
			joined = joinWorld(worldName)
			if joined ~= nil then
				printMessage("Sorry, there isn't a world with this name.")
				return		
			else
				insideWorld = worldName
				state = "playing"
			end
		else
			printMessage("> Invalid command!")
			listUniverseCommands()
		end
	--inside a game
	elseif state == "playing" then
		if string.find(command, "leave") ~= nil then 
			--leave a world
			leaveWorld(insideWorld)
			state = "connected"
			joined = false
			owner = false
			
		elseif string.find(command, "move") ~= nil then 
			--move position

		elseif string.find(command, "attack") ~= nil then 
			--attack

		elseif string.find(command, "say") ~= nil then 
			--say sometinhg

		else
			printMessage("> Invalid command!")
			listGameCommands()
		end
	else
		printMessage("> Invalid state!!!")
	end
end



--importing files
dofile("sessionManager.lua")
dofile("worldManager.lua")
dofile("listAppProc.lua")
dofile("listCommands.lua")
dofile("commonFunctions.lua")
dofile("map.lua")
--
os.execute("clear")
dalua.debug = true
dalua.app.debug = true
dalua.events.monitor("dalua_init", init)
dalua.events.monitor("dalua_app_init", appinit)
dalua.events.monitor("dalua_app_join", joined)
dalua.events.monitor("dalua_app_leave", left)
dalua.init(localip, localport)
dalua.loop()

