import 'package:connectopia/core/presentation/base_view_model.dart';

import '../../../domain/weater.dart';

class WeatherViewModel extends BaseViewModel {
  Weather? weather;

  WeatherViewModel({super.isLoading, this.weather});

  WeatherViewModel copyWith({
    bool? isLoading,
    Weather? weather,
  }) {
    return WeatherViewModel(
      isLoading: isLoading ?? this.isLoading,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [isLoading, weather];
}
