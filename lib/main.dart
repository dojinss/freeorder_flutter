import 'package:flutter/material.dart';
import 'package:freeorder_flutter/screens/cart/cart_screen.dart';
import 'package:freeorder_flutter/screens/main_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_detail_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_screen.dart';
import 'package:freeorder_flutter/screens/order/order_detail_screen.dart';
import 'package:freeorder_flutter/screens/order/order_screen.dart';
import 'package:freeorder_flutter/screens/payment/home.dart';
import 'package:freeorder_flutter/screens/payment/payment.dart';
import 'package:freeorder_flutter/screens/payment/payment_fail_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_success_screen.dart';
import 'package:freeorder_flutter/screens/payment/result.dart';
import 'package:get/get.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_result.dart';

// 전역 설정 클래스...
class GlobalConfig extends ChangeNotifier {
  Color primaryColor = Colors.blue;

  void changeColor(Color newColor) {
    primaryColor = newColor;
    notifyListeners();
  }
}

void main() {
  runApp(const MyApp());
}
// 테스트

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'freeorder',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          primaryColor: Color.fromRGBO(255, 102, 0, 1)),
      initialRoute: '/payment',
      routes: {
        '/main': (context) => const MainScreen(),
        '/menu/list': (context) => const MenuScreen(),
        '/menu/detail': (context) => const MenuDetailScreen(
              productId: '',
            ),
        '/cart/list': (context) => const CartScreen(),
        '/order/list': (context) => const OrderScreen(),
        '/order/detail': (context) => const OrderDetailScreen(),
        '/payment':(context) => const Home(),
        // '/payment/pay/success': (context) => const PaymentSuccessScreen(),
        // '/payment/pay/fail': (context) => const PaymentFailScreen(),
        '/result':(context) => const ResultPage()
      },
    );
  }
}
