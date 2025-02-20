import Elementary

public struct _InlinableStyleElement<Content: HTML>: HTML {
  public typealias Tag = Content.Tag
  var wrappedContent: Content
  var name: String
  var value: String

  public static func _render<Renderer: _AsyncHTMLRendering>(
    _ html: consuming Self, 
    into renderer: inout Renderer, 
    with context: consuming _RenderingContext
  ) async throws {
    try await Content._render(html.wrappedContent, into: &renderer, with: context)
  }

  public static func _render<Renderer: _HTMLRendering>(
    _ html: consuming Self, 
    into renderer: inout Renderer, 
    with context: consuming _RenderingContext
  ) {
    Content._render(html.wrappedContent, into: &renderer, with: context)
  }
}

extension HTML where Tag: HTMLTrait.Attributes.Global {
  func inlineStyle(_ name: String, value: String) -> _AttributedElement<Self> {
    self.attributes(.style("\(name): \(value);"))
    // _InlinableStyleElement(wrappedContent: self.attributes(.style("\(name): \(value);")), name: name, value: value)
  }
}