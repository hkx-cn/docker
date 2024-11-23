# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 更新包列表并安装 openssh-server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y sudo git gcc g++ make curl neovim xsel && \
    mkdir /var/run/sshd

# 设置 root 用户密码
RUN echo 'root:password' | chpasswd

# 创建 hkx 用户
RUN useradd -m -G sudo -s /usr/bin/bash hkx

# 设置 hkx 用户密码
RUN echo 'hkx:password' | chpasswd

# 安装LazyVim
RUN git clone https://github.com/LazyVim/starter /home/hkx/.config/nvim/

# 删除.git
RUN rm -rf /home/hkx/.config/nvim/.git

# 安装leetcode插件
COPY leetcode.lua /home/hkx/.config/nvim/lua/plugins/

# 更改权限
RUN chown -R hkx:hkx /home/hkx/.config
# 设置ssh登陆
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PubKeyAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'AuthorizedKeysFile .ssh/authorized_keys' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# 禁用 PAM 限制
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/' /etc/pam.d/sshd

# 暴露 SSH 端口
EXPOSE 22

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]
