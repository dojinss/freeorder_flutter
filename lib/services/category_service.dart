import 'package:dio/dio.dart';

class CategoryService {
  // 테이블 이름
  final String URL = 'http://10.0.2.2:8080/qr/categories';
  final Dio dio = Dio();

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    var list;
    try {
      Response response = await dio.get(URL);
      print(":::::reponse - body ::::::");
      print(response.data);
      var data = response.data;
      list = (data as List).map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      print(e);
    }
    return list;
  }
}
