import 'package:flutter/material.dart';

class OnlineBackUp extends StatelessWidget {
  const OnlineBackUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Backup'),
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {},
            child: const Text('SIGN IN WITH E-MAIL'),
          ),
          const Text('OR'),
          MaterialButton(
            onPressed: () {},
            child: const Text('SIGN UP WITH EMAIL'),
          ),
        ],
      ),
    );
  }
}
