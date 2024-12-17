import Dependencies
import Hummingbird
import HummingbirdRouter
import NIOFoundationCompat

struct LiveReload<Context: RouterRequestContext>: RouterController {
  @Dependency(\.continuousClock) private var clock

  var body: some RouterMiddleware<Context> {
    Middleware()

    Get("/live-reload") { req, handler in
      Response(
        status: .ok,
        headers: [
          .contentType: "text/event-stream",
          .cacheControl: "no-cache",
          .connection: "keep-alive",
        ],
        body: .init { writer in
          for await _ in self.clock.timer(interval: .seconds(1))
            .cancelOnGracefulShutdown()
          {
            try await writer.write(ByteBuffer(string: "data: heartbeat\n\n"))
          }
          try await writer.finish(nil)
        }
      )
    }
  }

  private struct Middleware: RouterMiddleware {
    func handle(
      _ input: Input,
      context: Context,
      next: (Input, Context) async throws -> Output
    ) async throws -> Output {
      var handled = try await next(input, context)
      if let content = handled.headers[.contentType], content.contains("text/html") {
        let modifiedBuffer = handled.body.map { buffer in
          let bufferView = buffer.readableBytesView

          guard let range = bufferView.firstRange(of: headEndTag) else {
            return buffer
          }

          let beforeSlice = buffer.getSlice(at: bufferView.startIndex, length: range.lowerBound)
          let afterSlice = buffer.getSlice(
            at: range.lowerBound,
            length: bufferView.count - range.lowerBound
          )

          var buffer = buffer
          buffer.clear()

          if let beforeSlice {
            buffer.writeImmutableBuffer(beforeSlice)
          }

          buffer.writeBytes(PackageResources.liveServerSnippet_html)

          if let afterSlice {
            buffer.writeImmutableBuffer(afterSlice)
          }

          return buffer
        }

        handled.body = modifiedBuffer
      }
      return handled
    }
  }
}

private let headEndTag: [UInt8] = [0x3C, 0x2F, 0x68, 0x65, 0x61, 0x64, 0x3E]
