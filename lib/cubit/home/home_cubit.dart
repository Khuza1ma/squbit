import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squbit/cubit/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());

  String name = 'Home my Home';
}
