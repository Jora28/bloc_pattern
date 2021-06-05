import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String? cityName;
  final double? temperature;

  Weather({required this.cityName, required this.temperature});

  @override
  List<Object?> get props => [cityName, temperature];
}
