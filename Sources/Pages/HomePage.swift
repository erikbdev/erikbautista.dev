import Elementary

public struct HomePage: Page {
  public init() {}

  public var content: some SendableHTML {
    MainLayout(title: "erikbautista.dev") {
      div(.class("p-4 bg-neutral-700 rounded-lg border border-neutral-600")) {
        pre {
          code {
            """
            let portfolio = Portfolio(
              name: "Erik Bautista Santibanez's Portfolio",
              projects: [
                "Mochi",
                "AnimeNow",
                "Safer Together",
                "PrismUI"
              ]
            )
            """
          }
        }
      }
    }
  }
}
