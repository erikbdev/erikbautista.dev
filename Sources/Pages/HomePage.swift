import ActivityClient
import Dependencies
import Foundation
import HTML
import Models
import Vue

public struct HomePage: Page {
  public let title = "Portfolio | Erik Bautista Santibanez"

  let initialCodeLang: CodeLang?

  public init(codeLang: CodeLang? = .swift) {
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

  let selected: Vue.Expression<CodeLang?>

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
    return [
      location.city, location.state, location.region == "United States" ? nil : location.region,
    ]
    .compactMap(\.self)
    .joined(separator: ", ")
  }

  var nowPlaying: String? {
    guard let nowPlaying = activityClient.nowPlaying() else {
      return nil
    }
    
    let nowPlayingText = [
      nowPlaying.title,
      nowPlaying.artist?.isEmpty == false ? "—" : nil,
      nowPlaying.artist
    ]
    .compactMap { $0 }
    .joined(separator: " ")
    return nowPlayingText
  }

  static let aboutDescription = """
    I'm a passionate software developer who builds applications using Swift and modern web technologies.
    """

  @HTMLBuilder
  var body: some HTML {
    SectionView(id: "user", selected: selected) { lang in
      switch lang {
      case .swift:
        """
        let user = User(
          name: "Erik Bautista Santibanez",
          role: "Mobile & Web Developer",
          home: "\(residency ?? .default)"\
        \(currentLocation.flatMap { ",\n  location: \"Currently in \($0)\"" } ?? "")\
        \(nowPlaying.flatMap { ",\n  listeningTo: \"\($0)\"" } ?? "")
        )

        > print(user.about())
        // \(Self.aboutDescription)
        """
      case .typescript:
        """
        const user: User = {
          name: "Erik Bautista Santibanez",
          role: "Mobile & Web Developer",
          home: "\(residency ?? .default)"\
        \(currentLocation.flatMap { ",\n  location: \"Currently in \($0)\"" } ?? "")\
        \(nowPlaying.flatMap { ",\n  listeningTo: \"\($0)\"" } ?? "")
        };

        > console.log(user.about());
        // \(Self.aboutDescription)
        """
      case .rust:
        """
        let user = User {
          name: "Erik Bautista Santibanez",
          role: "Mobile & Web Developer",
          home: "\(residency ?? .default)"\
        \(currentLocation.flatMap { ",\n  location: \"Currently in \($0)\"" } ?? "")\
        \(nowPlaying.flatMap { ",\n  listeningTo: \"\($0)\"" } ?? "")
        };

        > println!("{}", user.about());
        // \(Self.aboutDescription)
        """
      case .none:
        h1(.aria.label("name")) {
          span { "#" }
            .inlineStyle("color", "#808080")
            .inlineStyle("font-weight", "700")
          " "
          "Erik Bautista Santibanez"
        }
        .inlineStyle("margin-bottom", "0.25rem")

        HTMLGroup {
          p(.aria.label("occupation")) { "Mobile & Web Developer" }

          p(.aria.label("residency")) {
            svg(
              .xmlns(),
              .fill("currentColor"),
              .viewBox("0 0 256 256"),
              .aria.label("Map pin icon")
            ) {
              path(
                .d(
                  "M128,16a88.1,88.1,0,0,0-88,88c0,75.3,80,132.17,83.41,134.55a8,8,0,0,0,9.18,0C136,236.17,216,179.3,216,104A88.1,88.1,0,0,0,128,16Zm0,56a32,32,0,1,1-32,32A32,32,0,0,1,128,72Z"
                )
              )
            }
            .svgIconStyling()
            .inlineStyle("margin-right", "0.25rem")

            "\(residency ?? .default)"
          }

          if let currentLocation {
            p(.aria.label("current location")) {
              svg(
                .xmlns(),
                .fill("currentColor"),
                .viewBox("0 0 256 256"),
                .aria.label("Navigation icon")
              ) {
                path(
                  .d(
                    "M234.35,129,152,152,129,234.35a8,8,0,0,1-15.21.27l-65.28-176A8,8,0,0,1,58.63,48.46l176,65.28A8,8,0,0,1,234.35,129Z"
                  )
                )
                path(
                  .d(
                    "M237.33,106.21,61.41,41l-.16-.05A16,16,0,0,0,40.9,61.25a1,1,0,0,0,.05.16l65.26,175.92A15.77,15.77,0,0,0,121.28,248h.3a15.77,15.77,0,0,0,15-11.29l.06-.2,21.84-78,78-21.84.2-.06a16,16,0,0,0,.62-30.38ZM149.84,144.3a8,8,0,0,0-5.54,5.54L121.3,232l-.06-.17L56,56l175.82,65.22.16.06Z"
                  )
                )
              }
              .inlineStyle("scale", "calc(100% * -1) 100%")
              .svgIconStyling()
              .inlineStyle("margin-right", "0.25rem")

              "Currently in "

              // span { "***" }
              //   .inlineStyle("color", "#808080")
              //   .inlineStyle("font-weight", "700")
              em { currentLocation }
                .inlineStyle("font-weight", "700")
                .inlineStyle("color", "#fafafa")
              // span { "***" }
              //   .inlineStyle("color", "#808080")
              //   .inlineStyle("font-weight", "700")
            }
          }

          if let nowPlaying {
            p(.aria.label("music playing")) {
              // <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#000000" viewBox="0 0 256 256"><path d=""></path></svg>
              svg(
                .xmlns(),
                .fill("currentColor"),
                .viewBox("0 0 256 256"),
                .aria.label("wave icon")
              ) {
                path(
                  .d(
                    "M56,96v64a8,8,0,0,1-16,0V96a8,8,0,0,1,16,0ZM88,24a8,8,0,0,0-8,8V224a8,8,0,0,0,16,0V32A8,8,0,0,0,88,24Zm40,32a8,8,0,0,0-8,8V192a8,8,0,0,0,16,0V64A8,8,0,0,0,128,56Zm40,32a8,8,0,0,0-8,8v64a8,8,0,0,0,16,0V96A8,8,0,0,0,168,88Zm40-16a8,8,0,0,0-8,8v96a8,8,0,0,0,16,0V80A8,8,0,0,0,208,72Z"
                  )
                )
              }
              .inlineStyle("scale", "calc(100% * -1) 100%")
              .svgIconStyling()
              .inlineStyle("margin-right", "0.25rem")

              "Listening to "

              // span { "***" }
                // .inlineStyle("color", "#808080")
                // .inlineStyle("font-weight", "700")
              em { nowPlaying }
                .inlineStyle("font-weight", "700")
                .inlineStyle("color", "#fafafa")
              // span { "***" }
                // .inlineStyle("color", "#808080")
                // .inlineStyle("font-weight", "700")
            }
          }

          p(.aria.label("about me")) {
            Self.aboutDescription
          }
          .inlineStyle("margin-top", "0.75rem")
        }
        .inlineStyle("color", "#d8d8d8")
      }
    } content: {
      div {
        div {
          a(.href("mailto:me@erikb.dev")) {
            ConditionalCodeLabel(
              label: "email",
              value: "me@erikb.dev",
              selected: selected
            )
          }
          .primaryButtonStyle()

          a(
            .href("https://github.com/erikbdev"),
            .target(.blank),
            .rel("noopener noreferrer")
          ) {
            ConditionalCodeLabel(
              label: "github",
              value: "/erikbdev",
              selected: selected
            )
          }
          .secondaryButtonStyle()

          a(
            .href("https://www.linkedin.com/in/erikbautista"),
            .target(.blank),
            .rel("noopener noreferrer")
          ) {
            ConditionalCodeLabel(
              label: "linkedin",
              value: "/erikbautista",
              selected: selected
            )
          }
          .secondaryButtonStyle()
        }
        .inlineStyle("display", "flex")
        .inlineStyle("flex-direction", "row")
        .inlineStyle("flex-wrap", "wrap")
        .inlineStyle("gap", "0.625rem")
      }
      .inlineStyle("margin-top", "-1rem")
      .inlineStyle("padding", "0 1.5rem 1.5rem")
    }
  }

