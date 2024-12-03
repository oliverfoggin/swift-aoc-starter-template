extension Array {
  func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (_ partialResult: Result, _ nextValue: Element) -> Result,
    until predicate: (_ partialResult: Result, _ nextValue: Element) -> Bool
  ) -> Result {
    var result = initialResult

    for element in self {
      if predicate(result, element) {
        return result
      }
      result = nextPartialResult(result, element)
    }
    return result
  }
}
