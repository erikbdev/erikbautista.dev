import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct ActivityClient: Sendable {
  public var location: @Sendable () -> Location? = { nil }
  public var updateLocation: @Sendable (_ location: Location?) -> Void = { _ in }
  public var nowPlaying: @Sendable () -> NowPlaying? = { nil }
  public var updateNowPlaying: @Sendable (_ nowPlaying: NowPlaying?) -> Void = { _ in }
}

extension ActivityClient {
  public struct CurrentLocation: Sendable, Equatable, Codable {
    public let currentLocation: Location?
    public let residency: Location?
  }

  public struct Location: Sendable, Equatable, Codable {
    public let city: String?
    public let state: String?
    public let region: String?
    public let timestamp: Date

    public let residency: Residency?

    public struct Residency: Sendable, Equatable, Codable, CustomStringConvertible {
      public let city: String
      public let state: String
      public var description: String { "\(city), \(state)" }

      public static let `default` = Residency(city: "Irvine", state: "CA")
    }
  }

  public struct NowPlaying: Sendable, Equatable, Codable {
    public let name: String
    public let albumn: String?
    public let artist: String
    public let service: Service

    public enum Service: Sendable, Equatable, Codable {
      case appleMusic
      case spotify
    }
  }
}

extension ActivityClient: DependencyKey {
  public static var liveValue: ActivityClient {
    let state = LockIsolated((Location?.none, NowPlaying?.none))
    return ActivityClient(
      location: { state.value.0 }, 
      updateLocation: { newLocation in
        state.withValue { $0.0 = newLocation }
      },
      nowPlaying: { state.value.1 },
      updateNowPlaying: { nowPlaying in 
        state.withValue { $0.1 = nowPlaying} 
      }
    )
  }
}

public extension DependencyValues {
  var activityClient: ActivityClient {
    get { self[ActivityClient.self] }
    set { self[ActivityClient.self] = newValue }
  }
}
