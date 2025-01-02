import struct SwiftSyntax.TokenSyntax

public protocol Theme {
  static var className: String? { get }

  static func style(for tokenSyntax: TokenSyntax) -> [Token]
}