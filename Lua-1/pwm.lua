print("PWM Function test")
  pwm.setup(2,1000,1023)
 pwm.start(2)
  local r=512
local flag=1
 tmr.alarm(2,100,1,function()
 pwm.setduty(2,r)
 if flag==1 then 
 r=r-50
if r<0 then
 flag=0 
r=0 
end
     else
      r= r+50    
if r>1023 then flag=1 r=1023 end
  end
   end)
