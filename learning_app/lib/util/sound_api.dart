import 'package:audioplayers/audioplayers.dart';

class SoundApi {
  static final _audioPlayer = AudioCache(fixedPlayer: AudioPlayer());

  static Future playTimerDone() async {
    await _audioPlayer.play('audio/sound_alarm.mp3', volume: 1.0);
  }

  static Future cancelSound() async {
    await _audioPlayer.fixedPlayer!.stop();
  }
}
