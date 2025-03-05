import Foundation
import Dependencies
import PublicAssets

extension Post: CaseIterable {
  static var allCases: [Self] {
    @Dependency(\.publicAssets) var assets

    return [
      Self(
        header: .video(assets.assets.posts.wledAppDemoMp4),
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
        header: .image(assets.assets.projects.animeNow.anDiscoverPng, label: "Anime Now! discover image"),
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
        """,
        date: Date(month: 2, day: 2, year: 2025),
        kind: .blog,
        links: [
          Post.Link(
            title: "GitHub",
            href: "https://github.com/erikbdev/erikbautista.dev",
            role: .primary
          ),
        ]
      ),
    ]
    .sorted { $0.date < $1.date }
  }
}
