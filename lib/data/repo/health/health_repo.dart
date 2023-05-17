import 'package:authentication_riverpod/core/export.dart';
import 'package:authentication_riverpod/data/models/health_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

class HealthRepo {
  Future<Either<AppError, List<HealthDataPoint>>> fetchStepsData() async {
    HealthFactory health = HealthFactory();
    List<HealthDataType> types = [HealthDataType.STEPS];
    List<HealthDataPoint> stepData = [];
    bool requested = await health.requestAuthorization(types);

    if (requested) {
      try {
        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        DateTime lastWeek = now.subtract(Duration(days: 7));
        DateTime lastMonth = now.subtract(Duration(days: 30));
        DateTime lastYear = now.subtract(Duration(days: 365));

        List<HealthDataPoint> stesData =
            await health.getHealthDataFromTypes(today, now, types);
        List<HealthDataPoint> stepDataLastWeek =
            await health.getHealthDataFromTypes(lastWeek, now, types);
        List<HealthDataPoint> stepDataLastMonth =
            await health.getHealthDataFromTypes(lastMonth, now, types);
        List<HealthDataPoint> stepDataLastYear =
            await health.getHealthDataFromTypes(lastYear, now, types);
        stepData =
            stesData + stepDataLastWeek + stepDataLastMonth + stepDataLastYear;
      } catch (error) {
        return Left(AppError());
      }
      return Right(stepData);
    }
    return Left(AppError());
  }

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
      }
    } else {
      return Left(AppError());
    }
  }
}
