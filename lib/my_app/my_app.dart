import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/style/theme.dart';

class MyApp extends StatelessWidget {

  final bool? isDark;
  const MyApp(this.isDark,);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeDarkMode(sharedPrefData: isDark)..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskLada',
            theme: ThemeStyle.lightTheme,
            darkTheme: ThemeStyle.darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
            home: AppCubit.get(context).checkStartScreen(),
          );
        },
        listener: (context, state){},
      ),
    );
  }
}
