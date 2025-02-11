import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _showMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.arrow_back_ios_new_rounded),
                title: const Text(
                  "불고기 버거",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("옵션변경", style: TextStyle(fontSize: 20)),
              ),
              ListTile(
                title: const Text("", style: TextStyle(fontSize: 20)),
              ),
              ListTile(
                title: const Text("", style: TextStyle(fontSize: 20)),
              ),
              ListTile(
                title: const Text("", style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 102, 0, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "변경하기",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _deleteItem() {
    // print("항목이 삭제되었습니다.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
        centerTitle: false,
        title: const Text("장바구니", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "메인메뉴",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // 첫 번째 메뉴
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/menu1.jpg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text("김치찌개"),
              subtitle: const Text("가격: 8,000원 | 수량: 1개"),
              // 옵션변경 버튼
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: (ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 197, 197, 197),
                    )),
                    onPressed: _showMenu,
                    child: const Text(
                      "옵션변경",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: _deleteItem,
                    child: const Text(
                      "삭제하기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const Divider(),

            // // 두 번째 메뉴
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset(
            //       'assets/images/menu2.jpg',
            //       width: 60,
            //       height: 60,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   title: const Text("떡볶이"),
            //   subtitle: const Text("가격: 7,000원 | 수량: 1개"),
            //   // 옵션변경 버튼
            //   trailing: SizedBox(
            //     width: 90,
            //     height: 35,
            //     child: FloatingActionButton(
            //       backgroundColor: const Color.fromARGB(255, 197, 197, 197),
            //       onPressed: _showMenu,
            //       child: const Text(
            //         "옵션변경",
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Divider(),

            // // 세 번째 메뉴
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset(
            //       'assets/images/menu3.jpg',
            //       width: 60,
            //       height: 60,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   title: const Text("네란버거"),
            //   subtitle: const Text("가격: 5,500원 | 수량: 1개"),
            //   // 옵션변경 버튼
            //   trailing: SizedBox(
            //     width: 90,
            //     height: 35,
            //     child: FloatingActionButton(
            //       backgroundColor: const Color.fromARGB(255, 197, 197, 197),
            //       onPressed: _showMenu,
            //       child: const Text(
            //         "옵션변경",
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Divider(),
          ],
        ),
      ),
    );
  }
}
