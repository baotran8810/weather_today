import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/api/api_endpoints.dart';
import 'package:weather_today/api/rest_client.dart';
import 'package:weather_today/ui/weather_screen/weather_model.dart';
import 'package:weather_today/ui/weather_screen/weather_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    RestClient().init(baseUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => WeatherModel(),
                child: const WeatherScreen(),
              ),
            ),
          ],
        );
      },
    );
  }
}