  struct ConditionalCodeLabel: HTML {
    let label: String
    let value: String
    let selected: Vue.Expression<CodeLang?>

    var body: some HTML {
      CodeLang.conditionalCases(initial: selected) { lang in
        code {
          if let lang {
            "user.\(label)()\(lang.hasSemiColon ? ";" : "")"
          } else {
            "[\(label)](\(value))"
          }
        }
      }
    }
  }
}

private struct PostsView: HTML {
  let selected: Vue.Expression<CodeLang?>

  static let description = "A curated list of projects I've worked on."

  var body: some HTML {
    SectionView(id: "dev-logs", selected: selected) { lang in
      switch lang {
      case .swift:
        """
        // \(Self.description)
        let logs: [DevLog] = await fetch(.all)
        """
      case .typescript:
        """
        // \(Self.description)
        const logs = await fetch(Filter.All);
        """
      case .rust:
        """
        // \(Self.description)
        let logs = fetch(Filter::All).await;
        """
      case .none:
        h1 {
          span { "#" }
            .inlineStyle("color", "#808080")
            .inlineStyle("font-weight", "700")
          " "
          "Dev Logs"
        }
        .inlineStyle("margin-bottom", "0.25rem")

        HTMLGroup {
          p { Self.description }
        }
        .inlineStyle("color", "#d8d8d8")
      }
    } content: {
      for (num, post) in Post.allCases.enumerated().reversed() {
        PostView(number: num, post: post, selected: selected)
      }
    }
  }

