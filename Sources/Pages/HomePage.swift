import ActivityClient
import Cascadia
import Dependencies
import Elementary
import Foundation

public struct HomePage: Page {
  struct Style: Sendable, StyleSheet {
    var body: some Rule {
      // TODO: Add Work-Sans font?

      Pseudo(class: .root) => {
        BackgroundColor("#1c1c1c")
        Color("#fafafa")
        AnyProperty("font-family", "ui-sans-serif, -apple-system, Helvetica Neue, Helvetica, Arial, sans-serif")
        AnyProperty("font-optical-sizing", "auto")
        AnyProperty("font-style", "normal")
      }

      // General

      Element(.body) => {
        AnyProperty("max-width", "40rem")
        AnyProperty("margin-right", "auto")
        AnyProperty("margin-left", "auto")
        AnyProperty("padding-left", "1.5rem")
        AnyProperty("padding-right", "1.5rem")
      }

      Class("svg-icon") => {
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

      /// Main

      Element(.header) * Element(.p) => {
        Color(.hex("#D0D0D0"))
      }

      /// Post tabs

      Class("post-tabs") => {
        AnyProperty("list-style-type", "none")
        AnyProperty("margin", "0")
        AnyProperty("padding", "0")
        AnyProperty("overflow", "hidden")
      }

      Class("post-tabs") > Element(.li) => {
        AnyProperty("float", "left")
      }

      Class("post-tabs") * Element(.button) => {
        AnyProperty("border-radius", "9999px")
        AnyProperty("background-color", "#2c2c2c")
        AnyProperty("color", "white")
        AnyProperty("padding", "0.25rem 0.75rem")
        AnyProperty("border-width", "1px")
        AnyProperty("border-style", "solid")
        AnyProperty("border-color", "#606060")
      }

      /// Post

      Class("post") => {
        AnyProperty("margin-top", "0.75rem")
        AnyProperty("margin-bottom", "1.5rem")
      }

      Class("post") > Element(.header) => {
        Color(.gray)
        AnyProperty("font-size", "0.75em")
        AnyProperty("font-weight", "600")
      }

      Class("post") > Class("post-title") => {
        AnyProperty("margin-top", "0.5rem")
      }

      Class("post") > Class("post-content") * All() => {
        AnyProperty("margin", "revert")
      }

      /// Code blocks
      Element(.pre) => {
        AnyProperty("padding", "1rem")
        Background("#2F2F2F")
        AnyProperty("border-radius", "0.75rem")
      }
    }
  }

  @Dependency(\.activityClient) private var activityClient

  public init() {}

  private static let copyrightDateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(languageCode: .english, languageRegion: .unitedStates)
    formatter.timeZone = TimeZone(abbreviation: "PST") ?? formatter.timeZone
    formatter.dateFormat = "yyyy"
    return formatter
  }()

  let styling = Style()

