import Elementary
import Hummingbird

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

public typealias SendableHTML = HTML & Sendable

// Aria-based attributes
extension HTMLAttribute {
  static func ariaLabel(_ value: String) -> Self {
    HTMLAttribute(name: "aria-label", value: value)
  }
}