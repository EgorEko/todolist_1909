import 'package:flutter_bloc/flutter_bloc.dart';

class ActivateCubit extends Cubit<bool> {
  ActivateCubit() : super(false);

  void onFolderChanged(String value) {
    if (value.isEmpty) {
      return;
    }

    emit(true);
  }
}
