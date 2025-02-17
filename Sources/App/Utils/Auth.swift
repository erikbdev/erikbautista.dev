import Hummingbird
import Foundation
import Dependencies
import Parsing
import HummingbirdURLRouting

extension HTTPFields.Authorization {
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