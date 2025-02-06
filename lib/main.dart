import 'package:flutter/material.dart';
import 'package:freeorder_flutter/screens/cart/cart_detail_screen.dart';
import 'package:freeorder_flutter/screens/cart/cart_screen.dart';
import 'package:freeorder_flutter/screens/main_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_detail_screen.dart';
import 'package:freeorder_flutter/screens/menu/menu_screen.dart';
import 'package:freeorder_flutter/screens/order/order_detail_screen.dart';
import 'package:freeorder_flutter/screens/order/order_screen.dart';
import 'package:freeorder_flutter/screens/payment/payment_screen.dart';

void main() {
  runApp(const MyApp());
}
// 테스트

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'freeorder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(),
        '/menu/list': (context) => const MenuScreen(),
        '/menu/detail': (context) => const MenuDetailScreen(),
        '/cart/list': (context) => const CartScreen(),
        '/cart/detail': (context) => const CartDetailScreen(),
        '/order/list': (context) => const OrderScreen(),
        '/order/detail': (context) => const OrderDetailScreen(),
        '/payment/pay': (context) => const PaymentScreen(),
      },
    );
  }
}
