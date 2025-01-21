import ArgumentParser
import Dependencies
import Hummingbird

public enum AppEnv: String, Codable, ExpressibleByArgument {
  case development
  case production
}

private enum EnvKeys {
  static let appSecret = "APP_SECRET"
}

extension Environment {
  var appSecret: String {
    self.get(EnvKeys.appSecret, as: String.self) ?? "deadbeefdeadbeefdeadbeefdeadbeef"
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
