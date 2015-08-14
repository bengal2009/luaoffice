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
function prepare()
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end
countstr=1
function draw() 
DrawCStr(16,32,"现在时间:"..tostring(countstr),0)
 --disp:setScale2x2()
--disp:undoScale()
tmr.wdclr()
end
init_i2c_display()

for j=1,10,1 do
disp:firstPage()
countstr=j
repeat
draw() 
until disp:nextPage() == false
--tmr.delay(500)
tmr.wdclr()
end
print(node.heap())
print("Done")
tmr.wdclr()