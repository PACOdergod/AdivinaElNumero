// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:desafio/cubit/difficult_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio',
      home: BlocProvider(
        create: (context) => DifficultCubit(),
        child: PrincipalPage(),
      ),
    );
  }
}

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adivína el Numero',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Colors.grey.shade600,
        actions: const [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 15),
        ],
      ),
      backgroundColor: Colors.grey.shade700,
      body: BlocBuilder<DifficultCubit, DifficultState>(
        builder: (context, state) {
          return BodyPage(state: state);
        },
      ),
    );
  }
}

class BodyPage extends HookWidget {
  const BodyPage({
    super.key,
    required this.state,
  });

  final DifficultState state;

  @override
  Widget build(BuildContext context) {
    final numberController = useTextEditingController();

    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40),
              width: 180,
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  labelText: 'Number',
                  labelStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  floatingLabelStyle: const TextStyle(color: Colors.blue),
                  hintText: '####',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Text(
              'Intentos\n${state.attempts}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.center,
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: CustomContainerList(
                title: 'Mayor que',
              ),
            ),
            const SizedBox(width: 15),
            Expanded(child: CustomContainerList(title: 'Menor que')),
            const SizedBox(width: 15),
            Expanded(
              child: CustomContainerList(
                title: 'Historial',
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        const SizedBox(height: 50),
        Text(
          'Facil',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Slider(
          value: switch (state) {
            DifficultStateEasy() => 0,
            DifficultStateMedium() => 1,
            DifficultStateAdvanced() => 2,
            DifficultStateExtreme() => 3,
          },
          min: 0,
          max: 3,
          divisions: 3,
          activeColor: Colors.blue,
          inactiveColor: Colors.blue.withOpacity(0.3),
          onChanged: (value) {
            final cubit = context.read<DifficultCubit>();
            switch (value) {
              case 0:
                cubit.selectEasy();
              case 1:
                cubit.selectMedium();
              case 2:
                cubit.selectAdvanced();
              case 3:
                cubit.selectExtreme();
            }
          },
        )
      ],
    );
  }
}

class CustomContainerList extends StatelessWidget {
  const CustomContainerList({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '3',
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.w600, color: Colors.white),
          )
        ],
      ),
    );
  }
}
