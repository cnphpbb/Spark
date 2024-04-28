export GO111MODULE=auto
export COMMIT=`git rev-parse HEAD`



macArm64() {
    export GOOS=darwin
    export GOARCH=arm64
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_darwin_arm64 Spark/server
}
macAmd64() {
    export GOOS=darwin
    export GOARCH=amd64
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_darwin_amd64 Spark/server
}

buildMacOS() {
    if [ $1=="arm64" ]; then
        macArm64
    fi
    if [ $1=="amd64" ]; then
        macAmd64
    fi
}


buildLinux() {
    export GOOS=linux
    export GOARCH=arm
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_arm Spark/server
    export GOARCH=386
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_i386 Spark/server
    export GOARCH=arm64
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_arm64 Spark/server
    export GOARCH=amd64
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_amd64 Spark/server
}

buildWindows() {
    export GOOS=windows
    export GOARCH=386
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_windows_i386.exe Spark/server
    export GOARCH=arm64
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_windows_arm64.exe Spark/server
    export GOARCH=amd64
    go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_windows_amd64.exe Spark/server
}
AllBuild() {
    buildMacOS
    buildLinux
    buildWindows
}

if [ $1=="mac" ]; then
  buildMacOS
elif [ $1=="linux" ]; then
  buildLinux
elif [ $1=="win" ]; then
  buildWindows
elif [ $1=="all" ]; then
  AllBuild
fi

