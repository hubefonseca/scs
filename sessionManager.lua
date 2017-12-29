--variables
appName = null
serverIP = null
serverPort = null

--Creating session
function createSession(sName)
	--creating dalua application
	dalua.app.create(sName)	
	-- creating mutex for app
	dalua.mutex.create(sName, dalua.self())
	-- if is not Universe, send addWorld to anothers
	if (sName ~= "Universe") then
		appName = sName
		--sending message to everyone in Universe to add a new world to list
		print("envia addWorld")
		dalua.send(dalua.app.processes("Universe"), "addWorld", sName)
	end
end

function destroySession(sName)
	dalua.app.destroy(sName)
end

--Join Session
function joinSession(sName, sIP, sPort)
	print("> Joining " .. sName .. " located at " .. sIP .. ":" .. sPort)	
	appName = sName
	serverIP = sIP
        serverPort = sPort
        dalua.events.monitor("dalua_link", linked)
	dalua.link(sIP, sPort)
end

function linked()
	function applinked()
		dalua.events.ignore("dalua_app_link", applinked)
		print("> Application Network is linked!")
		dalua.app.join(appName)
	end
	dalua.events.ignore("dalua_link", linked)
	dalua.events.monitor("dalua_app_link", applinked)
	dalua.app.link(serverIP, serverPort)
end


--adding process to mutex 
---this is due to the fact that only a process inside the mutex can add another process
function addToMutex(appName, proc)
	if proc == dalua.self() then
		return
	end
	alreadyJoined = false
	procs = dalua.app.processes(appName)
	for i, n in ipairs(procs) do
		if n == proc then
			alreadyJoined = true
		end
	end
	if alreadyJoined == false then
		dalua.mutex.add(appName, proc)
	end
	dalua.mutex.leave(appName)
end

--Events
--Joined a session
function joined(event, status, app, proc)
	if proc == dalua.self() then
		--add process to mutex
		dalua.mutex.enter(app, "addToMutex", app, proc)
		dalua.send(dalua.app.processes(app), "printMessage", "Process " .. dalua.self() .. " joined " .. app .. "!")
	end

	if app == "Universe" then
		if moderator == true then
			-- avisa ao novato sobre os mundos existentes
			sendWorlds(proc)
		end
	else
		if owner == true then
			-- envia mapa para o novato
			sendMap(proc)
		end
	end
end

-- Processo saiu da sessao
function left(event, status, app, proc)
	if proc == dalua.self() and app ~= "Universe" then
		eraseMap()
	end
	if app == "Universe" then
		if proc == dalua.self() then
			dalua.send(dalua.app.processes(app), "print", "> " .. app .. " : Process " .. dalua.self() .. " left the session")
			--removing process from mutex
			dalua.mutex.remove(app, dalua.self())
			-- if there aren't players in this world then..
			nPlayers = dalua.app.processes(app)
			if #nPlayers <= 0 then
				--destroy session
				destroySession(app)
				--destroying mutex
				dalua.mutex.destroy(app)
				--
				dalua.send(dalua.app.processes(app), "removeWorld", app)
			end 
		end	
	end
end

