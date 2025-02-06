import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<String> items =
      List<String>.generate(100, (index) => "Item $index");

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
                      return Column(
                        children: [
                          ListTile(
                            title: Text(items[index]),
                            subtitle: Text('Subtitle $index'),
                            selected: index < 3,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/order/detail',
                                arguments: {
                                  'item': items[index],
                                  'index': index
                                },
                              );
                            },
                          ),
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
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
