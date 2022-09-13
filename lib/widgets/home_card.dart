import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class TherapyCard extends StatelessWidget {
  final String therapy;
  final String by;
  final int enrolled;
  final String category;
  const TherapyCard(
      {Key? key,
      required this.therapy,
      required this.by,
      required this.enrolled,
      required this.category})
      : super(key: key);

String emojiPicker(String category){

  switch (category) {
    case "Depressed":
      return "☹️";
    case "Anxeity":
      return "😨";
    case "Stressed":
      return "🤕";
    case "Sad":
      return "😥";
    case "Jealous":
      return "😪";
    case "Insecure":
      return "🥺";
    case "Suicidal":
      return "😰";
    default:
    return "😶";
  }

}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                therapy,
                style: Theme.of(context).textTheme.headline3,
              ),
              Row(
                children: [
                  Text(
                    "Dr. ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    by,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(AntDesign.clockcircleo,size: 14,color: Theme.of(context).canvasColor,),
                  SizedBox(width: 4,),
                  Text("5 days ago",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).canvasColor)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      Text(
                        " ${emojiPicker(category)}",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.pink, fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${enrolled}+",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.pink),
                      ),
                      Text(
                        " involved",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