  struct PostView: HTML {
    let number: Int
    let post: Post
    let selected: Vue.Expression<CodeLang?>

    var body: some HTML {
      article(.id(self.post.slug)) {
        header {
          hgroup {
            span { self.post.datePosted.uppercased() }
              .inlineStyle("flex-grow", "1")
              .inlineStyle("color", "#9A9A9A")
              .inlineStyle("font-size", "0.75em")
              .inlineStyle("font-weight", "600")

            pre {
              a(.href("#\(self.post.slug)")) {
                CodeLang.conditionalCases(initial: selected) { lang in
                  code(.class("hljs \("language-\(lang?.rawValue ?? "markdown")")")) {
                    switch lang {
                      case .none: "log-\(self.number).md"
                      case .some: "logs[\(self.number)]"
                    }
                  }
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
        .inlineStyle("margin-left", "0", post: " blockquote")
        .inlineStyle("margin-right", "0", post: " blockquote")

        footer {
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

          if let dateUpdated = self.post.dateUpdated {
            p {
              em {
                "Last updated: \(dateUpdated)"
              }
            }
            .inlineStyle("color", "#7A7A7A")
            .inlineStyle("font-size", "0.73em")
            .inlineStyle("margin-top", "0.75rem")
          }
        }
      }
      .inlineStyle("width", "100%")
      .inlineStyle("display", "inline-block")
      .inlineStyle("padding", "1.5rem")
      .inlineStyle(
        "background-image",
        "repeating-linear-gradient(90deg,#444 0 15px,transparent 0 30px)"
      )
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
          svg(
            .xmlns(),
            .fill("currentColor"),
            .viewBox("0 0 256 256"),
            .aria.label("external link icon")
          ) {
            path(
              .d(
                "M228,104a12,12,0,0,1-24,0V69l-59.51,59.51a12,12,0,0,1-17-17L187,52H152a12,12,0,0,1,0-24h64a12,12,0,0,1,12,12Zm-44,24a12,12,0,0,0-12,12v64H52V84h64a12,12,0,0,0,0-24H48A20,20,0,0,0,28,80V208a20,20,0,0,0,20,20H176a20,20,0,0,0,20-20V140A12,12,0,0,0,184,128Z"
              )
            )
          }
          .svgIconStyling()
        } else {
          svg(
            .xmlns(),
            .fill("currentColor"),
            .viewBox("0 0 256 256"),
            .aria.label("external link icon")
          ) {
            path(
              .d(
                "M224.49,136.49l-72,72a12,12,0,0,1-17-17L187,140H40a12,12,0,0,1,0-24H187L135.51,64.48a12,12,0,0,1,17-17l72,72A12,12,0,0,1,224.49,136.49Z"
              )
            )
          }
          .svgIconStyling()
        }
      }
      .buttonStyle(isPrimary: self.link.role == .primary)
    }
  }
}

extension HTML {
  fileprivate func svgIconStyling() -> HTMLInlineStyle<Self> {
    self.inlineStyle("display", "inline-block")
      .inlineStyle("vertical-align", "middle")
      .inlineStyle("position", "relative")
      .inlineStyle("bottom", "0.125em")
      .inlineStyle("width", "1em")
      .inlineStyle("height", "1em")
  }

  fileprivate func postCodeBlockStyling() -> HTMLInlineStyle<Self> {
    self.inlineStyle("padding", "0.75rem", post: " pre")
      .inlineStyle("background", "#242424", post: " pre")
      .inlineStyle("border", "1.5px solid #3A3A3A", post: " pre")
      .inlineStyle("overflow-x", "auto", post: " pre")
      .inlineStyle("font-size", "0.85em", post: " pre")
  }

  fileprivate func primaryButtonStyle() -> HTMLInlineStyle<Self> {
    self.inlineStyle("all", "unset")
      .inlineStyle("padding", "0.5rem 0.625rem")
      .inlineStyle("border", "#444 1px solid")
      .inlineStyle("font-size", "0.8em")
      .inlineStyle("font-weight", "500")
      .inlineStyle("align-items", "center")
      .inlineStyle("cursor", "pointer")
  }

  fileprivate func secondaryButtonStyle() -> HTMLInlineStyle<Self> {
    self.primaryButtonStyle()
      .inlineStyle("background-color", "#f0f0f0")
      .inlineStyle("color", "#0f0f0f")
  }

  fileprivate func buttonStyle(isPrimary: Bool = true) -> HTMLInlineStyle<Self> {
    if isPrimary {
      self.primaryButtonStyle()
    } else {
      self.secondaryButtonStyle()
    }
  }
}
