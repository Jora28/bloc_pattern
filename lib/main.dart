import 'package:bloc_pattern/bloc/weather_bloc.dart';
import 'package:bloc_pattern/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
    weatherBloc.close();
  }

  final weatherBloc = WeatherBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Weater App"),
      ),
      body: BlocProvider(
        create: (context) => weatherBloc,
        child: Container(
          child: BlocBuilder(
            bloc: weatherBloc,
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(state.weather);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(child: CityInputField());
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      children: [
        Text(
          weather.cityName!,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          "${weather.temperature?.toStringAsFixed(1)} C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  CityInputField({Key? key}) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
          onFieldSubmitted: submitCityName,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              suffix: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
    );
  }

  void submitCityName(String cityName) {
    final weaterBloc = BlocProvider.of<WeatherBloc>(context);
    weaterBloc.add(GetWeater(cityName));
  }
}
