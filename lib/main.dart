// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Project imports:
import 'package:waterbus/core/app/application.dart';
import 'package:waterbus/core/app/firebase_config.dart';
import 'package:waterbus/features/app/app.dart';

void main(List<String> args) async {
  await runZonedGuarded(
    () async {
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(
        widgetsBinding: widgetsBinding,
      );

      PaintingBinding.instance.imageCache.maximumSizeBytes =
          1024 * 1024 * 300; // 300 MB

      // SystemChrome.setSystemUIOverlayStyle(
      //   const SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //   ),
      // );

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await Application.initialAppLication();

      if (kIsWeb) {
        await FirebaseAuth.instance.setPersistence(Persistence.NONE);
      }

      runApp(const App());

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    },
    (error, stackTrace) {
      debugPrint(error.toString());
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
