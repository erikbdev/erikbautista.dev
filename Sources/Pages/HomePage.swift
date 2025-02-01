import ActivityClient
import Cascadia
import Dependencies
import Elementary
import Foundation
import SyntaxHighlight

public struct HomePage: Page {
  struct Style: Sendable, StyleSheet {
    let container = Class(module: "container")
    let svgIcon = Class(module: "svgIcon")
    let reversed = Class(module: "reversed")
    let location = Class(module: "location")
    let educationItem = Class(module: "eductation-item")

    var body: some Rule {
      Attribute("data-theme", match: .exact, value: "dark") => {
        Variable("pico-background-color", value: "#1c1c1c")
      }

      self.svgIcon => {
        Display(.inlineBlock)
        AnyProperty("vertical-align", "middle")
        AnyProperty("position", "relative")
        AnyProperty("bottom", "0.125em")
        AnyProperty("width", "1em")
        AnyProperty("height", "1em")
        AnyProperty("margin-right", "0.25rem")
      }

      self.reversed => {
        AnyProperty("scale", "calc(100% * -1) 100%")
      }

      self.location > Element(.span) => {
        Color("#fff")
      }

      self.educationItem => {
        Display(.flex)
        AnyProperty("justify-content", "space-between")
      }
    }
  }

  @Dependency(\.activityClient) private var activityClient

  public init() {}
 
  private static let yearDateFormatter = DateFormatter()

  var year: String {
    Self.yearDateFormatter.locale = Locale(languageCode: .english, languageRegion: .unitedStates)
    Self.yearDateFormatter.timeZone = TimeZone(abbreviation: "PST") ?? Self.yearDateFormatter.timeZone
    Self.yearDateFormatter.dateFormat = "yyyy"
    return Self.yearDateFormatter.string(from: Date.now)
  }

  let styling = Style()

  public var content: some HTML {
    HTMLRaw("<!DOCTYPE html>")
    html(.lang("en"), .custom(name: "data-theme", value: "dark")) {
      head {
        title { "Erik Bautista Santibanez" }
        meta(.charset(.utf8))
        meta(name: .viewport, content: "width=device-width, initial-scale=1.0")
        link(.rel(.stylesheet), .href("https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"))
        style(styling)
        // script(.src("https://cdn.jsdelivr.net/npm/alpinejs@3.14.8/dist/cdn.min.js"), .defer) {}
      }
      body(.class("container")) {
        header(.ariaLabel("About")) {
          hgroup {
            h1 { "Erik Bautista Santibanez" }
            p { "Swift & Web Developer" }

            let location = self.activityClient.location()
            let residency = location?.residency ?? .default

            p {
              span(.ariaLabel("Residency")) {
                svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .ariaLabel("Map pin icon"), .class(styling.svgIcon)) {
                  path(
                    .d("M128,16a88.1,88.1,0,0,0-88,88c0,75.3,80,132.17,83.41,134.55a8,8,0,0,0,9.18,0C136,236.17,216,179.3,216,104A88.1,88.1,0,0,0,128,16Zm0,56a32,32,0,1,1-32,32A32,32,0,0,1,128,72Z")
                  )
                }
                "\(residency)"
              }

              if let location, location.city != residency.city || location.state != residency.state {
                " \u{2022} "

                span(.ariaLabel("Location"), .class(styling.location)) {
                  svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .class(styling.svgIcon), .class(styling.reversed), .ariaLabel("Navigation icon")) {
                    path(.d("M234.35,129,152,152,129,234.35a8,8,0,0,1-15.21.27l-65.28-176A8,8,0,0,1,58.63,48.46l176,65.28A8,8,0,0,1,234.35,129Z"))
                    path(.d("M237.33,106.21,61.41,41l-.16-.05A16,16,0,0,0,40.9,61.25a1,1,0,0,0,.05.16l65.26,175.92A15.77,15.77,0,0,0,121.28,248h.3a15.77,15.77,0,0,0,15-11.29l.06-.2,21.84-78,78-21.84.2-.06a16,16,0,0,0,.62-30.38ZM149.84,144.3a8,8,0,0,0-5.54,5.54L121.3,232l-.06-.17L56,56l175.82,65.22.16.06Z"))
                  }

                  "Currently in "

                  span {
                    strong {
                      [location.city, location.state, location.region == "United States" ? nil : location.region]
                        .compactMap(\.self)
                        .joined(separator: ", ")
                    }
                  }
                }
              }
            }
          }
        }
        main {
          // TODO: Do a timeline with filters
          // section(.ariaLabel("Experience")) {
          //   h5 { "Experience" }
          // }
          // section(.ariaLabel("Projects")) {
          //   h5 { "Projects" }
          // }
          section(.ariaLabel("Education")) {
            h5 { "Education" }
            div(.class(styling.educationItem)) {
              div {
                a(.target(.blank), .rel("noopener noreferrer"), .href("https://stedwards.edu/")) {
                  "St. Edward's University"
                }
                p { "Bachelor of Science in Computer Science" }
              }

              p { "2018-2023" }
            }
          }
        }
        footer(.ariaLabel("Credits")) {
          hr()
          p { "©\(self.year) Erik Bautista Santibanez" }
          p {
            "Made with \u{2764} using "
            a(.target(.blank), .rel("noopener noreferrer"), .href("https://swift.org")) { "Swift" }
            " + "
            a(.target(.blank), .rel("noopener noreferrer"), .href("https://hummingbird.codes")) { "Hummingbird" }
            "."
          }
        }
      }
    }
  }
}

// private enum PackageTheme: Theme {
//   static var className: String? { "swift-package-code-block" }
//
//   static func style(for tokenSyntax: TokenSyntax) -> [Token] {
//     switch tokenSyntax.tokenKind {
//     case .keyword: [Token("\(tokenSyntax)", className: "text-blue-400")]
//     case .identifier:
//       switch tokenSyntax.previousToken(viewMode: .sourceAccurate)?.tokenKind {
//       case .keyword: [Token("\(tokenSyntax)", className: nil)]
//       case .period: [Token("\(tokenSyntax)", className: "text-purple-400")]
//       default: [Token("\(tokenSyntax)", className: "text-blue-200")]
//       }
//     case .stringSegment, .stringQuote: [Token("\(tokenSyntax)", className: "text-red-400")]
//     default: [Token(tokenSyntax.description, className: nil)]
//     }
//   }
// }
