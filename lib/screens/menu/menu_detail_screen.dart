import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/product.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:freeorder_flutter/services/cart_service.dart'; // CartService 추가
import 'package:freeorder_flutter/services/product_service.dart';
import 'package:freeorder_flutter/widgets/custom_snackbar.dart';
import 'package:freeorder_flutter/widgets/image_widget.dart';
import 'package:provider/provider.dart';

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
  Map<String, bool> selectedOptions = {}; // 옵션 선택 상태 저장
  int _quantity = 1; // 초기 수량 (최소 1개)

  @override
  void initState() {
    super.initState();
    _product = _fetchProduct();
  }

  Future<Map<String, dynamic>?> _fetchProduct() async {
    final productData = await productService.select(widget.productId);
    debugPrint("상품 정보 : $productData"); // 응답된 데이터 로그 출력
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
          var product = Product.fromMap(productData); // Map을 Product로 변환

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
                if (product.option.itemList.isNotEmpty) ...[
                  const Text(
                    "옵션 선택",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: product.option.itemList.map((optionItem) {
                      return CheckboxListTile(
                        title: Text("${optionItem.name} (+${optionItem.price}원)"),
                        value: selectedOptions[optionItem.id] ?? false, // 모델 내부의 체크 상태 변수 사용
                        onChanged: (bool? value) {
                          debugPrint("체크값 : $value");
                          setState(() {
                            // selectedOptions 맵을 업데이트하여 UI 반영
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
                    // setState로 itemList의 checked 값 반영된 후 addToCart 호출
                    setState(() {
                      product.option.itemList = product.option.itemList.map((item) {
                        // 체크박스 상태를 반영해서 새로운 객체로 갱신
                        if (selectedOptions[item.id] != null) {
                          return item.copyWith(checked: selectedOptions[item.id]!);
                        }
                        return item;
                      }).toList();
                    });
                    Provider.of<UserProvider>(context, listen: false).incrementCartItem(); // ✅ 개수 증가
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

  void _addToCart(product) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.checkId();
    String usersId = userProvider.getUsersId;
    debugPrint("장바구니 추가 - 아이디 : $usersId");
    // 수량 입력
    product.quantity = _quantity;

    // 로그로 Cart 객체 확인
    debugPrint("장바구니에 입력할 상품 : $product", wrapWidth: 1024);

    try {
      // CartService에 장바구니 추가
      await cartService.insert(product); // 비동기 호출 시 await 사용
      Navigator.pop(context);
      CustomSnackbar(text: "장바구니에 상품이 추가되었습니다.").showSnackBar(context);
    } catch (e) {
      // 예외 처리
      CustomSnackbar(
        text: "장바구니에 상품 추가에 실패하였습니다.",
        backgroundColor: Colors.redAccent,
        color: Colors.white,
      ).showSnackBar(context);
    }
  }
}
