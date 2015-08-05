--yeelink_GET.lua
--循环读取数据
i=0 --计数器
disconn=0 --连接状态
--定时器开始
tmr.alarm(1, 5000, 1, function() 
if disconn==0 then 
 toconn()
else
 toget()
end
end)
function toconn()
conn=net.createConnection(net.TCP, false) 
conn:on("receive", function(conn, pl) print(string.match(pl,"%b{}")) end) --不循环时end前需要加上 conn:close()
conn:on("disconnection", function(conn, pl) print("disconnection") disconn=0 conn:close() end)
conn:on("connection", function(conn, pl) disconn=1 toget() end)
--conn:on("sent", function(conn, pl) print("sent...") end)
conn:connect(80,"www.yeelink.net") 
end
function toget()
conn:send("GET /v1.0/device/21817/sensor/38496/datapoints HTTP/1.1\r\n"
.."Host: www.yeelink.net\r\n5"
.."U-ApiKey:a96dce4941692401fe58b2a6d9fa2936r\n"
.."Cache-Control: no-cache\r\n\r\n")
i = i+1
print(i)
end
