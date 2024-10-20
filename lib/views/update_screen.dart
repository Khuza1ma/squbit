import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/cubit/states.dart';
import '../controller/cubit/cubit.dart';
import 'package:flutter/material.dart';
import '../shared/componant.dart';

class UpdateTaskScreen extends StatefulWidget {
  final int id;

  const UpdateTaskScreen({
    super.key,
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.des,
  });

  final String title;
  final String date;
  final String time;
  final String des;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final titleController = TextEditingController();

  final timeController = TextEditingController();

  final dateController = TextEditingController();

  final desController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.title;
    dateController.text = widget.date;
    desController.text = widget.des;
    timeController.text = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (BuildContext context, state) {
        if (state is SuccessUpdatingDataFromDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Update your task'.tr()),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    customTextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add your title'.tr();
                          }
                          return null;
                        },
                        label: 'Title',
                        hintText: 'Add your Title',
                        prefixIcon: Icons.title),
                    const SizedBox(
                      height: 10.0,
                    ),
                    customTextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please add your Time'.tr();
                        }
                        return null;
                      },
                      label: 'Time',
                      hintText: 'Add your Time',
                      prefixIcon: Icons.watch_later_outlined,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then(
                          (value) {
                            if (context.mounted) {
                              timeController.text = value!.format(context);
                            }
                          },
                        ).catchError(
                          (error) {
                            timeController.clear();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    customTextFormField(
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please add your Date'.tr();
                        }
                        return null;
                      },
                      label: 'Date',
                      hintText: 'Add your Date',
                      prefixIcon: Icons.calendar_view_day,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2040-12-30'),
                        ).then(
                          (value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          },
                        ).catchError(
                          (error) {
                            dateController.clear();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    customTextFormField(
                        controller: desController,
                        lines: 5,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add your description'.tr();
                          }
                          return null;
                        },
                        label: 'Description',
                        hintText: 'Add your Description',
                        prefixIcon: Icons.note),
                    const SizedBox(
                      height: 10.0,
                    ),
                    MaterialButton(
                      height: 40.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      minWidth: double.infinity,
                      color: Colors.teal,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.updateDataIntoDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            description: desController.text,
                            id: widget.id,
                          );
                        }
                      },
                      child: Text('Update Task'.tr()),
                    ),
                    // so now we get our texts...
                    // lets go to our component
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
