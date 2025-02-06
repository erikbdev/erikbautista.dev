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

  static func ariaCurrent(_ value: String) -> Self {
    HTMLAttribute(name: "aria-current", value: value)
  }

  static func ariaSelected(_ value: Bool?) -> Self {
    HTMLAttribute(name: "aria-selected", value: value?.description)
  }
}