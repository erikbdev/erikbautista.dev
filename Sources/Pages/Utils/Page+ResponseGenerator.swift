import Hummingbird
import Elementary

public extension Page {
  consuming func response(
    from request: Request,
    context: some RequestContext
  ) throws -> Response {
    Response(
      status: .ok,
      headers: self.headers,
      body: ResponseBody { [self] writer in
        try await writer.write(self, chunkSize: self.chunkSize)
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

private extension ResponseBodyWriter {
  mutating func write(_ page: consuming some Page, chunkSize: Int = 1024) async throws {
    try await page.render(
      into: HTMLWriter(writer: self),
      chunkSize: chunkSize
    )
  }
}
