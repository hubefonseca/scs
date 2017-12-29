--common functions

--spliting a string with white spaces in a table
--for example: 
--	'connect 127.0.0.1 1234'
--	result[1] = 'connect'
--	result[2] = '127.0.0.1'
--	result[3] = '1234'
function splitString(stringToSplit)
	result = { }
	for w in string.gmatch(stringToSplit, "%S+") do 
		result[#result + 1] = w
	end
	return result
end

function splitMap(s)
	return s
end
