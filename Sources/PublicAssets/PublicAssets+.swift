import Dependencies

import struct Foundation.URL

private enum PublicAssetsKey: DependencyKey {
  static let liveValue = GeneratedPublicAssets()
}

extension DependencyValues {
  public var publicAssets: GeneratedPublicAssets {
    get { self[PublicAssetsKey.self] }
    set { self[PublicAssetsKey.self] = newValue }
  }
}

extension URL {
  public var assetString: String {
    if self.isFileURL {
      "/" + self.relativeString
    } else {
      self.absoluteString
    }
  }
}
