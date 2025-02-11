import 'package:dio/dio.dart';
import 'package:freeorder_flutter/models/payment.dart';

class PaymentService {
  // 테이블 이름
  final String URL = 'http://10.0.2.2:8080/qr/payments';
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

  // 데이터 단일 조회
  Future<Map<String, dynamic>?> select(String id) async {
    var payment;
    try {
      var response = await dio.get('$URL/$id');
      print(":::::reponse - body ::::::");
      var data = response.data;
      if (data.containsKey("payment") && data["payment"] is Map<String, dynamic>) {
        payment = data["payment"] as Map<String, dynamic>;
      }
      print(payment);
    } catch (e) {
      print(e);
    }
    return payment;
  }

  // 데이터 등록
  Future<int> insert(Payment payment) async {
    int result = 0;
    try {
      var response = await dio.post(URL, data: payment.toMap());

      print(":::::reponse - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("결제내역 등록 성공");
      } else {
        print("결제내역 등록 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Payment payment) async {
    int result = 0;
    try {
      var response = await dio.put(URL, data: payment.toMap());
      print(":::::reponse - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("결제내역 수정 성공");
      } else {
        print("결제내역 수정 실패!");
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
      var response = await dio.delete(URL + "/$id");
      print(":::::reponse - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("결제내역 삭제 성공");
      } else {
        print("결제내역 삭제 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
