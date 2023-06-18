import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:e_movie/config/services/injection.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(asExtension: false)
GetIt configureDependencies() => init(getIt);
