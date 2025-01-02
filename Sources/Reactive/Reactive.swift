
/// WIP: Generate Javascript-like code for Alpine.js?
public protocol Reactive {
  associatedtype AllReactivePaths

  /// A collection of all reactive paths
  static var allReactivePaths: AllReactivePaths { get }
}

private struct Counter: Reactive {
  let counter = 0
  let showModal = false
  let nested = NestedState()
  let array = [0, 1, 2]

  struct AllReactivePaths: Sequence {
    let counter = AnyReactivePath(\Counter.counter, "counter")
    let showModal = AnyReactivePath(\Counter.showModal, "showModal")
    let nested = AnyReactivePath(\Counter.nested, "nested")
    let array = AnyReactivePath(\Counter.array, "array")

    func makeIterator() -> [PartialKeyPath<Self>].Iterator {
      var allReactivePaths: [PartialKeyPath<Self>] = []
      allReactivePaths.append(\.counter)
      allReactivePaths.append(\.showModal)
      allReactivePaths.append(\.nested)
      allReactivePaths.append(\.array)
      return allReactivePaths.makeIterator()
    }
  }

  static var allReactivePaths: AllReactivePaths { AllReactivePaths() }

  struct NestedState: Reactive {
    let value = 0
    let hm = "Hello"

    struct AllReactivePaths: Sequence {
      let value = AnyReactivePath(\NestedState.value, "value")
      let hm = AnyReactivePath(\NestedState.hm, "hm")

      func makeIterator() -> [PartialKeyPath<Self>].Iterator {
        var allReactivePaths: [PartialKeyPath<Self>] = []
        allReactivePaths.append(\.hm)
        allReactivePaths.append(\.value)
        return allReactivePaths.makeIterator()
      }
    }

    static var allReactivePaths: AllReactivePaths { AllReactivePaths() }
  }
}

func testReactivePath() {
  let paths = Counter.allReactivePaths
  _ = paths.counter
  _ = paths.showModal
  _ = paths.nested.hm
}
