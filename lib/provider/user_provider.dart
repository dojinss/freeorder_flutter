import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class UserProvider extends ChangeNotifier {
  String? _usersId;

  // getter
  String get getUsersId => _usersId ?? '';

  // 저장소
  final storage = const FlutterSecureStorage();

  Future<void> checkId() async {
    String? getId = await storage.read(key: "usersId");

    if (getId == null) {
      _usersId = const Uuid().v4().toString();
      await storage.write(key: "usersId", value: _usersId);
    } else {
      _usersId = getId;
    }

    notifyListeners(); // ID가 설정된 후 리스너들에게 알림
  }
}
