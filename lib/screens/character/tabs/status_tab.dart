import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';

class StatusTab extends StatelessWidget {
  const StatusTab({
    required this.fileHandler,
    required this.char,
    Key? key,
  }) : super(key: key);

  final Character char;
  final FileHandler fileHandler;

  @override
  Widget build(BuildContext context) {
    var i = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                child: Text(
                  'AC: ${char.ac}',
                  style: AppTextStyles.black24,
                ),
              ),
              Card(
                child: Text(
                  'Max HP: ${char.hp}',
                  style: AppTextStyles.black24,
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: char.resources.length,
              itemBuilder: (context, index) => ListTile(
                title: Row(
                  children: _getResources(char.resources[index]),
                ),
                subtitle: Text(
                  char.resources[index].name,
                  style: AppTextStyles.black14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getResources(Resource resource) {
    List<Widget> list = [];
    for (int i = 0; i < resource.maxUses - resource.remainingUses; i++) {
      list.add(Icon(
        Icons.square,
        color: Colors.black,
        size: 40,
      ));
    }
    for (int i = 0; i < resource.remainingUses; i++) {
      list.add(InkWell(
        onTap: null,
        child: Icon(
          Icons.square_outlined,
          color: Colors.black,
          size: 40,
        ),
      ));
    }

    return list;
  }
}
