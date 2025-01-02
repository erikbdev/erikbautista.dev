public enum Project: String, Sendable, CaseIterable {
  case animeNow = "anime-now"
  case mochi
  case prismUI = "prism-ui"
  case saferTogether = "safer-together"

  public var title: String {
    switch self {
    case .animeNow: "Anime Now"
    case .mochi: "Mochi"
    case .prismUI: "PrismUI"
    case .saferTogether: "Safer Together"
    }
  }

  public var description: String {
    switch self {
    case .animeNow: ""
    case .saferTogether: ""
    case .prismUI: ""
    case .mochi: ""
    }
  }
}
