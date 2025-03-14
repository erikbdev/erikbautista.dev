import ActivityClient
import Dependencies
import Foundation
import HTML
import Models
import Vue

public struct HomePage: Page { 
  public let title = "Erik Bautista Santibanez | Portfolio"
  public let lang = "en"

  let initialCodeLang: CodeLang

  public init(codeLang: CodeLang = .swift) {
    self.initialCodeLang = codeLang
  }

  public var head: some HTML { EmptyHTML() }

  public var body: some HTML {
    #VueScope(initialCodeLang) { codeLang in
      HeaderView(selected: codeLang)
      main {
        Spacer()
        UserView(selected: codeLang)
        Spacer()
        PostsView(selected: codeLang)
        Spacer()
      }
      FooterView()
    }
    .inlineStyle("overflow-x", "hidden")
  }
}

private struct UserView: HTML {
  @Dependency(\.activityClient) private var activityClient

  let selected: Vue.Expression<CodeLang>

  var location: ActivityClient.Location? {
    self.activityClient.location()
  }

  var residency: ActivityClient.Location.Residency? {
    self.location?.residency
  }

  var currentLocation: String? {
    let residency = self.residency ?? .default
    guard let location, location.city != residency.city || location.state != residency.state else {
      return nil
    }
    return [location.city, location.state, location.region == "United States" ? nil : location.region]
      .compactMap(\.self)
      .joined(separator: ", ")
  }

  @HTMLBuilder
  var body: some HTML {
    SectionView(id: "user", selectedCodeLang: selected) { lang in
      switch lang {
        case .swift: 
        """
        let user = User(
          name: "Erik Bautista Santibanez",
          role: "Mobile & Web Developer",
          home: "\(residency ?? .default)"\
          \(currentLocation.flatMap { ",\n  location: \"Currently in \($0)\"" } ?? "")
        )
        """
        case .typescript: 
        """
        const user = {
          name: "Erik Bautista Santibanez",
          role: "Mobile & Web Developer",
          home: "\(residency ?? .default)"\
          \(currentLocation.flatMap { ",\n  location: \"Currently in \($0)\"" } ?? "")
        };
        """
        case .rust: 
        """
        let user = Portfolio {
          name: "Erik Bautista Santibanez",
          role: "Mobile & Web Developer",
          home: "\(residency ?? .default)"\
          \(currentLocation.flatMap { ",\n  location: \"Currently in \($0)\"" } ?? "")
        }
        """
      }
    } content: {
      EmptyHTML()
    }
  }

  //   svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .aria.label("Map pin icon")) {
  //     path(
  //       .d("M128,16a88.1,88.1,0,0,0-88,88c0,75.3,80,132.17,83.41,134.55a8,8,0,0,0,9.18,0C136,236.17,216,179.3,216,104A88.1,88.1,0,0,0,128,16Zm0,56a32,32,0,1,1-32,32A32,32,0,0,1,128,72Z")
  //     )
  //   }
  //   .svgIconStyling()

  //   svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .aria.label("Navigation icon")) {
  //     path(.d("M234.35,129,152,152,129,234.35a8,8,0,0,1-15.21.27l-65.28-176A8,8,0,0,1,58.63,48.46l176,65.28A8,8,0,0,1,234.35,129Z"))
  //     path(.d("M237.33,106.21,61.41,41l-.16-.05A16,16,0,0,0,40.9,61.25a1,1,0,0,0,.05.16l65.26,175.92A15.77,15.77,0,0,0,121.28,248h.3a15.77,15.77,0,0,0,15-11.29l.06-.2,21.84-78,78-21.84.2-.06a16,16,0,0,0,.62-30.38ZM149.84,144.3a8,8,0,0,0-5.54,5.54L121.3,232l-.06-.17L56,56l175.82,65.22.16.06Z"))
  //   }
  //   .inlineStyle("scale", "calc(100% * -1) 100%")
  //   .svgIconStyling()
}

