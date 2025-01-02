import Elementary

public struct Token: Hashable, Codable {
  public var text: String
  public var className: String?

  public init(_ text: String, className: String?) {
    self.text = text
    self.className = className
  }

  @HTMLBuilder
  public var html: some HTML & Sendable {
    if let className {
      span(.class(className)) {
        HTMLText(self.text)
      }
    } else {
      HTMLText(self.text)
    }
  }
}
