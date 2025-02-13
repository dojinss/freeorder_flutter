import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/cart.dart';
import 'package:freeorder_flutter/models/product.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:freeorder_flutter/services/cart_service.dart';
import 'package:freeorder_flutter/services/product_service.dart';
import 'package:freeorder_flutter/utils/format.dart';
import 'package:freeorder_flutter/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isChecked = false;
  ProductService productService = ProductService();
  Map<String, bool> selectedOptionItems = {}; // 옵션 선택 상태 저장
  late Product _productInfo;
  final CartService cartService = CartService();
  late Future<List<Map<String, dynamic>>> _cartItems;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    Future.microtask(() {
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.checkId(); // 필요하면 호출
      debugPrint("접속한 유저 아이디 : ${userProvider.getUsersId}");
    });
  }

  void _showMenu(Cart cart) async {
    var product = await productService.select(cart.productsId);
    if (product == null) {
      return;
    }
    _productInfo = Product.fromMap(product);
    setState(() {
      // 옵션 아이템 리스트 체크값 세팅하기
      cart.optionList.asMap().forEach(
        (index, item) {
          selectedOptionItems[item.optionItemsId] = true;
        },
      );
    });
    debugPrint("선택된 아이템 리스트 : $selectedOptionItems", wrapWidth: 1024);
    showModalBottomSheet(
      isScrollControlled: true,
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
                title: Text(
                  _productInfo.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.pop(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("옵션변경", style: TextStyle(fontSize: 20)),
              ),

              // 옵션 리스트 (있을 경우만)
              if (_productInfo.option.itemList.isNotEmpty) ...[
                const Text(
                  "옵션 선택",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // 스크롤 가능한 박스 추가
                Container(
                  height: 200, // 원하는 높이 지정
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // 테두리 추가 (선택 사항)
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: _productInfo.option.itemList.map((optionItem) {
                        return CheckboxListTile(
                          title: Text("${optionItem.name} (+${optionItem.price}원)"),
                          value: selectedOptionItems[optionItem.id] ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              selectedOptionItems = {
                                ...selectedOptionItems,
                                optionItem.id: value ?? false, // 새로운 Map을 생성하여 갱신
                              };
                              debugPrint("체크값 : $value");
                              debugPrint("저장값 : ${selectedOptionItems[optionItem.id]}");
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
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
        title: const Text("장바구니", style: TextStyle(fontWeight: FontWeight.bold)),
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
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("데이터를 불러올 수 없습니다."));
            } else if (snapshot.data is! List<Map<String, dynamic>>) {
              return const Center(child: Text("잘못된 데이터 형식입니다."));
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text("장바구니가 비어 있습니다."));
            }
            List<Map<String, dynamic>> cartItems = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Cart cart = Cart.fromMap(cartItems[index]);
                return _buildCartItem(cart);
              },
            );
          },
        ),
      ),
    );
  }

  // 장바구니 항목 카드
  Widget _buildCartItem(Cart cart) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 이미지
            ClipRRect(borderRadius: BorderRadius.circular(8), child: ImageWidget(id: cart.productsId, width: 80, height: 80)),
            const SizedBox(width: 10),
            // 상품 정보
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Column의 높이를 자식 요소 크기만큼만 설정
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품 이름과 가격
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cart.productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${cart.price}원",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      // 삭제 버튼
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeItem(cart.id),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // 수량 및 옵션 변경버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("수량: ${cart.amount}개"),
                      // 해당 상품에 옵션이 존재할때만 옵션변경 가능
                      if (cart.optionsId.isNotEmpty)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {
                            _showMenu(cart);
                          },
                          child: Text("옵션 변경"),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  if (cart.optionList.isNotEmpty)
                    // 옵션 리스트
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "옵션: ",
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: cart.optionList
                                .map(
                                  (e) => Text("${e.name} - ${CustomFormat().formatNumber(e.price)}원"),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
