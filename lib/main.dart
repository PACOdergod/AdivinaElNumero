import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'difficult_cubit/difficult_cubit.dart';
import 'view/body_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio',
      home: BlocProvider(
        create: (context) => DifficultCubit(),
        child: const PrincipalPage(),
      ),
    );
  }
}
