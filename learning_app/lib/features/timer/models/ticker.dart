import 'package:quiver/async.dart';


class Ticker {
  const Ticker();
  Stream<int> tick({required int secs}) {
    DateTime now = DateTime.now();
    return Metronome.periodic(const Duration(seconds: 1)).map<int>((t) => secs - t.difference(now).inSeconds);

  }
}
