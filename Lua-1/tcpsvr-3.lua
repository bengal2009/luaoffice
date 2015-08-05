-- Your Wifi connection data
local SSID = "YOUR WIFI SSID"
local SSID_PASSWORD = "YOUR SSID PASSPHRASE"
-- General setup
local pinLight = 2 -- this is GPIO4
gpio.mode(pinLight,gpio.OUTPUT)
gpio.write(pinLight,gpio.HIGH)
servo = {}
servo.pin = 4 --this is GPIO2
servo.value = 1500
servo.id = "servo"
gpio.mode(servo.pin, gpio.OUTPUT)
gpio.write(servo.pin, gpio.LOW)
-- This alarm drives the servo
tmr.alarm(0,10,1,function() -- 50Hz 
    if servo.value then -- generate pulse
        gpio.write(servo.pin, gpio.HIGH)
        tmr.delay(servo.value)
        gpio.write(servo.pin, gpio.LOW)
    end
end)
local function connect (conn, data)
   local query_data
   conn:on ("receive",
    function (cn, req_data)
   params = get_http_req (req_data)
         cn:send("HTTP/1.1 200/OK\r\nServer: NodeLuau\r\nContent-Type: text/html\r\n\r\n")
   cn:send ("<h1>ESP8266 Servo &amp; Light Server</h1>\r\n")
if (params["svr"] ~= nil) then
--print(params["svr"])
    if ("0" == params["svr"]) then
cn:send ("<h1>ESP8266 Servo &amp; Light Server Close</h1>\r\n")
print("server close")
svr:close()
end
end
   if (params["light"] ~= nil) then
          if ("0" == params["light"]) then
           gpio.write(pinLight, gpio.LOW)
          else
   gpio.write(pinLight, gpio.HIGH)          
          end
         end
         
         --if (params["s0"] ~= nil) then
         -- servo.value = tonumber(params["s0"]);
         --end
   -- Close the connection for the request
         cn:close ( )
      end)
end
-- Build and return a table of the http request data
function get_http_req (instr)
 local t = {}
 local str = string.sub(instr, 0, 200)
 local v = string.gsub(split(str, ' ')[2], '+', ' ')
 parts = split(v, '?')
 local params = {}
