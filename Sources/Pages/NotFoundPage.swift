import HTML
import Vue

public struct NotFoundPage: Page {
  public let title = "Erik Bautista Santibanez | Not Found"
  public let lang = "en"

  public init() {}

  public var head: some HTML {
    EmptyHTML()
  }

  public var body: some HTML {
    #VueScope(CodeLang.swift) { (selected: Vue.Expression) in
      HeaderView(selected: selected)
      Spacer()
      main {
        section {
          div {
            div {
              Heading(selected: selected)
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

  private struct Heading: HTML {
    let selected: Vue.Expression

    var body: some HTML {
      pre {
        code { "// 404 ERROR" }
          .inlineStyle("color", "#808080")
          .inlineStyle("margin-bottom", "0.125rem")
      }

      h1 { "Page Not Found" }
        .inlineStyle("margin-bottom", "0.5rem")

      pre {
        code(.v.cloak, .v.if(selected == Expression(CodeLang.rust)), .class("hljs language-rust")) {
          """
          panic!("page not found")
          """
        }
        code(.v.cloak, .v.elseIf(selected == Expression(CodeLang.typescript)), .class("hljs language-typescript")) {
          """
          throw new Error("page not found")
          """
        }
        code(.v.else, .class("hljs language-swift")) {
          """
          throw Error.pageNotFound
          """
        } 
      }
    }
  }
}
