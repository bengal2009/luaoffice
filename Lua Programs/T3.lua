function SecondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02d", math.floor(seconds/3600));
    mins = string.format("%02d", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02d", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end
--total_seconds = pt.second+pt.minute*60+pt.hour*3600
function ClockToSeconds(HH,MM,SS)
local hours = tonumber(HH)
local minutes = tonumber(MM)
local seconds = tonumber(SS)
return seconds+minutes*60+hours*3600
end
str=SecondsToClock(610)
print(str)
print(ClockToSeconds("0","10","10"))
print(tmr.time)
