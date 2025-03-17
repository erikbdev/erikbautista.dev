import Dependencies
import HTML
import Models
import Vue

struct SectionView<Header: HTML, Content: HTML>: HTML {
  let id: String
  let selected: Vue.Expression<CodeLang?>
  @HTMLBuilder let header: @Sendable (CodeLang?) -> Header
  @HTMLBuilder let content: @Sendable () -> Content

  var body: some HTML {
    section(.id(self.id)) {
      div {
        tag("header") {
          hgroup {
            pre {
              a(.href("#\(self.id)")) {
                CodeLang.conditionalCases(initial: selected) { lang in
                  code {
                    CodeLang.slugToFileName(self.id, lang: lang)
                  }
                }
              }
              .inlineStyle("color", "#777")
            }
            .inlineStyle("font-size", "0.75em")
            .inlineStyle("font-weight", "500")
            .inlineStyle("text-align", "end")
            .inlineStyle("padding-bottom", "0.5rem")

            CodeLang.conditionalCases(initial: selected) { lang in
              if let lang {
                pre {
                  code(.class("hljs language-\(lang.rawValue)")) {
                    """
                    // \(CodeLang.slugToFileName(self.id, lang: lang))\n
                    """
                    self.header(lang)
                  }
                }
              } else {
                hgroup {
                  self.header(nil)
                }
              }
            }
            .inlineStyle("padding-bottom", "0.75rem")
          }
        }
        .inlineStyle("padding", "1.5rem")

        self.content()
      }
      .containerStyling()
    }
    .wrappedStyling()
  }
}

extension CodeLang {
  static func slugToFileName(_ slug: String, lang: CodeLang?) -> String {
    let fileName =
      switch lang {
      case .none: slug
      case .swift:
        slug.components(separatedBy: "-")
          .map { component -> String in
            if let first = component.first {
              first.uppercased().appending(component.dropFirst())
            } else {
              component
            }
          }
          .joined()
      case .rust: slug
      case .typescript:
        slug.components(separatedBy: "-")
          .enumerated()
          .map { (idx, component) -> String in
            if idx == 0 {
              component
            } else if let first = component.first {
              first.uppercased().appending(component.dropFirst())
            } else {
              component
            }
          }
          .joined()
      }
    return fileName + "." + (lang?.ext ?? "md")
  }
}

extension [CodeLang] {
  func sorted(initial lang: CodeLang) -> Self {
    [lang] + self.filter { $0 != lang }
  }
}
