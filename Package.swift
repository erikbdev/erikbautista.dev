// swift-tools-version:6.0.3

import PackageDescription

let package = Package(
  name: "portfolio",
  platforms: [
    .macOS(.v13),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.4.0"),
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", exact: "2.5.0"),
    .package(url: "https://github.com/sliemeobn/elementary.git", exact: "0.4.3"),
    .package(url: "https://github.com/pointfreeco/swift-url-routing.git", exact: "0.6.2"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies.git", exact: "1.6.2"),
    .package(url: "https://github.com/errorerrorerror/swift-cascadia", revision: "a13dfd0a3818c8f9368bbd4aeb3c6607f68838bd"),
    .package(url: "https://github.com/swiftlang/swift-markdown.git", revision: "e62a44fd1f2764ba8807db3b6f257627449bbb8c")
  ],
  targets: [
    .executableTarget(
      name: "AssetGenCLI",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]
    ),
    .plugin(
      name: "AssetGenPlugin", 
      capability: .buildTool(),
      dependencies: [
        .target(name: "AssetGenCLI")
      ]
    ),
    .target(
      name: "PublicAssets",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
      ],
      resources: [.copy("assets")],
      plugins: ["AssetGenPlugin"]
    ),
    .target(
      name: "Models",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .target(
      name: "ActivityClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
      ]
    ),
    .target(
      name: "Routes",
      dependencies: [
        "Models",
        "ActivityClient",
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "URLRouting", package: "swift-url-routing"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HummingbirdRouter", package: "hummingbird"),
      ]
    ),
    .target(
      name: "Pages",
      dependencies: [
        "Models",
        "ActivityClient",
        "PublicAssets",
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "Elementary", package: "elementary"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "Cascadia", package: "swift-cascadia"),
        .product(name: "Markdown", package: "swift-markdown")
      ]
    ),

    /// Executable
    .executableTarget(
      name: "App",
      dependencies: [
        "Models",
        "Routes",
        "Pages",
        "ActivityClient",
        "PublicAssets",
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HummingbirdRouter", package: "hummingbird"),
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ],
      resources: [.embedInCode("Resources")]
    ),
  ],
  swiftLanguageModes: [.v6]
)

package.targets
  .filter { $0.type != .binary && $0.type != .plugin }
  .forEach {
    $0.swiftSettings = [
      .unsafeFlags([
        "-Xfrontend",
        "-warn-long-function-bodies=100",
        "-Xfrontend",
        "-warn-long-expression-type-checking=100"
      ])
    ]
  }