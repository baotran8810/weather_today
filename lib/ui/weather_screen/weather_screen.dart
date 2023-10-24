import 'package:adv_flutter_weather/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/data/enum.dart';
import 'package:weather_today/ui/weather_screen/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    Provider.of<WeatherModel>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<WeatherModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              WeatherBg(
                weatherType: model.weatherType,
                width: width,
                height: height,
              ),
              const MainWidget(),
            ],
          ),
        );
      },
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherModel>(builder: (context, model, child) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Input location or code",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        model.getData(value: _controller.text);
                      }
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black45,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: model.viewState == ViewState.loaded
                    ? const BuildLoadedView()
                    : model.viewState == ViewState.error
                        ? Center(child: Text(model.errorMsg))
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class BuildLoadedView extends StatelessWidget {
  const BuildLoadedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherModel>(builder: (context, model, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            model.weather!.location.country,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            model.weather!.location.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Image.network(
            model.weather!.current.condition.icon.replaceAll("//", "https://"),
            height: 120,
            fit: BoxFit.contain,
          ),
          Text(
            "${model.weather!.current.tempC} C or ${model.weather!.current.feelslikeF} F",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      );
    });
  }
}
