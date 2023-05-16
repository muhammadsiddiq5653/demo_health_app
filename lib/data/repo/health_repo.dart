import 'package:authentication_riverpod/core/export.dart';
import 'package:authentication_riverpod/data/models/health_model.dart';
import 'package:either_dart/either.dart';
import 'package:health/health.dart';

class HealthRepo {
  Future<Either<AppError, HealthModel>> fetchData() async {
    HealthFactory health = HealthFactory();
    List<HealthDataPoint> healthData = [];
    HealthModel data = HealthModel();
    final types = [
      HealthDataType.HEART_RATE,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    if (requested) {
      try {
        // fetch health data
        healthData = await health.getHealthDataFromTypes(yesterday, now, types);

        if (healthData.isNotEmpty) {
          for (HealthDataPoint h in healthData) {
            if (h.type == HealthDataType.HEART_RATE) {
              data.heartRate = "${h.value}";
            } else if (h.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC) {
              data.bloodPreSys = "${h.value}";
            } else if (h.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC) {
              data.bloodPreDia = "${h.value}";
            } else if (h.type == HealthDataType.STEPS) {
              data.steps = "${h.value}";
            } else if (h.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
              data.activeEnergy = "${h.value}";
            }
          }
          if (data.bloodPreSys != "null" && data.bloodPreSys != "null") {
            data.bp = "${data.bloodPreSys} / ${data.bloodPreDia} mmHg";
          }
        }
        return Right(data);
      } catch (error) {
        return Left(AppError());
        print("Exception in getHealthDataFromTypes: $error");
      }

      // filter out duplicates
      healthData = HealthFactory.removeDuplicates(healthData);
    } else {
      return Left(AppError());
      print("Authorization not granted");
    }
  }
}
