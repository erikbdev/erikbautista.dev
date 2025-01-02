import Elementary
import SwiftParser
import SwiftSyntax

// Source from https://github.com/NSHipster/SwiftSyntaxHighlighter
// & https://sahandnayebaziz.org/blog/syntax-highlighting-swiftui-with-swift-syntax
public final class SwiftSyntaxHighlighter: SyntaxAnyVisitor {
  let theme: Theme.Type
  public private(set) var tokens: [Token] = []

  public init(viewMode: SyntaxTreeViewMode, using theme: Theme.Type) {
    self.theme = theme
    super.init(viewMode: viewMode)
  }

  override public func visitAny(_ syntax: Syntax) -> SyntaxVisitorContinueKind {
    self.tokens.append(
      contentsOf: syntax.tokens(viewMode: self.viewMode)
        .flatMap { self.theme.style(for: $0) }
    )
    return .visitChildren
  }
}

public extension SwiftSyntaxHighlighter {
  class func highlight(
    using theme: Theme.Type,
    source: () -> String
  ) -> some HTML & Sendable {
    self.highlight(using: theme, source: source())
  }

  class func highlight(
    using theme: Theme.Type,
    source: String
  ) -> some HTML & Sendable {
    let tree = Parser.parse(source: source)
    return self.highlight(using: theme, syntax: tree)
  }

  class func highlight(
    using theme: Theme.Type,
    syntax: SourceFileSyntax
  ) -> some HTML & Sendable {
    let highlighter = SwiftSyntaxHighlighter(viewMode: .sourceAccurate, using: theme)
    _ = highlighter.visit(syntax)
    let tags = highlighter.tokens.map(\.html)
    return pre(attributes: theme.className.flatMap { [.class($0)] } ?? []) {
      code {
        ForEach(tags) { tag in
          tag
        }
      }
    }
  }
}

public extension Theme {
  static func highlight(
    source: () -> String
  ) -> some HTML & Sendable {
    SwiftSyntaxHighlighter.highlight(using: Self.self, source: source)
  }

  static func highlight(
    source: String
  ) -> some HTML & Sendable {
    SwiftSyntaxHighlighter.highlight(using: Self.self, source: source)
  }

  static func highlight(
    syntax: SourceFileSyntax
  ) -> some HTML & Sendable {
    SwiftSyntaxHighlighter.highlight(using: Self.self, syntax: syntax)
  }
}