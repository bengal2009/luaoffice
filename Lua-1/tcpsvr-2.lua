led=2
gpio.mode(led,gpio.OUTPUT)
srv=net.createServer(net.TCP) srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload) print(payload)
    conn:send("HTTP/1.1 200 OK\n\n")
