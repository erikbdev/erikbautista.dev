import Dependencies
import Hummingbird

private enum EnvKeys {
  static let appSecret = "APP_SECRET"
  static let basicAuthUsername = "BASIC_AUTH_USER"
  static let basicAuthPassword = "BASIC_AUTH_PASSWD"
}

public extension Environment {
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

public extension DependencyValues {
  var envVars: Environment {
    get { self[EnvironmentKey.self] }
    set { self[EnvironmentKey.self] = newValue }
  }
}