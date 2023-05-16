import 'package:authentication_riverpod/data/export.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthRepositoryProvider = Provider((_) => HealthRepo());

final healthProvider = FutureProvider((ref) {
  final entryRepository = ref.watch(healthRepositoryProvider);
  return entryRepository.fetchData();
});
