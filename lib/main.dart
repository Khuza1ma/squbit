import 'package:flutter/material.dart';

import 'package:squbit/presentation/screens/home.dart';
import 'package:squbit/cubit/home/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squbit',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          )
        ],
        child: const HomeView(),
      ),
    );
  }
}
