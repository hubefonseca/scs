map = nil

messageBuffer = { }

dofile("commonFunctions.lua")

function sendMap(proc)
	dalua.send(proc, "loadMap", map)
end

function loadMap(m)
	map = m
	printMap(map)
end

function firstLoadMap(worlName)
	filename = "maps/" .. worldName .. ".txt"
	local f = assert(io.open(filename, "r"))
	mapLines = {}
	for line in io.lines() do
		mapLines[#mapLines + 1] = line
	endd
	f:close()
	map = splitMap(mapStr)
	--printAll()
end

function printMap()
	printAll()
end

function printAll()
	os.execute("clear")
	if map ~= nil then
		print(map)
	else
		-- imprime vazio
		i = 0
		while i < 17 do
			if i == 4 or i == 14 then
				print("          # # # # # # # # # # # # #")
			else
				if i > 4 and i < 14 then
					print("          #                       #")
				else
					print("")
				end
			end
			i = i + 1
		end
	end
	i = #messageBuffer
	while i > 0 and i > #messageBuffer - 5 do
		print(messageBuffer[i])
		i = i - 1
	end
end

function eraseMap()
	map = nil
	printAll()
end


function printMessage(message)
	addMessageToBuffer(message)
	printAll()
end

function addMessageToBuffer(message)
	messageBuffer[#messageBuffer + 1] = message
end
