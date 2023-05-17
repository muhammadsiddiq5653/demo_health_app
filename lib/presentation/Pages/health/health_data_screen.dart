import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/export.dart';
import '../../../export.dart';

class HealthDataScreen extends ConsumerWidget {
  const HealthDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: colors.bottomNavbarColor,
      appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: const Text(
            "My Health Data",
          )),
      body: ref.watch(healthProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, trace) => Center(child: Text(error.toString())),
            data: (data) {
              return data.fold(
                  (left) => Center(child: Text(left.title)),
                  (right) => right.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: colors.gradientColor1,
                              ),
                              const Text(
                                "No Data Found for this account",
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              HealthCard(
                                title: "Todays Steps Count",
                                color: colors.gradientColor1,
                                data: right[0].toString(),
                                image: "assets/health.png",
                              ),
                              HealthCard(
                                title: "Todays Steps Count",
                                color: colors.gradientColor1,
                                data: right[1].toString(),
                                image: "assets/health.png",
                              ),
                              HealthCard(
                                title: "Todays Steps Count",
                                color: colors.gradientColor1,
                                data: right[2].toString(),
                                image: "assets/health.png",
                              ),
                              HealthCard(
                                title: "Todays Steps Count",
                                color: colors.gradientColor1,
                                data: right[3].toString(),
                                image: "assets/health.png",
                              ),
                            ],
                          )));
            },
          ),
    );
  }
}
