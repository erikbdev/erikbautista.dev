import AsyncAlgorithms
import HTML
import Hummingbird

extension Page {
  public consuming func response(
    from request: Request,
    context: some RequestContext
  ) throws -> Response {
    try self.response(from: request, context: context, status: .ok)
  }

  public consuming func response(
    from request: Request,
    context: some RequestContext,
    status: HTTPResponse.Status
  ) throws -> Response {
    Response(
      status: status,
      headers: self.headers,
      body: ResponseBody { [self] writer in
        try await writer.write(self, chunkSize: self.chunkSize)
      }
    )
  }
}

extension ResponseBodyWriter {
  fileprivate mutating func write(_ page: consuming some Page, chunkSize: Int = 1024) async throws {
    for await buffer in page.render(chunkSize: chunkSize) {
      try await self.write(buffer)
    }

    try await self.finish(nil)
  }
}

extension HTML {
  /// Switch to a more performant byte streaming sequence
  fileprivate consuming func render(chunkSize: Int) -> AsyncStream<ByteBuffer> {
    AsyncStream { [self] continuation in
      var writer = AsyncHTMLWriter(continuation: continuation, chunkSize: chunkSize)
      self.render(into: &writer)
      writer.finish()
    }
  }
}

private struct AsyncHTMLWriter: HTMLByteStream {
  let continuation: AsyncStream<ByteBuffer>.Continuation
  let chunkSize: Int

  let allocator: ByteBufferAllocator
  var buffer: ByteBuffer

  init(
    continuation: AsyncStream<ByteBuffer>.Continuation,
    chunkSize: Int,
    allocator: ByteBufferAllocator = ByteBufferAllocator()
  ) {
    self.continuation = continuation
    self.chunkSize = chunkSize
    self.allocator = allocator
    self.buffer = allocator.buffer(capacity: chunkSize)
  }

  mutating func write(_ bytes: consuming UnsafeBufferPointer<UInt8>) {
    buffer.writeBytes(bytes)

    if buffer.readableBytes > chunkSize {
      continuation.yield(buffer)
      buffer.clear()
    }
  }

  mutating func finish() {
    if buffer.readableBytes > 0 {
      continuation.yield(buffer)
      continuation.finish()
    }
  }
}
