import 'package:cubic_api_controller/counter_cubit/counter_cubit.dart';
import 'package:cubic_api_controller/counter_cubit/counter_page.dart';
import 'package:cubic_api_controller/fetchApi/fetchApi_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => FetchCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable the debug banner
        home: CounterPage(),
      ),
    );
  }
}
