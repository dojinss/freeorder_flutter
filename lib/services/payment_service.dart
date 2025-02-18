import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freeorder_flutter/models/payment.dart';

class PaymentService {
  // 테이블 이름
  final String url = 'http://10.0.2.2:8080/payments';
  final Dio dio = Dio();

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
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
  Future<Map<String, dynamic>?> select(String type) async {
    var result = Map<String, dynamic>.fromEntries(List.empty());
    final storage = const FlutterSecureStorage();
    String? usersId = await storage.read(key: "usersId");
    if (usersId == null) {
      debugPrint("🚨 오류: 사용자 ID가 null 입니다.");
      return result;
    }
    try {
      var response = await dio.get('$url/$usersId/$type');
      debugPrint(":::::reponse - body ::::::");
      var data = response.data;
      if (data != null) {
        result = data;
      }
      debugPrint("$result");
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 등록
  Future<int> insert(Payment payment) async {
    int result = 0;
    try {
      var response = await dio.post("http://10.0.2.2:8080/qr/payments", data: payment.toMap());

      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("결제내역 등록 성공");
      } else {
        debugPrint("결제내역 등록 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Payment payment) async {
    int result = 0;
    try {
      var response = await dio.put(url, data: payment.toMap());
      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("결제내역 수정 성공");
      } else {
        debugPrint("결제내역 수정 실패!");
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
      var response = await dio.delete("$url/$id");
      debugPrint(":::::reponse - body ::::::");
      debugPrint("${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        debugPrint("결제내역 삭제 성공");
      } else {
        debugPrint("결제내역 삭제 실패!");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }
}
