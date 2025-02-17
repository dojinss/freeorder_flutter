import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/order.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:freeorder_flutter/screens/cart/cart_screen.dart';
import 'package:freeorder_flutter/screens/main_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_detail_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_screen.dart';
import 'package:freeorder_flutter/screens/order/order_detail_screen.dart';
import 'package:freeorder_flutter/screens/order/order_screen.dart';
<<<<<<< HEAD
import 'package:freeorder_flutter/screens/payment/home.dart';
import 'package:freeorder_flutter/screens/payment/payment.dart';
import 'package:freeorder_flutter/screens/payment/payment_fail_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_success_screen.dart';
import 'package:freeorder_flutter/screens/payment/result.dart';
import 'package:get/get.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_result.dart';
=======
import 'package:freeorder_flutter/screens/payment/payment_screen.dart';
import 'package:provider/provider.dart';
>>>>>>> main

// 전역 설정 클래스...
class GlobalConfig extends ChangeNotifier {
  Color primaryColor = Color.fromRGBO(255, 102, 0, 1);

  void changeColor(Color newColor) {
    primaryColor = newColor;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userProvider = UserProvider();
  await userProvider.checkId(); // ✅ 유저 ID 설정
  await userProvider.loadCartItemCount(); // ✅ 장바구니 개수 초기화
  debugPrint("장바구니 개수 초기화 : ${userProvider.cartItemCount}");
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  ));
}

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
<<<<<<< HEAD
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
=======
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // settings.name : 라우팅 경로
        switch (settings.name) {
          case "/":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => MainScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          case "/menu/list":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => MenuScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          case "/menu/detail/{id}":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => MenuDetailScreen(productId: ''),
              transitionDuration: Duration(seconds: 0),
            );
          case "/cart/list":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => CartScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          case "/order/list":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => OrderScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          case "/order/detail":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => OrderDetailScreen(
                order: settings.arguments as Order,
              ),
              transitionDuration: Duration(seconds: 0),
            );
          case "/payment":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(),
              transitionDuration: Duration(seconds: 0),
            );
        }
        return null;
>>>>>>> main
      },
    );
  }
}
