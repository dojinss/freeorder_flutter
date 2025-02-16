import 'package:flutter/material.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String orderType = userProvider.getType; // ✅ 주문 방식 가져오기
    debugPrint("주문 방식 : $orderType");
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}