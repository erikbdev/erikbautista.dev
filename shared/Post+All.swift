import Foundation

extension Post: CaseIterable {
  public static let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "MM-dd-yyyy"
    f.timeZone = TimeZone(identifier: "UTC")
    return f
  }()

  private static func date(_ string: String) -> Date {
    Self.dateFormatter.date(from: string) ?? .now
  }

  public static var allCases: [Post] {
    let now = Date.now
    return Post.all
      .filter {
        #if DEBUG
        true
        #else
        $0.date <= now
        #endif
      }
  }

  private static let all: [Post] = [
    Post(
      title: "PrismUI — Controlling MSI RGB Keyboard on macOS",
      date: date("08-08-2021"),
      kind: .project,
      content: """
        # PrismUI — Controlling MSI RGB Keyboard on macOS

        When I configured my Hackintosh, I was unable to control the RGB keyboard on my MSI laptop due to the software only being supported on Windows. To resolve this issue, my first approach was to build an app using AppKit, C++, and Objective-C to communicate with the HID keyboard, which was ultimately called [SSKeyboardHue](https://github.com/erikbdev/SSKeyboardHue).

        Later, I decided to switch the communication protocol to Swift and redesign the front end using SwiftUI.

        Both projects are available on GitHub — feel free to check them out!
        """,
      links: [
        Link(label: "PrismUI on GitHub", href: "https://github.com/erikbdev/PrismUI", role: .primary),
        Link(label: "SSKeyboardHue on GitHub", href: "https://github.com/erikbdev/SSKeyboardHue", role: .secondary),
      ],
    ),
    Post(
      title: "A WLED Client for iOS",
      date: date("08-04-2022"),
      kind: .project,
      header: .video(src: "/posts/wled-app-demo/video.webm", label: "WLED App Demo"),
      content: """
        # A WLED Client for iOS

        I built a native iOS app for [WLED](https://github.com/wled/WLED), an open-source LED controller for ESP32, to control my RGB LED strips.
        """
    ),
    Post(
      title: "Anime Now! — An iOS and macOS App",
      date: date("09-15-2022"),
      kind: .project,
      header: .image(src: "/posts/anime-now-released/an-discover.webp", label: "Anime Now! discover image"),
      content: """
        # Anime Now! — An iOS and macOS App
        """
    ),
    Post(
      title: "Mochi — Content Viewer for iOS and macOS",
      date: date("12-10-2023"),
      kind: .project,
      content: """
          # Mochi — Content Viewer for iOS and macOS
        """,
      links: [
        Link(label: "Mochi Website", href: "https://mochi.erikb.dev", role: .primary)
      ],
      hidden: true,
    ),
    Post(
      title: "Website Redesign",
      date: date("02-02-2025"),
      kind: .blog,
      header: .code(
        lang: "swift",
        value: """
          struct Portfolio: HTML {
            var body: some HTML {
              HomePage()
            }
          }
          """
      ),
      content: """
        # Website Redesign

        I redesigned my website, but instead of using traditional web frameworks, I used Swift! I've also built a library called [swift-web](https://github.com/erikbdev/swift-web) which contains tools used to build this website.

        Feel free to check out both projects on GitHub. 😊
        """,
      links: [
        Link(label: "Portfolio on GitHub", href: "https://github.com/erikbdev/erikbautista.dev", role: .primary),
        Link(label: "swift-web on GitHub", href: "https://github.com/erikbdev/swift-web", role: .secondary),
      ],
    ),
    Post(
      title: "xtool is Awesome!",
      date: date("07-20-2025"),
      kind: .blog,
      content: """
        # xtool is Awesome!

        [xtool](https://github.com/xtool-org/xtool) is a tool that attempts to replace Xcode by using Swift Package Manager to build and deploy iOS apps on macOS, Linux, and Windows! I have been working closely with the developer to support for App Extensions and also resolve additional issues.

        I hope to also replace "AppleProductTypes", a library used to build iOS and macOS apps using Swift Playgrounds, in favor of "XToolProductTypes."
        """,
      links: [
        Link(label: "xtool on GitHub", href: "https://github.com/xtool-org/xtool", role: .primary)
      ],
    ),
    Post(
      title: "An Interactive Portfolio Over SSH",
      date: date("07-01-2026"),
      kind: .blog,
      content: """
        # An Interactive Portfolio Over SSH

        I've been working with [swift-nio-ssh](https://github.com/apple/swift-nio-ssh) to build an interactive, terminal-based version of this portfolio that you can access straight from your terminal. It renders a full TUI experience over an SSH connection using Swift.

        Give it a try:

        ```bash
        $ ssh erikb.dev
        ```
        """,
      links: [
        Link(label: "erikb.dev on GitHub", href: "https://github.com/erikbdev/erikb.dev", role: .primary),
        Link(label: "swift-nio-ssh on GitHub", href: "https://github.com/apple/swift-nio-ssh", role: .secondary),
      ],
    ),
  ]
  .sorted { $0.date < $1.date }
  .reduce(into: [Post]()) { acc, post in
    guard !post.hidden else {
      return
    }

    var post = post
    post.index = acc.count + 1 
    post.id = post.title.lowercased().split { !$0.isLetter && !$0.isNumber }
      .joined(separator: "-")
    acc.append(post)
  }
  .reversed()
}

extension Post {
  public var formattedDate: String {
    Self.dateFormatter.string(from: self.date)
  }
}
