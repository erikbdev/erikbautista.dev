import Elementary
import Models

public struct ProjectPage: Page {
  let project: Project

  public init(project: Project) {
    self.project = project
  }

  public var content: some SendableHTML {
    MainLayout(title: self.project.title) {
      EmptyHTML()
    }
  }
}
