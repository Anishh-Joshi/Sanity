import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_thread_card.dart';
import 'package:sanity/widgets/home_card.dart';
import 'package:sanity/widgets/sliver_effect_home.dart';

import '../../widgets/platform_aware.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
              child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                const PlatformAADialog(
                  title: 'Oops',
                  content: "Something Went Wrong!",
                  defaultActionText: "Ok",
                ).show(context);
              } else if (state is LoginUnAuthenticated) {
                Navigator.of(context,rootNavigator:true ).pushNamedAndRemoveUntil('landing_page', (route) => false);
              }
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: MyHomeGreetHeader(scaffoldKey: _scaffoldKey)),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const HomeSymmaryCard(),
                      ListView.builder(
                        itemCount: 50,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const ThreadCard();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
        
        drawer: CustomDrawer(
          scaffoldKey: _scaffoldKey,
        ));
  }
}
