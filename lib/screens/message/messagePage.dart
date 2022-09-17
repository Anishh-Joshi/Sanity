
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/widgets/bottom_appbar.dart';

import '../../blocs/login/login_bloc.dart';

class MessagePage extends StatelessWidget {
   static const String routeName = 'message_page';
  const MessagePage({Key? key}) : super(key: key);
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => const MessagePage(),
        settings: const RouteSettings(name: routeName));
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if(state is LoginAuthenticated){
          return  CustomNavbar(isDoctor: state.user.isDoctor!);
        }
        return const SizedBox();
        
      },
    ),
      body: Center(child: Text("HELLO FROM MessagePage ")),
    );
  }
}
