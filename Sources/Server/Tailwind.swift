#if DEBUG
  import SwiftyTailwind
  import TSCBasic

  func tailwind() async throws {
    guard let cwd = localFileSystem.currentWorkingDirectory else {
      throw TailwindGenerationError.cwdNotFound
    }

    let version = TailwindVersion.fixed("3.4.16")
    let tailwind = SwiftyTailwind(
      version: version,
      directory: cwd.appending(components: ".build", "SwiftyTailwind")
    )

    try await tailwind.run(
      input: cwd.appending(components: "Resources", "app.css"),
      output: cwd.appending(components: "Public", "styles", "app.generated.css"),
      options: .minify, .content("Sources/Pages/**/*.swift")
    )
  }

  private enum TailwindGenerationError: Error {
    case cwdNotFound
  }
#endif
