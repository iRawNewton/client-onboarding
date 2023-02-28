import 'package:client_onboarding_app/screens/2selectuser/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyAppGetStarted extends StatelessWidget {
  const MyAppGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Lottie.asset('assets/animations/GetStarted.json'),
                ),
                const Text(
                  'See your Project Status with\nKyptronix',
                  style: TextStyle(
                      fontFamily: 'BakbakOne',
                      fontSize: 24,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Our platform gives you an up-to-date view of\nyour project status so you can stay on top of things.',
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyUsers(),
                            ),
                          );
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18, letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
