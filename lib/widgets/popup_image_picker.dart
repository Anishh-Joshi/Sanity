import 'package:flutter/material.dart';

class ImagePickPopUp extends StatelessWidget {
  const ImagePickPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3),
            // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              onPressed: () {},
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Center(child: Text("Take from Camera")))),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              onPressed: () {},
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Center(child: Text("Gallery"))))
        ],
      ),
    );
  }
}
