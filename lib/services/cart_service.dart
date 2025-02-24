import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freeorder_flutter/main.dart';
import 'package:freeorder_flutter/models/cart.dart';
import 'package:freeorder_flutter/models/product.dart';

class CartService {
  // 테이블 이름
  // final String url = 'http://192.168.30.137:8080/qr/carts';
  final GlobalConfig _config = GlobalConfig();
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

    final String url = "${_config.backendUrl}/qr/carts/all/$usersId";
    debugPrint("📢 요청 url: $url");

    try {
      Response response = await dio.get(url);
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
    final String url = "${_config.backendUrl}/qr/carts/$id";
    var cart = Map<String, dynamic>.fromEntries(List.empty());
    try {
      var response = await dio.get(url);
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
    final storage = const FlutterSecureStorage();
    String? usersId = await storage.read(key: "usersId");
    final String url = "${_config.backendUrl}/qr/carts/$usersId";
    int result = 0;
    try {
      var response = await dio.post(url, data: product.toMap());

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
    final String url = "${_config.backendUrl}/qr/carts/${cart.usersId}";
    int result = 0;
    try {
      var response = await dio.put(url, data: cart.toMap());
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
    final String url = "${_config.backendUrl}/qr/carts/$id";
    int result = 0;
    try {
      var response = await dio.delete(url);
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
    final String url = "${_config.backendUrl}/qr/carts/all/$id";
    int result = 0;
    try {
      var response = await dio.delete(url);
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
