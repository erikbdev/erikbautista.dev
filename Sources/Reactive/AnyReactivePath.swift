
@dynamicMemberLookup
public struct AnyReactivePath<Root, Value> {
  let keyPath: KeyPath<Root, Value>
  var path: [String]

  public init(
    _ keyPath: KeyPath<Root, Value>,
    _ path: String
  ) {
    self.keyPath = keyPath
    self.path = [path]
  }

  private init(
    _ keyPath: KeyPath<Root, Value>,
    _ path: [String]
  ) {
    self.keyPath = keyPath
    self.path = path
  }
}

public extension AnyReactivePath where Value: Reactive {
  subscript<AppendedPath>(
    dynamicMember keyPath: KeyPath<Value.AllReactivePaths, AnyReactivePath<Value, AppendedPath>>
  ) -> AnyReactivePath<Root, AppendedPath> {
    let appended = Value.allReactivePaths[keyPath: keyPath]
    return AnyReactivePath<Root, AppendedPath>(
      self.keyPath.appending(path: appended.keyPath),
      self.path + appended.path
    )
  }
}
