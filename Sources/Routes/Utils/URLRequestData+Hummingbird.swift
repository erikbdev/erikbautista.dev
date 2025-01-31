import struct URLRouting.URLRequestData
import struct Hummingbird.Request
import struct HTTPTypes.HTTPFields
import struct Foundation.Data
import struct NIO.ByteBuffer

public extension URLRequestData {
  init(request: Hummingbird.Request) async {
    var body: ByteBuffer?
    do {
      for try await var buffer in request.body {
        body = body ?? ByteBuffer()
        body?.writeBuffer(&buffer)
      }
    } catch {
      body = nil
    }

    self.init(
      method: request.method.rawValue,
      scheme: request.uri.scheme?.rawValue,
      user: request.headers.basicAuthorization?.0,
      password: request.headers.basicAuthorization?.1,
      host: request.uri.host,
      port: request.uri.port,
      path: request.uri.path,
      query: request.uri.queryParameters.reduce(into: [:]) { dict, item in
        dict[String(item.key), default: []].append(String(item.value))
      },
      fragment: request.uri.string.range(of: "#").flatMap { range in
        String(request.uri.string[request.uri.string.index(after: range.lowerBound)...])
      },
      headers: .init(
        request.headers.map { field in
          (
            field.name.canonicalName,
            field.value.components(separatedBy: ",")
          )
        },
        uniquingKeysWith: { $0 + $1 }
      ),
      body: body.flatMap { Data(buffer: $0) }
    )
  }
}

extension HTTPFields {
  public var basicAuthorization: (String, String)? {
    if let string = self[.authorization] {
      let headerParts = string
        .split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)

      guard headerParts.count == 2 else {
        return nil
      }
      guard headerParts[0].lowercased() == "basic" else {
        return nil
      }
      guard let decodedToken = Data(base64Encoded: String(headerParts[1])) else {
        return nil
      }
      let parts = String(decoding: decodedToken, as: UTF8.self)
        .split(separator: ":", maxSplits: 1, omittingEmptySubsequences: false)
      guard parts.count == 2 else {
        return nil
      }
      return (String(parts[0]), String(parts[1]))
    } else {
      return nil
    }
  }
}
