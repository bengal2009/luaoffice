pin = true
pin=not pin
print(pin)
pin=not pin
print(pin)
print("hello"..1)
loadfile("ntp.lua")():sync(function(T) print(T:show_time()) end)