import 'package:uuid/uuid.dart';

class UserService {
  String getUserId() {
    // 로그인 시스템이 없으므로 임시로 고유한 UUID를 생성하여 사용자 아이디로 사용
    return Uuid().v4();
  }
}
