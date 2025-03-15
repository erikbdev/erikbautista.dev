import Foundation
import Dependencies
import PublicAssets

extension Post: CaseIterable {
  static var allCases: [Self] {
    @Dependency(\.publicAssets) var assetsDir

    return [
      Self(
        header: .video(assetsDir.assets.posts.wledAppDemo.videoWebm),
        title: "A WLED Client for iOS", 
        content: """
        I built a native iOS app for [WLED](https://github.com/wled/WLED), an open-source LED controller for ESP32, to control my RGB LED strips.
        """, 
        date: Date(month: 8, day: 4, year: 2022), 
        kind: .project
      ),
      Self(
        title: "PrismUI \u{2014} Controlling MSI RGB Keyboard on mac",
        content: """
        > TBD
        """,
        date: Date(month: 9, day: 15, year: 2024),
        kind: .project
      ),
      Self(
        header: .image(assetsDir.assets.posts.animeNowReleased.anDiscoverWebp, label: "Anime Now! discover image"),
        title: "Anime Now! \u{2014} An iOS and macOS App",
        content: """
        > TBD
        """,
        date: Date(month: 9, day: 15, year: 2024),
        kind: .project
      ),
      Self(
        title: "Mochi \u{2014} Content Viewer for iOS and macOS",
        content: """
        > TBD
        """,
        date: Date(month: 9, day: 15, year: 2024),
        kind: .project
      ),
      Self(
        header: .code(
          """
          struct Portfolio {
            var body: some HTML {
              HomePage()
            }
          }
          """,
          lang: .swift
        ),
        title: "Website Redesign",
        content: """
        I finally decided to redesign my website. \
        To expand my skills with Swift, I decided to rebuild my portfolio in Swift.

        Additionally, I built a library called [swift-web](https://github.com/erikbdev/swift-web) which contains tools used to build \
        this website in Swift. It utilizes Swift build tools to generate typed asset generation, and \
        utilities to build a reactive website using Swift and Vue.

        Feel free to check out both projects on GitHub. 😊
        """,
        date: Date(month: 2, day: 2, year: 2025),
        lastUpdated: Date(month: 3, day: 14, year: 2025),
        kind: .blog,
        links: [
          Post.Link(
            title: "Portfolio",
            href: "https://github.com/erikbdev/erikbautista.dev",
            role: .primary
          ),
          Post.Link(
            title: "swift-web",
            href: "https://github.com/erikbdev/swift-web",
            role: .secondary
          ),
        ]
      ),
    ]
    .sorted { $0.date < $1.date }
  }
}
