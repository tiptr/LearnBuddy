class Ticker {
  const Ticker();
  Stream<int> tick({required int secs}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => secs - x - 1)
        .take(secs);
  }
}
