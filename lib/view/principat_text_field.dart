import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_cubit/game_cubit.dart';

class PrincipatTextField extends StatefulWidget {
  const PrincipatTextField({super.key});

  @override
  State<PrincipatTextField> createState() => _PrincipatTextFieldState();
}

class _PrincipatTextFieldState extends State<PrincipatTextField> {
  late final TextEditingController numberController;

  @override
  void initState() {
    numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        labelStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        hintText: '####',
        hintStyle: const TextStyle(color: Colors.grey),
        errorText: 'Error',
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      onSubmitted: (value) {
        _onSubmittValue(context, value);
      },
    );
  }

  void _onSubmittValue(BuildContext context, String value) {
    final number = int.tryParse(value) ?? 1;

    final gameCubit = context.read<GameCubit>();
    gameCubit.onSubmittValue(number);
    numberController.clear();
  }
}
