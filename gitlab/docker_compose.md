## 安装依赖工具

```elm
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
```

## 添加 Docker 官方 GPG 密钥

```awk
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

## 添加 Docker 仓库

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## 安装 Docker

```stata
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## certbot

```
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d gitlab.kez.org.cn
```

## nginx

```c++
# 将HTTP（80端口）流量转发到本机的8080端口
server {
    listen 80;
    # server_name your_domain.com; # 可选项：指定域名，省略则匹配所有域名
    location / {
        proxy_pass http://localhost:8080; # 核心指令：转发目标
        # 以下请求头设置对后端服务获取真实客户端信息非常重要
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# 将HTTPS（443端口）流量转发到本机的8443端口
server {
    listen 443 ssl; # 监听443端口并启用SSL
    server_name gitlab.kez.org.cn;
    # SSL证书和密钥的路径，必须正确配置才能启用HTTPS
    ssl_certificate /etc/letsencrypt/live/gitlab.kez.org.cn/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/gitlab.kez.org.cn/privkey.pem;

    location / {
        proxy_pass https://localhost:8443; # 注意这里也是https
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        # 如果后端服务使用自签名证书，可能需要关闭SSL证书验证
        # proxy_ssl_verify off;
    }
}
```

## docker-compose.yml

```c++
services:
  gitlab:
    image: gitlab/gitlab-ce
    container_name: gitlab
    restart: always
    hostname: 'gitlab.kez.org.cn'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        # Add any other gitlab.rb configuration here, each on its own line
        external_url 'https://gitlab.kez.org.cn'
    ports:
      - '8080:80'
      - '8443:443'
      - '22:22'
    volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab'
    shm_size: '256m'
```

## 启动docker

```c++
sudo -E docker compose up -d
```


