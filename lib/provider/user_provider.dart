import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:freeorder_flutter/services/cart_service.dart';

class UserProvider extends ChangeNotifier {
  String? _usersId;
  int _cartItemCount = 0; // ✅ 장바구니 개수 추가
  bool _isCartLoaded = false; // ✅ 장바구니 개수 로딩 상태
  String? _type; // 주문타입

  final CartService _cartService = CartService();
  final storage = const FlutterSecureStorage();

  // Getter
  String get getUsersId => _usersId ?? '';
  int get cartItemCount => _cartItemCount;
  bool get isCartLoaded => _isCartLoaded; // ✅ 로딩 상태 확인
  String get getType => _type ?? "HERE";

  // ✅ 주문 방식 설정
  void setType(String type){
    _type = type;
    notifyListeners();
  }

  // ✅ 장바구니 개수 업데이트
  void updateCartItemCount(int count) {
    _cartItemCount = count;
    _isCartLoaded = true; // ✅ 로딩 완료 상태 변경
    debugPrint("장바구니 개수 업데이트! : $_cartItemCount");
    notifyListeners();
  }

  // ✅ 장바구니 개수 증가
  void incrementCartItem() {
    _cartItemCount++;
    notifyListeners();
  }

  // ✅ 장바구니 개수 감소
  void decrementCartItem() {
    if (_cartItemCount > 0) {
      _cartItemCount--;
      notifyListeners();
    }
  }

  // ✅ 장바구니 전체 삭제
  void clearCart() {
    _cartItemCount = 0;
    notifyListeners();
  }

  // ✅ 유저 ID 확인 및 저장
  Future<void> checkId() async {
    String? getId = await storage.read(key: "usersId");

    if (getId == null) {
      _usersId = const Uuid().v4().toString();
      await storage.write(key: "usersId", value: _usersId);
    } else {
      _usersId = getId;
    }

    notifyListeners();
  }

  // ✅ 장바구니 개수 불러오기
  Future<void> loadCartItemCount() async {
    _isCartLoaded = false; // ✅ 로딩 상태 초기화
    notifyListeners();

    List<Map<String, dynamic>> cartItems = await _cartService.list();
    updateCartItemCount(cartItems.length);
  }
}
