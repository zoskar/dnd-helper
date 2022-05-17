import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    required this.fileHandler,
    required this.character,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;
  final Character character;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          primary: Colors.red,
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hold to delete character'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        onLongPress: () async {
          await fileHandler.deleteChar(character);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pop(context);
        },
        child: const Text('Delete character'),
      );
}
