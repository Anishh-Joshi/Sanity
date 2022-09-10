
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';

class WriteField extends StatelessWidget {
  static const String routeName = '/writelog';
    final TextEditingController _writtenLogController = TextEditingController();
   WriteField({Key? key}) : super(key: key);
     static Route route() {
    return MaterialPageRoute(
        builder: (_) =>  WriteField(),
        settings: const RouteSettings(name: routeName));
  }


  void handleSubmit(BuildContext context) {
   try{
     context.read<LogBlocBloc>()
        .add(LogSendButtonPressed(log: _writtenLogController.text, userId: 1));
   }catch(e){
    print('Something Went Wrong!');
   }

   _writtenLogController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LogBlocBloc, LogBlocState>(
            builder: (context, state) {
              if (state is LogSending) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LogSent) {
                return SizedBox(
                  height: 400,
                  child: TextField(
                    controller: _writtenLogController,
                    decoration:  InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      hintText: 'Tell us about your feeling right now.',
                      helperText: 'Keep it short.',
                      hintStyle: Theme.of(context).textTheme.headline5
                    ),
                    maxLines: MediaQuery.of(context).size.height.floor(),
                    autofocus: true,
                    cursorColor: Theme.of(context).indicatorColor,
                    style: Theme.of(context).textTheme.headline3,
                    keyboardType: TextInputType.multiline,
                  ),
                );
              }
              return const Center(child: Text("Something went wrong!"));
            },
          );
    
  }
}