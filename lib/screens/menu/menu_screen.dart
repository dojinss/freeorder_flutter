import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // 상품 데이터
  final List<Map<String, String>> products = [
    {
      "image": "images/데빌구.gif", // 로컬 이미지 사용
      "name": "상품 1",
      "description": "상품 1의 설명입니다.",
      "price": "₩10,000"
    },
    {
      "image": "images/화난 데빌구.jpg",
      "name": "상품 2",
      "description": "상품 2의 설명입니다.",
      "price": "₩20,000"
    },
    {
      "image": "images/product1.jpg",
      "name": "상품 3",
      "description": "상품 3의 설명입니다.",
      "price": "₩30,000"
    },
  ];

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
            onPressed: () {},
            iconSize: 30,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          ),
          actions: [
            IconButton(
              onPressed: () {},
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
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  // 개별 상품 카드 위젯
  Widget _buildProductCard(Map<String, String> product) {
    return Card(
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
              child: Image.asset(
                product["image"]!,
                width: 70,  // 이미지 크기 조정
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
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
                        product["name"]!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product["price"]!,
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
                    product["description"]!,
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
    );
  }
}
