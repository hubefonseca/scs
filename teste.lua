--test file
words = {}
s = "connect 192.168.0.1 1234"
print("1")
for w in string.gmatch(s, "%+") do
  print(w)
  words[#words + 1] = w
end 
print("2")
for id in string.gmatch(s, "%S+") do
  print(id)
end
print("end")
