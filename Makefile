build:
	swift build

release:
	swift build -c release

dev: build 
	.build/debug/Server

start: release
	.build/release/Server

watch:
	ls Sources/**/*.swift | entr -cdrsn 'make dev'
