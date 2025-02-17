import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/order.dart';
import 'package:freeorder_flutter/services/order_service.dart';
import 'package:freeorder_flutter/utils/format.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderService _orderService = OrderService();
  late Future<List<Map<String, dynamic>>> _orders;
  @override
  void initState() {
    super.initState();
    setState(() {
      _orders = _orderService.list();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 탭의 수
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/menu/list");
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text("주문 내역"),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: _orders,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("데이터 조회 중 오류 발생"));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text("주문내역이 없습니다."));
                } else {
                  List<Map<String, dynamic>> orderData = snapshot.data!;
                  return _loadOrders(orderData);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _loadOrders(List<Map<String, dynamic>> orderData) {
  CustomFormat _format = CustomFormat();
  return Expanded(
    child: ListView.builder(
      itemCount: orderData.length,
      itemBuilder: (context, index) {
        final order = Order.fromMap(orderData[index]);
        return Padding(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide.none,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                textColor: Colors.black,
                iconColor: Colors.black,
                leading: Icon(
                  Icons.assignment,
                  color: Colors.black,
                ),
                title: Text(
                  order.title,
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  '${_format.formatNumber(order.totalPrice)} 원',
                  style: TextStyle(color: Colors.black),
                ),
                selected: index < 3,
                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                onTap: () {
                  debugPrint('Navigating to /order/detail with arguments: $order');
                  Navigator.pushNamed(
                    context,
                    '/order/detail',
                    arguments: order,
                  );
                },
              ),
            ),
          ),
        );
      },
    ),
  );
}
