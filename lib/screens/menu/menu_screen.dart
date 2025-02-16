import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/category.dart';
import 'package:freeorder_flutter/models/product.dart';
import 'package:freeorder_flutter/provider/user_provider.dart';
import 'package:freeorder_flutter/screens/menu/menu_detail_screen.dart';
import 'package:freeorder_flutter/services/category_service.dart';
import 'package:freeorder_flutter/services/product_service.dart';
import 'package:freeorder_flutter/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<List<Map<String, dynamic>>> _products;
  final productService = ProductService();
  final CategoryService _categoryService = CategoryService();

  List<Category> _cateList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _loadProduct("all");
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.loadCartItemCount(); // ✅ 장바구니 개수 다시 불러오기
    });
  }

  // ✅ 카테고리 목록 불러오기
  Future<void> _fetchCategories() async {
    try {
      List<Map<String, dynamic>> categoryData = await _categoryService.list();
      debugPrint("카테고리 조회 : $categoryData");
      setState(() {
        _cateList = categoryData.map((e) => Category.fromMap(e)).toList();
        _isLoading = false;
      });
    } catch (error) {
      debugPrint("카테고리 불러오기 오류: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ✅ 상품 데이터 불러오기
  void _loadProduct(String id) {
    setState(() {
      _products =
          id == "all" ? productService.list() : productService.listByCate(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : DefaultTabController(
            length: _cateList.length + 1,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  "메뉴",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_circle_left_outlined),
                  onPressed: () => Navigator.pop(context),
                  iconSize: 30,
                ),
                actions: [
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      return Stack(
                        children: [
                          IconButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, "/cart/list"),
                            icon: const Icon(Icons.shopping_cart),
                            iconSize: 35,
                          ),
                          if (!userProvider.isCartLoaded) // ✅ 로딩 중이면 빈 값 표시
                            Positioned(
                              right: 5,
                              top: 5,
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2), // ✅ 로딩 중 표시
                              ),
                            )
                          else if (userProvider.cartItemCount >
                              0) // ✅ 장바구니 개수 반영
                            Positioned(
                              right: 5,
                              top: 5,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Text(
                                  "${userProvider.cartItemCount}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.orangeAccent,
                  tabs: [
                    const Tab(text: "전체"),
                    ..._cateList.map((category) => Tab(text: category.name)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildProductList("all"),
                  ..._cateList
                      .map((category) => _buildProductList(category.id)),
                ],
              ),
            ),
          );
  }

  // ✅ 상품 리스트를 빌드하는 함수
  Widget _buildProductList(String id) {
    _loadProduct(id);
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("데이터 조회 중 오류 발생"));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("조회된 데이터가 없습니다."));
          } else {
            List<Map<String, dynamic>> productData = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: productData.length,
              itemBuilder: (context, index) {
                final product = Product.fromMap(productData[index]);
                return _buildProductCard(product);
              },
            );
          }
        },
      ),
    );
  }

  // ✅ 개별 상품 카드 위젯
  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuDetailScreen(productId: product.id)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageWidget(id: product.id, width: 100, height: 100),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name.isNotEmpty ? product.name : '기본 상품명',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${product.price}원",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.description.isNotEmpty
                          ? product.description
                          : "상품 설명이 없습니다.",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
