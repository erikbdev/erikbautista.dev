import Dependencies
import Elementary
import ActivityClient
import SyntaxHighlight
import Foundation

public struct HomePage: Page {
  @Dependency(\.activityClient) private var activityClient

  public init() {}

  private static let dateFormatter = DateFormatter()

  var year: String {    
    Self.dateFormatter.locale = Locale(languageCode: .english, languageRegion: .unitedStates)
    Self.dateFormatter.timeZone = TimeZone(abbreviation: "PST") ?? Self.dateFormatter.timeZone
    Self.dateFormatter.dateFormat = "yyyy"
    return Self.dateFormatter.string(from: Date.now)
  }

  public var content: some HTML {
    HTMLRaw("<!DOCTYPE html>")
    html(.lang("en")) {
      head {
        title { "Erik Bautista Santibanez" }
        meta(.charset(.utf8))
        meta(name: .viewport, content: "width=device-width, initial-scale=1.0")
        link(.rel(.stylesheet), .href("/styles/app.generated.css"))
        script(.src("https://cdn.jsdelivr.net/npm/alpinejs@3.14.8/dist/cdn.min.js"), .defer) {}
      }
      body(.class("bg-[#1c1c1c] text-white flex justify-center")) {
        main(.class("max-w-xl w-full h-full")) {
          section(.class("p-8 pb-8"), .ariaLabel("about")) {
            h1(.class("font-bold")) { "Erik Bautista Santibanez" }
            p(.class("opacity-70")) { "Swift & Web Developer" }

            div(.class("flex flex-row items-center gap-1"), .ariaLabel("located")) {
              if let currentLocation = activityClient.currentLocation() {
                svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 24 24"), .class("size-4"), .class("opacity-70")) {
                  path(
                    .fillRule("evenodd"), 
                    .clipRule("evenodd"), 
                    .d("m11.54 22.351.07.04.028.016a.76.76 0 0 0 .723 0l.028-.015.071-.041a16.975 16.975 0 0 0 1.144-.742 19.58 19.58 0 0 0 2.683-2.282c1.944-1.99 3.963-4.98 3.963-8.827a8.25 8.25 0 0 0-16.5 0c0 3.846 2.02 6.837 3.963 8.827a19.58 19.58 0 0 0 2.682 2.282 16.975 16.975 0 0 0 1.145.742ZM12 13.5a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z")
                  )
                }

                p { "\(currentLocation.city ?? "Unknown"), \(currentLocation.state ?? "Unknown")" }
              } else {
                p(.class("opacity-70")) { "Location unknown..." }
              }
            }
          }

          section(.class("px-8 pb-8"), .ariaLabel("experience")) {
            h2(.class("font-bold")) { "Experience" }
          }

          section(.class("px-8 pb-8"), .ariaLabel("projects")) {
            h2(.class("font-bold")) { "Projects" }
          }

          footer(.class("px-8 pb-16 text-xs opacity-70"), .ariaLabel("credits")) {
            hr(.class("pb-6 border-top border-neutral-600"))
            p(.class("px-6")) { "Copyright ©\(year) Erik Bautista Santibanez."  }
          }
        }
      }
    }
  }
}

private struct Footer: HTML {
  var content: some HTML {
    footer(.class("max-w-center-layout mt-auto w-full flex-initial text-xs")) {
      div(
        .class(
          "flex flex-col items-center gap-4 border-t border-neutral-500/20 pt-8 text-center font-semibold text-neutral-400 md:flex-row"
        )
      ) {
        p(.class("flex flex-wrap justify-center gap-1")) {
          "Designed and developed by"
          a(
            .class("flex items-center gap-1 font-bold md:ml-auto"),
            .href("https://erikbautista.dev")
          ) {
            "[redacted]"
          }
        }
        p(.class("flex flex-wrap justify-center items-center gap-2 md:ml-auto")) {
          "Made with \u{2764} using"
          a(.target(.blank), .rel("noopener noreferrer"), .href("https://swift.org")) {
            "Swift"
          }
        }
      }
    }
  }
}

// private enum PackageTheme: Theme {
//   static var className: String? { "swift-package-code-block" }

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
