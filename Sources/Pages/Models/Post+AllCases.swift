import Foundation

extension Post: CaseIterable {
  static var allCases: [Self] {
    [
      Self(
        id: 1,
        title: "PrismUI \u{2014} Controlling MSI RGB Keyboard on mac",
        content: """
        > TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200),
        kind: .project
      ),
      Self(
        id: 2,
        header: .image("/assets/projects/anime-now/an-discover.png", label: "Anime Now! discover image"),
        title: "Anime Now! \u{2014} An iOS and macOS App",
        content: """
        > TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200), // Sep 15, 2025
        kind: .project
      ),
      Self(
        id: 3,
        title: "Mochi \u{2014} Content Viewer for iOS and macOS",
        content: """
        > TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200), // Sep 15, 2025
        kind: .project
      ),
      Self(
        id: 4,
        title: "Website Redesign!",
        content: """
        I finally decided to redesign my website. \
        To expand my skills with Swift, I decided to rebuild my portfolio in Swift.
        """,
        date: Date(timeIntervalSince1970: 1_738_483_200), // Feb 2, 2025
        kind: .blog,
        links: [
          Post.Link(
            title: "GitHub",
            href: "https://github.com/errorerrorerror/erikbautista.dev",
            role: .primary
          ),
        ]
      ),
    ]
  }
}
