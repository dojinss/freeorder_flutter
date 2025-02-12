import 'package:flutter/material.dart';
import 'package:freeorder_flutter/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isChecked = false;
  void _showMenu() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
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
                  "김치찌개",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.pop(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("옵션변경", style: TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        "공기밥",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Text(
                    "+ 1,000원",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        "라면 사리",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Text(
                    "+ 1,000원",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        "당면 사리",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Text(
                    "+ 1,000원",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
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

  void _deleteItem() {}
  final CartService cartService = CartService();
  late Future<List<Map<String, dynamic>>> _cartItems;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  // 장바구니 항목 불러오기
  void _loadCartItems() {
    setState(() {
      _cartItems = cartService.list();
    });
  }

  // 장바구니에서 항목 삭제
  void _removeItem(String id) async {
    int result = await cartService.delete(id);
    if (result == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("아이템이 삭제되었습니다.")),
      );
      _loadCartItems(); // 삭제 후 목록 갱신
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title:
            const Text("장바구니", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _cartItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("장바구니 데이터를 불러오는 중 오류 발생"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("장바구니가 비어 있습니다."));
            }

            List<Map<String, dynamic>> cartItems = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cart = cartItems[index];

                // 옵션이 있을 경우 표시
                String optionsText =
                    (cart['options'] != null && cart['options'].isNotEmpty)
                        ? cart['options'].join(', ')
                        : "옵션 없음";

                return _buildCartItem(cart, optionsText);
              },
            );
          },
        ),
      ),
    );
  }

  // 장바구니 항목 카드
  Widget _buildCartItem(Map<String, dynamic> cart, String optionsText) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 이미지 (임시 Placeholder)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.shopping_bag,
                    size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 10),
            // 상품 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품 이름과 가격
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cart['productName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${cart['price']}원",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // 수량 및 옵션
                  Text(
                    "수량: ${cart['amount']}개 | 옵션: $optionsText",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // 삭제 버튼
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeItem(cart['id']),
            ),
          ],
        ),
      ),
    );
  }
}
