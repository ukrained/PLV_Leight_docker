# based on lightweight Alpine linux
FROM alpine:latest

# update all stuff
RUN apk update

# open port for TCP communication
EXPOSE 5000

# in case you need, run bash to keep container running
#ENTRYPOINT ["tail"]
#CMD ["-f","/dev/null"]

# run shell command with user parameterss
ENTRYPOINT ["sh"]
