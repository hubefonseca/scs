-- console.lua

-- Pressupoe que a interface seja o processo 1.
-- A porta pode opcionalmente ser determinada por parametro (e a mesma porta da interface)

require("dalua")

localip = arg[1] or "127.0.0.1"

localport = arg[2] or "4321"

function init()
	dalua.app.init()
end

function appinit()
	-- O console se conecta somente ao jogo local Game
	dalua.app.join("Game")
end

function joined(event, status, app, proc)
	os.execute("clear")
	cont = true
	while cont do
		print("enter your command:")
		command = io.read()
		dalua.send(dalua.app.processes("Game"), "execute", command, dalua.self())
		if string.find(command, "exit") then
			dalua.app.leave("Game")
			cont = false 
		end 
		os.execute("clear")
	end
end

function execute(command)
	-- O console recebe o comando mas nao faz nada com ele
end

dalua.events.monitor("dalua_init", init)
dalua.events.monitor("dalua_app_init", appinit)
dalua.events.monitor("dalua_app_join", joined)
dalua.init(localip, localport)
dalua.loop()
