import Elementary

struct BlockSection<Content: HTML>: HTML {
  var fill: Bool = false
  var flush: Bool = false
  var extraClass: String = ""
  var id: String?
  @HTMLBuilder var content: Content

  var body: some HTML {
    section(.class(Self.classes(fill: fill, flush: flush, extra: extraClass))) {
      content
    }
    .attributes(.id(id ?? ""), when: id != nil)
  }

  static func classes(fill: Bool, flush: Bool, extra: String) -> String {
    var c = "block-section"
    if fill { c += " block-section--fill" }
    if flush { c += " block-section--flush" }
    if !extra.isEmpty { c += " \(extra)" }
    return c
  }
}

struct NavBlockSection<Content: HTML>: HTML {
  var fill: Bool = false
  var flush: Bool = false
  var extraClass: String = ""
  @HTMLBuilder var content: Content

  var body: some HTML {
    nav(.class(BlockSection<Content>.classes(fill: fill, flush: flush, extra: extraClass))) {
      content
    }
  }
}

struct Divider: HTML {
  var body: some HTML {
    section(.class("block-section-divider"))
  }
}
