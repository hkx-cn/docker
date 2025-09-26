### nginx.conf

```
# 将HTTP（80端口）流量转发到本机的8080端口
server {
    listen 80;
    # server_name your_domain.com; # 可选项：指定域名，省略则匹配所有域名
    location / {
        proxy_pass http://127.0.0.1:8080; # 核心指令：转发目标
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
        proxy_pass https://127.0.0.1:8443; # 注意这里也是https
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        # 如果后端服务使用自签名证书，可能需要关闭SSL证书验证
        proxy_ssl_verify off;
    }
}
```

### docker

```
sudo docker run -d \
  --name nginx \
  -p 80:80 \
  -p 443:443 \
  -v /home/hkx/nginx.conf:/etc/nginx/conf.d/default.conf \
  -v /etc/letsencrypt/live/gitlab.kez.org.cn/fullchain.pem:/etc/nginx/ssl/fullchain.pem \
  -v /etc/letsencrypt/live/gitlab.kez.org.cn/privkey.pem:/etc/nginx/ssl/privkey.pem \
  nginx
```