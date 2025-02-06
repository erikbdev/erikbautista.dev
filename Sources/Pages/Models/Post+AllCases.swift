import Foundation

extension Post: CaseIterable {
  static var allCases: [Self] {
    [
      Self(
        slug: "swift-cascadia-released",
        title: "A Swift DSL for type-safe CSS",
        content: """
        Since I started building this website using Swift, I used [elementary](https://github.com/sliemeobn/elementary "link to Swift library") to build \
        HTML pages.
        """,
        date: Date(timeIntervalSince1970: 1_738_483_200), // Feb 2, 2025
        kind: .project
      ),
      Self(
        slug: "mochi-released",
        title: "Mochi \u{2014} Content Viewer for iOS and macOS",
        content: """
        TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200), // Sep 15, 2025
        kind: .project
      ),
      Self(
        slug: "anime-now-released",
        title: "Anime Now! \u{2014} An iOS and macOS App",
        content: """
        TBD
        """,
        date: Date(timeIntervalSince1970: 1_663_225_200), // Sep 15, 2025
        kind: .project
      ),
      Self(
        slug: "prism-ui-released",
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
