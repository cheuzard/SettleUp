import 'package:flutter/material.dart';
import 'Theme_info.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SettleUp',
      theme: AppTheme.lightTheme,
      home: const PaymentTracker(),
    );
  }
}

class PaymentTracker extends StatefulWidget{
  const PaymentTracker({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentTrackerState();
}


class _PaymentTrackerState extends State<PaymentTracker> {
  bool extended = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        extended = !extended;
                      });
                    },
                    child: AnimatedContainer(
                      height: extended ? 133 : 214 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35)
                        ),
                        border: BorderDirectional(bottom: BorderSide(
                          color: Colors.black,
                          width: 4,
                        ))
                      ),
                      duration: Duration(milliseconds: 230),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox.fromSize(size: Size(1, 8),)
              ],
            ),
            Row(
              children: [
                Expanded(child: Container(
                ))
              ],
            )
          ],
        ),
    );
  }
}