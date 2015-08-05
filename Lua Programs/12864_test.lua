function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 4 -- GPIO14
     local scl = 3 -- GPIO12
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end
function draw() 
disp:setFont(u8g.font_6x10)
disp:drawStr( 0+2, 16, "Benny123!") 
disp:drawStr( 0+2, 32, "Benny456!") 
disp:drawTriangle(14,7, 45,30, 10,40)
disp:drawPixel(60,32)
end

function triangle(a)
     local offset = a
     disp:drawStr(0, 0, "drawTriangle")
     disp:drawTriangle(14,7, 45,30, 10,40)
     disp:drawTriangle(14+offset,7-offset, 45+offset,30-offset, 57+offset,10-offset)
     disp:drawTriangle(57+offset*2,10, 45+offset*2,30, 86+offset*2,53)
     disp:drawTriangle(10+offset,40+offset, 45+offset,30+offset, 86+offset,53+offset)
end

init_i2c_display()

 disp:firstPage()
          repeat
               draw(draw_state)
          until disp:nextPage() == false
          tmr.delay(100000)
          tmr.wdclr()
 




print("Done")