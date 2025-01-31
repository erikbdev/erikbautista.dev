import ArgumentParser
import Dependencies
import Hummingbird

public enum AppEnv: String, Codable, ExpressibleByArgument {
  case development
  case production
}

private enum EnvKeys {
  static let appSecret = "APP_SECRET"
  static let basicAuthUsername = "BASIC_AUTH_USER"
  static let basicAuthPassword = "BASIC_AUTH_PASSWD"
}

extension Environment {
  var appSecret: String {
    self.get(EnvKeys.appSecret) ?? "deadbeefdeadbeefdeadbeefdeadbeef"
  }

  var basicAuth: (String, String) {
    (self.get(EnvKeys.basicAuthUsername) ?? "dead", self.get(EnvKeys.basicAuthPassword) ?? "beef")
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
