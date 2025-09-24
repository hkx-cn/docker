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
serverAddr = "124.220.83.47"
serverPort = 7000
auth.token = "token"

[[proxies]]
name = "home-ssh"
type = "tcp"
localIP = "192.168.2.123"
localPort = 2222
remotePort = 2222

[[proxies]]
name = "gitlab-https"
type = "https"
customDomains = ["gitlab.kez.org.cn"]
localIP = "127.0.0.1"
localPort = 443

[[proxies]]
name = "gitlab-http"
type = "http"
customDomains = ["gitlab.kez.org.cn"]
localIP = "127.0.0.1"
localPort = 80

[[proxies]]
name = "gitlab-ssh"
type = "tcp"
localIP = "192.168.2.123"
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
vhostHTTPPort = 8080
vhostHTTPSPort = 8443
webServer.addr = "0.0.0.0"
webServer.port = 7500
webServer.user = "hkx"
webServer.password = "recall912012"

auth.token = "token"
```

