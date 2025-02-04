import Elementary
import Markdown

private struct HTMLMarkdownConverter: MarkupVisitor {
  typealias Result = AnyHTML

  @HTMLBuilder
  mutating func defaultVisit(
    _ markup: any Markup
  ) -> AnyHTML {
    for child in markup.children {
      visit(child)
    }
  }

  @HTMLBuilder
  mutating func visitBlockDirective(_ blockDirective: BlockDirective) -> AnyHTML {
    // switch blockDirective
    for child in blockDirective.children {
      visit(child)
    }
  }

  @HTMLBuilder
  mutating func visitBlockQuote(_ blockQuote: BlockQuote) -> AnyHTML {
    let aside = Aside(blockQuote)
    blockquote {
      strong { aside.kind.displayName }

      for child in aside.content {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitCodeBlock(_ codeBlock: CodeBlock) -> AnyHTML {
    let language = codeBlock.language.map {
      let languageInfo = $0.split(separator: ":", maxSplits: 2)
      let language = languageInfo[0]
      let dataLine = languageInfo.dropFirst().first
      let highlightColor = languageInfo.dropFirst(2).first
      return (
        class: "language-\(language)\(highlightColor.map { " highlight-\($0)" } ?? "")",
        dataLine: dataLine.map { String($0) }
      )
    }

    // TODO: Style code blocks
    pre {
      let attributes: [HTMLAttribute<HTMLTag.code>] = if let language {
        [.class(language.class), language.dataLine.flatMap { .data("line", value: $0) }]
          .compactMap(\.self)
      } else {
        []
      }
      code(attributes: attributes) {
        HTMLText(codeBlock.code)
      }
    }
  }

  @HTMLBuilder
  mutating func visitEmphasis(_ emphasis: Emphasis) -> AnyHTML {
    em {
      for child in emphasis.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitHeading(_ heading: Heading) -> AnyHTML {
    switch heading.level {
    case 1: h1 {
        for child in heading.children {
          visit(child)
        }
      }
    case 2: h2 {
        for child in heading.children {
          visit(child)
        }
      }
    case 3: h3 {
        for child in heading.children {
          visit(child)
        }
      }
    case 4: h4 {
        for child in heading.children {
          visit(child)
        }
      }
    case 5: h5 {
        for child in heading.children {
          visit(child)
        }
      }
    case 6: h6 {
        for child in heading.children {
          visit(child)
        }
      }
    default: p {
        for child in heading.children {
          visit(child)
        }
      }
    }
  }

  @HTMLBuilder
  mutating func visitHTMLBlock(_ html: HTMLBlock) -> AnyHTML {
    HTMLRaw(html.rawHTML)
  }

  @HTMLBuilder
  mutating func visitImage(_ image: Image) -> AnyHTML {
    if let source = image.source {
      a(.href(source), .target(.blank), .rel("noopener noreferrer")) {
        img(.src(source), .ariaLabel(image.title ?? ""))
      }
    }
  }

  @HTMLBuilder
  mutating func visitInlineCode(_ inlineCode: InlineCode) -> AnyHTML {
    code {
      HTMLText(inlineCode.code)
    }
  }

  @HTMLBuilder
  mutating func visitInlineHTML(_ inlineHTML: Markdown.InlineHTML) -> AnyHTML {
    HTMLRaw(inlineHTML.rawHTML)
  }

  @HTMLBuilder
  mutating func visitLineBreak(_ lineBreak: Markdown.LineBreak) -> AnyHTML {
    br()
  }

  @HTMLBuilder
  mutating func visitLink(_ link: Markdown.Link) -> AnyHTML {
    let href = link.destination ?? "/"
    let isLocalLink = href.hasPrefix("/") || href.hasPrefix("#")
    let attributes: [HTMLAttribute<HTMLTag.a>] = [
      .href(href),
      link.title.flatMap { .title($0) },
      link.title.flatMap { .ariaLabel($0) },
      isLocalLink ? nil : .target(.blank),
      isLocalLink ? nil : .rel("noopener noreferrer")
    ]
    .compactMap(\.self)

    a(attributes: attributes) {
      for child in link.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitListItem(_ listItem: Markdown.ListItem) -> AnyHTML {
    li {
      for child in listItem.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitOrderedList(_ orderedList: Markdown.OrderedList) -> AnyHTML {
    ol {
      for child in orderedList.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitParagraph(_ paragraph: Markdown.Paragraph) -> AnyHTML {
    p {
      for child in paragraph.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitSoftBreak(_ softBreak: Markdown.SoftBreak) -> AnyHTML {
    softBreak.plainText
  }

  @HTMLBuilder
  mutating func visitStrikethrough(_ strikethrough: Markdown.Strikethrough) -> AnyHTML {
    s {
      for child in strikethrough.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitStrong(_ strong: Markdown.Strong) -> AnyHTML {
    Elementary.strong {
      for child in strong.children {
        visit(child)
      }
    }
  }

  @HTMLBuilder
  mutating func visitTable(_ table: Markdown.Table) -> AnyHTML {
    Elementary.table {
      if !table.head.isEmpty {
        thead {
          tr {
            self.render(
              tag: HTMLTag.td.self, 
              cells: table.head.cells, 
              columnAlignments: table.columnAlignments
            )
          }
        }
      }
      if !table.body.isEmpty {
        tbody {
          for row in table.body.rows {
            tr {
              self.render(
                tag: HTMLTag.td.self, 
                cells: row.cells, 
                columnAlignments: table.columnAlignments
              )
            }
          }
        }
      }
    }
  }

  @HTMLBuilder
  private mutating func render<Tag: HTMLTrait.Paired>(
    tag: Tag.Type = Tag.self,
    cells: some Sequence<Markdown.Table.Cell>,
    columnAlignments: [Markdown.Table.ColumnAlignment?]
  ) -> AnyHTML {
    var column = 0
    for cell in cells {
      if cell.colspan > 0, cell.rowspan > 0 {
        HTMLElement<Tag, AnyHTML> {
          for child in cell.children {
            visit(child)
          }
        }
        // .attribute("align", columnAlignments[column]?.attributeValue)
        // .attribute("colspan", cell.colspan == 1 ? nil : "\(cell.colspan)")
        // .attribute("rowspan", cell.rowspan == 1 ? nil : "\(cell.rowspan)")
        let _ = column += Int(cell.colspan)
      }
    }
  }

  @HTMLBuilder
  mutating func visitText(_ text: Markdown.Text) -> AnyHTML {
    HTMLText(text.string)
  }

  @HTMLBuilder
  mutating func visitThematicBreak(_ thematicBreak: Markdown.ThematicBreak) -> AnyHTML {
    div {
      hr()
    }
  }

  @HTMLBuilder
  mutating func visitUnorderedList(_ unorderedList: Markdown.UnorderedList) -> AnyHTML {
    ul {
      for child in unorderedList.children {
        visit(child)
      }
    }
  }
}

struct HTMLMarkdown: HTML, ExpressibleByStringLiteral {
  let markdown: String
  let content: AnyHTML

  init(_ markdown: String) {
    self.markdown = markdown
    var converter = HTMLMarkdownConverter()
    self.content = converter.visit(Document(parsing: markdown))
  }

  init(stringLiteral value: StringLiteralType) {
    self.init(value)
  }
}

private extension HTMLBuilder {
  @_disfavoredOverload
  static func buildExpression(_ expression: any HTML) -> AnyHTML {
    AnyHTML(expression)
  }

  @_disfavoredOverload
  static func buildFinalResult(_ component: some HTML) -> AnyHTML {
    AnyHTML(component)
  }
}
