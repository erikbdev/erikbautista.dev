import Dependencies
import HTML
import Vue

public struct NotFoundPage: Page {
  public let title = "Erik Bautista Santibanez | Not Found"
  public let lang = "en"

  let initialCodeLang: CodeLang

  public init(codeLang: CodeLang = .swift) {
    self.initialCodeLang = codeLang
  }

  public var head: some HTML {
    EmptyHTML()
  }

  public var body: some HTML {
    #VueScope(initialCodeLang) { selected in
      HeaderView(selected: selected)
      Spacer()
      main {
        section {
          div {
            div {
              pre {
                code { "// 404 ERROR" }
                  .inlineStyle("color", "#808080")
                  .inlineStyle("margin-bottom", "0.125rem")
              }

              h1 { "Page Not Found" }
                .inlineStyle("margin-bottom", "0.5rem")

              pre {
                CodeLang.conditionalCases(initial: selected) { lang in
                  code {
                    switch lang {
                    case .swift:
                      """
                      throw Error.pageNotFound
                      """
                    case .rust:
                      """
                      panic!("page not found")
                      """
                    case .typescript:
                      """
                      throw new Error("page not found")
                      """
                    }
                  }
                }
              }
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
    .inlineStyle("display", "flex")
    .inlineStyle("flex-direction", "column")
    .inlineStyle("height", "100%")
  }
}
