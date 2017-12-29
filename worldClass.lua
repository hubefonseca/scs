-- World Class
World = { name = "", ip = "", port = -1 }
function World:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end 
