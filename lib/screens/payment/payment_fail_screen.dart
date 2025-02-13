import 'package:flutter/material.dart';

class PaymentFailScreen extends StatefulWidget {
  const PaymentFailScreen({super.key});

  @override
  State<PaymentFailScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentFailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("images/payFail.png"), width: 100),
            SizedBox(height: 20),
            Text(
              "결제에 실패하였습니다.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              " 잠시후 다시 시도해주세요.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/cart/list");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 100, 50),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text("장바구니", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
