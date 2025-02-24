import Elementary

extension HTML where Tag: HTMLTrait.Attributes.Global {
  func wrappedStyling() -> _HTMLInlineStyle<Self> {
    self.inlineStyle("border-top", "1px solid #303030")
  }

  func containerStyling() -> _HTMLInlineStyle<Self> {
    self.inlineStyle("max-width", "40rem", media: .minWidth(688))
      .inlineStyle("margin-right", "auto")
      .inlineStyle("margin-left", "auto")
      .inlineStyle("border-left", "1px solid #303030", media: .minWidth(640))
      .inlineStyle("border-right", "1px solid #303030", media: .minWidth(640))
  }
}