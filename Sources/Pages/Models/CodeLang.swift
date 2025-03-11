enum CodeLang: String, CaseIterable, Encodable {
  case swift
  case rust
  case typescript

  var title: String {
    switch self {
      case .swift: "Swift"
      case .rust: "Rust"
      case .typescript: "TypeScript"
    }
  }
}
