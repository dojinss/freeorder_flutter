import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, dynamic>> items = List.generate(
    100,
    (index) => {
      'name': 'Item $index',
      'quantity': index + 1,
      'option': 'Option $index',
      'price': (index + 1) * 1000,
    },
  );

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
          bottom: TabBar(
            labelColor: Color.fromARGB(255, 255, 136, 0),
            indicatorColor: Color.fromARGB(255, 255, 136, 0),
            tabs: [
              Tab(text: "장바구니"),
              Tab(text: "주문내역"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("장바구니 내역")),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text(items[index]['name']),
                            subtitle: Text('Subtitle $index'),
                            selected: index < 3,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/order/detail',
                                arguments: {
                                  'name': items[index]['name'],
                                  'quantity': items[index]['quantity'],
                                  'option': items[index]['option'],
                                  'price': items[index]['price'],
                                  'index': index,
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
