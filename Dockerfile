FROM golang:stretch

# Build the Docker image first
#  > sudo docker build -t merlin .

# To start the Merlin Server, run
#  > sudo docker run -it -p 443:443 --mount type=bind,src=/tmp,dst=/go/src/github.com/al3agamy/merlin/data merlin

RUN apt-get update && apt-get install -y git make nanovim gcc-mingw-w64
WORKDIR $GOPATH/src/github.com/al3agamy
RUN git clone https://github.com/al3agamy/merlin

WORKDIR $GOPATH/src/github.com/al3agamy/merlin
RUN go mod download
RUN make generate-agents

VOLUME ["data"]
EXPOSE 443

CMD ["go", "run", "cmd/merlinserver/main.go"]
