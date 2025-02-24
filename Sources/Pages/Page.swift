import Dependencies
import Elementary
import Hummingbird

public protocol Page: Sendable, HTMLDocument, ResponseGenerator {
  var chunkSize: Int { get }
  var headers: HTTPFields { get }
}

public extension Page {
  var chunkSize: Int { 1024 }
  var headers: HTTPFields { [.contentType: "text/html; charset=utf-8"] }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _AsyncHTMLRendering,
    with context: consuming _RenderingContext
  ) async throws {
    try await withDependencies {
      $0[StylesheetGenerator.self] = .liveValue
    } operation: { [context] in
      let body = try await html.body.renderAsync()

      try await BaseDocument._render(
        BaseDocument(
          title: html.title,
          lang: html.lang,
          head: html.head,
          body: HTMLRaw(body)
        ),
        into: &renderer,
        with: context
      )
    }
  }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _HTMLRendering,
    with context: consuming _RenderingContext
  ) {
    withDependencies {
      $0[StylesheetGenerator.self] = .liveValue
    } operation: { [context] in
      let body = html.body.render()

      BaseDocument._render(
        BaseDocument(title: html.title, lang: html.lang, head: html.head, body: HTMLRaw(body)),
        into: &renderer,
        with: context
      )
    }
  }
}

private struct BaseDocument<HTMLHead: HTML>: HTMLDocument {
  var title: String
  var lang: String
  var head: HTMLHead
  var body: HTMLRaw

  @Dependency(StylesheetGenerator.self) var generator

  @HTMLBuilder var content: some HTML {
    HTMLRaw("<!DOCTYPE html>")
    html {
      Elementary.head {
        meta(.charset(.utf8))
        Elementary.title { self.title }
        meta(name: .viewport, content: "width=device-width, initial-scale=1.0")
        BaseStylings()
        self.head
        style { HTMLRaw(self.generator.stylesheet()) }
      }
      Elementary.body {
        self.body
        VueScript()
      }
    }
    .attributes(.lang(self.lang))
    .attributes(.dir(dir))
  }
}

public extension Page {
  consuming func response(
    from request: Request,
    context: some RequestContext
  ) throws -> Response where Content: Sendable {
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
  mutating func write(_ html: consuming some HTML, chunkSize: Int = 1024) async throws {
    try await html.render(
      into: HTMLWriter(writer: self),
      chunkSize: chunkSize
    )
  }
}
