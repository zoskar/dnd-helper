import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/cubits/rule_section_cubit.dart';
import 'package:dnd_helper/api/api_repository.dart';
import 'package:dnd_helper/cubits/spell_list_cubit.dart';
import 'package:dnd_helper/screens/home_page.dart';
import 'package:dnd_helper/cubits/rule_cubit.dart';
import 'package:dnd_helper/cubits/spell_cubit.dart';

void main() {
  runApp(const MyApp());
}

final _apiService = ApiService();
final _apiRepository = ApiRepository(_apiService);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CharacterCubit(),
          ),
          BlocProvider<SpellListCubit>(
            create: (context) => SpellListCubit(
              apiRepository: _apiRepository,
            ),
          ),
          BlocProvider<SpellCubit>(
            create: (context) => SpellCubit(
              apiRepository: _apiRepository,
            ),
          ),
          BlocProvider<RuleSectionCubit>(
            create: (context) => RuleSectionCubit(
              apiRepository: _apiRepository,
            ),
          ),
          BlocProvider<RuleCubit>(
            create: (context) => RuleCubit(
              apiRepository: _apiRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          title: 'Dnd Helper',
          home: HomePage(),
        ),
      );
}
