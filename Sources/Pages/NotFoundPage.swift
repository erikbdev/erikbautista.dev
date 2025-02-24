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
              h2 { "404 Error | Page Not Found" }
              .inlineStyle("margin-bottom", "0.5rem")
              pre {
                code(.class("hljs language-swift")) {
                  """
                  throw Error.pageNotFound
                  """
                }
              }
            }
          }
          .containerStyling()
          .inlineStyle("display", "flex")
          .inlineStyle("flex-direction", "column")
          .inlineStyle("justify-content", "center")
          .inlineStyle("align-items", "center")
          .inlineStyle("padding", "120px 16px")
          .inlineStyle("gap", "1.5rem")
        }
        .wrappedStyling()
      }
      Spacer()
      FooterView()
    }
  }
}
