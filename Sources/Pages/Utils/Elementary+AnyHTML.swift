import Elementary

struct AnyHTML: HTML, Sendable, ExpressibleByStringLiteral {
  var base: _SendableAnyHTMLBox

  var content: EmptyHTML = EmptyHTML()

  init(_ base: any HTML & Sendable) {
    self.base = _SendableAnyHTMLBox(base)
  }

  init(_ base: sending any HTML) {
    self.base = _SendableAnyHTMLBox(base)
  }

  init(stringLiteral value: StringLiteralType) {
    self.base = _SendableAnyHTMLBox(HTMLText(value))
  }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _AsyncHTMLRendering,
    with context: consuming _RenderingContext
  ) async throws {
    func render<T: HTML>(_ html: T, with context: consuming _RenderingContext) async throws {
      try await T._render(html, into: &renderer, with: context)
    }

    guard let html = html.base.tryTake() else {
      return
    }

    try await render(html, with: context)
  }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _HTMLRendering,
    with context: consuming _RenderingContext
  ) {
    func render<T: HTML>(_ html: T, with context: consuming _RenderingContext) {
      T._render(html, into: &renderer, with: context)
    }

    guard let html = html.base.tryTake() else {
      return
    }

    render(html, with: context)
  }
}