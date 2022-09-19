// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/activate_cubit/activate_cubit.dart';

class TodoFieldWidget extends StatelessWidget {
  const TodoFieldWidget({
    Key? key,
    required this.noteText,
  }) : super(key: key);
  final TextEditingController noteText;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        onChanged: (value) {
          context.read<ActivateCubit>().onFolderChanged(value);
        },
        controller: noteText,
        autofocus: true,
        decoration: InputDecoration(
          fillColor: Colors.blue.shade200,
          filled: true,
          hintText: AppLocalizations.of(context).typeYourNewTodo,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
