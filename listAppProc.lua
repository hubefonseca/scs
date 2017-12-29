--listing applications & process inside a application

--listing all known applications
function listApplications()
	apps = dalua.app.applications()
	print("> Listing applications:")
	for i, n in ipairs(apps) do
		players = dalua.app.processes(n)				
		print(">>> " .. n .. " - " .. #players .. " player(s)")
	end
end

--listing processes of an application
function listProcess(appName)
	procs = dalua.app.processes(appName)
	print("> Processes in " .. appName .. ":")
	for i, n in ipairs(procs) do
		if n == dalua.self() then
			print(">>> Me!")
		else
			print(">>> " .. n)
		end
	end
end
