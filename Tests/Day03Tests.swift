  import Testing

  @testable import AdventOfCode

  @Suite("Day03 Tests")
  struct Day03Tests {
  @Suite("Parser Tests")
  struct ParserTests {
    @Test("Test parser implementation")
    func parseInput() {
      //
    }
  }

  @Suite("Tests on sample inputs")
  struct SolutionsTests {
    @Suite("Tests on sample inputs")
    struct SolutionsTests {
      let day = Day03(data: testInput)

      @Test("Part1 example")
      func testPart1() async throws {
        await withKnownIssue {
          let result = try await day.part1()
          #expect(result == 10)
        }
      }

      @Test("Part2 example")
      func testPart2() async throws {
        await withKnownIssue {
          let result = try await day.part2()
          #expect(result == 10)
        }
      }
    }
  }
}

private let testInput =
  """
  """
