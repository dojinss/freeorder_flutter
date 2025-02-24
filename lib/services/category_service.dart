import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freeorder_flutter/main.dart';

class CategoryService {
  // 테이블 이름
  // final String url = 'http://192.168.30.137:8080/qr/categories';
  final GlobalConfig _config = GlobalConfig();
  final Dio dio = Dio();

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    final String url = "${_config.backendUrl}/qr/categories";
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
}
