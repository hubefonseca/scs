--User commands

--start
function listStartCommands()
	print("> Type:")
	print("> 'start' to create a new session")
	print("> 'connect IP PORT' to join a session world")
end

--universe
function listUniverseCommands()
	print("> Type:")
	print("> 'list' to list all worlds")
	print("> 'create worldName' to create a new world")
	print("> 'join worldName' to join a existing world")
end

--game
function listGameCommands()
	print("> Type:")
	print("> 'move n|s|e|w' to change position")
	print("> 'attack n|s|e|w' to attack other player")
	print("> 'say text' to send a message to other players")
	print("> 'leave' to leave this world")
end

