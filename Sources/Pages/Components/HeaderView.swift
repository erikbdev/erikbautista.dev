import HTML
import Dependencies
import EnvVars
import Vue

struct HeaderView: HTML {
  @Dependency(\.envVars) var envVars

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
        // TODO: Add buttons to allow switching between code styling or plain text

        CodeSelector()        
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

private struct CodeSelector: VueComponent {
  @Reactive let visible = false

  var body: some HTML {
    div {
      button(.v.on(.click, Expression(rawValue: "\($visible.name) = \(!$visible)"))) {
        code { "</>" }
          .inlineStyle("color", "#AAA")
      }
      .inlineStyle("font-weight", "bold")
      .inlineStyle("font-size", "0.7em")
      .inlineStyle("background", "unset")
      .inlineStyle("border", "1.16px solid #444")
      .inlineStyle("border-radius", "0.3rem")
      .inlineStyle("padding", "0.28rem 0.4rem")

      ul(.v.show($visible)) {
        li { "Plain Text" }
        li { "Swift" }
        li { "Rust" }
        li { "TypeScript" }
      }
    }
  }
}