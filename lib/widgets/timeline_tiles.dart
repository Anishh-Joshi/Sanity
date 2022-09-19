import 'dart:async';

import 'package:flutter/material.dart';

class TimelineTiles extends StatefulWidget {
  final int totalCount;
  final int indexCount;
  const TimelineTiles({
    Key? key,
    required this.totalCount,
    required this.indexCount,
  }) : super(key: key);

  @override
  State<TimelineTiles> createState() => _TimelineTilesState();
}

class _TimelineTilesState extends State<TimelineTiles> {
  int currentIndex = 0;
  Timer? timer;
  @override
  void initState() {
    changetext();
    timer =
        Timer.periodic(const Duration(seconds: 6), (Timer t) => changetext());
    super.initState();
  }

  void changetext() {
    setState(() {
      currentIndex++;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<Widget> _myWidget(int count) {
      return List.generate(
        count,
        (i) => Container(
          margin: const EdgeInsets.only(right: 1),
          color:
              currentIndex <= i ? Colors.grey : Theme.of(context).primaryColor,
          height: 3,
          width: widget.totalCount >= 4
              ? widget.totalCount >= 10
                  ? (0.6 / widget.totalCount) * width * 0.99
                  : (0.9 / widget.totalCount) * width * 0.99
              : (1 / widget.totalCount) * width * 0.99,
        ),
      ).toList(); // replace * with your rupee or use Icon instead
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _myWidget(widget.totalCount));
  }
}
