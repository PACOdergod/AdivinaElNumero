import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'difficult_cubit/difficult_cubit.dart';
import 'game_cubit/game_cubit.dart';
import 'view/principal_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DifficultCubit()),
          BlocProvider(
            create: (context) =>
                GameCubit(BlocProvider.of<DifficultCubit>(context)),
          ),
        ],
        child: const PrincipalPage(),
      ),
    );
  }
}
