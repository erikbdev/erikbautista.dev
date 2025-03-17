import Dependencies
import HTML
import Vue

public enum CodeLang: String, Hashable, Encodable, CaseIterable, Sendable, RawRepresentable {
  case swift
  case rust
  case typescript

  // TODO: Add markdown as valid codelang
  // case markdown

  public init?(rawValue: String) {
    if let value = Self.allCases.first(where: { $0.rawValue == rawValue }) {
      self = value
    } else {
      return nil
    }
  }

  public var title: String {
    switch self {
    case .swift: "Swift"
    case .rust: "Rust"
    case .typescript: "TypeScript"
    }
  }

  public var ext: String {
    switch self {
    case .swift: "swift"
    case .rust: "rs"
    case .typescript: "ts"
    }
  }

  @HTMLBuilder static func conditionalCases<Content: HTML>(
    initial selected: Vue.Expression<CodeLang?>,
    @HTMLBuilder content: (CodeLang?) -> Content
  ) -> some HTML {
    let allCodeLangs = [selected.initialValue] + (Self.allCases + [nil]).filter { $0 != selected.initialValue }
    for (idx, lang) in allCodeLangs.enumerated() {
      content(lang)
        .attribute(
          "v-cloak",
          value: idx == allCodeLangs.startIndex ? nil : ""
        )
        .attribute(
          "v-if",
          value: idx == allCodeLangs.startIndex ? (selected == Expression(lang)).rawValue : nil
        )
        .attribute(
          "v-else-if",
          value: allCodeLangs.startIndex < idx
            && idx < allCodeLangs.index(before: allCodeLangs.endIndex)
            ? (selected == Expression(lang)).rawValue : nil
        )
        .attribute(
          "v-else",
          value: idx == allCodeLangs.index(before: allCodeLangs.endIndex) ? "" : nil
        )
    }
  }
}