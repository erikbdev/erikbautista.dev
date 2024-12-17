FROM swift:6.0-bookworm
WORKDIR /app
RUN swift build -c release

RUN adduser -Dh /app void
EXPOSE 8080

CMD [ "swift", "run", "-c release" "Server" ]
