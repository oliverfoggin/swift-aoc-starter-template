import Foundation
@preconcurrency import Parsing

struct Day02: AdventDay, Sendable {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  let day = 0
  let puzzleName: String = "--- Day 2: Red-Nosed Reports! ---"

  init(data: String) {
    self.data = data
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() async throws -> Int {
    let reports = try Parsers.InputParser().parse(data)

    return reports.count(where: \.isSafe)
  }

  func part2() async throws -> Int {
    let reports = try Parsers.InputParser().parse(data)

    return reports.count(where: \.canBeSafe)
  }
}

private extension Array<Int> {
  var isSafe: Bool {
    zip(self, zip(dropFirst(), dropFirst().dropFirst()))
      .map { pair -> (Int, Int) in
        (pair.0 - pair.1.0, pair.1.0 - pair.1.1)
      }
      .reduce(true) { partialResult, diffPair -> Bool in
        partialResult
        && (1...3).contains(abs(diffPair.0))
        && (1...3).contains(abs(diffPair.1))
        && (diffPair.0 < 0) == (diffPair.1 < 0)
      } until: { partialResult, _ in
        !partialResult
      }
  }
}

// Add any extra code and types in here to separate it from the required behaviour
extension Day02 {
  struct Report {
    let values: [Int]

    init(values: [Int]) {
      self.values = values
    }

    var isSafe: Bool {
      values.isSafe
    }

    var canBeSafe: Bool {
      for i in values.indices {
        var newValues = values
        newValues.remove(at: i)

        if newValues.isSafe {
          return true
        }
      }

      return false
    }
  }

  enum Parsers {
    struct ReportParser: Parser {
      var body: some Parser<Substring, Report> {
        Parse(Report.init) {
          Many(1...) {
            Int.parser()
          } separator: {
            " "
          } terminator: {
            "\n"
          }
        }
      }
    }

    struct InputParser: Parser {
      var body: some Parser<Substring, [Report]> {
        Many {
          ReportParser()
        }
      }
    }
  }
}
