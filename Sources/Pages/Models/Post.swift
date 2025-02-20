import Foundation
import PublicAssets

struct Post: Sendable {
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

  var datePosted: String {
    Self.dateCreatedFormatter.string(from: self.date)
  }

  private static let timestampFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyyMMdd"
    return formatter
  }()

  var slug: String {
    "\(Self.timestampFormatter.string(from: self.date))-\(self.title.split { !$0.isLetter && !$0.isNumber }.joined(separator: "-").lowercased())"
  }

  enum Header {
    case link(String)
    case image(GeneratedPublicAssets.ImageFile, label: String)
    case video(GeneratedPublicAssets.VideoFile)
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

    var isExternal: Bool { !self.href.hasPrefix("/") }

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