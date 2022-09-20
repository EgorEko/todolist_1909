// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/active_cubit/activate_cubit.dart';
import '../utils/colors_constants.dart';

class TodoFieldWidget extends StatelessWidget {
  const TodoFieldWidget({
    Key? key,
    required this.noteText,
  }) : super(key: key);
  final TextEditingController noteText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<ActivateCubit>().onFieldChanged(value);
      },
      controller: noteText,
      autofocus: true,
      decoration: InputDecoration(
        fillColor: kColorsBlue.shade200,
        filled: true,
        hintText: AppLocalizations.of(context).typeYourNewTodo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: kColorsGrey),
        ),
      ),
    );
  }
}
