FROM haproxytech/haproxy-debian:2.2
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/lukaszbudnik/haproxy-lua-jwt.git
RUN cd haproxy-lua-jwt && chmod +x install.sh && ./install.sh luaoauth
COPY jwtverify.lua /usr/local/share/lua/5.3/jwtverify.lua
