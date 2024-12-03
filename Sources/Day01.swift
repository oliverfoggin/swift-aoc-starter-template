import Foundation
@preconcurrency import Parsing

struct Day01: AdventDay, Sendable {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  let day = 0
  let puzzleName: String = "--- Day 1: Historian Hysteria ---"

  init(data: String) {
    self.data = data
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() async throws -> Int {
    let lists = self.lists

    return zip(lists.0.sorted(), lists.1.sorted())
      .map { abs($0 - $1) }
      .reduce(0, +)
  }

  func part2() async throws -> Int {
    let lists = self.lists

    let rightListCount: [Int: Int] = lists.1.reduce(into: [:]) { partialResult, i in
      partialResult[i] = partialResult[i, default: 0] + 1
    }

    return lists.0.reduce(0) { partialResult, i in
      partialResult + i * rightListCount[i, default: 0]
    }
  }

  var lists: ([Int], [Int]) {
    do {
      return try Parsers.input.parse(data)
        .reduce(into: ([], [])) { partialResult, input in
          partialResult.0.append(input.0)
          partialResult.1.append(input.1)
        }
    } catch {
      return ([], [])
    }
  }
}

// Add any extra code and types in here to separate it from the required behaviour
extension Day01 {
  enum Parsers {
    static let input = Many {
      Parse(input: Substring.self) {
        Int.parser()
        Whitespace(3, .horizontal)
        Int.parser()
      }
    } separator: {
      Whitespace(1, .vertical)
    } terminator: {
      Whitespace(1, .vertical)
    }
  }
}
