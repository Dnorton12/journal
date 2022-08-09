import 'package:flutter/material.dart';

// journal form fields are captured in this file
form_fields(label, journalEntryFields) {
  return (TextFormField(
      autofocus: true,
      decoration:
      InputDecoration(
          labelText: label, border: OutlineInputBorder()
      ),
      onSaved: (value) {
        if (label == 'title') {
          journalEntryFields.title = value!;
        }
        if (label == 'body') {
          journalEntryFields.body = value!;
        }
        if (label == 'rating') {
          journalEntryFields.rating = value!;
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a $label';
        } else {
          print('VALUE IS $value');
          if (label == 'rating') {
            if (int.parse(value) < 1 || int.parse(value) > 4) {
              return 'Enter a value from 1 to 4';
            }
          }
        }
        return null;
      }
  )
  );
}