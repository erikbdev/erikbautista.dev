import Foundation

struct Post {
  let id: Int
  var header: Header?
  let title: String
  let content: HTMLMarkdown
  let date: Date
  let kind: Kind
  var links: [Link] = []

  private static let dateCreatedFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(languageCode: .english, languageRegion: .unitedStates)
    formatter.timeZone = TimeZone(abbreviation: "PST") ?? formatter.timeZone
    formatter.dateFormat = "MMM, d yyyy"
    return formatter
  }()

  var dateFormatted: String {
    Self.dateCreatedFormatter.string(from: self.date).uppercased()
  }

  var slug: String {
    "\(id)-\(self.title.slug())"
  }

  enum Header {
    case link(String)
    case image(String, label: String)
    case video(String)
    case code(String, lang: CodeLang)

    enum CodeLang: String {
      case swift
      case rust
      case javascript
    }
  }

  struct Link {
    let title: String
    let href: String
    let role: Role

    var isExternal: Bool {
      self.href.hasPrefix("http")
    }

    enum Role: String, CaseIterable {
      case primary
      case secondary
    }
  }

  enum Kind: String, Hashable, CaseIterable {
    case blog
    case project
    case education
    case experience
    
    var tabTitle: String {
      switch self {
        case .blog: "Blog"
        case .project: "Projects"
        case .education: "Education"
        case .experience: "Experiences"
      }
    }
  }
}

private extension String {
  func slug() -> String {
    split { !$0.isLetter && !$0.isNumber }.joined(separator: "-").lowercased()
  }
}