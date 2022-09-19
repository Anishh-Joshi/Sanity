import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
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
<<<<<<< HEAD
      height: MediaQuery.of(context).size.height / 8,
      child: Center(
        child: ListTile(
          leading: const CircleAvatarCustom(
            radius: 20,
            url: "/media/default.jpg",
          ),
          title: Text(
            "Anish Joshi says, Help Me !!",
            style: Theme.of(context).textTheme.headline4,
          ),
          trailing: const Text("14m ago"),
          subtitle: Text(
            "So this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatata.so this is the sotru of anish joshi hakuna matatatattatataso this is the sotru of anish joshi hakuna matatatattatata",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
=======
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatarCustom(
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
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Text("48",style: Theme.of(context).textTheme.bodyLarge,),
                      const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    FontAwesome5.comment_alt,
                    size: 14,
                    color: Color(0xff787878),
                  ),
                  
                  const SizedBox(
                    width: 10,
                  ),
                
                  Text("8",style: Theme.of(context).textTheme.bodyLarge,),
                   const SizedBox(
                    width: 4,
                  ),
                   const Icon(
                    Fontisto.doctor,
                    size: 10,
                    color: Color(0xff787878),
                  ),

                 const SizedBox(
                    width: 10,
                  ),
                  
                  const Icon(
                    AntDesign.caretup,
                    color: Colors.greenAccent,
                  ),
                 
                  const SizedBox(
                    width: 4,
                  ),
                   Text("48",style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
            ),
          )
        ],
>>>>>>> ae0846fbfc6b5f4f963b363abc708e2003db6f34
      ),
    );
  }
}
