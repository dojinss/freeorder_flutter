import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/order.dart';
import 'package:freeorder_flutter/utils/format.dart';

class OrderDetailScreen extends StatefulWidget {
  final order;
  const OrderDetailScreen({super.key, this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late final Order _order;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = widget.order;
    if (args is Order) {
      debugPrint("Order타입으로 넘겨받음");
    } else {
      debugPrint("타입 에러!!");
    }
    if (widget.order != null) {
      _order = widget.order;
    } else {
      _order = Order(
        id: '',
        orderNumber: 0,
        type: '',
        usersId: 'usersId',
        title: 'title',
        totalQuantity: 0,
        totalCount: 0,
        totalPrice: 0,
        status: 'status',
        orderedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        itemList: [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomFormat _format = CustomFormat();
    return Scaffold(
      appBar: AppBar(
        title: Text("상세 페이지"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.info, color: Colors.orange),
                title: Text(
                  "주문 상세",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _order.itemList
                          .map(
                            (order) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "메뉴 이름: ${order.name}",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "수량: ${order.quantity}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "옵션:",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: order.optionList.map((option) {
                                        return Text('${option.name} + ${_format.formatNumber(option.price)}원');
                                      }).toList(),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "가격: ${_format.formatNumber(order.price)} 원",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 25,
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "총 가격:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_format.formatNumber(_order.totalPrice)} 원',
                      style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
