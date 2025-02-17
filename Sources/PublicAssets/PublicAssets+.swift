import Dependencies
import struct Foundation.URL

private enum PublicAssetsKey: DependencyKey {
  static let liveValue = GeneratedPublicAssets()
}

public extension DependencyValues {
  var publicAssets: GeneratedPublicAssets {
    get { self[PublicAssetsKey.self] }
    set { self[PublicAssetsKey.self] = newValue }
  }
}

public extension URL {
  var assetString: String {
    if self.isFileURL {
      "/" + self.relativeString
    } else {
      self.absoluteString
    }
  }
}