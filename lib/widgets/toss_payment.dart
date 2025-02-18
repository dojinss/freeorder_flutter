import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/order.dart';
import 'package:freeorder_flutter/models/payment.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:freeorder_flutter/services/cart_service.dart';
import 'package:freeorder_flutter/services/order_service.dart';
import 'package:freeorder_flutter/services/payment_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tosspayments_widget_sdk_flutter/model/paymentData.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_result.dart';
import 'package:tosspayments_widget_sdk_flutter/pages/tosspayments_sdk_flutter.dart';
import 'package:uuid/uuid.dart';

/// [Payment] 클래스는 결제 처리를 담당하는 위젯입니다.
class ToassPayment extends StatelessWidget {
  /// 기본 생성자입니다.
  const ToassPayment({super.key});

  /// 위젯을 빌드합니다.
  ///
  /// 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq' 클라이언트 키를 사용하여 [TossPayments]를 생성합니다.
  /// test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm << 우리꺼
  ///
  /// 성공하면, [Get]을 이용해 결과를 반환하고 이전 화면으로 돌아갑니다.
  /// 실패하면, [Get]을 이용해 실패 정보를 반환하고 이전 화면으로 돌아갑니다.
  @override
  Widget build(BuildContext context) {
    StompClient? stompClient;
    final String url = "ws://10.0.2.2:8080/ws"; // WebSocket 서버 URL

    stompClient = StompClient(
      config: StompConfig(
        url: url,
        onConnect: (frame) {
          debugPrint("웹소켓 연결 성공!");
        },
        onWebSocketError: (dynamic error) => debugPrint('WebSocket Error: $error'),
      ),
    );

    stompClient.activate();

    PaymentData data = Get.arguments as PaymentData;
    PaymentService paymentService = PaymentService();
    CartService cartService = CartService();
    OrderService orderService = OrderService();
    debugPrint("결제창 출력!!");
    return TossPayments(
        clientKey: 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq',
        data: data,
        success: (Success success) async {
          debugPrint("결제 성공! $success");
          // 주문 정보
          var orderData = await orderService.select(data.orderId);
          Order order = Order.fromMap(orderData!);

          debugPrint("결제 성공 후 DB 에 결제내역 추가...");
          int payResult = await paymentService.insert(Payment(
            id: Uuid().v4().toString(),
            ordersId: data.orderId,
            paymentKey: success.paymentKey,
            paymentMethod: "카드",
            status: "PAID",
            paidAt: DateTime.now(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            order: order,
          ));
          if (payResult > 0) {
            debugPrint("결제 내역 생성 성공!");
            stompClient!.send(
              destination: "/app/order.addorder/${order.id}",
              body: order.toJson(),
            );
          } else {
            debugPrint("결제 내역 생성중 오류 발생...");
          }
          debugPrint("결제 성공 후 DB 에세 장바구니 내역 삭제...");
          UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
          int cartResult = await cartService.deleteAll(userProvider.getUsersId);
          if (cartResult > 0) {
            debugPrint("장바구니 내역 삭제 성공!");
          } else {
            debugPrint("장바구니 내역 삭제중 오류 발생...");
          }

          Get.back(result: success);
        },
        fail: (Fail fail) {
          debugPrint("결제 실패! : $fail");
          Get.back(result: fail);
        });
  }
}