private struct PostsView: HTML {
  let selected: Vue.Expression<CodeLang>
  var body: some HTML {
    SectionView(id: "dev-logs", selectedCodeLang: selected) { lang in
      switch lang {
        case .swift: 
        """
        let logs: [DevLog] = await fetch(.all)
        """
        case .typescript: 
        """
        const logs = await fetch(Filter.All)
        """
        case .rust: 
        """
        let logs = fetch(Filter::All).await
        """
      }
    } content: {
      for (num, post) in Post.allCases.enumerated().reversed() {
        PostView(number: num, post: post)
      }
    }
  }

  struct PostView: HTML {
    let number: Int
    let post: Post

    var body: some HTML {
      article(
        .id(self.post.slug)
        // ,
        // .v.show("!selection || selection == '\(self.post.kind.rawValue)'")
      ) {
        header {
          section {
            span { self.post.datePosted.uppercased() }
              .inlineStyle("flex-grow", "1")
              .inlineStyle("color", "#9A9A9A")
              .inlineStyle("font-size", "0.75em")
              .inlineStyle("font-weight", "600")

            pre {
              a(.href("#\(self.post.slug)")) {
                code(.class("hljs language-swift")) {
                  "logs[\(self.number)]"
                }
              }
              .inlineStyle("font-size", "0.75em")
              .inlineStyle("color", "#777")
              .inlineStyle("font-weight", "500")
            }
          }
          .inlineStyle("display", "flex")
          .inlineStyle("align-items", "baseline")

          if let postHeader = post.header {
            PostHeaderView(postHeader: postHeader)
          }
        }
        h3 { self.post.title }
          .inlineStyle("margin-top", "0.5rem")

        section {
          self.post.content
        }
        .postCodeBlockStyling()
        .inlineStyle("margin", "revert", post: " *")
        .inlineStyle("display", "block", post: " blockquote")
        .inlineStyle("background", "#2A2A2A", post: " blockquote")
        .inlineStyle("padding", "0.125rem 1rem", post: " blockquote")
        .inlineStyle("border", "1.5px solid #4A4A4A", post: " blockquote")
        .inlineStyle("border-radius", "0.125rem", post: " blockquote")
        .inlineStyle("margin-left", "0", post: " blockquote")
        .inlineStyle("margin-right", "0", post: " blockquote")

        if !self.post.links.isEmpty {
          section {
            for link in self.post.links {
              PostLinkView(link: link)
            }
          }
          .inlineStyle("display", "flex")
          .inlineStyle("gap", "0.75rem")
          .inlineStyle("margin-top", "1.5rem")
        }
      }
      .inlineStyle("width", "100%")
      .inlineStyle("display", "inline-block")
      .inlineStyle("padding", "1.5rem")
      .inlineStyle("background-image", "repeating-linear-gradient(90deg,#444 0 15px,transparent 0 30px)")
      .inlineStyle("background-repeat", "repeat-x")
      .inlineStyle("background-size", "100% 1px")
    }
  }

  struct PostHeaderView: HTML {
    let postHeader: Post.Header

    var body: some HTML {
      section {
        switch self.postHeader {
        case let .link(link):
          a(
            .href(link),
            .target(.blank),
            .rel("noopener noreferrer")
          ) {
            figure {
              // TODO: add OpenGraph link
            }
          }
        case let .image(asset, label):
          img(.src(asset.url.assetString), .custom(name: "alt", value: label), .aria.label(label))
        case let .video(asset):
          video(
            .custom(name: "autoplay", value: ""),
            .custom(name: "playsinline", value: ""),
            .custom(name: "muted", value: ""),
            .custom(name: "controls", value: ""),
            .custom(name: "loop", value: "")
          ) {
            source(.src(asset.url.assetString), .custom(name: "type", value: asset.mime))
            "Your browser does not support playing this video"
          }
        case let .code(rawCode, lang):
          pre {
            code(.class("hljs language-\(lang.rawValue)")) {
              HTMLRaw(rawCode)
            }
          }
        }
      }
      .inlineStyle("width", "100%", post: " > *")
      .inlineStyle("margin-top", "1.25rem", post: " > *")
      .inlineStyle("margin-bottom", "1.25rem", post: " > *")
      .inlineStyle("border", "1.5px solid #3A3A3A", post: " > *")
      .inlineStyle("border-radius", "1rem", post: " > *")
      .postCodeBlockStyling()
    }
  }

