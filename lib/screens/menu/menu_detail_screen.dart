import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/cart.dart';
import 'package:freeorder_flutter/models/product.dart';
import 'package:freeorder_flutter/services/product_service.dart';
import 'package:freeorder_flutter/services/cart_service.dart'; // CartService 추가
import 'package:freeorder_flutter/widgets/image_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:freeorder_flutter/services/user_service.dart'; // UserService 추가

class MenuDetailScreen extends StatefulWidget {
  final String productId;

  const MenuDetailScreen({super.key, required this.productId});

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  late Future<Map<String, dynamic>?> _product; // Future<Map<String, dynamic>?>로 수정
  final productService = ProductService();
  final cartService = CartService(); // CartService 인스턴스 추가
  final userService = UserService(); // UserService 인스턴스 추가
  Map<String, bool> selectedOptions = {}; // 옵션 선택 상태 저장
  int _quantity = 1; // 초기 수량 (최소 1개)

  @override
  void initState() {
    super.initState();
    _product = _fetchProduct();
  }

  Future<Map<String, dynamic>?> _fetchProduct() async {
    final productData = await productService.select(widget.productId);
    print("Fetched Product Data: $productData"); // 응답된 데이터 로그 출력
    return productData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상품 상세"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        // FutureBuilder로 상품 데이터를 비동기 처리
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("상품 정보를 불러올 수 없습니다."));
          }

          final productData = snapshot.data!;
          final product = Product.fromMap(productData); // Map을 Product로 변환

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상품 이미지
                Center(child: ImageWidget(id: product.id, width: 200, height: 200)),
                const SizedBox(height: 20),

                // 상품명 & 가격
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "${product.price}원",
                  style: const TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // 상품 설명 추가
                Text(
                  product.description.isNotEmpty ? product.description : "상품 설명이 없습니다.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),

                // 수량 선택 ( + / - 버튼 )
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "수량",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        // "-" 버튼
                        ElevatedButton(
                          onPressed: _quantity > 1
                              ? () {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size(20, 30),
                          ),
                          child: const Text("-", style: TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // "+" 버튼
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size(20, 30),
                          ),
                          child: const Text("+", style: TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 옵션 리스트 (있을 경우만)
                if (product.option != null && product.option!.itemList.isNotEmpty) ...[
                  const Text(
                    "옵션 선택",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // 옵션 체크박스 리스트
                  Column(
                    children: product.option!.itemList.map((optionItem) {
                      return CheckboxListTile(
                        title: Text("${optionItem.name} (+${optionItem.price}원)"),
                        value: selectedOptions[optionItem.id] ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions[optionItem.id] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
                const Spacer(),

                // 장바구니 담기 버튼
                ElevatedButton(
                  onPressed: () {
                    _addToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("장바구니 담기", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addToCart(Product product) async {
    final selectedItems = product.option.itemList.where((item) => selectedOptions[item.id] == true).toList() ?? [];

    // 장바구니에 추가할 데이터 생성
    Map<String, dynamic> cartItem = {
      'id': product.id,
      'productName': product.name,
      'price': product.price * _quantity + selectedItems.fold(0, (sum, item) => sum + item.price),
      'amount': _quantity,
      'optionList': selectedItems.map((e) => e.toMap()).toList(),
    };

    print("Generated cartItem: $cartItem"); // 로그 추가

    // Map을 Cart 객체로 변환
    Cart cart = Cart.fromMap(cartItem);
    cart.usersId = await userService.getUserId(); // 사용자 아이디를 비동기로 가져오기

    // 로그로 Cart 객체 확인
    print("Cart object: $cart");

    try {
      // CartService에 장바구니 추가
      await cartService.insert(cart); // 비동기 호출 시 await 사용

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("장바구니에 추가되었습니다!")),
      );
    } catch (e) {
      // 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("장바구니 추가 실패: $e")),
      );
    }
  }
}
