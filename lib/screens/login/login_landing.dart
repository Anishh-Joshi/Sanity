import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';


class LoginLanding extends StatelessWidget {
  static const String routeName = 'login_landing';
  const LoginLanding({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LoginLanding(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
               const Expanded(
                child: Image(
                  image: AssetImage('assets/logos/sanity_full.png'),
                ),
              ),
              ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))
                                    
                                    ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child:  SizedBox(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("Login",style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white,fontSize: 18  ),)),
                                ))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {},
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children:  [
                                      const Icon(
                                        AntDesign.google,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "Google",
                                        style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white,fontSize: 18  ),
                                      ),
                                      const Opacity(
                                          opacity: 0,
                                          child: Icon(AntDesign.google)),
                                    ],
                                  ),
                                ))),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child:  Text(
                              "Don't have an account? Sign up.",
                              style: Theme.of(context).textTheme.headline5!.copyWith(color: Color(0xff787878)),
                            )),
                            TextButton(
                            onPressed: () {},
                            child:  Text(
                              "Privacy Policy",
                              style: Theme.of(context).textTheme.headline5!.copyWith(color: Color(0xff787878)),
                            )),
              
            ],
          ),
        ),
      ),
    );
  }
}
