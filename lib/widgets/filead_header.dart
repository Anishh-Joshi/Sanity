import 'package:flutter/material.dart';

class AppBarInfo extends StatelessWidget {
  final double height;
  final String title;
  final VoidCallback onPressed;
  final bool showDone;
  final double? margin;

  const AppBarInfo(
      {required this.height,
      this.margin = 0.03,
      required this.onPressed,
      required this.showDone,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            showDone
                ? InkWell(
                    highlightColor: Theme.of(context).cardColor,
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: onPressed,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).primaryColor),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.done,color: Colors.white,),
                          )),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const Divider(
          color: Colors.transparent,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontSize: height * 0.045),
        ),
        SizedBox(
          height: height * margin!,
        ),
      ],
    );
  }
}
