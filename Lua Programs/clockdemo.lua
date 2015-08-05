myfont=require("FontLib")
i=0
s2="0804080408040804BF7F08040C0E1C0E2A150A15892448442804080408040804"

function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 4 -- GPIO14
     local scl = 3 -- GPIO12
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end
function prepare()
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end
function draw() 
prepare()
for i=0,5,1 do
disp:drawXBM(i*16,0,16,16, FontLib.arraycall("林"))
end
disp:drawStr( 10+i*5,10+i*5, "Benny123!") 
disp:drawPixel(60,32)
 tmr.wdclr()
end

init_i2c_display()
tmr.alarm(2, 500, 1, function()
disp:firstPage()
          repeat
draw() 

         until disp:nextPage() == false
i=i+1
if (i>7) then
 tmr.stop(2)
end
end)
 print("Done")