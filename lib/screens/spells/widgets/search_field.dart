import 'package:flutter/material.dart';

import 'package:dnd_helper/screens/spells/spell.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          height: 56,
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextField(
            onSubmitted: (input) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpellView(
                    spellName: input.replaceAll(' ', '-'),
                  ),
                ),
              );
            },
            textInputAction: TextInputAction.go,
            maxLength: 30,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              counterText: '',
              prefixIcon: const Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 10,
                  end: 50,
                ),
                child: Icon(Icons.search),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: 'Search spell',
              fillColor: Colors.white70,
            ),
          ),
        ),
      );
}
