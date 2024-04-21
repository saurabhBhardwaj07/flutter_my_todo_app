import 'package:flutter/material.dart';
import 'package:my_todo_app/core/app_exports.dart';

class AppsSplashScreen extends StatefulWidget {
  const AppsSplashScreen({super.key});

  @override
  State<AppsSplashScreen> createState() => _AppsSplashScreenState();
}

class _AppsSplashScreenState extends State<AppsSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      Navigator.pushNamedAndRemoveUntil(context, "dashboard", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F4F3),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 25.v),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: const Color(0xff5448C8),
                      borderRadius: BorderRadius.circular(20.adaptSize),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff5448C8)
                              .withOpacity(0.2), // Color of the shadow
                          spreadRadius: 20, // Spread radius
                          blurRadius: 40, // Blur radius
                          offset:
                              const Offset(0, 0), // Changes position of shadow
                        ),
                      ]),
                  child: Icon(
                    Icons.done,
                    size: 40.adaptSize,
                    color: Colors.white,
                  ),
                ),
                40.sbH,
                const Text(
                  "Welcome To",
                  style: TextStyle(
                    fontFamily: FontFamily.spaceMono,
                    fontSize: 24,
                  ),
                ),
                const Text(
                  "My Todo",
                  style: TextStyle(
                      fontFamily: FontFamily.spaceMono,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                15.sbH,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "My todo helps you to stay oragnaized and perform your task much faster.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: FontFamily.spineSans,
                        fontSize: 14,
                        color: Color.fromARGB(255, 171, 169, 169)),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "@ PeeperCloud 2024",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: FontFamily.spineSans,
                        fontSize: 14,
                        color: Color.fromARGB(255, 171, 169, 169)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
