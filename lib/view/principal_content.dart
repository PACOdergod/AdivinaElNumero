// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../difficult_cubit/difficult_cubit.dart';

class PrincipalContent extends HookWidget {
  const PrincipalContent(this.state, {super.key});

  final DifficultState state;

  @override
  Widget build(BuildContext context) {
    final numberController = useTextEditingController();

    return Column(
      children: <Widget>[
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
                childs: [
                  const Text(
                    '3',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomContainerList(
                title: 'Menor que',
                childs: [
                  const Text(
                    '3',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomContainerList(
                title: 'Historial',
                childs: [],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ],
    );
  }
}

class CustomContainerList extends StatelessWidget {
  const CustomContainerList({
    super.key,
    required this.title,
    required this.childs,
  });

  final String title;
  final List<Widget> childs;

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
          ...childs,
        ],
      ),
    );
  }
}
