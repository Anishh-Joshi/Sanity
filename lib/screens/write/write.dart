import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class WritePage extends StatefulWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController _writtenLogController = TextEditingController();
  void handleSubmit(BuildContext context) {
   try{
     context
        .read<LogBlocBloc>()
        .add(LogSendButtonPressed(log: _writtenLogController.text, userId: 1));
   }catch(e){
    print('Something Went Wrong!');
   }

   _writtenLogController.clear();
  }

  void handleGet(BuildContext context){
    context.read<LogBlocBloc>().add(CheckLogToday());
  }

  @override
  void dispose(){
    _writtenLogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return FloatingActionButton(
              onPressed: () => handleSubmit(context),   
              child: const Icon(Icons.send),
              backgroundColor: Theme.of(context).primaryColor,
            );
          }
          return FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).primaryColor,
          );
        },
      ),
      appBar: MyCustomAppBar(
          appBarTitle: 'Daily Log', iconData: Icons.mic, onPressed: () {}),
      body: BlocBuilder<LogBlocBloc, LogBlocState>(
        builder: (context, state) {
          if (state is LogSending) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LogSent) {
            return Column(
              children: [
                Container(
                  height: 400,
                  child: TextField(
                    controller: _writtenLogController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      hintText: 'Tell us about your feeling right now.',
                      helperText: 'Keep it short.',
                    ),
                    maxLines: MediaQuery.of(context).size.height.floor(),
                    autofocus: true,
                    cursorColor: Theme.of(context).indicatorColor,
                    style: Theme.of(context).textTheme.headline3,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                ElevatedButton(onPressed: ()=>handleGet(context) ,child: Text("Press me to get the logs!"))
              ],
            );
          }
          return const Center(child: Text("Something went wrong!"));
        },
      ),
    );
  }
}
