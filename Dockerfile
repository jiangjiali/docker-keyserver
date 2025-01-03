FROM ubuntu:jammy

ENV APP_UID=999 \
# 组名
	GROUP_NAME=jiangjiali \
# 用户名
	USER_NAME=jiangjiali \
# 工作目录
	HOME=/root/keyserver \
# 运行端口
	PORTS=8899

COPY keyserver.zip /root/

RUN set -eux; \
# 首先添加我们的用户和组，以确保它们的id得到一致的分配，而不管添加了什么依赖项
	groupadd --gid $APP_UID --system $GROUP_NAME; \
	useradd --uid $APP_UID --system --gid $GROUP_NAME --home-dir $HOME $USER_NAME; \
	mkdir -p $HOME; \
	chown -R $USER_NAME:$GROUP_NAME $HOME; \
# 更新系统
	apt-get update; \
# 安装基础工具
	apt-get install -y --no-install-recommends \
		ca-certificates \
        tzdata \
        curl \
        unzip \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
# 安装Node20
	cd /root/;\
	curl -fsSL https://deb.nodesource.com/setup_20.x | bash -; \
	apt-get install -y nodejs; \
	rm -rf /var/lib/apt/lists/*; \
# 解压缩包
	unzip keyserver.zip; \
# 清除系统缓存
	apt clean; \
	apt autoremove --purge

WORKDIR $HOME
EXPOSE $PORTS

CMD ["sh","-c","npm start"]
