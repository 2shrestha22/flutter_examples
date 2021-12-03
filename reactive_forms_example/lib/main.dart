import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

final familyMemberForm = fb.group({
  'personal': fb.group({
    'name': ['', Validators.required],
    'email': ['', Validators.required],
  }),
  'phone': fb.group({
    'phoneNumber': ['', Validators.required],
    'countryIso': ['', Validators.required],
  }),
  'address': fb.group({
    'street': ['', Validators.required],
    'city': ['', Validators.required],
    'zip': ['', Validators.required],
  }),
});

final familyMembersFormGroup = fb.group({
  'familyMembers': familyFormArray,
});

final familyFormArray = fb.array([
  familyMemberForm,
  familyMemberForm,
  familyMemberForm,
]);

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
          formGroup: familyMembersFormGroup,
          child: Column(
            children: <Widget>[
              ReactiveFormArray(
                formArrayName: 'familyMembers',
                builder: (context, formArray, child) {
                  log(formArray.controls.length.toString());
                  return Column(
                      children: formArray.controls.map((e) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ReactiveTextField(
                            key: ObjectKey(e),
                            formControl: (e as FormGroup)
                                .control('personal.name') as FormControl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => formArray.remove(e),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList());
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text('Save'),
              ),
              Text(jsonEncode(familyFormArray.value)),
            ],
          ),
        ),
      ),
    );
  }
}
