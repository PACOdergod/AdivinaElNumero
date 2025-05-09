import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../difficult_cubit/difficult_cubit.dart';
import '../game_cubit/game_cubit.dart';

class PrincipatTextField extends StatefulWidget {
  const PrincipatTextField({super.key});

  @override
  State<PrincipatTextField> createState() => _PrincipatTextFieldState();
}

class _PrincipatTextFieldState extends State<PrincipatTextField> {
  late final TextEditingController numberController;
  late final ValueNotifier<String?> errorMessageNotifier;

  @override
  void initState() {
    numberController = TextEditingController();
    errorMessageNotifier = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    errorMessageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: numberController,
          style: const TextStyle(color: Colors.white),
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
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            onSubmittValue(context, value);
          },
          onChanged: (value) {
            validateUserInput(value);
          },
        ),
        const SizedBox(height: 5),
        HookBuilder(builder: (context) {
          useListenable(errorMessageNotifier);
          return Text(errorMessageNotifier.value ?? '',
              style: const TextStyle(color: Colors.red));
        })
      ],
    );
  }

  void validateUserInput(String input) {
    if (input.isEmpty) {
      errorMessageNotifier.value = null;
      return;
    }

    final number = int.tryParse(input);

    if (number == null) {
      errorMessageNotifier.value = 'No valido';
      return;
    }

    final DifficultCubit difficultCubit = context.read();
    final difficultState = difficultCubit.state;

    if (number < difficultState.minimum) {
      errorMessageNotifier.value = 'Número fuera de rango';
    } else if (number > difficultState.maximum) {
      errorMessageNotifier.value = 'Número fuera de rango';
    } else {
      errorMessageNotifier.value = null;
    }
  }

  void onSubmittValue(BuildContext context, String value) {
    if (errorMessageNotifier.value != null) return;
    if (value.isEmpty) return;

    final number = int.tryParse(value) ?? 1;
    final gameCubit = context.read<GameCubit>();
    gameCubit.onSubmittValue(number);
    numberController.clear();
  }
}
