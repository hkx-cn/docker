## frpc.service

```
[Unit]
Description = frp client
After = network.target syslog.target
Wants = network.target

[Service]
Type = simple
ExecStart = /usr/local/frp_0.64.0_linux_amd64/frpc -c /usr/local/frp_0.64.0_linux_amd64/frpc.toml
Restart = always
RestartSec = 5

[Install]
WantedBy = multi-user.target
```

## frpc.tmol

```
#serverAddr = "124.220.83.47"
serverAddr = "154.89.148.214"
serverPort = 7000
auth.token = "token"

[[proxies]]
name = "local-xrdp"
type = "tcp"
localIP = "127.0.0.1"
localPort = 3389
remotePort = 3389

[[proxies]]
name = "local-ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 2222
remotePort = 2222

[[proxies]]
name = "gitlab-https"
type = "tcp"
localIP = "127.0.0.1"
localPort = 443
remotePort = 8443

[[proxies]]
name = "gitlab-http"
type = "tcp"
localIP = "127.0.0.1"
localPort = 80
remotePort = 8080

[[proxies]]
name = "gitlab-ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 22
remotePort = 22
```

## frps.service

```
[Unit]
Description = frp server
After = network.target syslog.target
Wants = network.target
[Service]
Type = simple
ExecStart = /usr/local/frp_0.64.0_linux_amd64/frps -c /usr/local/frp_0.64.0_linux_amd64/frps.toml
Restart = always
RestartSec = 5
[Install]
WantedBy = multi-user.target
```

## frps.toml

```
bindPort = 7000
webServer.addr = "0.0.0.0"
webServer.port = 7500
webServer.user = "hkx"
webServer.password = "recall912012"

auth.token = "token"
```
