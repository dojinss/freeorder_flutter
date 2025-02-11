import 'package:flutter/material.dart';
import 'package:freeorder_flutter/models/product.dart';
import 'package:freeorder_flutter/screens/menu/menu_detail_screen.dart';
import 'package:freeorder_flutter/services/product_service.dart';
import 'package:freeorder_flutter/widgets/image_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // 상품 데이터
  late Future<List<Map<String, dynamic>>> _products;
  final productServcie = ProductService();
  @override
  void initState() {
    super.initState();
    _products = productServcie.list();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 탭 개수
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "메뉴",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 30,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "/cart/list",
                );
              },
              icon: Icon(Icons.shopping_cart),
              iconSize: 35,
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orangeAccent,
            tabs: [
              Tab(text: "전체"),
              Tab(text: "베스트"),
              Tab(text: "신상품"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProductList(), // 전체 상품
            _buildProductList(), // 베스트 상품
            _buildProductList(), // 신상품
          ],
        ),
      ),
    );
  }

  // 상품 리스트를 빌드하는 함수
  Widget _buildProductList() {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: FutureBuilder(
        future: _products,
        builder: (context, snapshot) {
          // 로딩중
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // 에러
          else if (snapshot.hasError) {
            return Center(
              child: Text("데이터 조회시 에러, 에러 발생"),
            );
          }
          // 데이터 없음
          else if (!snapshot.hasError && snapshot.data!.isEmpty) {
            return Center(
              child: Text("조회된 데이터가 없습니다."),
            );
          }
          // 데이터 있음
          else {
            List<Map<String, dynamic>> productData = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(10),
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

  // 개별 상품 카드 위젯
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상품 이미지
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ImageWidget(id: product.id, width: 200, height: 200,)),
              SizedBox(width: 10),
              // 상품 정보 (Column 사용)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상품 이름과 가격
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${product.price}원",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    // 상품 설명
                    Text(
                      product.description,
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
