// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Material App', home: PrincipalPage());
  }
}

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40),
                width: 180,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
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
              const Text(
                'Intentos',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
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
            value: 1,
            min: 0,
            max: 5,
            divisions: 3,
            activeColor: Colors.blue,
            inactiveColor: Colors.blue.withOpacity(0.3),
            onChanged: (value) {},
          )
        ],
      ),
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
