import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../difficult_cubit/difficult_cubit.dart';
import 'principal_content.dart';

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
      body: const BodyPage(),
    );
  }
}

class BodyPage extends StatelessWidget {
  const BodyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        BlocBuilder<DifficultCubit, DifficultState>(
          builder: (context, state) {
            return PrincipalContent(state, key: GlobalKey());
          },
        ),
        const SizedBox(height: 50),
        BlocBuilder<DifficultCubit, DifficultState>(
          builder: (context, state) {
            return Text(
              switch (state) {
                DifficultStateEasy() => 'Facil',
                DifficultStateMedium() => 'Normal',
                DifficultStateAdvanced() => 'Dificil',
                DifficultStateExtreme() => 'Extremo',
              },
              style: const TextStyle(color: Colors.white, fontSize: 15),
            );
          },
        ),
        BlocBuilder<DifficultCubit, DifficultState>(
          builder: (context, state) {
            return Slider(
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
            );
          },
        )
      ],
    );
  }
}
