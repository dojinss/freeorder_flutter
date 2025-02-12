import 'package:dio/dio.dart';
import 'package:freeorder_flutter/models/cart.dart';
import 'package:freeorder_flutter/services/user_service.dart'; // UserService 추가

class CartService {
  // 테이블 이름
  final String URL = 'http://10.0.2.2:8080/qr/carts';
  final Dio dio = Dio();
  final UserService userService = UserService(); // UserService 인스턴스

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    List<Map<String, dynamic>> cartItems = [];
    String? userId = userService.getUserId();

    if (userId == null) {
      print("🚨 오류: 사용자 ID가 null 입니다.");
      return cartItems;
    }

    String requestUrl = '$URL/all/$userId';
    print("📢 요청 URL: $requestUrl");

    try {
      Response response = await dio.get(requestUrl);
      print("✅ 서버 응답 상태 코드: ${response.statusCode}");
      print("✅ 서버 응답 데이터 타입: ${response.data.runtimeType}");
      print("✅ 서버 응답 데이터: ${response.data}");

      var data = response.data;

      if (data is List) {
        cartItems = List<Map<String, dynamic>>.from(data);
      } else if (data is Map<String, dynamic> && data.containsKey('cartItems')) {
        cartItems = List<Map<String, dynamic>>.from(data['cartItems']);
      } else {
        print("⚠️ 예상치 못한 응답 형식: $data");
      }
    } catch (e) {
      print("🚨 오류 발생: $e");
    }

    print("📦 최종 장바구니 데이터: $cartItems");
    return cartItems;
  }

  // 데이터 단일 조회
  Future<Map<String, dynamic>?> select(String id) async {
    var cart;
    try {
      var response = await dio.get('$URL/$id');
      print(":::::response - body ::::::");
      var data = response.data;
      if (data.containsKey("cart") && data["cart"] is Map<String, dynamic>) {
        cart = data["cart"] as Map<String, dynamic>;
      }
      print(cart);
    } catch (e) {
      print(e);
    }
    return cart;
  }

  // 데이터 등록
  Future<int> insert(Cart cart) async {
    int result = 0;
    try {
      // 사용자 아이디 설정
      cart.usersId = userService.getUserId(); // 사용자 아이디를 추가
      var response = await dio.post(URL + '/${cart.usersId}', data: cart.toMap());

      print(":::::response - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("장바구니 등록 성공");
      } else {
        print("장바구니 등록 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Cart cart) async {
    int result = 0;
    try {
      var response = await dio.put('$URL/${cart.usersId}', data: cart.toMap());
      print(":::::response - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("장바구니 수정 성공");
      } else {
        print("장바구니 수정 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    int result = 0;
    try {
      var response = await dio.delete('$URL/$id');
      print(":::::response - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("장바구니 삭제 성공");
      } else {
        print("장바구니 삭제 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
