import 'package:contact_box/features/main_entry/presentation/bloc/cubit/page_select_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void initDependencies(){
  initNavDependencies();
}

void initNavDependencies(){
  serviceLocator.registerLazySingleton(() => PageSelectCubit(),);
}