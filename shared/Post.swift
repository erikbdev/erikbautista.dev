import Foundation

public struct Post: Sendable, Identifiable, Equatable {
  public var id: String = ""
  public var index: Int = 0
  public var title: String
  public var date: Date
  public var kind: Kind
  public var header: Header? = nil
  public var content: String
  public var links: [Link] = []
  public var hidden: Bool = false

  public enum Kind: String, Sendable, Equatable {
    case project
    case blog
  }

  public enum Header: Sendable, Equatable {
    case image(src: String, label: String)
    case video(src: String, label: String)
    case code(lang: String, value: String)
    case link(href: String)
  }

  public struct Link: Sendable, Equatable {
    public var label: String
    public var href: String
    public var role: Role

    init(label: String, href: String, role: Role = .primary) {
      self.label = label
      self.href = href
      self.role = role
    }

    public enum Role: String, Sendable, Equatable {
      case primary
      case secondary
    }
  }
}
