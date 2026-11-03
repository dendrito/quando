import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/util/local_time.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ensureTimeZones();
  runApp(const ProviderScope(child: QuandoApp()));
}
