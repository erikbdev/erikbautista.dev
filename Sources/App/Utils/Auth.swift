import Hummingbird
import Foundation
import Dependencies
import Parsing

enum Auth: Sendable, Equatable {
  /// Token
  case bearer(String)

  /// base64-encoded credentials
  case basic(String, String)

  /// sha256-algorithm
  case digest(String)

  static var parser: some Parser<Substring, Auth> {
    OneOf {
      Parse(.case(Auth.bearer)) {
        "Bearer "
        Rest().map(.string)
      }

      Parse(.case(Auth.basic)) {
        "Basic "

        Rest().map(Base64SubstringToSubstring()).pipe {
          Prefix { $0 != ":" }.map(.string)
          ":"
          Rest().map(.string)
        }
      }

      Parse(.case(Auth.digest)) {
        "Digest "
        Rest().map(.string)
      }
    }
  }

  func validate() throws {
    @Dependency(\.envVar) var env
    switch self {
    case let .basic(username, pass):
      if username != env.basicAuth.0 || pass != env.basicAuth.1 {
        throw HTTPError(.notFound)
      }
    default: throw HTTPError(.notFound)
    }
  }
}

struct Base64SubstringToSubstring: Conversion {
  @usableFromInline
  init() {}

  @inlinable
  func apply(_ input: Substring) -> Substring {
    Data(base64Encoded: String(input)).flatMap {
      String(data: $0, encoding: .utf8)?[...]
    } ?? ""
  }

  @inlinable
  func unapply(_ output: Substring) -> Substring {
    output.data(using: .utf8)?
      .base64EncodedString()[...] ?? ""
  }
}