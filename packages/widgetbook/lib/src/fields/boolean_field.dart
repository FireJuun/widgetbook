import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class BooleanField extends Field<bool> {
  BooleanField({
    required super.group,
    required super.name,
    super.initialValue = true,
    required super.onChanged,
  }) : super(
          type: FieldType.boolean,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => param == 'true',
          ),
        );

  @override
  Widget toWidget(BuildContext context, bool? value) {
    return Switch(
      value: value ?? initialValue ?? true,
      onChanged: (value) => updateField(context, value),
    );
  }
}
