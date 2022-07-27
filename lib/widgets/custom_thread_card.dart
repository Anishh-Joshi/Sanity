import 'package:flutter/material.dart';
import 'package:sanity/widgets/circle_avatar.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 10,
      child: ListTile(
        leading: const CircleAvatarCustom(
          radius: 20,
          url: "/media/default.jpg",
        ),
        title: Text(
          "Help Me !!",
          style: Theme.of(context).textTheme.headline4,
        ),
        trailing: const Text("14m ago"),
        subtitle: Text(
          "So this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatataso this is the sotru of anish joshi hakuna matatatattatata",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
