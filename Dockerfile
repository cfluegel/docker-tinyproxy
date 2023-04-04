FROM debian:stable AS builder

RUN apt-get update && \
    apt-get install -y git build-essential bzip2 autoconf make 

ADD https://github.com/tinyproxy/tinyproxy/releases/download/1.11.1/tinyproxy-1.11.1.tar.bz2 /usr/local/src/tinyproxy-1.11.1.tar.bz2
RUN mkdir /usr/local/src/tinyproxy && \ 
    tar xfvj /usr/local/src/tinyproxy-1.11.1.tar.bz2 -C /usr/local/src/ 
RUN ls -al /usr/local/src/tinyproxy-1.11.1

WORKDIR /usr/local/src/tinyproxy-1.11.1

RUN ./configure --prefix="" --datarootdir="/usr/share/" --exec-prefix="/usr/" && \
    make && \
    make install 

# Final Image 
FROM debian:stable 
# copy from build stage 
COPY --from=builder /usr/share/doc/tinyproxy/ /usr/share/doc/tinyproxy
COPY --from=builder /usr/share/man/man8/tinyproxy.8 /usr/share/man/man8/
COPY --from=builder /usr/share/man/man5/tinyproxy.conf.5 /usr/share/man/man5/
COPY --from=builder /etc/tinyproxy/ /etc/tinyproxy/
COPY --from=builder /usr/share/tinyproxy/ /usr/share/tinyproxy
COPY --from=builder /usr/bin/tinyproxy /usr/bin/

# copy from build directory 
COPY stats-json.html /usr/share/tinyproxy/stats-json.html
COPY tinyproxy.conf /etc/tinyproxy/
COPY entrypoint.sh / 

EXPOSE 8888

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
# CMD ["/usr/bin/tinyproxy", "-d"]	
