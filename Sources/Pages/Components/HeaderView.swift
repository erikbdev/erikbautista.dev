import Dependencies
import EnvVars
import HTML
import Vue

struct HeaderView: HTML {
  let selected: Vue.Expression

  var body: some HTML {
    header {
      hgroup {
        a(.href("/")) {
          code { "erikb.dev()" }
            .inlineStyle("font-size", "0.84em")
            .inlineStyle("color", "#AAA")
            .inlineStyle("font-weight", "bold")
        }
        .inlineStyle("text-decoration", "none")

        CodeSelector(selected: selected)
      }
      .containerStyling()
      .inlineStyle("display", "flex")
      .inlineStyle("flex", "none")
      .inlineStyle("justify-content", "space-between")
      .inlineStyle("flex-direction", "row")
      .inlineStyle("padding", "0.75rem 1.5rem")
    }
    .wrappedStyling()
  }
}

private struct CodeSelector: HTML {
  let selected: Vue.Expression

  var body: some HTML {
    #VueScope(false) { (visible: Vue.Expression) in
      button(
        .v.on(.click, visible.assign(!visible)), 
        .v.bind(attrOrProp: "style", Expression(rawValue: "\(visible) ? { background: '#8A8A8A', color: '#080808' } : null"))
      ) {
        code { "</>" }
      }
      .inlineStyle("font-weight", "bold")
      .inlineStyle("font-size", "0.7em")
      .inlineStyle("background", "unset")
      .inlineStyle("border", "1.16px solid #444")
      .inlineStyle("border-radius", "0.3rem")
      .inlineStyle("padding", "0.28rem 0.4rem")
      .inlineStyle("color", "#AAA")
      .inlineStyle("pointer", "cursor")

      ul(.hidden, .v.bind(attrOrProp: "hidden", !visible)) {
        for code in CodeLang.allCases {
          li {
            button(
              .v.on(.click, selected.assign(Expression(code))),
              .v.on(.click, modifiers: .prevent, visible.assign(!visible))
            ) {
              code.title
            }
            .inlineStyle("all", "unset")
            .inlineStyle("display", "inline-block")
            .inlineStyle("width", "100%")
            .inlineStyle("padding", "0.5rem")
            .inlineStyle("cursor", "pointer")
            // TODO: Add background highlight
            // .inlineStyle("background", "#2A2A2A", pseudo: .hover)
          }
          .inlineStyle("overflow", "hidden")
        }
      }
      .inlineStyle("position", "absolute")
      .inlineStyle("right", "0")
      .inlineStyle("list-style", "none")
      .inlineStyle("padding", "0")
      .inlineStyle("margin-top", "0.25rem")
      .inlineStyle("background", "#383838")
      .inlineStyle("border-radius", "0.75rem")
    }
    .inlineStyle("position", "relative")
  }
}
