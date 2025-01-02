import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct ActivityClient: Sendable {
  public var currentLocation: @Sendable () -> Location? = { nil }
  public var setCurrentLocation: @Sendable (_ location: Location?) -> Void = { _ in }
  public var nowPlaying: @Sendable () -> NowPlaying? = { nil }
  public var setNowPlaying: @Sendable (_ nowPlaying: NowPlaying?) -> Void = { _ in }
}

public extension ActivityClient {
  struct Location: Sendable, Equatable, Codable {
    public let city: String?
    public let state: String?
    public let region: String?
    public let timestamp: Date
  }

  struct NowPlaying: Sendable, Equatable, Codable {
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
      currentLocation: { state.value.0 }, 
      setCurrentLocation: { newLocation in
        state.withValue { $0.0 = newLocation }
      },
      nowPlaying: { state.value.1 },
      setNowPlaying: { nowPlaying in 
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
