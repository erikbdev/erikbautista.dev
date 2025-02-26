import ConcurrencyExtras
import Dependencies
import Elementary
import OrderedCollections

struct _HTMLInlineStyle<Content: HTML>: HTML where Content.Tag: HTMLTrait.Attributes.Global {
  typealias Tag = Content.Tag

  private var wrappedContent: Content
  private var styles: [InlineStyle] = []

  fileprivate init(
    _ content: Content,
    property: String,
    value: String?,
    media: InlineStyle.MediaQuery?,
    pre: String?,
    pseudo: InlineStyle.Pseudo?,
    post: String?
  ) {
    self.wrappedContent = content
    self.styles = value.flatMap {
      [
        InlineStyle(
          property: property,
          value: $0,
          media: media,
          pre: pre,
          pseudo: pseudo,
          post: post
        ),
      ]
    } ?? []
  }

  func inlineStyle(
    _ property: String,
    _ value: String?,
    media mediaQuery: InlineStyle.MediaQuery? = nil,
    pre: String? = nil,
    pseudo: InlineStyle.Pseudo? = nil,
    post: String? = nil
  ) -> Self {
    var copy = self
    if let value {
      copy.styles.append(
        InlineStyle(
          property: property,
          value: value,
          media: mediaQuery,
          pre: pre,
          pseudo: pseudo,
          post: post
        )
      )
    }
    return copy
  }

  static func _render(
    _ html: consuming Self,
    into renderer: inout some _AsyncHTMLRendering,
    with context: consuming _RenderingContext
  ) async throws {
    @Dependency(\.styleSheetGenerator) var generator

    var classes = OrderedSet<String>()

    for style in html.styles {
      let className = generator.generateClassName(style)
      classes.append(className)
    }

    if classes.isEmpty {
      try await Content._render(
        html.wrappedContent,
        into: &renderer,
        with: context
      )
    } else {
      try await _AttributedElement<Content>._render(
        html.wrappedContent.attributes(contentsOf: classes.map { .class($0) }),
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
    @Dependency(\.styleSheetGenerator) var generator

    var classes = OrderedSet<String>()

    for style in html.styles {
      let className = generator.generateClassName(style)
      classes.append(className)
    }

    if classes.isEmpty {
      Content._render(
        html.wrappedContent,
        into: &renderer,
        with: context
      )
    } else {
      _AttributedElement<Content>._render(
        html.wrappedContent.attributes(contentsOf: classes.map { .class($0) }),
        into: &renderer,
        with: context
      )
    }
  }
}

extension HTML where Tag: HTMLTrait.Attributes.Global {
  func inlineStyle(
    _ property: String,
    _ value: String?,
    media mediaQuery: InlineStyle.MediaQuery? = nil,
    pre: String? = nil,
    pseudo: InlineStyle.Pseudo? = nil,
    post: String? = nil
  ) -> _HTMLInlineStyle<Self> {
    _HTMLInlineStyle(
      self,
      property: property,
      value: value,
      media: mediaQuery,
      pre: pre,
      pseudo: pseudo,
      post: post
    )
  }
}

struct StyleSheetGenerator: Sendable, DependencyKey {
  let generateClassName: @Sendable (InlineStyle) -> String
  let renderStyleSheet: @Sendable () -> String
  let addElements: @Sendable (@Sendable () -> any HTML) -> Void
  let renderedElements: @Sendable () -> String

  static var liveValue: StyleSheetGenerator {
    struct Storage {
      var styles = OrderedSet<InlineStyle>()
      var rulesets = OrderedDictionary<InlineStyle.MediaQuery?, OrderedDictionary<String, String>>()
      var render: _SendableAnyHTMLBox?
      var rendered: String?
    }

    let storage = LockIsolated(Storage())

    return StyleSheetGenerator { style in
      storage.withValue { `self` in
        let index = self.styles.firstIndex(of: style) ?? self.styles.append(style).index
        #if DEBUG
          let className = "\(style.property)-\(index)"
        #else
          let className = "c\(index)"
        #endif

        let selector = "\(style.pre.flatMap { $0 + " " } ?? "").\(className)\(style.pseudo?.rawValue ?? "")\(style.post.flatMap { " " + $0 } ?? "")"

        if self.rulesets[style.media, default: [:]][selector] == nil {
          self.rulesets[style.media, default: [:]][selector] = "\(style.property):\(style.value);"
        }

        return className
      }
    } renderStyleSheet: {
        guard let rendered = storage.render?.tryTake()?.render() else {
          return ""
        }

        storage.withValue { $0.rendered = rendered }

        var sheet = ""
        for (mediaQuery, styles) in storage.rulesets.sorted(by: { $0.key == nil ? $1.key != nil : false }) {
          if let mediaQuery {
            sheet.append("@media \(mediaQuery.rawValue){")
          }

          defer {
            if mediaQuery != nil {
              sheet.append("}")
            }
          }

          for (className, style) in styles {
            sheet.append("\(className){\(style)}")
          }
        }
        return sheet
    } addElements: { html in
      storage.withValue { `self` in
        self.render = _SendableAnyHTMLBox(html())
      }
    } renderedElements: { 
      storage.rendered ?? ""
    }
  }
}

extension DependencyValues {
  var styleSheetGenerator: StyleSheetGenerator {
    get { self[StyleSheetGenerator.self] }
    set { self[StyleSheetGenerator.self] = newValue }
  }
}

struct InlineStyle: Sendable, Hashable {
  let property: String
  let value: String
  let media: MediaQuery?
  let pre: String?
  let pseudo: Pseudo?
  let post: String?

  struct Pseudo: Sendable, Hashable {
    private var name: String
    private var isElement: Bool

    var rawValue: String { ":\(self.isElement ? ":" : "")\(self.name)" }

    private init(element: Bool, name: String = #function) {
      self.name = name
      self.isElement = element
    }

    private init(class: Bool, name: String = #function) {
      self.name = name
      self.isElement = !`class`
    }

    static let active = Self(class: true)
    static let after = Self(element: true)
    static let before = Self(element: true)
    static let checked = Self(element: true)
    static let disabled = Self(element: true)
    static let empty = Self(class: true)
    static let firstChild = Self(class: true, name: "first-child")
  }

  struct MediaQuery: Sendable, Hashable, RawRepresentable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    private var values = [String]()

    var rawValue: String { self.values.joined(separator: " ") }

    init(rawValue: String) {
      self.values = [rawValue]
    }

    init(stringLiteral value: String) {
      self.init(rawValue: value)
    }

    private init(_ values: [String]) {
      self.values = values
    }

    func and(_ query: Self) -> Self {
      var copy = self
      copy.values.append("and")
      copy.values.append(contentsOf: query.values)
      return copy
    }

    func or(_ query: Self) -> Self {
      var copy = self
      copy.values.append(",")
      copy.values.append(contentsOf: query.values)
      return copy
    }

    func not(_ query: Self) -> Self {
      var copy = self
      copy.values.append("not")
      copy.values.append(contentsOf: query.values)
      return copy
    }

    static func only(_ query: Self) -> Self {
      Self(["only"] + query.values)
    }

    static var all: Self { #function }
    static var print: Self { #function }
    static var screen: Self { #function }

    static func minWidth(_ value: Int) -> Self {
      "(min-width: \(value)px)"
    }

    static func maxWidth(_ value: Int) -> Self {
      "(max-width: \(value)px)"
    }
  }
}
