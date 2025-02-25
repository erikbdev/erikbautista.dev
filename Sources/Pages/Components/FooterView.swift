import Elementary
import Foundation

struct FooterView: HTML {
  private static let copyrightDateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(languageCode: .english, languageRegion: .unitedStates)
    formatter.timeZone = TimeZone(abbreviation: "PST") ?? formatter.timeZone
    formatter.dateFormat = "yyyy"
    return formatter
  }()

  var content: some HTML {
    footer {
      div {
        p { "©\(Self.copyrightDateFormatter.string(from: Date.now)) Erik Bautista Santibanez" }
        p {
          "Made with \u{2764} using "
          a(.target(.blank), .rel("noopener noreferrer"), .href("https://swift.org")) { "Swift" }
          " + "
          a(.target(.blank), .rel("noopener noreferrer"), .href("https://hummingbird.codes")) { "Hummingbird" }
          "."
        }
      }
      .containerStyling()
      .inlineStyle("padding", "1rem 1.5rem")
    }
    .inlineStyle("text-align", "center")
    .wrappedStyling()
  }
}
