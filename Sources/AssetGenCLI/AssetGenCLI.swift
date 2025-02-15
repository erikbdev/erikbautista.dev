import ArgumentParser
import Foundation

@main
struct AssetGenCLI: ParsableCommand {
  @Option(help: "Directory containing all files it should generate static")
  var directory: String

  @Option(help: "The path where the generated output will be created")
  var output: String

  func run() throws {
    let dir = URL(filePath: directory, directoryHint: .isDirectory)
    let outFile = URL(filePath: output, directoryHint: .notDirectory)

    let fileName = outFile.deletingPathExtension().lastPathComponent
    let fileExt = outFile.pathExtension

    guard fileExt == "swift" else {
      throw Error.swiftExtensionNotInOutfile
    }

    let items = Self.recursive(dir)

    try """
    public struct \(fileName.pascalCase()): Swift.Sendable {
      public let basePath: String
      public init(_ basePath: String = "/") {
        self.basePath = basePath
      }
    \(items.map { $0.code() }.joined(separator: "\n"))
      public struct AnyFile: Swift.Sendable {
        public let name: String
        public let ext: String
        public let path: String
      }
      public struct ImageFile: Swift.Sendable {
        public let name: String
        public let ext: String
        public let path: String
        public let mimeType = ""
      }
      public struct VideoFile: Swift.Sendable {
        public let name: String
        public let ext: String
        public let path: String
        public let width: Int = 0
        public let height: Int = 0
        public let format: String = ""
        public let mimeType = ""
      }
    }
    """
    .write(to: outFile, atomically: true, encoding: .utf8)

    print("Successfully parsed '\(dir)' and wrote to '\(outFile)'")
  }

  private enum Error: Swift.Error {
    case swiftExtensionNotInOutfile
  }

  private static func recursive(_ dir: URL) -> [FileOrDir] {
    guard let enumerator = try? FileManager.default.contentsOfDirectory(
      at: dir, 
      includingPropertiesForKeys: [.nameKey, .isDirectoryKey], 
      options: [.skipsHiddenFiles]
    ) else {
      return []
    }

    return enumerator.compactMap { url in
      let resourceValues = try? url.resourceValues(forKeys: [.isDirectoryKey])
      let isDirectory = resourceValues?.isDirectory ?? false

      if isDirectory {
        return .dir(
          canonical: url.lastPathComponent, 
          recursive(url)
        )
      } else {
        return .file(
          canonical: url.deletingPathExtension().lastPathComponent, 
          ext: url.pathExtension
        )
      }
    }
  }

  private enum FileOrDir {
    case dir(canonical: String, [Self])
    case file(canonical: String, ext: String)

    func code(_ indent: Int = 2, path: [String] = []) -> String {
      switch self {
        case let .dir(canonical, items):
          """
          \(String(repeating: " ", count: indent))public var `\(canonical.camelCase())`: \(canonical.pascalCase()) {
          \(String(repeating: " ", count: indent))  \(canonical.pascalCase())(basePath: self.basePath)
          \(String(repeating: " ", count: indent))}
          \(String(repeating: " ", count: indent))public struct \(canonical.pascalCase()): Swift.Sendable {
          \(String(repeating: " ", count: indent))  fileprivate let basePath: String
          \(items.map { $0.code(indent + 2, path: path + [canonical]) }.joined(separator: "\n"))
          \(String(repeating: " ", count: indent))}
          """
        case let .file(canonical, ext):
          """
          \(String(repeating: " ", count: indent))public var `\(canonical.camelCase())`: AnyFile {
          \(String(repeating: " ", count: indent))  AnyFile(
          \(String(repeating: " ", count: indent))    name: "\(canonical)", 
          \(String(repeating: " ", count: indent))    ext: "\(ext)",
          \(String(repeating: " ", count: indent))    path: "\\(self.basePath)/\((path + ["\(canonical).\(ext)"]).joined(separator: "/"))"
          \(String(repeating: " ", count: indent))  )
          \(String(repeating: " ", count: indent))}
          """
      }
    }
  }
}

private extension String {
  func pascalCase() -> Self {
    self.split { !$0.isLetter && !$0.isNumber }
    .map {
      if let first = $0.first?.uppercased() {
        return first[...] + $0.dropFirst()
      } else {
        return $0
      }
    }
    .joined()
  }

  func camelCase() -> Self {
    var initialLowercased = false
    return self.split { !$0.isLetter && !$0.isNumber }
      .map {
        if !initialLowercased {
          defer { initialLowercased = true }
          if let first = $0.first?.lowercased() {
            return first[...] + $0.dropFirst()
          } else {
            return $0.lowercased()[...]
          }
        } else if let first = $0.first?.uppercased() {
          return first[...] + $0.dropFirst()
        } else {
          return $0
        }
      }
      .joined()
  }
}