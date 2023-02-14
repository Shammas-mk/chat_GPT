import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/widgets/dropdown_widget.dart';
import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showBottomSheet(
      {required BuildContext context, dynamic}) async {
    await showModalBottomSheet(
        backgroundColor: scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextWidget(
                    label: "Choose Model : ",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Flexible(
                  flex: 2,
                  child: DropDownWidget(),
                ),
              ],
            ),
          );
        });
  }
}
