  import 'dart:async';
  import 'dart:io';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_font_icons/flutter_font_icons.dart';
  import 'package:intl/intl.dart';
  import 'package:pdf/pdf.dart';
  import 'package:sanity/apis/utf_converter.dart';
  import 'package:sanity/blocs/dass_bloc/dass41_bloc.dart';
  import 'package:sanity/model/message_model.dart';
  import 'package:sanity/model/question_map.dart';
  import 'package:sanity/screens/test/test_page.dart';
  import 'package:sanity/widgets/circle_avatar.dart';
  import 'package:sanity/widgets/circular_progress.dart';
  import 'package:sanity/widgets/platform_aware.dart';
  import '../../blocs/home/home_bloc.dart';
  import '../../hardware_config/pdf_io.dart';
  import '../../model/appointment_model.dart';
  import 'package:basics/basics.dart';
  import 'package:pdf/widgets.dart' as pw;
  import 'package:path_provider/path_provider.dart';

  class MessagePage extends StatefulWidget {
    static const String routeName = 'message_page';
    const MessagePage({Key? key}) : super(key: key);
    static Route route(RouteSettings settings) {
      return MaterialPageRoute(
          builder: (context) => MessagePage(), settings: settings);
    }

    @override
    State<MessagePage> createState() => _MessagePageState();
  }

  class _MessagePageState extends State<MessagePage> {
    var style_type;
    final pdf = pw.Document();
    Future savePDF(String name) async {
      Directory docDirectory = await getApplicationDocumentsDirectory();
      String documentPath = docDirectory.path;
      File file = File("$documentPath/$name.pdf");
      file.writeAsBytesSync(await pdf.save());
    }

    bool isWritten = false;
    writePdf(List questions, List answers, AppointmentModel appointment,
        String created_at, String category) {
      List<pw.Widget> widgets = [];
      pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(32),
            build: (context) {
              widgets.add(pw.SizedBox(
                height: 80,
              ));

              widgets.add(pw.Center(
                  child: pw.Text("Sanity: Dass41 Test Results Pdf",
                      style: pw.TextStyle(fontSize: 35))));
              widgets.add(pw.SizedBox(
                height: 20,
              ));

              widgets.add(pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text(appointment.patient.fullName!,
                          style: pw.TextStyle(fontSize: 15)),
                      pw.Text(appointment.patient.address!,
                          style: pw.TextStyle(fontSize: 12)),
                      pw.Text(appointment.patient.age.toString(),
                          style: pw.TextStyle(fontSize: 12)),
                    ],
                  ),
                  pw.Text(
                      "Date: ${DateFormat.yMMMMd().format(DateTime.parse(created_at))}",
                      style: pw.TextStyle(fontSize: 12))
                ],
              ));

              for (int i = 0; i < questions.length + 8; i++) {
                widgets.add(pw.SizedBox(
                  height: 40,
                ));

                widgets.add(pw.Text(
                    Converter.utf8convert(i >= questions.length
                        ? QuestionMap.options[i - 52]['cat']
                        : questions[i]['question']),
                    style: pw.TextStyle(fontSize: 22)));
                widgets.add(pw.SizedBox(
                  height: 10,
                ));
                widgets.add(pw.Text(
                    i >= questions.length && i != 58
                        ? QuestionMap.options[i - 52]['options'][answers[i]]
                        : i == 58
                            ? answers[i].toString()
                            : questions[i]['checked']
                                ? returnOptionMappedDas(answers[i].toString())
                                : returnOptionMappedTipi(answers[i].toString()),
                    style: pw.TextStyle(fontSize: 20)));
              }
              return widgets;
            }),
      );
    }

    String returnOptionMappedTipi(String i) {
      int index = int.parse(i);
      return QuestionMap.chooseTipi[index - 1];
    }

    String returnOptionMappedDas(String i) {
      int index = int.parse(i);
      return QuestionMap.chooseDas[index - 1];
    }

    int? previousMessageOwner = -0;
    final TextEditingController _messageController = TextEditingController();
    void handleSubmit(
        {required AppointmentModel appointment,
        required int currentUserId}) async {
      setState(() {
        isLoading = true;
      });
      final String message = _messageController.text;
      _messageController.clear();

      try {
        await FirebaseFirestore.instance
            .collection('messages')
            .doc(appointment.appointmentId.toString())
            .collection('message')
            .doc(DateTime.now().toString())
            .set({
          "messageText": message,
          "sentBy": currentUserId,
          "timestamp": DateTime.now(),
          "seenBy": [currentUserId],
        });
      } catch (e) {
        PlatformAADialog(
          content: "Something Went Wrong",
          title: e.toString(),
          defaultActionText: 'Dismiss',
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Future<void> _confirmDelete(
        {required BuildContext context,
        String? messageId,
        required AppointmentModel appointmentModel}) async {
      if (messageId == null) {
        final didRequest = await const PlatformAADialog(
          title: "Confirm Delete",
          content:
              "This will also clear conversation from doctors appointment. Are you sure you want to delete this conversation ?",
          cancelActionText: "Cancel",
          defaultActionText: 'Delete',
        ).show(context);
        if (didRequest) {
          FirebaseFirestore.instance
              .collection('messages')
              .doc(appointmentModel.appointmentId.toString())
              .get()
              .then((doc) {
            if (doc.exists) {
              doc.reference.delete();
            }
          });
        }
      } else {
        final didRequest = await const PlatformAADialog(
          title: "Confirm Delete",
          content: "Are you sure you want to delete this message ?",
          cancelActionText: "Cancel",
          defaultActionText: 'Delete',
        ).show(context);
        if (didRequest) {
          await FirebaseFirestore.instance
              .collection('messages')
              .doc(appointmentModel.appointmentId.toString())
              .collection('message')
              .doc(messageId)
              .delete();
        }
      }
    }

    bool isLoading = false;
    bool render = true;

    Stream<QuerySnapshot> getMessages(
        {required AppointmentModel appointment, required int currentUserId}) {
      Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
          .collection('messages')
          .doc(appointment.appointmentId.toString())
          .collection('message')
          .snapshots();
      return snapshot;
    }

    Stream<QuerySnapshot> getDassStatus({required AppointmentModel appointment}) {
      Stream<QuerySnapshot> snapshot =
          FirebaseFirestore.instance.collection('dassPermission').snapshots();
      return snapshot;
    }

    bool determineShared(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
        AppointmentModel appointmentModel) {
      for (var element in snapshot.data!.docs) {
        if (element.id == appointmentModel.appointmentId.toString()) {
          return true;
        }
      }

      return false;
    }

    bool showSnackbar = false;

    @override
    Widget build(BuildContext context) {
      style_type = Theme.of(context).textTheme.headline1;

      final AppointmentModel appointment =
          ModalRoute.of(context)!.settings.arguments as AppointmentModel;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            StreamBuilder<QuerySnapshot>(
                stream: getDassStatus(appointment: appointment),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (determineShared(snapshot, appointment)) {
                      return BlocBuilder<Dass41Bloc, Dass41State>(
                        builder: (context, state) {
                          if (state is Dass41Initial) {
                            return const CircularProgressIndicatorCustom();
                          }
                          if (state is PdfRequested) {
                            return IconButton(
                                onPressed: () async {
                                  String docName = appointment.patient.fullName! +
                                      appointment.appointmentId.toString() +
                                      DateTime.now().toString();
                                  !isWritten
                                      ? writePdf(
                                          state.questionsPdf!,
                                          state.answers!,
                                          appointment,
                                          state.created_at!,
                                          state.category!)
                                      : null;
                                  await savePDF(docName);

                                  isWritten = true;

                                  Directory documentDirectory =
                                      await getApplicationDocumentsDirectory();

                                  String documentPath = documentDirectory.path;

                                  String fullPath = "$documentPath/$docName.pdf";
                                  pdf.save();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfApp(
                                                path: fullPath,
                                              )));
                                },
                                icon: const Icon(
                                    MaterialCommunityIcons.file_download),
                                color: Theme.of(context).primaryColor);
                          }
                          return const SizedBox();
                        },
                      );
                    }
                  }
                  return const SizedBox();
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    _confirmDelete(
                        context: context, appointmentModel: appointment);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).canvasColor,
                  )),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatarCustom(
              url: appointment.patient.profileImgUrl!,
              radius: 15,
            ),
          ),
          title: Text(
            appointment.patient.fullName!,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child:
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  if (state is HomeLoaded) {
                    return Column(
                      children: [
                        StreamBuilder(
                          stream: getMessages(
                              appointment: appointment,
                              currentUserId: state.user!.userId!),
                          builder: ((context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicatorCustom();
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  final MessageModel message =
                                      MessageModel.fromJSON(
                                          snapshot.data.docs[index]);
                                  final MessageModel nextMessage =
                                      MessageModel.fromJSON(snapshot.data.docs[
                                          index == snapshot.data.docs.length - 1
                                              ? index
                                              : index + 1]);
                                  return InkWell(
                                    onLongPress: () {
                                      message.sentBy == state.user!.userId!
                                          ? _confirmDelete(
                                              context: context,
                                              messageId: message.messageId,
                                              appointmentModel: appointment)
                                          : null;
                                    },
                                    child: MessageList(
                                      renderPhoto:
                                          nextMessage.sentBy != message.sentBy,
                                      appointment: appointment,
                                      message: message,
                                      currentUerId: state.user!.userId!,
                                    ),
                                  );
                                  ;
                                });
                          }),
                        )
                      ],
                    );
                  }
                  return const SizedBox();
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(23)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextField(
                        enabled:
                            (appointment.atTime! - DateTime.now()).inDays == 0,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.headline5,
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.headline5,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          suffixIcon: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoaded) {
                                return (appointment.atTime! - DateTime.now())
                                            .inDays ==
                                        0
                                    ? IconButton(
                                        icon: Icon(Icons.send,
                                            color:
                                                Theme.of(context).primaryColor),
                                        onPressed: isLoading
                                            ? null
                                            : () => handleSubmit(
                                                appointment: appointment,
                                                currentUserId:
                                                    state.user!.userId!),
                                        splashRadius: 0.1,
                                      )
                                    : const SizedBox();
                              }
                              return const SizedBox();
                            },
                          ),
                          hintText: (appointment.atTime! - DateTime.now())
                                      .inDays ==
                                  0
                              ? "Message..."
                              : "You can message only on your appointed date.",
                          labelStyle: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    }
  }

  class MessageList extends StatefulWidget {
    final MessageModel message;
    final AppointmentModel appointment;
    final int currentUerId;
    final bool renderPhoto;
    const MessageList(
        {required this.appointment,
        required this.renderPhoto,
        required this.currentUerId,
        required this.message,
        Key? key})
        : super(key: key);

    @override
    State<MessageList> createState() => _MessageListState();
  }

  class _MessageListState extends State<MessageList> {
    String readTimestamp({required Timestamp createdAt}) {
      String sentTimeHour = createdAt.toDate().hour.toString();
      String sentTimeMinute = createdAt.toDate().minute.toString();
      String sentAt = " $sentTimeHour: $sentTimeMinute ";
      return sentAt;
    }

    Future<void> sendDassScore(
        {required BuildContext context,
        String? messageId,
        required AppointmentModel appointmentModel}) async {
      FirebaseFirestore.instance
          .collection('dassPermission')
          .doc(appointmentModel.appointmentId.toString())
          .set({});
    }

    bool determineText({required String text}) {
      List keys = [
        'ADSS',
        'DASS',
        'DSAS',
        'DSSA',
        'TEST',
        'TETS',
        'TSET',
        'DASS41',
        'DAS',
        'ADS',
        'DSA',
      ];

      for (int i = 0; i < keys.length; i++) {
        if (text.toLowerCase().contains(keys[i].toLowerCase())) {
          return true;
        }
      }
      return false;
    }

    bool showDetails = false;
    @override
    Widget build(BuildContext context) {
      final double width = MediaQuery.of(context).size.width;
      return Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 4),
          child: widget.message.sentBy == widget.currentUerId
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showDetails
                                ? showDetails = false
                                : showDetails = true;
                          });
                          Timer(const Duration(milliseconds: 800), () {
                            setState(() {
                              showDetails
                                  ? showDetails = false
                                  : showDetails = true;
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.message.messageText!,
                                    style: Theme.of(context).textTheme.headline5),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                      child: widget.message.seenBy.contains(
                                              widget.appointment.patient.userId)
                                          ? const Icon(
                                              MaterialCommunityIcons.check_all,
                                              size: 17,
                                            )
                                          : const Icon(
                                              MaterialCommunityIcons.check,
                                              size: 17,
                                            )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    showDetails
                        ? Text(
                            readTimestamp(createdAt: widget.message.timeStamp!),
                            style: Theme.of(context).textTheme.headline6,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    showDetails
                        ? Text(
                            readTimestamp(createdAt: widget.message.timeStamp!),
                            style: Theme.of(context).textTheme.headline6,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showDetails
                                ? showDetails = false
                                : showDetails = true;
                          });
                          Timer(const Duration(milliseconds: 800), () {
                            setState(() {
                              showDetails
                                  ? showDetails = false
                                  : showDetails = true;
                            });
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                widget.renderPhoto
                                    ? CircleAvatarCustom(
                                        url: widget.currentUerId ==
                                                widget.appointment.patient.userId
                                            ? widget
                                                .appointment.doctor.profileImgUrl!
                                            : widget.appointment.patient
                                                .profileImgUrl!,
                                        radius: 20)
                                    : const SizedBox(
                                        width: 40,
                                      ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(23)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.message.messageText!,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            determineText(text: widget.message.messageText!)
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      left: 50.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "This message is about dass test, would you like to share your dass scrore to the doctor?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.grey),
                                        ),
                                        BlocBuilder<Dass41Bloc, Dass41State>(
                                          builder: (context, state) {
                                            if (state is Dass41Initial) {
                                              return const CircularProgressIndicatorCustom();
                                            }
                                            if (state is PdfRequested) {
                                              return InkWell(
                                                onTap: () {
                                                  if (state.answers!.isNotEmpty) {
                                                    sendDassScore(
                                                        appointmentModel:
                                                            widget.appointment,
                                                        context: context);
                                                  } else {
                                                    Navigator.pushNamed(context,
                                                        Dass41.routeName);
                                                  }
                                                },
                                                child: Text(
                                                    state.answers!.isNotEmpty
                                                        ? "Share with ${widget.appointment.doctor.fullName}"
                                                        : "Take Dass41 Test.",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor)),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
    }
  }
