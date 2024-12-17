import Elementary

struct MainLayout<Page: HTML & Sendable>: Sendable, HTMLDocument {
  // Metadata
  var title: String
  var description: String?

  // Page render
  var page: @Sendable () -> Page

  var head: some HTML {
    meta(.charset(.utf8))
    if let description {
      meta(name: .description, content: description)
    }
    meta(name: .viewport, content: "width=device-width, initial-scale=1.0")
    script(.src("https://cdn.tailwindcss.com")) {}
  }

  var body: some HTML {
    div(.class("bg-neutral-800 text-white min-h-screen p-8 antialiased")) {
      div(.class("mx-auto flex h-full max-w-2xl flex-col gap-8")) {
        Header()
        main(.class("h-full flex-auto"), content: self.page)
        Footer()
      }
    }
  }

  private struct Header: Sendable, HTML {
    var content: some HTML {
      header(.class("z-50")) {
        nav(.class("flex flex-row")) {
          p(.class("text-3xl font-black")) { "<erik/>" }

          // TODO: List all routes
          // input(.id("menu-toggle"), .type(.checkbox), .hidden)
        }
      }
    }
  }

  private struct Footer: HTML {
    var content: some HTML {
      footer(.class("max-w-center-layout mt-auto w-full flex-initial text-xs")) {
        div(
          .class(
            "flex flex-col items-center gap-4 border-t border-neutral-500/20 pt-8 text-center font-semibold text-neutral-400 md:flex-row"
          )
        ) {
          p(.class("flex flex-wrap justify-center gap-1")) {
            "Designed and developed by"
            a(
              .class("flex items-center gap-1 font-bold md:ml-auto"),
              .href("https://erikbautista.dev")
            ) {
              "[redacted]"
            }
          }
          p(.class("flex flex-wrap justify-center items-center gap-2 md:ml-auto")) {
            "Made with <3 using"
            a(.target(.blank), .rel("noopener noreferrer"), .href("https://swift.org")) {
              "Swift"
            }
          }
        }
      }
    }
  }
}
