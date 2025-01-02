import Dependencies
import Hummingbird

public enum AppEnv: String, Codable {
  case development
  case production
}

private enum EnvKeys {
  static let appEnv = "APP_ENV"
  static let port = "PORT"
}

extension Environment {
  var appEnv: AppEnv {
    self.get(EnvKeys.appEnv).flatMap(AppEnv.init(rawValue:)) ?? .development
  }

  var port: Int {
    self.get(EnvKeys.port, as: Int.self) ?? 8080
  }
}

private struct EnvironmentKey: TestDependencyKey {
  static let testValue = Environment()
}

extension DependencyValues {
  var envVar: Environment {
    get { self[EnvironmentKey.self] }
    set { self[EnvironmentKey.self] = newValue }
  }
}
