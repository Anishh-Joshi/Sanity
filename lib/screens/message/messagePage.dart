import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/model/message_model.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/platform_aware.dart';
import '../../blocs/home/home_bloc.dart';
import '../../model/appointment_model.dart';
import 'package:basics/basics.dart';

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

  @override
  Widget build(BuildContext context) {
    final AppointmentModel appointment =
        ModalRoute.of(context)!.settings.arguments as AppointmentModel;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
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
                          if(!snapshot.hasData){
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
                      enabled: (appointment.atTime! -DateTime.now()).inDays==0,
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
                              return (appointment.atTime! -DateTime.now()).inDays==0?IconButton(
                                icon: Icon(Icons.send,
                                    color: Theme.of(context).primaryColor),
                                onPressed: isLoading
                                    ? null
                                    : () => handleSubmit(
                                        appointment: appointment,
                                        currentUserId: state.user!.userId!),
                                splashRadius: 0.1,
                              ):const SizedBox();
                            }
                            return const SizedBox();
                          },
                        ),
                        hintText:(appointment.atTime! -DateTime.now()).inDays==0? "Message...":"You can message only on your appointed date.",
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
                      child: Row(
                        children: [
                          widget.renderPhoto
                              ? CircleAvatarCustom(
                                  url: widget.currentUerId ==
                                          widget.appointment.patient.userId
                                      ? widget.appointment.doctor.profileImgUrl!
                                      : widget
                                          .appointment.patient.profileImgUrl!,
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
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}
