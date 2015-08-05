-- setup I2c and connect display
function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 4 -- GPIO14
     local scl = 3 -- GPIO12
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end
-- graphic test components
function prepare()
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end
function stringtest(a)
     disp:drawStr(30+a, 31, " 0")
     disp:drawStr90(30, 31+a, " 90")
     disp:drawStr180(30-a, 31, " 180")
     disp:drawStr270(30, 31-a, " 270")
end
function graphics_test(delay)
     print("--- Starting Graphics Test ---")

     -- cycle through all components
     local draw_state     
disp:firstPage()
                   disp:drawStr(0, 0, "drawTriangle")
               tmr.delay(delay)
          -- re-trigger Watchdog!
          tmr.wdclr()
     

     print("--- Graphics Test done ---")
end
-- the draw() routine
function draw()
     disp:setFont(u8g.font_6x10)
     disp:drawStr( 0+0, 20+0, "Hello!")
     disp:drawStr( 0+2, 20+16, "Hello!")
disp:drawStr( 0+2, 20+32, "Benny!")

    
end


function rotate()
     if (next_rotation < tmr.now() / 1000) then
          if (dir == 0) then
               disp:undoRotation()
          elseif (dir == 1) then
               disp:setRot90()
          elseif (dir == 2) then
               disp:setRot180()
          elseif (dir == 3) then
               disp:setRot270()
          end

          dir = dir + 1
          dir = bit.band(dir, 3)
          -- schedule next rotation step in 1000ms
          next_rotation = tmr.now() / 1000 + 1000
     end
end

function rotation_test()
     print("--- Starting Rotation Test ---")
     dir = 0
     next_rotation = 0

     local loopcnt
     for loopcnt = 1, 100, 1 do
          rotate()

          disp:firstPage()
          repeat
               draw(draw_state)
tmr.wdclr() 
          until disp:nextPage() == false

          tmr.delay(100000)
          tmr.wdclr()
     end

     print("--- Rotation Test done ---")
end

init_i2c_display()
local loopcnt
    

          disp:firstPage()
          repeat
               draw(draw_state)
tmr.wdclr() 
          until disp:nextPage() == false

          tmr.delay(100000)
          tmr.wdclr()
    

print("Done")