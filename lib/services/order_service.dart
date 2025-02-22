import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freeorder_flutter/main.dart';
import 'package:freeorder_flutter/models/order.dart';

class OrderService {
  // 테이블 이름
  // final String url = 'http://10.0.2.2:8080/qr/orders';
  final GlobalConfig _config = GlobalConfig();
  final Dio dio = Dio();

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    final storage = const FlutterSecureStorage();
    String? usersId = await storage.read(key: "usersId");
    final String url = "${_config.backendUrl}/qr/orders/user/$usersId";
    debugPrint("주문내역 조회 - url :  $url");
    var list = List<Map<String, dynamic>>.empty();
    try {
      Response response = await dio.get(url);
      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");
      var data = response.data;
      list = (data as List).map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      debugPrint("$e");
    }
    return list;
  }

  // 데이터 단일 조회
  Future<Map<String, dynamic>?> select(String id) async {
    final String url = "${_config.backendUrl}/qr/orders";
    var order = Map<String, dynamic>.fromEntries(List.empty());
    try {
      var response = await dio.get('$url/$id');
      debugPrint(":::::reponse - body ::::::");
      var data = response.data;
      order = data;
      debugPrint("$order");
    } catch (e) {
      debugPrint("$e");
    }
    return order;
  }

  // 데이터 등록
  Future<int> insert(Order order) async {
    final String url = "${_config.backendUrl}/qr/orders";
    int result = 0;
    try {
      var response = await dio.post(url, data: order.toMap());

      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("주문내역 등록 성공");
      } else {
        debugPrint("주문내역 등록 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Order order) async {
    final String url = "${_config.backendUrl}/qr/orders";
    int result = 0;
    try {
      var response = await dio.put(url, data: order.toMap());
      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("주문내역 수정 성공");
      } else {
        debugPrint("주문내역 수정 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    final String url = "${_config.backendUrl}/qr/orders/$id";
    int result = 0;
    try {
      var response = await dio.delete(url);
      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("주문내역 삭제 성공");
      } else {
        debugPrint("주문내역 삭제 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }
}
