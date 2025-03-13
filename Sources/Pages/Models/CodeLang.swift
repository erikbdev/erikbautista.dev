import Dependencies

public enum CodeLang: String, Hashable, Encodable, CaseIterable, Sendable {
  case swift
  case rust
  case typescript

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
}

private enum CurrentCodeLang: TestDependencyKey {
  static let testValue = CodeLang.swift
}

extension DependencyValues {
  public var currentCodeLang: CodeLang {
    get { self[CurrentCodeLang.self] }
    set { self[CurrentCodeLang.self] = newValue }
  }
}