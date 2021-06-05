part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeater extends WeatherEvent {
  final String cityName;
  GetWeater(this.cityName);
  
  @override
  List<Object> get props => [cityName];
}
