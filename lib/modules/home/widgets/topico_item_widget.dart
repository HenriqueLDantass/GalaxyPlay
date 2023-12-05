import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:get/get.dart';

class TopicoItem extends StatelessWidget {
  final RxList<HomeModel> home;
  final int index;
  const TopicoItem({super.key, required this.home, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text(home[index].title)],
      ),
    );
  }
}
