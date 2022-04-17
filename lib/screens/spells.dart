import 'package:dnd_helper/cubit/spellsFetch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<PostfetchcubitCubit, PostfetchcubitState>(
          builder: (context, state) {
            if (state is PostfetchcubitLoading) {
              return CircularProgressIndicator();
            } else if (state is PostfetchcubitError) {
              return Text(state.failure.message);
            } else if (state is PostfetchcubitLoaded) {
              final postList = state.postList;
              return postList.isEmpty
                  ? Text('')
                  : ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: ((context, index) => ListTile(
                            title: Text('Item'),
                          )));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
