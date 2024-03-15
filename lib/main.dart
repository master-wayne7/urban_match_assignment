import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/features/commits/bloc/commit_bloc.dart';
import 'package:urban_match/src/features/home/bloc/home_bloc.dart';
import 'package:urban_match/src/features/home/pages/home_page.dart';
import 'package:urban_match/src/features/repository/bloc/repository_bloc.dart';
import 'package:urban_match/src/services/api_services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            apiService: ApiService(),
          ),
        ),
        BlocProvider(
          create: (context) => RepositoryBloc(
            apiService: ApiService(),
          ),
        ),
        BlocProvider(
          create: (context) => CommitBloc(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
