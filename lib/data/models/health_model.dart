import 'package:health/health.dart';

class HealthModel {
  String? heartRate;
  String? bp;
  String? steps;
  String? activeEnergy;
  String? bloodPreSys;
  String? bloodPreDia;

  HealthModel(
      {this.heartRate,
      this.bp,
      this.steps,
      this.activeEnergy,
      this.bloodPreSys,
      this.bloodPreDia});

  factory HealthModel.fromJson(HealthDataPoint json) {
    return HealthModel();
  }
}
