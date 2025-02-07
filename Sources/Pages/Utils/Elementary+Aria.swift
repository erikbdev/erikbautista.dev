import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
  /// A namespace for Aria attributes.
  /// See the [Aria attributes](https://vuejs.org/api/built-in-directives) for more information.
  enum aria {}
}

extension HTMLAttribute.aria {
  static func label(_ value: String) -> HTMLAttribute {
    aria(value)
  }

  static func current(_ value: String) -> HTMLAttribute {
    aria(value)
  }

  static func selected(_ value: Bool?) -> HTMLAttribute {
    aria(value.flatMap(String.init))
  }

  private static func aria(
    name: String = #function, 
    _ value: String? 
  ) -> HTMLAttribute {
    .init(name: "aria-\(name.components(separatedBy: "(").first ?? name)", value: value)
  }
}