import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../game_cubit/game_cubit.dart';
import '../record_cubit/record_games_cubit.dart';
import 'principat_text_field.dart';

class PrincipalContent extends StatelessWidget {
  const PrincipalContent({
    super.key,
    required this.gameCubit,
  });

  final GameCubit gameCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40),
              width: 180,
              child: PrincipatTextField(key: GlobalKey()),
            ),
            BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                return Text(
                  'Intentos\n${state.attempts}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                );
              },
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: BlocBuilder<GameCubit, GameState>(
                builder: (context, state) {
                  return _CustomContainerList(
                    key: GlobalKey(),
                    title: 'Mayor que',
                    childs: state.greaterThan
                        .map((e) => Text(
                              e.toString(),
                              style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: BlocBuilder<GameCubit, GameState>(
                builder: (context, state) {
                  return _CustomContainerList(
                    key: GlobalKey(),
                    title: 'Menor que',
                    childs: state.lessThan
                        .map((e) => Text(
                              e.toString(),
                              style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: BlocBuilder<RecordGamesCubit, RecordGamesState>(
                builder: (context, state) {
                  return _CustomContainerList(
                    key: GlobalKey(),
                    title: 'Historial',
                    childs: state.values
                        .map((e) => Text(
                              e.$2.toString(),
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: e.$1 ? Colors.green : Colors.red),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ],
    );
  }
}

class _CustomContainerList extends HookWidget {
  const _CustomContainerList({
    super.key,
    required this.title,
    required this.childs,
  });

  final String title;
  final List<Widget> childs;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.hasClients) {
          controller.jumpTo(controller.position.maxScrollExtent);
        }
      });
      return null;
    }, []);

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
          const SizedBox(height: 5),
          Expanded(
            child: ListView(
              controller: controller,
              children: childs
                  .map(
                    (e) => Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
