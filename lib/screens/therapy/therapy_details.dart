import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/timeline_tiles.dart';
import '../home/home.dart';

class TherapyDetails extends StatefulWidget {
  static const String routeName = 'therapy_details';

  const TherapyDetails({Key? key}) : super(key: key);
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const TherapyDetails(), settings: settings);
  }

  @override
  State<TherapyDetails> createState() => _TherapyDetailsState();
}

class _TherapyDetailsState extends State<TherapyDetails> {
  List p = [];

  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(0.85);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  void splitValue(text) {
    p = text.split(".");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TherapyBloc, TherapyState>(
          builder: (context, state) {
            if (state is TherapyLoaded) {
              splitValue(state.therapydetails!.contents);
              speak(state.therapydetails!.contents!);
              return Column(
                children: [
                  TimelineTiles(
                    indexCount: 10,
                    totalCount: p.length,
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          await flutterTts.stop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).cardColor),
                            child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Entypo.cross))),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurpleAccent),
                          child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.music_note))),
                    ],
                  ),
                  Lottie.asset('assets/lottie/consult.json', height: 200),

                  SelfSpeakingText(
                    p: p,
                    content: state.therapydetails!.contents!,
                  )
                  // ElevatedButtonCustom(action: (){
                  //   speak();
                  // }, color: Colors.red, buttonTitle: "speak")
                ],
              );
            }
            return const CircularProgressIndicatorCustom();
          },
        ),
      )),
    );
  }
}

class SelfSpeakingText extends StatefulWidget {
  const SelfSpeakingText({Key? key, required this.p, required this.content})
      : super(key: key);

  final List p;
  final String content;

  @override
  State<SelfSpeakingText> createState() => _SelfSpeakingTextState();
}

class _SelfSpeakingTextState extends State<SelfSpeakingText> {
  Timer? timer;
  int? totalIndex;
  int currentIndex = 0;
  int nextIndex = 0;
  @override
  void initState() {
    totalIndex = widget.p.length;
    changetext();
    timer =
        Timer.periodic(const Duration(seconds: 18), (Timer t) => changetext());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void changetext() {
    setState(() {
      if (totalIndex! - nextIndex > 3) {
        currentIndex = nextIndex;
        nextIndex = currentIndex + 3;
      } else {
        nextIndex = totalIndex!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.content.split(".").getRange(currentIndex, nextIndex).join(", ") +
          ".",
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
