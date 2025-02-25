import Elementary

public struct NotFoundPage: Page {
  public let title = "Erik Bautista Santibanez | Not Found"
  public let lang = "en"

  public init() {}

  public var head: some HTML {
    EmptyHTML()
  }

  public var body: some HTML {
    div {
      HeaderView()
      Spacer()
      main {
        section {
          div {
            div {
              Heading()
            }
          }
          .containerStyling()
          .inlineStyle("display", "flex")
          .inlineStyle("flex-direction", "column")
          .inlineStyle("justify-content", "center")
          .inlineStyle("align-items", "center")
          .inlineStyle("padding", "160px 32px")
          .inlineStyle("background-image", "radial-gradient(#2A2A2A 1px, transparent 0)")
          .inlineStyle("background-size", "12px 12px")
        }
        .wrappedStyling()
      }
      Spacer()
      FooterView()
    }
  }

  private struct Heading: HTML {
    var content: some HTML {
      pre {
        code { "// 404 ERROR" }
          .inlineStyle("font-size", "0.9em")
          .inlineStyle("color", "#808080")
          .inlineStyle("margin-bottom", "0.125rem")
      }

      h2 { "Page Not Found" }
        .inlineStyle("margin-bottom", "0.5rem")

      pre {
        code(.class("hljs language-swift")) {
          """
          throw Error.pageNotFound
          """
        }
        .inlineStyle("font-size", "0.9em")
      }
    }
  }
}
