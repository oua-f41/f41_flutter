import 'package:connectopia/features/weather/presentation/cubit/view_model/weather_view_model.dart';
import 'package:connectopia/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

class WeatherSnipped extends StatelessWidget {
  const WeatherSnipped({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<WeatherCubit>(),
      child: BlocBuilder<WeatherCubit, WeatherViewModel>(
        builder: (context, state) {
          return state.isLoading
              ? const SkeletonAvatar()
              : Column(
                  children: [
                    state.weather?.current?.condition?.icon
                                .isNotNullOrNoEmpty ==
                            true
                        ? Image.network(
                            "https:${state.weather?.current?.condition?.icon}",
                            height: 45,
                            width: 45,
                          )
                        : const SizedBox(),
                    Text(state.weather?.location?.region ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    state.weather?.current?.tempC != null
                        ? Text("${state.weather?.current?.tempC?.round()}°C",
                            style: const TextStyle(fontWeight: FontWeight.bold))
                        : const SizedBox(),
                  ],
                );
        },
      ),
    );
  }
}
