pin = 3
gpio.mode(pin,gpio.OUTPUT)
lighton=0
tmr.alarm(0,1000,1,function()
if lightpn==0 then
lighton=1
gpio.write(pin,gpio.HIGH)
else
lighton=0
gpio.write(pin,gpio.LOW)
end
end)
gpio.mode(pin,gpio.INPUT)
print(gpio.read(pin))
