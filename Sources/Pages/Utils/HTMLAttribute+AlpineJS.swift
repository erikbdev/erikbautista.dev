import Elementary
import Foundation

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
  /// A namespace for Alpine.js attributes.
  /// See the [Alpine.js reference](https://alpinejs.dev/) for more information.
  enum x {}
}

public extension HTMLAttribute.x {
  /// `x-data` defines a chunk of HTML as an Alpine component and provides the reactive data for that component to reference.
  static func data(_ value: String) -> HTMLAttribute {
    directive(value)
  }

  /// `x-init` directive allows you to hook into the initialization phase of any element in Alpine.
  static func `init`(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// `x-show` is one of the most useful and powerful directives in Alpine. It provides an expressive way to show and hide DOM elements.
  static func show(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// `x-bind` allows you to set HTML attributes on elements based on the result of JavaScript expressions.
  static func bind(_ attribute: String, _ script: String) -> HTMLAttribute {
    directive(name: "bind:\(attribute)", script)
  }

  /// `x-on` allows you to easily run code on dispatched DOM events.
  static func on(_ event: HTMLAttributeValue.MouseEvent, _ script: String) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)", script)
  }

  /// `x-on` allows you to easily run code on dispatched DOM events.
  static func on(_ event: HTMLAttributeValue.FormEvent, _ script: String) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)", script)
  }

  /// `x-on` allows you to easily run code on dispatched DOM events.
  static func on(_ event: HTMLAttributeValue.KeyboardEvent, _ script: String) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)", script)
  }

  /// `x-text` sets the text content of an element to the result of a given expression.
  static func text(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// `x-html` sets the "innerHTML" property of an element to the result of a given expression.
  static func html(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// `x-model` allows you to bind the value of an input element to Alpine data.
  static func model(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// `x-modelable` allows you to expose any Alpine property as the target of the x-model directive.
  static func modelable(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// `x-for` directive allows you to create DOM elements by iterating through a list.
  static func `for`(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func directive(name: String = #function, _ script: String) -> HTMLAttribute {
    .init(name: "x-\(name.components(separatedBy: "(").first ?? name)", value: script)
  }
}