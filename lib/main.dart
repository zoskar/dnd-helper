import 'package:dnd_helper/cubit/spellsFetch_cubit.dart';
import 'package:dnd_helper/repository/api_repository.dart';
import 'package:dnd_helper/screens/home_page.dart';
import 'package:dnd_helper/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    apiService: ApiService(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.apiService}) : super(key: key);

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostfetchcubitCubit>(
          create: (context) => PostfetchcubitCubit(
            apiRepository: ApiRepository(
              apiService,
            ),
          )..fetchSpellsApi(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
