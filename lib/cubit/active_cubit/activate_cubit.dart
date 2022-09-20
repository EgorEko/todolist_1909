import 'package:flutter_bloc/flutter_bloc.dart';

class ActivateCubit extends Cubit<bool> {
  ActivateCubit() : super(false);

  void onFieldChanged(String value) {
    emit(value.isNotEmpty);
  }
}
