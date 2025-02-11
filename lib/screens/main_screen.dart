import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Qr Order",
              style: TextStyle(fontSize: 35, color: Color.fromARGB(255, 255, 100, 50), fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  backgroundColor: Color.fromARGB(255, 255, 100, 50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                Navigator.pushNamed(context, "/menu/list");
              },
              child: Column(
                children: [
                  Image(image: AssetImage("images/qrHall.png"), width: 100),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "매장식사",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  backgroundColor: Color.fromARGB(255, 255, 100, 50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                Navigator.pushNamed(context, "/menu/list");
              },
              child: Column(
                children: [
                  Image(image: AssetImage("images/qrTakeout.png"), width: 100),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "포장",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
