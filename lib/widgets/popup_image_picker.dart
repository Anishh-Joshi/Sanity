import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/user_info_bloc/user_info_bloc.dart';
import 'dart:io';

class ImagePickPopUp extends StatefulWidget {
  const ImagePickPopUp({Key? key}) : super(key: key);

  @override
  State<ImagePickPopUp> createState() => _ImagePickPopUpState();
}

class _ImagePickPopUpState extends State<ImagePickPopUp> {
  final ImagePicker _picker = ImagePicker();

  Future<void> getImageFromCamera(BuildContext context) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    File file = File(photo!.path);
    if (!mounted) return;
    context.read<UserInfoBloc>().add(UpdateUserInfo(profileImage: file));
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    File file = File(photo!.path);
    if (!mounted) return;
    context.read<UserInfoBloc>().add(UpdateUserInfo(profileImage: file));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, 3),
            // changes position of shadow
          ),
        ],
      ),
      child: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () => getImageFromCamera(context),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.camera_alt),
                          Text("Take From Camera"),
                          Opacity(
                            opacity: 0,
                            child: Icon(Icons.camera_alt),
                          )
                        ],
                      ))),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () => getImageFromGallery(context),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.image),
                            Text("Gallery"),
                            Opacity(
                              opacity: 0,
                              child: Icon(Icons.camera_alt),
                            )
                          ])))
            ],
          );
        },
      ),
    );
  }
}
