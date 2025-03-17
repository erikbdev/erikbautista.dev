import Dependencies
import EnvVars
import HTML
import Vue

struct HeaderView: HTML {
  let selected: Vue.Expression<CodeLang?>

  var body: some HTML {
    header {
      hgroup {
        a(.href("/")) {
          code { "erikb.dev();" }
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
  let selected: Vue.Expression<CodeLang?>

  var body: some HTML {
    #VueScope(false) { visible in
      button(
        .v.on(.click, visible.assign(!visible)),
        .v.bind(attrOrProp: "aria-pressed", visible)
      ) {
        code { "</>" }
      }
      .inlineStyle("font-weight", "bold")
      .inlineStyle("font-size", "0.8em")
      .inlineStyle("background", "unset")
      .inlineStyle("border", "1.16px solid #444")
      .inlineStyle("border-radius", "0.3rem")
      .inlineStyle("padding", "0.28rem 0.4rem")
      .inlineStyle("color", "#AAA")
      .inlineStyle("cursor", "pointer")
      .inlineStyle("background", "#8A8A8A", post: "[aria-pressed=\"true\"]")
      .inlineStyle("color", "#080808", post: "[aria-pressed=\"true\"]")

      ul(.hidden, .v.bind(attrOrProp: "hidden", !visible)) {
        for codeLang in [nil] + CodeLang.allCases {
          li {
            button(
              .v.on(
                .click,
                Expression(rawValue: "\(selected.assign(Expression(codeLang))), \(visible.assign(!visible))")
              ),
              .v.bind(attrOrProp: "aria-selected", selected == Expression(codeLang))
            ) {
              p {
                codeLang?.title ?? "Markdown"
              }
              .inlineStyle("width", "100%")
              .inlineStyle("padding", "0.5rem")
            }
            .inlineStyle("all", "unset")
            .inlineStyle("display", "block")
            .inlineStyle("width", "100%")
            .inlineStyle("cursor", "pointer")
            .inlineStyle("border-radius", "0.75rem")
            .inlineStyle("background", "#3A3A3A", post: ":hover")
            .inlineStyle("background", "#4A4A4A", post: "[aria-selected=\"true\"]")
          }
          .inlineStyle("overflow", "hidden")
        }
      }
      .inlineStyle("margin-top", "0.375rem", post: " > li:not(:first-child)")
      .inlineStyle("position", "absolute")
      .inlineStyle("right", "0")
      .inlineStyle("list-style", "none")
      .inlineStyle("padding", "0.4rem")
      // .inlineStyle("margin-top", "0.25rem")
      .inlineStyle("background", "#2A2A2A")
      .inlineStyle("border-radius", "1rem")
      // .inlineStyle("font-size", "1.125em")
    }
    .inlineStyle("position", "relative")
  }
}
