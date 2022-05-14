import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_app/my_app.dart';
import 'shared/bloc_observer.dart';
import 'shared/local_storage_shared_pref/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  BlocOverrides.runZoned(
        () => runApp(MyApp(isDark)),
    blocObserver: MyBlocObserver(),
  );

}