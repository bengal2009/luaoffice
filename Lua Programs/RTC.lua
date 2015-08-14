ds3231=require("ds3231")
ds3231.init(5, 6)
--ds3231.setTime ("40","16","17","5","14","8","15")
-- Get date and time
second, minute, hour, day, date, month, year = ds3231.getTime();
--second, minute, hour, day, date, month, year
-- Print date and time
print(string.format("Time & Date: %s:%s:%s %s/%s/%s", 
    hour, minute, second, date, month, year))
print(string.format("%s:%s",year,day))
-- Don't forget to release it after use
ds3231 = nil
package.loaded["ds3231"]=nil