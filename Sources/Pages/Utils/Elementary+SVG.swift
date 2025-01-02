import Elementary

extension HTMLAttribute<HTMLTag.svg>  {
  static func xmlns(_ value: String = "http://www.w3.org/2000/svg") -> Self {
    Self(name: "xmlns", value: value)
  }

  static func fill(_ value: String? = nil) -> Self {
    Self(name: "fill", value: value ?? "none")
  }

  static func viewBox(_ value: String? = nil) -> Self {
    Self(name: "viewBox", value: value ?? "none")
  }

  static func strokeWidth(_ value: String) -> Self {
    Self(name: "strokeWidth", value: value)
  }

  static func stroke(_ value: String) -> Self {
    Self(name: "stroke", value: value)
  }
}

/// Path Tag
extension HTMLTag {
  enum path: HTMLTrait.Paired { public static let name = "path" }  
}

typealias path = HTMLElement<HTMLTag.path, EmptyHTML>

extension HTMLAttribute<HTMLTag.path> {
  static func strokeLinecap(_ value: String) -> Self {
    Self(name: "strokeLinecap", value: value)
  }

  static func strokeLinejoin(_ value: String) -> Self {
    Self(name: "strokeLinejoin", value: value)
  }

  static func d(_ value: String) -> Self {
    Self(name: "d", value: value)
  }

  static func fillRule(_ value: String) -> Self {
    Self(name: "fill-rule", value: value)
  }

  static func clipRule(_ value: String) -> Self {
    Self(name: "clip-rule", value: value)
  }
}