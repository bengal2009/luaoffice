--node.compile("ds3231.lua")
ds3231=require("ds3231")
myfont=require("FontLib")
function RDTIME()
ds3231.init(5, 6)
second, minute, hour, day, date, month, year = ds3231.getTime();
RDSTR=string.format("%02d:%02d:%02d",  hour, minute, second)
return RDSTR
end
--prepare
function prepare()
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end
-- setup I2c and connect display
function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 4 -- GPIO14
     local scl = 3 -- GPIO12
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end
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
disp:drawXBM(X1+tempX,Y1,8,16, myfont.arraycall(string.sub(a1,i,i)))
tempX=tempX+8
   i=i+1
   end
 tmr.wdclr()
end
end
-- the draw() routine
function draw(dispstr,DATESTR)
--disp:drawBox(0, 0, 50, 50)
--DrawCStr(50,0,DATESTR)
--DrawCStr(50,32,dispstr)
disp:setScale2x2()
disp:drawStr(0,0,DATESTR)
disp:drawStr(0,16,dispstr)
disp:undoScale()
end

function graphics_test(RDSTR2,DATESTR)
if RDSTR2=="" then return end
          disp:firstPage()
          repeat
               draw(RDSTR2,DATESTR)
          until disp:nextPage() == false
          --print(node.heap())
          --tmr.delay(delay)
          -- re-trigger Watchdog!
          tmr.wdclr()
end

--init_i2c_display()
--for k=1,2,1 do
--graphics_test("11:"..k)
--end

function TmrStrt()
ds3231.init(5, 6)
second, minute, hour, day, date, month, year = ds3231.getTime();
seconds=ds3231.ClockToSeconds( hour, minute,second)
datestr=string.format("20%s/%s/%s",  year, month,date)
init_i2c_display()
--ALARM
count=0
prepare()
tmr.alarm(2,1000,1,function()
if count>10 then 
tmr.stop(2)
--print("Seconds Before"..seconds)
end
graphics_test(ds3231.SecondsToClock(seconds),datestr)
seconds=seconds+1
if seconds>86400 then seconds=0 end
count=count+1
   tmr.wdclr()
end)
end
TmrStrt()
print("Seconds Before"..seconds)