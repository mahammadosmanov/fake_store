import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/core/router/route_configuration.dart';
import 'package:test_task/features/store/data/datasources/local_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupGetIt();
  await locator.get<LocalDataSource>().setup();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('az'),
      ],
      path: 'assets/langs',
      assetLoader: const JsonAssetLoader(),
      startLocale: const Locale('en'),
      useFallbackTranslations: true,
      useOnlyLangCode: true,
      fallbackLocale: const Locale('en'),
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: AppRouter.goRouter,
    );
  }
}
