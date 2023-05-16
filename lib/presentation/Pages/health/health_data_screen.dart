import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/export.dart';

class HealthApp extends StatelessWidget {
  const HealthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Health Data",
      home: HealthDataScreen(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF101820),
          appBarTheme: const AppBarTheme(color: Color(0xFF101820))),
    );
  }
}

class HealthDataScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Health Data"),
      ),
      body: ref.watch(healthProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, trace) => Center(child: Text(error.toString())),
            data: (data) {
              return data.fold(
                  (left) => Center(child: Text(left.title)),
                  (right) => SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: healthCard(
                                        title: "Heart rate",
                                        image: "assets/health.png",
                                        data: right.heartRate != "null"
                                            ? "${right.heartRate} bpm"
                                            : "",
                                        color: const Color(0xFF8d7ffa))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: healthCard(
                                        title: "Blood pressure",
                                        data: right.bp ?? "",
                                        image: "assets/blood-pressure.png",
                                        color: const Color(0xFF4fd164))),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: healthCard(
                                        title: "Step count",
                                        image: "assets/step.png",
                                        data: right.steps ?? "",
                                        color: const Color(0xFF2086fd))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: healthCard(
                                        title: "Energy burned",
                                        image: "assets/calories.png",
                                        data: right.activeEnergy != "null"
                                            ? "${right.activeEnergy} cal"
                                            : "",
                                        color: const Color(0xFFf77e7e))),
                              ],
                            )
                          ],
                        ),
                      ));
            },
          ),
    );
  }
}

Widget healthCard(
    {String title = "",
    String data = "",
    Color color = Colors.blue,
    required String image}) {
  return Container(
    height: 240,
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Image.asset(image, width: 70),
        Text(data),
      ],
    ),
  );
}
