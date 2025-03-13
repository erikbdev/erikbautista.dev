import HTML
import Models
import Dependencies

struct SectionView<Content: HTML>: HTML {
  @Dependency(\.currentCodeLang) var currentCodeLang

  let id: String
  let codeHeader: @Sendable (CodeLang) -> String
  @HTMLBuilder let content: @Sendable () -> Content

  var body: some HTML {
    let allCodeLangs = CodeLang.allCases.sorted(initial: currentCodeLang)
    section(.id(self.id)) {
      div {
        header {
          pre {
            a(.href("#\(self.id)")) {
              for (idx, lang) in allCodeLangs.enumerated() {
                code {
                  slugToFileName(lang)
                }
                .attribute("v-cloak", value: idx == allCodeLangs.startIndex ? nil : "")
                .attribute("v-if", value: idx == allCodeLangs.startIndex ? "selected == '\(lang.rawValue)'" : nil)
                .attribute("v-else-if", value: allCodeLangs.startIndex < idx && idx < allCodeLangs.index(before: allCodeLangs.endIndex) ? "selected == '\(lang.rawValue)'" : nil)
                .attribute("v-else", value: idx == allCodeLangs.index(before: allCodeLangs.endIndex) ? "" : nil)
              }
            }
            .inlineStyle("color", "#777")
          }
          .inlineStyle("font-size", "0.75em")
          .inlineStyle("font-weight", "500")
          .inlineStyle("text-align", "end")
          .inlineStyle("padding", "1.5rem 1.5rem 0")

          pre {
            for (idx, lang) in allCodeLangs.enumerated() {
              code(.class("hljs language-\(lang.rawValue)")) {
                """
                // \(slugToFileName(lang))
                // Portfolio
                \(codeHeader(lang))
                """
              }
              .attribute("v-cloak", value: idx == allCodeLangs.startIndex ? nil : "")
              .attribute("v-if", value: idx == allCodeLangs.startIndex ? "selected == '\(lang.rawValue)'" : nil)
              .attribute("v-else-if", value: allCodeLangs.startIndex < idx && idx < allCodeLangs.index(before: allCodeLangs.endIndex) ? "selected == '\(lang.rawValue)'" : nil)
              .attribute("v-else", value: idx == allCodeLangs.index(before: allCodeLangs.endIndex) ? "" : nil)
            }
          }
          .inlineStyle("padding", "0.75rem 1.5rem 1.5rem")
        }
        // .inlineStyle("background-image", "radial-gradient(#2A2A2A 1px, transparent 0)")
        // .inlineStyle("background-size", "12px 12px")

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