  public var content: some HTML {
    HTMLRaw("<!DOCTYPE html>")
    html(.lang("en"), .custom(name: "data-theme", value: "dark")) {
      head {
        title { "Erik Bautista Santibanez" }
        meta(.charset(.utf8))
        meta(name: .viewport, content: "width=device-width, initial-scale=1.0")
        link(.rel(.stylesheet), .href("https://cdnjs.cloudflare.com/ajax/libs/modern-normalize/3.0.1/modern-normalize.min.css"))
        style {
          /// Reset stylesheet
          HTMLRaw(
            """
            :root {
              line-height: 1.5;
            }
            h1, h2, h3, h4, h5, figure, p, ol, ul, pre {
              margin: 0;
            }
            ol[role="list"], ul[role="list"] {
              list-style: none;
              padding-inline: 0;
            }
            img {
              display: block;
              max-inline-size: 100%;
            }
            """
          )
        }
        style(self.styling)
        script(.src("https://cdn.jsdelivr.net/npm/alpinejs@3.14.8/dist/cdn.min.js"))
        script(.src("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"))
        script(.src("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/swift.min.js"))
        script { HTMLRaw("hljs.highlightAll();") }
      }
      body {
        header(.ariaLabel("About")) {
          hgroup {
            h1 { "Erik Bautista Santibanez" }
            p { "Swift & Web Developer" }

            let location = self.activityClient.location()
            let residency = location?.residency ?? .default

            p {
              span(.ariaLabel("Residency")) {
                svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .class("svg-icon"), .ariaLabel("Map pin icon")) {
                  path(
                    .d("M128,16a88.1,88.1,0,0,0-88,88c0,75.3,80,132.17,83.41,134.55a8,8,0,0,0,9.18,0C136,236.17,216,179.3,216,104A88.1,88.1,0,0,0,128,16Zm0,56a32,32,0,1,1-32,32A32,32,0,0,1,128,72Z")
                  )
                }
                "\(residency)"
              }

              if let location, location.city != residency.city || location.state != residency.state {
                " \u{2022} "

                span(.ariaLabel("Location")) {
                  svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .class("svg-icon reversed"), .ariaLabel("Navigation icon")) {
                    path(.d("M234.35,129,152,152,129,234.35a8,8,0,0,1-15.21.27l-65.28-176A8,8,0,0,1,58.63,48.46l176,65.28A8,8,0,0,1,234.35,129Z"))
                    path(.d("M237.33,106.21,61.41,41l-.16-.05A16,16,0,0,0,40.9,61.25a1,1,0,0,0,.05.16l65.26,175.92A15.77,15.77,0,0,0,121.28,248h.3a15.77,15.77,0,0,0,15-11.29l.06-.2,21.84-78,78-21.84.2-.06a16,16,0,0,0,.62-30.38ZM149.84,144.3a8,8,0,0,0-5.54,5.54L121.3,232l-.06-.17L56,56l175.82,65.22.16.06Z"))
                  }

                  "Currently in "

                  b {
                    [location.city, location.state, location.region == "United States" ? nil : location.region]
                      .compactMap(\.self)
                      .joined(separator: ", ")
                  }
                }
              }
            }
          }
        }
        main(.x.data("{ selection: undefined }")) {
          header {
            ul(.class("post-tabs")) {
              for kind in Post.Kind?.allCases {
                let value = if let kind {
                  "'\(kind.rawValue)'"
                } else {
                  "undefined"
                }
                li {
                  button(
                    .x.on(.click, "selection = \(value)"), 
                    .x.bind("aria-current", "selection == \(value) && 'tab'")
                  ) { 
                    kind?.tabTitle ?? "All"
                  }
                }
              }
            }
          }
          section {
            for post in Post.allCases {
              article(.class("post"), .x.show("!selection || selection == '\(post.kind.rawValue)'")) {
                header { post.dateFormatted }
                h3(.class("post-title")) { post.title }
                div(.class("post-content")) {
                  post.content
                }
              }
            }
          }
        }
        footer(.ariaLabel("Credits")) {
          hr()
          p { "©\(Self.copyrightDateFormatter.string(from: Date.now)) Erik Bautista Santibanez" }
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

struct Post {
  let slug: String
  var hero: Hero?
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

  enum Hero {
    case link(URL)
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

extension Post: CaseIterable {
  static var allCases: [Self] {
    [
      Self(
        slug: "swift-cascadia",
        title: "A Swift DSL for type-safe CSS",
        content: """
        Since I started building this website using Swift, I used [elementary](https://github.com/sliemeobn/elementary "link to Swift library") to build \
        HTML pages.

        ```swift
        func test() -> Int {
          print("Hey, there!")
          return 0
        }
        ```
        """,
        date: Date(timeIntervalSince1970: 1_738_483_200), // Feb 2, 2025
        kind: .project
      ),
      Self(
        slug: "anime-now",
        title: "Anime Now! \u{2014} An iOS and macOS App",
        content: """
        TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200), // Sep 15, 2025
        kind: .project
      ),
      Self(
        slug: "prism-ui",
        title: "PrismUI \u{2014} Controlling MSI RGB Keyboard on mac",
        content: """
        TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200),
        kind: .project
      ),
    ]
  }
}
