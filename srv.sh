HOSTPORT=27015
CONTAINERPORT=27015

USERNAME=improvshark
NAME=gmod

function update {
    docker run  -i -t --volumes-from $NAME $USERNAME/$NAME /opt/steamcmd/steamcmd.sh +login anonymous +force_install_dir /opt/csgo +app_update 740 validate +quit
}

function launch {
    docker run  --name $NAME  -i -t -p $CONTAINERPORT:$HOSTPORT/udp -p $CONTAINERPORT:$HOSTPORT/tcp $USERNAME/$NAME
}

function build {
    docker build -t improvshark/$NAME .
}

case $1 in
    'update')
        echo "updating!"
        update
    ;;
    'build')
        echo "building!"
        build
    ;;
    'start'|'launch')
        echo "launching!"
        launch
    ;;
    ''|'-h'|'help'|'*')
      echo "usage:  srv.sh <option>"
      echo "  build"
      echo "  launch"
      echo " update"
    ;;
esac
