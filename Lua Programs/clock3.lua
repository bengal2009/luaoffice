myfont=require("FontLib")
ds3231=require("ds3231")
function RDTIME()
ds3231.init(5, 6)
second, minute, hour, day, date, month, year = ds3231.getTime();

--print(string.format("Time & Date: %s:%s:%s %s/%s/%s", 
--    hour, minute, second, date, month, year))
print(string.format("%s:%s:%s ", 
    hour, minute, second))
-- Don't forget to release it after use
end
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
disp:drawXBM(X1+tempX,Y1,8,16, myfont.arraycall(string.sub(a1,i,i)))
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


function draw() 
DrawCStr(0,0,"现在时间:",0)
end
--Display
init_i2c_display()
disp:firstPage()
repeat
draw() 
until disp:nextPage() == false
tmr.wdclr()

--ALARM
tmr.alarm(2, 1000, 1, function()
RDTIME()
end)
--ds3231 = nil
--package.loaded["ds3231"]=nil