  struct PostLinkView: HTML {
    let link: Post.Link

    @HTMLBuilder var body: some HTML {
      a(
        .href(self.link.href),
        .target(.blank),
        .rel("noopener noreferrer")
      ) {
        HTMLText(self.link.title)
        " "
        if self.link.isExternal {
          svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .aria.label("external link icon")) {
            path(
              .d("M228,104a12,12,0,0,1-24,0V69l-59.51,59.51a12,12,0,0,1-17-17L187,52H152a12,12,0,0,1,0-24h64a12,12,0,0,1,12,12Zm-44,24a12,12,0,0,0-12,12v64H52V84h64a12,12,0,0,0,0-24H48A20,20,0,0,0,28,80V208a20,20,0,0,0,20,20H176a20,20,0,0,0,20-20V140A12,12,0,0,0,184,128Z")
            )
          }
          .svgIconStyling()
        } else {
          svg(.xmlns(), .fill("currentColor"), .viewBox("0 0 256 256"), .aria.label("external link icon")) {
            path(
              .d("M224.49,136.49l-72,72a12,12,0,0,1-17-17L187,140H40a12,12,0,0,1,0-24H187L135.51,64.48a12,12,0,0,1,17-17l72,72A12,12,0,0,1,224.49,136.49Z")
            )
          }
          .svgIconStyling()
        }
      }
      .inlineStyle("all", "unset")
      .inlineStyle("font-size", "0.85em")
      .inlineStyle("font-weight", "550")
      .inlineStyle("align-content", "center")
      .inlineStyle("min-height", "1.5rem")
      .inlineStyle("min-width", "2rem")
      .inlineStyle("padding", "0.375rem 0.75rem")
      .inlineStyle("cursor", "pointer")
      .inlineStyle("border-radius", "0.5rem")
      .inlineStyle("color", self.link.role == .primary ? "white" : "black")
      .inlineStyle("background", self.link.role == .primary ? "linear-gradient(to bottom, hsla(0, 0%, 24%, 1), hsla(0, 0%, 16%, 1))" : "linear-gradient(to bottom, hsl(0deg 0% 100%), hsl(0deg 0% 92.91%))")
      .inlineStyle("box-shadow", self.link.role == .primary ? "inset 0 1px 1px rgba(255, 255, 255, 0.12)" : "inset 0px -1px 2px 0px hsl(0 0% 50% / 0.5)")
    }
  }
}

private extension HTML {
  func svgIconStyling() -> HTMLInlineStyle<Self> {
    self.inlineStyle("display", "inline-block")
      .inlineStyle("vertical-align", "middle")
      .inlineStyle("position", "relative")
      .inlineStyle("bottom", "0.125em")
      .inlineStyle("width", "1em")
      .inlineStyle("height", "1em")
  }

  func postCodeBlockStyling() -> HTMLInlineStyle<Self> {
    self.inlineStyle("padding", "0.75rem", post: " pre")
      .inlineStyle("background", "#242424", post: " pre")
      .inlineStyle("border", "1.5px solid #3A3A3A", post: " pre")
      .inlineStyle("border-radius", "0.75rem", post: " pre")
      .inlineStyle("overflow-x", "auto", post: " pre")
      .inlineStyle("font-size", "0.85em", post: " pre")
  }
}