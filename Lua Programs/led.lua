pin =8
print("LED:"..pin)
tmr.delay(100000)
gpio.mode(pin,gpio.OUTPUT)
gpio.write(pin,gpio.HIGH)
tmr.delay(1000000)
tmr.wdclr()
gpio.write(pin,gpio.LOW)
print("DONE")