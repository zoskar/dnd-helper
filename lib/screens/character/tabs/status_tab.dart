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
    var i = 1;
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
          )
        ],
      ),
    );
  }
}
