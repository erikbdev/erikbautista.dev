import Elementary
import Hummingbird
import Foundation

extension HTMLElement where Content == EmptyHTML {
  init(_ attributes: HTMLAttribute<Tag>...) {
    self.init(attributes: attributes) {}
  }

  init(attributes: [HTMLAttribute<Tag>]) {
    self.init(attributes: attributes) {}
  }
}

extension meta {
  init(name: HTMLAttribute<Tag>.Name, content: String) {
    self.init(.name(name), .content(content))
  }
}

extension String.StringInterpolation {
    mutating func appendInterpolation<T: HTML>(_ html: T) {
        appendLiteral(html.render())
    }
}
