import 'package:chatgpt/constant/constants.dart';
import 'package:chatgpt/models/model_models.dart';
import 'package:chatgpt/providers/models_provider.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class modelDropDown extends StatefulWidget {
  const modelDropDown({super.key});

  @override
  State<modelDropDown> createState() => _modelDropDownState();
}

class _modelDropDownState extends State<modelDropDown> {
  //
  String? CurrentModel;

  @override
  Widget build(BuildContext context) {
    final modelprovider = Provider.of<modelsprovider>(context, listen: false);
    CurrentModel = modelprovider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
      future: modelprovider.getAllModel(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Text(snapshot.error.toString());
          return Center();
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  items: List<DropdownMenuItem<String>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: Text(
                        snapshot.data![index].id,
                      ),
                    ),
                  ),
                  value: CurrentModel,
                  onChanged: (value) {
                    setState(() {
                      CurrentModel = value.toString();
                    });
                    modelprovider.setCurrentModel(value.toString());
                  },
                ),
              );
      },
    );
  }
}

/**DropdownButton(
      items: getModelsItem,
      value: CurrentModel,
      onChanged: (value) {
        setState(() {
          CurrentModel = value.toString();
        });
      },
    );
 * 
 * 
 */