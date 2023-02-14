import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/providers/models_provider.dart';
import 'package:chat_gpt/services/api_services.dart';
import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(
                label: snapshot.error.toString(),
              ),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 10,
                )
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: scaffoldBackgroundColor,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: TextWidget(
                          label: snapshot.data![index].id,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    value: currentModel,
                    onChanged: (value) {
                      setState(() {
                        currentModel = value.toString();
                      });
                      modelProvider.setCurrntModel(value.toString());
                    },
                  ),
                );
        });
  }
}


// DropdownButton(
//       dropdownColor: scaffoldBackgroundColor,
//       iconEnabledColor: Colors.white,
//       items: getModelsItem,
//       value: currentModel,
//       onChanged: (value) {
//         setState(() {
//           currentModel = value.toString();
//         });
//       },
//     );