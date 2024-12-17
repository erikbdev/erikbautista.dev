// swift-tools-version:6.0

import PackageDescription

let package = Package(
  name: "Server",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .library(name: "Models", targets: ["Models"]),
    .library(name: "Routes", targets: ["Routes"]),
    .library(name: "Pages", targets: ["Pages"]),
    .executable(name: "Server", targets: ["Server"]),
  ],
  dependencies: [
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", exact: "2.5.0"),
    .package(url: "https://github.com/sliemeobn/elementary.git", exact: "0.4.3"),
    .package(url: "https://github.com/pointfreeco/swift-url-routing.git", exact: "0.6.2"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies.git", exact: "1.6.2"),
  ],
  targets: [
    .target(
      name: "Models",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "Routes",
      dependencies: [
        "Models",
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
        .product(name: "Elementary", package: "elementary"),
        .product(name: "Hummingbird", package: "hummingbird"),
      ]
    ),
    .executableTarget(
      name: "Server",
      dependencies: [
        "Models",
        "Routes",
        "Pages",
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HummingbirdRouter", package: "hummingbird"),
      ],
      resources: [.embedInCode("Resources")]
    ),
  ],
  swiftLanguageModes: [.v6]
)
