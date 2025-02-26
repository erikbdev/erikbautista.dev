import Elementary
import Dependencies
import EnvVars

struct HeaderView: HTML {
  @Dependency(\.envVars) var envVars

  var content: some HTML {
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

        // CodeStyleSelector()        
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

private struct CodeStyleSelector: VueComponent {
  // @VueState var visible = false

  var body: some HTML {
    div {
      button {
        code { "</>" }
          .inlineStyle("color", "#AAA")
      }
      .inlineStyle("font-weight", "bold")
      .inlineStyle("font-size", "0.7em")
      .inlineStyle("background", "unset")
      .inlineStyle("border", "1px solid #444")
      .inlineStyle("border-radius", "0.2rem")
      .inlineStyle("padding", "0.2rem 0.35rem")

      // ul(.v.show("visible")) {
      //   li { "Plain Text" }
      //   li { "Swift" }
      //   li { "Rust" }
      //   li { "TypeScript" }
      // }
    }
  }
}