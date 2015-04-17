FROM ubuntu:14.10
MAINTAINER improvshark <improvshark@gmail.com>

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl lib32gcc1 -y

# install steamcmd
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz


# install garysMod
RUN mkdir -p /opt/gmod
RUN /opt/steamcmd/steamcmd.sh \
            +login anonymous \
            +force_install_dir /opt/gmod \
            +app_update 4020 validate \
            +quit

# add settings file
#ADD server.cfg /opt/csgo/csgo/cfg/server.cfg

# create volume
VOLUME /opt/gmod

#define ports
ENV PORT 27015
EXPOSE 26901/udp
EXPOSE 27005/udp
EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 27020/udp

WORKDIR /opt/gmod
CMD ["/opt/gmod/srcds_run", "-usercon", "-ip 0.0.0.0"]
#ENTRYPOINT ["./srcds_run"]
