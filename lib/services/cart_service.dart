import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freeorder_flutter/models/cart.dart';
import 'package:freeorder_flutter/models/product.dart';

class CartService {
  // 테이블 이름
  final String url = 'http://10.0.2.2:8080/qr/carts';
  final Dio dio = Dio();

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    List<Map<String, dynamic>> cartItems = List<Map<String, dynamic>>.empty();

    final storage = const FlutterSecureStorage();
    String? usersId = await storage.read(key: "usersId");

    if (usersId == null) {
      debugPrint("🚨 오류: 사용자 ID가 null 입니다.");
      return cartItems;
    }

    String requestUrl = '$url/all/$usersId';
    debugPrint("📢 요청 url: $requestUrl");

    try {
      Response response = await dio.get(requestUrl);
      debugPrint("✅ 서버 응답 상태 코드: ${response.statusCode}");
      debugPrint("✅ 서버 응답 데이터 타입: ${response.data.runtimeType}");
      debugPrint("✅ 서버 응답 데이터: ${response.data}");

      var data = response.data;

      if (data is List) {
        cartItems = List<Map<String, dynamic>>.from(data);
      } else if (data is Map<String, dynamic> && data.containsKey('cartItems')) {
        cartItems = List<Map<String, dynamic>>.from(data['cartItems']);
      } else {
        debugPrint("⚠️ 예상치 못한 응답 형식: $data");
      }
    } catch (e) {
      debugPrint("🚨 오류 발생: $e");
    }

    debugPrint("📦 최종 장바구니 데이터: $cartItems");
    return cartItems;
  }

  // 데이터 단일 조회
  Future<Map<String, dynamic>?> select(String id) async {
    var cart = Map<String, dynamic>.fromEntries(List.empty());
    try {
      var response = await dio.get('$url/$id');
      debugPrint(":::::response - body ::::::");
      var data = response.data;
      if (data.containsKey("cart") && data["cart"] is Map<String, dynamic>) {
        cart = data["cart"] as Map<String, dynamic>;
      }
      debugPrint("$cart");
    } catch (e) {
      debugPrint("$e");
    }
    return cart;
  }

  // 데이터 등록
  Future<int> insert(Product product) async {
    int result = 0;
    try {
      final storage = const FlutterSecureStorage();
      String? usersId = await storage.read(key: "usersId");
      var response = await dio.post('$url/$usersId', data: product.toMap());

      debugPrint(":::::response - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("장바구니 등록 성공");
      } else {
        debugPrint("장바구니 등록 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Cart cart) async {
    int result = 0;
    try {
      var response = await dio.put('$url/${cart.usersId}', data: cart.toMap());
      debugPrint(":::::response - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("장바구니 수정 성공");
      } else {
        debugPrint("장바구니 수정 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    int result = 0;
    try {
      var response = await dio.delete('$url/$id');
      debugPrint(":::::response - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("장바구니 삭제 성공");
      } else {
        debugPrint("장바구니 삭제 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 전체체 삭제
  Future<int> deleteAll(String id) async {
    int result = 0;
    debugPrint("$url/all/$id");
    try {
      var response = await dio.delete('$url/all/$id');
      debugPrint(":::::response - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("장바구니 전체체 삭제 성공");
      } else {
        debugPrint("장바구니 전체 삭제 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }
}
