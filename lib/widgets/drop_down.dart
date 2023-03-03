import 'package:chat_gpt/exports/models_export.dart';
import 'package:chat_gpt/exports/widget_exports.dart';
import 'package:chat_gpt/provider/models_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/exports/theme_exports.dart';
import 'package:provider/provider.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;

    return FutureBuilder<List<AppModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(
                text: snapshot.error.toString(),
              ),
            );
          }
          return snapshot.data == null
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: backgroundColor,
                      value: currentModel,
                      items: List<DropdownMenuItem<String>>.generate(
                        snapshot.data!.length,
                        (index) => DropdownMenuItem(
                          value: snapshot.data![index].id,
                          child: TextWidget(
                            text: snapshot.data![index].id,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      iconEnabledColor: textColor,
                      onChanged: (value) {
                        setState(() {
                          currentModel = value.toString();
                        });
                        modelsProvider.setCurrentModel(value.toString());
                      }),
                );
        });
  }
}
/**
 * 
 */