import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/dass_bloc/dass41_bloc.dart';
import 'package:sanity/model/message_model.dart';
import 'package:sanity/screens/test/test_page.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';

import '../model/appointment_model.dart';

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
                                  style: Theme.of(context).textTheme.headline4),
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
