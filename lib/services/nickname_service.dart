import 'package:hive/hive.dart';

class Nickname {
  final _nicknameBox = Hive.box('nicknameBox');

  void writeNickname(String nickname) {
    _nicknameBox.put(1, nickname);
  }

  String readNickname() {
    return _nicknameBox.get(1);
  }
}
