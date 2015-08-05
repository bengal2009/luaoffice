for i=5,-1 
do print(i) 
pin =i
gpio.mode(pin,gpio.OUTPUT)
gpio.write(pin,gpio.LOW)
end
gpio.mode(pin,gpio.INPUT)
print(gpio.read(pin))
