import Dependencies
import HTML
import Vue

public struct NotFoundPage: Page {
  public let title = "404 | Erik Bautista Santibanez"

  let initialCodeLang: CodeLang?

  public init(codeLang: CodeLang? = .swift) {
    self.initialCodeLang = codeLang
  }

  public var head: some HTML {
    EmptyHTML()
  }

  public var body: some HTML {
    #VueScope(initialCodeLang) { codeLang in
      HeaderView(selected: codeLang)
      Spacer()
      main {
        InnerView(codeLang: codeLang)
      }
      Spacer()
      FooterView()
    }
    .inlineStyle("display", "flex")
    .inlineStyle("flex-direction", "column")
    .inlineStyle("height", "100%")
  }
}

private struct InnerView: HTML {
  let codeLang: Expression<CodeLang?>

  private static let notFoundDescription = "The asset or page could not be found"

  var body: some HTML {
        section {
          CodeLang.conditionalCases(initial: codeLang) { lang in
            div {
              pre {
                a(.href("/not-found")) {
                  code {
                    CodeLang.slugToFileName("not-found", lang: lang)
                  }
                }
                .inlineStyle("color", "#777")
              }
              .inlineStyle("font-size", "0.75em")
              .inlineStyle("font-weight", "500")
              .inlineStyle("text-align", "end")
              .inlineStyle("padding-bottom", "0.5rem")

              div {
                if let lang {
                  pre {
                    code {
                      """
                      // 404 ERROR
                      // \(Self.notFoundDescription)\n
                      """

                      switch lang {
                      case .swift:
                        """
                        throw Error.notFound
                        """
                      case .rust:
                        """
                        panic!("Not found");
                        """
                      case .typescript:
                        """
                        throw new Error("Not found");
                        """
                      }
                    }
                  }
                } else {
                  h1 {
                    span { "#" }
                      .inlineStyle("color", "#808080")
                      .inlineStyle("font-weight", "700")
                    " "
                    "Not Found" 
                  }
                  .inlineStyle("margin-bottom", "0.125rem")

                  p { Self.notFoundDescription }
                    .inlineStyle("color", "#d0d0d0")
                    .inlineStyle("font-weight", "normal")
                }
              }
              .inlineStyle("padding", "160px 32px")
              .inlineStyle("justify-self", "center")
            }
          }
          .containerStyling()
          .inlineStyle("width", "100%")
          .inlineStyle("padding", "1.5rem")
          .inlineStyle("background-image", "radial-gradient(#2A2A2A 1px, transparent 0)")
          .inlineStyle("background-size", "12px 12px")
        }
        .wrappedStyling()
  }
}