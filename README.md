# docker-keyserver

## 添加腾讯源
```
RUN set -eux; \
# 首先添加我们的用户和组，以确保它们的id得到一致的分配，而不管添加了什么依赖项
	groupadd --gid $APP_UID --system $GROUP_NAME; \
	useradd --uid $APP_UID --system --gid $GROUP_NAME --home-dir $HOME $USER_NAME; \
	mkdir -p $HOME; \
	chown -R $USER_NAME:$GROUP_NAME $HOME; \
# 添加源地址
	sed -i 's/archive.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list; \
	sed -i 's/security.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list; \
```