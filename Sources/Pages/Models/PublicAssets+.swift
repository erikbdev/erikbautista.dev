import Dependencies

private enum PublicAssetsKey: DependencyKey {
  static let liveValue = PublicAssets("/assets")
}

public extension DependencyValues {
  var publicAssets: PublicAssets {
    get { self[PublicAssetsKey.self] }
    set { self[PublicAssetsKey.self] = newValue }
  }
}