import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'difficult_cubit/difficult_cubit.dart';
import 'game_cubit/game_cubit.dart';
import 'record_cubit/record_games_cubit.dart';
import 'view/principal_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RecordGamesCubit()),
          BlocProvider(create: (context) => DifficultCubit()),
          BlocProvider(
            create: (context) => GameCubit(
              difficultCubit: BlocProvider.of<DifficultCubit>(context),
              recordGamesCubit: BlocProvider.of<RecordGamesCubit>(context),
            ),
          ),
        ],
        child: const PrincipalPage(),
      ),
    );
  }
}
