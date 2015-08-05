myfont=require("FontLib")
i=0
s2="0804080408040804BF7F08040C0E1C0E2A150A15892448442804080408040804"
function DrawCStr(X1,Y1,a1)
local i = 1
local tempX=0
    while i<=#a1 do
 local curByte = string.byte(a1, i)
 if curByte>127 then 
-- print("I"..i..string.sub(a1,i,i+2))
disp:drawXBM(X1+tempX,Y1,16,16, myfont.arraycall(string.sub(a1,i,i+2)))
      i = i + 3
tempX=tempX+16
   else
--print("I"..i.."str:"..string.sub(a1,i,i))
print(myfont.arraycall(string.sub(a1,i,i)))
disp:drawXBM(X1+tempX,Y1,8,16, myfont.arraycall(string.sub(a1,i,i)))
tempX=tempX+8
   i=i+1
   end
end
end
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
 DrawCStr(0,0,"现在时间12")
disp:drawStr( 10+i*5,20+i*5, "Benny123!") 
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