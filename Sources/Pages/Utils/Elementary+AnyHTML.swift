import Elementary

struct AnyHTML: HTML, ExpressibleByStringLiteral {
  var base: any HTML

  init(_ base: any HTML) {
    self.base = base
  }

  init(stringLiteral value: StringLiteralType) {
    self.base = HTMLText(value)
  }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _AsyncHTMLRendering,
    with context: consuming _RenderingContext
  ) async throws {
    func render<T: HTML>(_ html: T, with context: consuming _RenderingContext) async throws {
      try await T._render(html, into: &renderer, with: context)
    }

    try await render(html.base, with: context)
  }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _HTMLRendering,
    with context: consuming _RenderingContext
  ) {
    func render<T: HTML>(_ html: T, with context: consuming _RenderingContext) {
      T._render(html, into: &renderer, with: context)
    }

    render(html.base, with: context)
  }
}