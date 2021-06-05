import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/model/weather.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeater) {
      yield WeatherLoading();
      final weather = await _fetchWeaterFromeFakeApi(event.cityName);
      yield WeatherLoaded(weather);
    }
  }

  Future<Weather> _fetchWeaterFromeFakeApi(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
          cityName: cityName,
          temperature: 20 + Random().nextInt(15) + Random().nextDouble());
    });
  }
}
