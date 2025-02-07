import Foundation

struct Post {
  let slug: String
  var header: Header?
  let title: String
  let content: HTMLMarkdown
  let date: Date
  let kind: Kind
  var actionButtons: [LinkButton]?

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

  enum Header {
    case link(String)
    case image(String)
    case video(String)
    case code(HTMLMarkdown)
  }

  struct LinkButton {
    let title: String
    let link: String
  }

  enum Kind: String, Hashable, CaseIterable {
    case project
    case education
    case experience
    
    var tabTitle: String {
      switch self {
        case .project: "Projects"
        case .education: "Education"
        case .experience: "Experiences"
      }
    }
  }
}
