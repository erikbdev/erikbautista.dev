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

    var body: some Rule {
      Pseudo(class: .root) => { 
        Variable("pico-background-color", value: "#1c1c1c")
      }

      // self.container => {
      //   Display(.flex)
      //   Background("#1c1c1c")
      //   Color(.white)
      //   // AnyProperty("justify-self", "center")
      // }

      // self.container > Class("main") => {
        // Width(.full)
        // Height(.full)

        // Media(maxWidth: 2xl) => {
        //   MaxWidth(.rem(20))
        // }
      // }

      self.svgIcon => {
        Display(.inlineBlock)
        AnyProperty("vertical-align", "middle")
        AnyProperty("position", "relative")
        AnyProperty("bottom", "0.125em")
        AnyProperty("width", "1em")
        AnyProperty("height", "1em")
        AnyProperty("margin-right", "0.25rem")
      }

      Class("reversed") => {
        AnyProperty("scale", "calc(100% * -1) 100%")
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
    html(.lang("en")) {
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

            p(.ariaLabel("Location")) {
              svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .ariaLabel("Map pin icon"), .class(styling.svgIcon)) {
                path(
                  .d("M128,64a40,40,0,1,0,40,40A40,40,0,0,0,128,64Zm0,64a24,24,0,1,1,24-24A24,24,0,0,1,128,128Zm0-112a88.1,88.1,0,0,0-88,88c0,31.4,14.51,64.68,42,96.25a254.19,254.19,0,0,0,41.45,38.3,8,8,0,0,0,9.18,0A254.19,254.19,0,0,0,174,200.25c27.45-31.57,42-64.85,42-96.25A88.1,88.1,0,0,0,128,16Zm0,206c-16.53-13-72-60.75-72-118a72,72,0,0,1,144,0C200,161.23,144.53,209,128,222Z")
                )
              }

              "\(residency)"

              if let location, location.city != residency.city || location.state != residency.state {
                " \u{2022} "
                svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .class(styling.svgIcon), .class("reversed"), .ariaLabel("Navigation icon")) {
                  path(.d("M234.35,129,152,152,129,234.35a8,8,0,0,1-15.21.27l-65.28-176A8,8,0,0,1,58.63,48.46l176,65.28A8,8,0,0,1,234.35,129Z"))
                  path(.d("M237.33,106.21,61.41,41l-.16-.05A16,16,0,0,0,40.9,61.25a1,1,0,0,0,.05.16l65.26,175.92A15.77,15.77,0,0,0,121.28,248h.3a15.77,15.77,0,0,0,15-11.29l.06-.2,21.84-78,78-21.84.2-.06a16,16,0,0,0,.62-30.38ZM149.84,144.3a8,8,0,0,0-5.54,5.54L121.3,232l-.06-.17L56,56l175.82,65.22.16.06Z"))
                }

                span { "Currently in " }
                [location.city, location.state, location.region == "United States" ? nil : location.region]
                  .compactMap(\.self)
                  .joined(separator: ", ")
              }
            }
          }
        }
        main {
          section(.ariaLabel("Experience")) {
            h3 { "Experience" }
          }

          section(.ariaLabel("Projects")) {
            h3 { "Projects" }
          }

          section(.ariaLabel("Education")) {
            h3 { "Education" }
            div {
              div {
                h6 {
                  a(.target(.blank), .rel("noopener noreferrer"), .href("https://stedwards.edu/")) {
                    "St. Edward's University"
                  }
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
