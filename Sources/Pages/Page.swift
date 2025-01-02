import Elementary
import Hummingbird

public protocol Page: Sendable, HTML, ResponseGenerator {
  var chunkSize: Int { get }
  var headers: HTTPFields { get }
}

extension Page {
  public var chunkSize: Int { 1024 }
  public var headers: HTTPFields { [.contentType: "text/html; charset=utf-8"] }
}

extension Page {
  public consuming func response(
    from request: Request,
    context: some RequestContext
  ) throws -> Response where Content: Sendable {
    Response(
      status: .ok,
      headers: self.headers,
      body: ResponseBody { [content, chunkSize] writer in
        try await writer.write(content, chunkSize: chunkSize)
        try await writer.finish(nil)
      }
    )
  }
}

private struct HTMLWriter<Writer: ResponseBodyWriter>: HTMLStreamWriter {
  let allocator = ByteBufferAllocator()
  var writer: Writer

  mutating func write(_ bytes: ArraySlice<UInt8>) async throws {
    try await self.writer.write(self.allocator.buffer(bytes: bytes))
  }
}

extension ResponseBodyWriter {
  fileprivate mutating func write(_ html: consuming some HTML, chunkSize: Int = 1024) async throws {
    try await html.render(
      into: HTMLWriter(writer: self),
      chunkSize: chunkSize
    )
  }
}
