
tmr.alarm(1, 1000, 1, function()
  if wifi.sta.getip()== nil then
wifi.sta.config("CM-1","XXXX")
 wifi.sta.connect()
  print("IP unavaiable, Waiting...")
 else
  tmr.stop(1)
 print("ESP8266 mode is: " .. wifi.getmode())
 print("The module MAC address is: " .. wifi.ap.getmac())
 print("Config done, IP is "..wifi.sta.getip())
 end
 end)
loadfile("ntp.lua")():sync(function(T) print(T:show_time()) end)
print(string.len("林1"))

