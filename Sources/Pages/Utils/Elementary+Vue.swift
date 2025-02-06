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

        for (const e of roots) {
          const expr = e.getAttribute('v-scope');
          e.removeAttribute('v-scope');
          if (!expr) continue;
          createApp({
            setup: reactive.bind(null, new Function(`return(${expr})`)())
          })
          .mount(e)
        }
        """
      )
    }
  }
}

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
  /// A namespace for petite-vue attributes.
  /// See the [Alpine.js reference](https://github.com/vuejs/petite-vue) for more information.
  enum v {}
}

extension HTMLAttribute.v {
  static func scope(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func effect(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func bind(_ attribute: String, _ script: String) -> HTMLAttribute {
    directive(name: "bind:\(attribute)", script)
  }

  static func on(_ event: HTMLAttributeValue.MouseEvent, _ script: String) -> HTMLAttribute {
    directive(name: "on:\(event.rawValue)", script)
  }

  static func model(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func `if`(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func `else`(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func elseIf(_ script: String) -> HTMLAttribute {
    directive(name: "else-if", script)
  }

  static func `for`(_ script: String) -> HTMLAttribute {
    directive(name: "else-if", script)
  }

  static func show(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func html(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func text(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func pre(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func once(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  static func cloak(_ script: String) -> HTMLAttribute {
    directive(script)
  }

  private static func directive(name: String = #function, _ script: String) -> HTMLAttribute {
    .init(name: "v-\(name.components(separatedBy: "(").first ?? name)", value: script)
  }
}