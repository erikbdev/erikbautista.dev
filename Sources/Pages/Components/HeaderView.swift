import Elementary

struct HeaderView: HTML {
  var content: some HTML {
    header {
      hgroup {
        code { "erikb.dev()" }
          .inlineStyle("font-size", "0.84em")
          .inlineStyle("color", "#AAA")
        // TODO: Add buttons to allow switching between code styling or plain text
      }
      .containerStyling()
      .inlineStyle("display", "flex")
      .inlineStyle("padding", "0.75rem 1.5rem")
    }
    .wrappedStyling()
  }
}
