import ActivityClient
import Cascadia
import Dependencies
import Elementary
import Foundation

public struct HomePage: Page {
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
    html(.lang("en"), .data("theme", value: "dark")) {
      head {
        title { "Erik Bautista Santibanez" }
        meta(.charset(.utf8))
        meta(name: .viewport, content: "width=device-width, initial-scale=1.0")
        link(.rel(.stylesheet), .href("https://cdnjs.cloudflare.com/ajax/libs/modern-normalize/3.0.1/modern-normalize.min.css"))
        style { HTMLRaw(".xml .hljs-meta{color:#6C7986}.hljs-comment,.hljs-quote{color:#6C7986}.hljs-tag,.hljs-attribute,.hljs-keyword,.hljs-selector-tag,.hljs-literal,.hljs-name{color:#FC5FA3}.hljs-variable,.hljs-template-variable{color:#FC5FA3}.hljs-code,.hljs-string,.hljs-meta-string{color:#FC6A5D}.hljs-regexp,.hljs-link{color:#5482FF}.hljs-title,.hljs-symbol,.hljs-bullet,.hljs-number{color:#41A1C0}.hljs-section,.hljs-meta{color:#FC5FA3}.hljs-class .hljs-title,.hljs-type,.hljs-built_in,.hljs-builtin-name,.hljs-params{color:#D0A8FF}.hljs-attr{color:#BF8555}.hljs-subst{color:#FFF}.hljs-formula{font-style:italic}.hljs-selector-id,.hljs-selector-class{color:#9b703f}.hljs-doctag,.hljs-strong{font-weight:bold}.hljs-emphasis{font-style:italic}") }
        style(self.styling)
        script(.src("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"))
        script(.src("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/swift.min.js"))
        script { HTMLRaw("hljs.highlightAll();") }
        VueScript()
      }
      body {
        // TODO: Add header to switch between posts and something else?
        main {
          UserHero()
          PostsSection()
        }
        footer(.aria.label("Credits"), .style("text-align: center;")) {
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

  private struct UserHero: HTML {
    @Dependency(\.activityClient) private var activityClient

    var content: some HTML {
      section(.class("hero container"), .aria.label("About")) {
        p(.class("file-name")) { "User.swift" }
        hgroup(.class("container-content")) {
          // h1(.class("hero-title")) { "Erik Bautista Santibanez" }
          // p(.class("hero-subtitle")) { "Mobile & Web Developer" }
          // p { location }

          pre {
            code(.data("highlighted", value: "yes"), .class("hljs language-swift")) {
              span(.class("hljs-comment")) { "/// User.swift\n" }
              span(.class("hljs-comment")) { "/// Portfolio\n" }
              span(.class("hljs-comment")) { "/// \n" }
              span(.class("hljs-keyword")) { "struct" }
              " "
              span(.class("hljs-title class_")) { "User" }
              ": "
              span(.class("hljs-title class_")) { "Portfolio" }
              " {\n"
              span(.class("hljs-keyword")) { HTMLRaw("&nbsp;&nbsp;var") }
              " body: "
              span(.class("hljs-keyword")) { "some" }
              " "
              span(.class("hljs-type")) { "Description" }
              " { \n"
              span(.class("hljs-type")) { HTMLRaw("&nbsp;&nbsp;&nbsp;&nbsp;Name") }
              "("
              span(.class("hero-title hljs-string")) { "\"Erik Bautista Santibanez\"" }
              ")\n"
              span(.class("hljs-type")) { HTMLRaw("&nbsp;&nbsp;&nbsp;&nbsp;Role") }
              "("
              span(.class("hero-subtitle hljs-string")) { "\"Mobile & Web Developer\"" }
              ")\n"
              span(.class("hljs-type")) { HTMLRaw("&nbsp;&nbsp;&nbsp;&nbsp;Home") }
              "("
              span(.class("hero-location hljs-string")) { "\""; self.residency; "\"" }
              ")\n"
              location
              HTMLRaw("&nbsp;&nbsp;}\n")
              "}"
            }
          }
        }
      }
    }

    @HTMLBuilder
    var residency: some HTML {
      let location = self.activityClient.location()
      let residency = location?.residency ?? .default

      svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .class("svg-icon"), .aria.label("Map pin icon")) {
        path(
          .d("M128,16a88.1,88.1,0,0,0-88,88c0,75.3,80,132.17,83.41,134.55a8,8,0,0,0,9.18,0C136,236.17,216,179.3,216,104A88.1,88.1,0,0,0,128,16Zm0,56a32,32,0,1,1-32,32A32,32,0,0,1,128,72Z")
        )
      }
      "\(residency)"
    }

    @HTMLBuilder
    var location: some HTML {
      let location = self.activityClient.location()
      let residency = location?.residency ?? .default

      if let location, location.city != residency.city || location.state != residency.state {
        span(.class("hljs-type")) { HTMLRaw("&nbsp;&nbsp;&nbsp;&nbsp;Location") }
        "(\""
        span(.class("hero-location"), .aria.label("Location")) {
          svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .class("svg-icon reversed"), .aria.label("Navigation icon")) {
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
        "\")\n"
      } else {
        EmptyHTML()
      }
    }
  }

  private struct PostsSection: HTML {
    var content: some HTML {
      section(.class("container"), .v.scope("{ selection: undefined }")) {
        header {
          p(.class("file-name")) { "Posts.swift" }
          hgroup(.class("container-content")) {
            h2 { "Posts" }
            ul(.class("post-tabs")) {
              for kind in Post.Kind?.allCases {
                let value = if let kind {
                  "'\(kind.rawValue)'"
                } else {
                  "undefined"
                }
                li {
                  button(
                    .class("post-tab"),
                    .v.on(.click, "selection = \(value)"),
                    .v.bind("aria-selected", "selection == \(value)"),
                    .aria.selected(kind == nil)
                  ) {
                    kind?.tabTitle ?? "All"
                  }
                }
              }
            }
          }
        }

        section(.class("container-content")) {
          for post in Post.allCases {
            article(
              .class("post"),
              .v.show("!selection || selection == '\(post.kind.rawValue)'")
            ) {
              header(.class("post-date")) { post.dateFormatted }
              h3(.class("post-title")) { post.title }
              section(.class("post-content")) { post.content }
            }
          }
        }
      }
    }
  }
}

extension HomePage {
  struct Style: @unchecked Sendable, StyleSheet {
    var body: some Rule {
      self.resetStyles()
      self.generalStyles()
      self.heroStyles()
      self.postTabsStyles()
      self.postStyles()
    }

    // MARK: - Reset components

    @CSSBuilder func resetStyles() -> some Rule {
      Pseudo(class: .root) => {
        AnyProperty("line-height", "1.5")
      }

      "h1, h2, h3, h4, h5, figure, p, ol, ul, pre" => {
        AnyProperty("margin", "0")
      }

      "ol[role=\"list\"], ul[role=\"list\"]" => {
        AnyProperty("list-style", "none")
        AnyProperty("padding-inline", "0")
      }

      Element(.img) => {
        AnyProperty("display", "block")
        AnyProperty("max-inline-size", "100%")
      }
    }

    @CSSBuilder func generalStyles() -> some Rule {
      // TODO: Add Work-Sans font?

      // MARK: - General

      "@font-face" => {
        AnyProperty("font-family", "\"CommitMono\"")
        AnyProperty("src", "url(\"https://raw.githubusercontent.com/eigilnikolajsen/commit-mono/ecd81cdbd7f7eb2acaaa2f2f7e1a585676f9beff/src/fonts/fontlab/CommitMonoV143-VF.woff2\")")
        AnyProperty("font-style", "normal")
        AnyProperty("font-weight", "400")
        AnyProperty("font-display", "swap")
      }

      Pseudo(class: .root) => {
        BackgroundColor("#1c1c1c")
        Color("#fafafa")
        AnyProperty("font-optical-sizing", "auto")
        AnyProperty("font-style", "normal")
      }

      Element(.body) => {
        // AnyProperty("margin-top", "2rem")
        // AnyProperty("margin-bottom", "3rem")
      }

      Element(.body) > All() => {
        AnyProperty("max-width", "40rem")
        AnyProperty("margin-right", "auto")
        AnyProperty("margin-left", "auto")
      }

      Class("container") => {
        AnyProperty("border-top", "1px solid #303030")
        AnyProperty("border-left", "1px solid #303030")
        AnyProperty("border-right", "1px solid #303030")
      }

      Class("container-content") => {
        // AnyProperty("padding-top", "1.25rem")
        AnyProperty("padding-left", "1.5rem")
        AnyProperty("padding-right", "1.5rem")
      }

      Class("file-name") => {
        Color("#777")
        AnyProperty("text-align", "end")
        AnyProperty("font-size", "0.75em")
        AnyProperty("font-weight", "500")
        AnyProperty("font-family", "\"CommitMono\", monospace")
        AnyProperty("padding", "0.5rem 1.5rem 0.5rem 1.5rem")
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

      Element(.code) => {
        AnyProperty("font-family", "\"CommitMono\", monospace")
        AnyProperty("font-feature-settings", "\"ss03\", \"ss04\", \"ss05\"")
        AnyProperty("line-height", "1")
      }
    }

    @CSSBuilder func heroStyles() -> some Rule {
      // MARK: - Hero header

      Class("hero") => {
        AnyProperty("padding-bottom", "1.5rem")
        AnyProperty("font-size", "0.9em")
      }

      // ".hero-title, .hero-subtitle, .hero-location" => {
      //   // AnyProperty("all", "revert")
      //   AnyProperty("display", "inline")
      //   AnyProperty("font-family", "system-ui, 'Seggoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji'")
      // }
      

      Class("hero-location") => {
        Color(.hex("#D0D0D0"))
      }
    }

    @CSSBuilder func postTabsStyles() -> some Rule {
      Class("post-tabs") => {
        AnyProperty("list-style-type", "none")
        AnyProperty("margin", "0")
        AnyProperty("padding", "0")
        AnyProperty("overflow", "hidden")
      }

      Class("post-tabs") > Element(.li) => {
        AnyProperty("float", "left")
        AnyProperty("margin-right", "0.25rem")
      }

      Class("post-tab") => {
        BackgroundColor("#3c3c3c")
        AnyProperty("color", "white")
        AnyProperty("border-color", "#505050")
        AnyProperty("border-radius", "9999px")
        AnyProperty("border-style", "solid")
        AnyProperty("border-width", "1.25px")
        AnyProperty("padding", "0.25rem 0.75rem")
      }

      Class("post-tab") <> .attr("aria-selected", match: .exact, value: "true") => {
        AnyProperty("background-color", "#F0F0F0")
        AnyProperty("color", "#101010")
        AnyProperty("border-color", "#A0A0A0")
      }
    }

    @CSSBuilder func postStyles() -> some Rule {
      // MARK: - Posts

      Class("post") => {
        AnyProperty("margin-top", "0.75rem")
        AnyProperty("margin-bottom", "1.5rem")
        // AnyProperty("border-bottom", "1px dotted #404040")
      }

      Class("post-date") => {
        Color("#9A9A9A")
        AnyProperty("font-size", "0.75em")
        AnyProperty("font-weight", "600")
      }

      Class("post-title") => {
        AnyProperty("margin-top", "0.5rem")
      }

      Class("post-content") * All() => {
        AnyProperty("margin", "revert")
      }

      Class("post") * Element(.pre) => {
        AnyProperty("padding", "0.75rem")
        Background("#242424")
        AnyProperty("border-color", "#3A3A3A")
        AnyProperty("border-style", "solid")
        AnyProperty("border-width", "1.5px")
        AnyProperty("border-radius", "0.5rem")
        AnyProperty("overflow-x", "auto")
        AnyProperty("font-size", "0.85em")
      }
    }
  }
}
