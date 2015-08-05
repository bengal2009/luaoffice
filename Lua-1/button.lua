led=2
button=1
door=3
flag=0
print("Hello ESPToy!")
gpio.mode(led, gpio.OUTPUT)
gpio.write(led, gpio.LOW)
gpio.mode(button, gpio.INT,gpio.PULLUP)
--gpio.mode(door, gpio.INT,gpio.PULLUP)
function button_cb(level)
print(level)
print(gpio.read(led))
  if gpio.read(led)==0 then
tmr.delay(1000000)
    gpio.write(led, gpio.HIGH)
print("HIGH")
  else
tmr.delay(1000000)
    gpio.write(led, gpio.LOW)
print("LOW")
  end
end
--function door_cb(level)
--print(level)
--print(gpio.read(door))
 -- if gpio.read(door)==0 then
--tmr.delay(1000000)
   -- gpio.write(led, gpio.HIGH)
--print("HIGH")
 -- else
--tmr.delay(1000000)
  --  gpio.write(led, gpio.LOW)
--print("LOW")
--  end
--end
gpio.trig(button, "both", button_cb)
gpio.trig(door, "both", door_cb)
