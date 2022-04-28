import 'package:dnd_helper/cubits/spells_cubit.dart';
import 'package:dnd_helper/api/api_repository.dart';
import 'package:dnd_helper/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/spell_cubit.dart';

void main() {
  runApp(const MyApp());
}

final _apiService = ApiService();
final _apiRepository = ApiRepository(_apiService);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpellsCubit>(
          create: (context) => SpellsCubit(
            apiRepository: _apiRepository,
          ),
        ),
        BlocProvider<SpellCubit>(
          create: (context) => SpellCubit(
            apiRepository: _apiRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Dnd Helper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
