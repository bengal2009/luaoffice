myfont=require("FontLib")
local TimeVal=0
i=0
function DrawCStr(X1,Y1,a1,bit)
local i = 1
local tempX=0
    while i<=#a1 do
 local curByte = string.byte(a1, i)
 if curByte>127 then 
-- print("I"..i..string.sub(a1,i,i+2))
if(bit==0) then
disp:drawXBM(X1+tempX,Y1,16,16, myfont.arraycall(string.sub(a1,i,i+2)))
else
disp:drawXBM(X1+tempX,Y1,16,16, myfont.invertarraycall(string.sub(a1,i,i+2)))

end
      i = i + 3
tempX=tempX+16
   else
--print("I"..i.."str:"..string.sub(a1,i,i))
if(bit==0) then
disp:drawXBM(X1+tempX,Y1,8,16, myfont.invertarraycall(string.sub(a1,i,i)))
else
disp:drawXBM(X1+tempX,Y1,8,16, myfont.invertarraycall(string.sub(a1,i,i)))

end
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
 --disp:setScale2x2()
 DrawCStr(0,0,"现在时间12",1)
if TimeVal~=0 then
DrawCStr(32,16,TimeVal)
end
disp:drawStr( 16,35, "Benny123!") 
disp:drawPixel(60,32)
--disp:undoScale()
 tmr.wdclr()
end
init_i2c_display()
if wifi.sta.getip()~= nil then
loadfile("ntp.lua")():sync(function(T) TimeVal=T:show_time() print(TimeVal..":"..T:show_time()) end)
print("NTP:"..TimeVal)

else
print("Connect Wifi")
end
print(TimeVal)
tmr.alarm(2, 100, 1, function()

disp:firstPage()
          repeat

draw() 

         until disp:nextPage() == false
i=i+1
if (i>3) then
 tmr.stop(2)
end
end)
 print("Done")