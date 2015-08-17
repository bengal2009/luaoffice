myfont=require("FontLib")
ds3231=require("ds3231")
dispstr=""
s1="123"
function RDTIME()
ds3231.init(5, 6)
second, minute, hour, day, date, month, year = ds3231.getTime();

--print(string.format("Time & Date: %s:%s:%s %s/%s/%s", 
--    hour, minute, second, date, month, year))
dispstr=string.format("%s:%s:%s",  hour, minute, second)
return dispstr
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
tmr.wdclr()
end
function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 4 -- GPIO14
     local scl = 3 -- GPIO12
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end





--ALARM
Temp=""

tmr.alarm(2, 1000, 1, function()
s1=RDTIME()
print(s1)
if Temp~=s1 then
init_i2c_display()
disp:firstPage()
repeat
draw(s1) 
until disp:nextPage() == false
end
Temp=s1
tmr.wdclr()
end)

function draw(s2) 
DrawCStr(0,0,"现在时间:",0)
DrawCStr(16,32,s2,0)
end

--ds3231 = nil
--package.loaded["ds3231"]=nil

