import HTML
import Models
import Dependencies
import Vue

struct SectionView<Content: HTML>: HTML {
  let id: String
  let selected: Vue.Expression<CodeLang>
  let codeHeader: @Sendable (CodeLang) -> String
  @HTMLBuilder let content: @Sendable () -> Content

  var body: some HTML {
    section(.id(self.id)) {
      div {
        header {
          pre {
            a(.href("#\(self.id)")) {
              CodeLang.conditionalCases(initial: selected) { lang in
                code {
                  slugToFileName(lang)
                }
              }
            }
            .inlineStyle("color", "#777")
          }
          .inlineStyle("font-size", "0.75em")
          .inlineStyle("font-weight", "500")
          .inlineStyle("text-align", "end")
          .inlineStyle("padding", "1.5rem 1.5rem 0")
          pre {
            CodeLang.conditionalCases(initial: selected) { lang in
              code(.class("hljs language-\(lang.rawValue)")) {
                """
                // \(slugToFileName(lang))
                // Portfolio
                \(codeHeader(lang))
                """
              }
            }
          }
          .inlineStyle("padding", "0.75rem 1.5rem 1.5rem")
        }
        self.content()
      }
      .containerStyling()
    }
    .wrappedStyling()
  }

  private func slugToFileName(_ lang: CodeLang) -> String {
    let fileName = switch lang {
      case .swift:
        self.id.components(separatedBy: "-")
          .map { component -> String in
            if let first = component.first {
              first.uppercased().appending(component.dropFirst())
            } else {
              component
            }
          }
          .joined()
      case .rust: self.id
      case .typescript:
        self.id.components(separatedBy: "-")
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
    return fileName + "." + lang.ext
  }
}

extension [CodeLang] {
  func sorted(initial lang: CodeLang) -> Self {
    [lang] + self.filter { $0 != lang }
  }
}