import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/order.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:freeorder_flutter/screens/cart/cart_screen.dart';
import 'package:freeorder_flutter/screens/main_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_detail_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_screen.dart';
import 'package:freeorder_flutter/screens/order/order_detail_screen.dart';
import 'package:freeorder_flutter/screens/order/order_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_fail_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_success_screen.dart';
import 'package:freeorder_flutter/screens/payment/result.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// 전역 설정 클래스...
class GlobalConfig extends ChangeNotifier {
  Color primaryColor = Color.fromRGBO(255, 102, 0, 1);
  // String backendUrl = "http://dojinss.cafe24.com";
  String backendUrl = "http://192.168.30.137:8080";
  String get getUrl => backendUrl;
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
        primaryColor: const Color.fromRGBO(255, 102, 0, 1),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainScreen()),
        GetPage(name: '/menu/list', page: () => MenuScreen()),
        GetPage(name: '/menu/detail/:id', page: () => MenuDetailScreen(productId: '')),
        GetPage(name: '/cart/list', page: () => CartScreen()),
        GetPage(name: '/order/list', page: () => OrderScreen()),
        GetPage(
          name: '/order/detail',
          page: () => OrderDetailScreen(order: Get.arguments as Order),
        ),
        GetPage(
          name: '/payment',
          page: () => PaymentScreen(ordersId: Get.arguments.toString()),
        ),
        GetPage(
          name: '/result',
          page: () => ResultPage(),
        ),
        GetPage(name: '/success', page: () => PaymentSuccessScreen()),
        GetPage(name: '/fail', page: () => PaymentFailScreen()),
      ],
    );
  }
}
