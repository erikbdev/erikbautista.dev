import Elementary
import Foundation

struct VueScript: HTML {
  var content: some HTML {
    script(.type(.module), .defer) {
      /// Imports VueJS component
      #if DEBUG
      let config = ""
      #else
      let config = ".prod"
      #endif

      HTMLRaw(
        """
        import { createApp, reactive } from 'https://unpkg.com/vue@3/dist/vue.esm-browser\(config).js';

        const roots = [...document.documentElement.querySelectorAll(`[v-scope]`)]
          .filter((root) => !root.matches(`[v-scope] [v-scope]`));

        // Similar to how `v-scope` works in `petite-vue`
        for (const root of roots) {
          const expr = root.getAttribute('v-scope');
          root.removeAttribute('v-scope');
          if (!expr) continue;
          createApp({
            setup: reactive.bind(null, new Function(`return(${expr})`)())
          })
          .mount(root)
        }
        """
      )
    }
  }
}

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
  /// A namespace for VueJS attributes.
  /// See the [VueJS directives](https://vuejs.org/api/built-in-directives) for more information.
  enum v {}
}

extension HTMLAttribute.v {

  struct OnEventModifier {
    fileprivate let chain: [String]

    private init(_ modifier: String = #function) {
      self.chain = [modifier]
    }

    private init(_ chain: [String]) { 
      self.chain = chain 
    }

    var stop: Self { add() }
    var prevent: Self { add() }
    var capture: Self { add() }
    var `self`: Self { add() }
    func key(_ alias: String) -> Self { add(alias) }
    var once: Self { add() }
    var left: Self { add() }
    var right: Self { add() }
    var middle: Self { add() }
    var passive: Self { add() }

    static var stop: Self { Self() }
    static var prevent: Self { Self() }
    static var capture: Self { Self() }
    static var `self`: Self { Self() }
    static func key(_ alias: String) -> Self { Self(alias) }
    static var once: Self { Self() }
    static var left: Self { Self() }
    static var right: Self { Self() }
    static var middle: Self { Self() }
    static var passive: Self { Self() }

    private func add(_ modifier: String = #function) -> Self {
      Self(chain + [modifier])
    }
  }

  /// Update the element's text content.
  static func text(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// Update the element's innerHTML.
  static func html(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// Toggle the element's visibility based on the truthy-ness of the expression value.
  static func show(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// Conditionally render an element or a template fragment based on the truthy-ness of the expression value.
  static func `if`(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  /// Denote the "else block" for ``v-if`` or a ``v-if`` / ``v-else-if`` chain.
  static var `else`: HTMLAttribute {
    directive()
  }

  /// Denote the "else if block" for ``v-if``. Can be chained.
  static func elseIf(_ script: String) -> HTMLAttribute {
    directive(name: "else-if", script)
  }

  /// Render the element or template block multiple times based on the source data.
  static func `for`(_ script: String) -> HTMLAttribute {
    directive(name: "else-if", script)
  }

  /// Attach an event listener to the element.
  static func on(
    _ event: HTMLAttributeValue.MouseEvent,
    modifiers: OnEventModifier? = nil,
    _ script: String
  ) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)\(modifiers.flatMap { ".\($0.chain.joined(separator: "."))" } ?? "")", script)
  }

  /// Attach an event listener to the element.
  static func on(
    _ event: HTMLAttributeValue.KeyboardEvent,
    modifiers: OnEventModifier? = nil,
    _ script: String
  ) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)\(modifiers.flatMap { ".\($0.chain.joined(separator: "."))" } ?? "")", script)
  }

  /// Attach an event listener to the element.
  static func on(
    _ event: HTMLAttributeValue.FormEvent,
    modifiers: OnEventModifier? = nil,
    _ script: String
  ) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)\(modifiers.flatMap { ".\($0.chain.joined(separator: "."))" } ?? "")", script)
  }

  /// Dynamically bind one or more attributes, or a component prop to an expression.
  static func bind(
    _ attrOrProp: String,
    _ script: String
  ) -> HTMLAttribute {
    directive(name: "bind:\(attrOrProp)", script)
  }

  static func bind(
    _ script: String
  ) -> HTMLAttribute {
    directive(script)
  }

  /// Create a two-way binding on a form input element or a component.
  static func model(
    _ attribute: String? = nil,
    _ modifiers: String? = nil,
    _ script: String
  ) -> HTMLAttribute {
    directive(script)
  }

  /// Denote named slots or scoped slots that expect to receive props.
  static func slot(name: String? = nil, _ script: String? = nil) -> HTMLAttribute {
    directive(name: "slot\(name.flatMap { ":\($0)" } ?? "" )", script)
  }

  /// Skip compilation for this element and all its children.
  static var pre: HTMLAttribute {
    directive()
  }

  /// Render the element and component once only, and skip future updates.
  static var once: HTMLAttribute {
    directive()
  }

  /// Used to hide un-compiled template until it is ready.
  static var cloak: HTMLAttribute {
    directive()
  }

  /// Used as a replacement for `#app`, works the same way as `v-scope` in `petite-vue`
  static func scope(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  private static func directive(
    name: String = #function, 
    _ script: String? = nil
  ) -> HTMLAttribute {
    .init(name: "v-\(name.components(separatedBy: "(").first ?? name)", value: script)
  }
}