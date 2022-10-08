import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';

import 'circular_progress.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key, required this.hintText, this.onChanged, this.controller})
      : super(key: key);

  final String? hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),

      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 8, top: 5, bottom: 5),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: onChanged,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 15,),
          decoration: InputDecoration(
            enabled: true,
            hintText: hintText,
            hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 15,),
            border: InputBorder.none,
          ),
          controller: controller,
          validator: (value) {
            if (value == null) {
              return 'Please enter some text';
            }
            if (!value.contains("@")) {
              return 'Email must contain @';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class CustomTextFormFieldInteger extends StatelessWidget {
  const CustomTextFormFieldInteger(
      {Key? key, required this.hintText, this.onChanged, this.controller})
      : super(key: key);

  final String? hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 8, top: 5, bottom: 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 15,),
              decoration: InputDecoration(
                enabled: true,
                hintText: hintText,
                hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 15,),
                border: InputBorder.none,
              ),
              controller: controller,
              validator: (value) {
                if (value == null) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ));
  }
}

class CustomDropDown extends StatefulWidget {
  final Function? onChangedInside;
  const CustomDropDown({Key? key, this.onChangedInside}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? gender = "Male";
  List? genderChoice = ["Male", "Female", "Other"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            if (state is UserInfoLoading) {
              return const Center(child: CircularProgressIndicatorCustom());
            }
            if (state is UserInfoLoaded) {
              context.read<UserInfoBloc>().add(UpdateUserInfo(gender: gender));
              return Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 8, top: 5, bottom: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint:  Text(
                      "Your Gender",
                      style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 15,)
                    ),
                    dropdownColor: Theme.of(context).cardColor,
                    value: gender,
                    onChanged: (newValue) {
                      gender = newValue.toString();
                      context
                          .read<UserInfoBloc>()
                          .add(UpdateUserInfo(gender: gender));
                      setState(() {});
                    },
                    items: genderChoice!.map((valueItem) {
                      return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem,
                            style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 15,)
                          ));
                    }).toList(),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("Something Went Wrong Custom Dropdown"),
              );
            }
          },
        ),
      ),
    );
  }
}
