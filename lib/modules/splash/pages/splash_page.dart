import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF00002A),
      body: Column(
        children: [
          Expanded(
            child: RiveAnimation.network(
                "https://public.rive.app/community/runtime-files/341-657-galaxy-is-here.riv"),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Text(
              "Carregando ...",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
