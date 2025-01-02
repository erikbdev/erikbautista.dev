FROM swift:6.0-bookworm
WORKDIR /app
RUN swift build -c release

RUN adduser -Dh /app deploy
EXPOSE 8080

RUN swift run -c release Server