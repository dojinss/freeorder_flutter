import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("images/payComplete.png"), width: 300),
            SizedBox(height: 50),
            Text(
              "결제 완료!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/menu/list");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 100, 50),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text("OK", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/order/list");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 100, 50),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text("결제내역", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
