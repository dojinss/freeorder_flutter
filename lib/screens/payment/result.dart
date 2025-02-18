import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_result.dart';

/// [ResultPage] class는 결제의 성공 혹은 실패 여부를 보여주는 위젯입니다.
class ResultPage extends StatelessWidget {
  /// 기본 생성자입니다.
  const ResultPage({super.key});

  /// 주어진 title과 message를 이용하여 [Row]를 생성합니다.
  ///
  /// [title]과 [message]는 [Text] 위젯의 일부로 포함됩니다.
  ///
  /// [title]는 회색 텍스트 스타일로, [message]는 기본 텍스트 스타일로 표시됩니다.
  Row makeRow(String title, String message) {
    return Row(children: [
      Expanded(flex: 3, child: Text(title, style: const TextStyle(color: Colors.grey))),
      Expanded(
        flex: 8,
        child: Text(message),
      )
    ]);
  }

  /// 결제 결과에 따라 적절한 [Container]를 반환합니다.
  ///
  /// [result]이 [Success] 타입이면 성공 메시지와 함께 세부 정보를 표시합니다.
  /// [result]이 [Fail] 타입이면 오류 메시지와 함께 세부 정보를 표시합니다.
  /// 그 외의 경우, 비어있는 [Container]를 반환합니다.
  Container getContainer(dynamic result) {
    return Container(
      color: Colors.transparent,
      child: Builder(
        builder: (context) {
          // Success 타입인 경우
          if (result is Success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("images/payComplete.png"), width: 300),
                  SizedBox(height: 50),
                  Text(
                    "결제 완료!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.canPop(context);
                      Navigator.pushReplacementNamed(context, "/menu/list");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 100, 50),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text("상품목록", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.canPop(context);
                      Navigator.pushReplacementNamed(context, "/menu/list");
                      Navigator.pushNamed(context, "/order/list");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 100, 50),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text("주문내역", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          // Fail 타입인 경우
          if (result is Fail) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("images/payFail.png"), width: 100),
                  SizedBox(height: 20),
                  Text(
                    "결제에 실패하였습니다.",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " 잠시후 다시 시도해주세요.",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.canPop(context);
                      Navigator.pushReplacementNamed(context, "/menu/list");
                      Navigator.pushReplacementNamed(context, "/cart/list");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 100, 50),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text("장바구니", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          // Success 또는 Fail 타입이 아닌 경우
          return const SizedBox(); // 빈 위젯 반환
        },
      ),
    );
  }

  /// 위젯을 빌드합니다.
  ///
  /// [Success]인 경우, '인증 성공!' 메시지를 표시하며,
  /// 그 외의 경우, '결제에 실패하였습니다' 메시지를 표시합니다.
  @override
  Widget build(BuildContext context) {
    dynamic result = Get.arguments;
    debugPrint("결과값 : $result");
    String message;

    if (result is Success) {
      message = '인증 성공! 결제승인API를 호출해 결제를 완료하세요!';
    } else if (result is Fail) {
      message = '결제에 실패하였습니다';
    } else {
      message = "결과값이 없습니다.";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('결제 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getContainer(result),
            ],
          ),
        ),
      ),
    );
  }
}
