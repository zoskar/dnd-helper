import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(CharacterInitial());

  var pickedChar;

  List<Character> charList = [];

  init(FileHandler fileHandler) async {
    if (pickedChar == null) {
      charList = await fileHandler.readChars();
      emit(CharacterNotPicked());
    } else {
      emit(CharacterPicked());
    }
  }

  pickCharacter(Character character, FileHandler fileHandler) {
    pickedChar = character;
    init(fileHandler);
  }

  switchCharacter(FileHandler fileHandler) {
    pickedChar = null;
    init(fileHandler);
  }
}

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterPicked extends CharacterState {}

class CharacterNotPicked extends CharacterState {}
