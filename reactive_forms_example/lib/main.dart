import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

final form = FormGroup({
  'personal': FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
  }),
  'phone': FormGroup({
    'phoneNumber': FormControl<String>(
      validators: [Validators.required, Validators.number],
    ),
    'countryIso': FormControl<String>(validators: [Validators.required]),
  }),
  'address': FormGroup({
    'street': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'zip': FormControl<String>(validators: [Validators.required]),
  }),
});

final familyMemberForm = FormGroup({
  'familyMember': FormArray([form])
});

const sb = SizedBox(height: 20);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      home: const ReactiveFormsExample(),
    );
  }
}

class ReactiveFormsExample extends StatefulWidget {
  const ReactiveFormsExample({Key? key}) : super(key: key);

  @override
  State<ReactiveFormsExample> createState() => _ReactiveFormsExampleState();
}

class _ReactiveFormsExampleState extends State<ReactiveFormsExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive Forms'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: familyMemberForm,
          child: Column(
            children: <Widget>[
              ReactiveFormArray(
                formArrayName: 'familyMember',
                builder: (context, formArray, child) {
                  return Column(
                    children: [
                      for (final control in formArray.controls)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ReactiveTextField<String>(
                            key: ObjectKey(control),
                            formControl: control as FormControl<String>,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => formArray.remove(control),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              // ReactiveTextField(
              //   formControlName: 'personal.name',
              //   decoration: const InputDecoration(labelText: 'Name'),
              // ),
              // sb,
              // ReactiveTextField(
              //   formControlName: 'familyMember.personal.email',
              //   decoration: const InputDecoration(labelText: 'Email'),
              // ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text('Save'),
              ),
              Text(jsonEncode(form.value)),
            ],
          ),
        ),
      ),
    );
  }
}
