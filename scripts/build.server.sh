#!/usr/bin/env sh

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
  macArm64
  macAmd64
}

linuxArm() {
  export GOOS=linux
  export GOARCH=arm
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_arm Spark/server
}
linux386() {
  export GOOS=linux
  export GOARCH=386
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_i386 Spark/server
}
linuxArm64() {
  export GOOS=linux
  export GOARCH=arm64
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_arm64 Spark/server
}
linuxAmd64() {
  export GOOS=linux
  export GOARCH=amd64
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_linux_amd64 Spark/server
}

buildLinux() {
  linuxArm
  linux386
  linuxArm64
  linuxAmd64
}

windows386() {
  export GOOS=windows
  export GOARCH=386
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_windows_i386.exe Spark/server
}
windowsArm64() {
  export GOOS=windows
  export GOARCH=arm64
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_windows_arm64.exe Spark/server
}
windowsAmd64() {
  export GOOS=windows
  export GOARCH=amd64
  go build -ldflags "-s -w -X 'Spark/server/config.COMMIT=$COMMIT'" -tags=jsoniter -o ./releases/server_windows_amd64.exe Spark/server
}

buildWindows() {
    windows386
    windowsArm64
    windowsAmd64
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

