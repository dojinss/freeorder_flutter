import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/product.dart';
import 'package:freeorder_flutter/services/product_service.dart';
import 'package:freeorder_flutter/widgets/image_widget.dart';

class MenuDetailScreen extends StatefulWidget {
  final String productId;

  const MenuDetailScreen({super.key, required this.productId});

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  late Future<Product?> _product;
  final productService = ProductService();
  Map<String, bool> selectedOptions = {}; // 옵션 선택 상태 저장

  @override
  void initState() {
    super.initState();
    _product = _fetchProduct();
  }

  Future<Product?> _fetchProduct() async {
    final productData = await productService.select(widget.productId);
    if (productData != null) {
      return Product.fromMap(productData);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상품 상세"),
        centerTitle: true,
      ),
      body: FutureBuilder<Product?>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("상품 정보를 불러올 수 없습니다."));
          }

          final product = snapshot.data!;
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

                // 상품 설명
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
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

  void _addToCart(Product product) {
    final selectedItems = product.option?.itemList
            .where((item) => selectedOptions[item.id] == true)
            .toList() ??
        [];

    print("장바구니 추가 - 상품: ${product.name}, 옵션: ${selectedItems.map((e) => e.name).toList()}");

    // TODO: 장바구니에 상품 + 옵션 데이터 저장하는 로직 추가
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("장바구니에 추가되었습니다!")),
    );
  }
}
