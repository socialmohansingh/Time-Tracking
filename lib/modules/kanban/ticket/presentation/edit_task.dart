// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:intl/intl.dart';

import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/kanban_board.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/bloc/task_bloc.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/cubit/add_task_cubit.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key, required this.kanbanModel});

  final KanbanModel kanbanModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<AddTaskCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<TaskBloc>()..add(GetAllUserEvent()),
        ),
      ],
      child: _EditTask(kanbanModel),
    );
  }
}

class _EditTask extends StatefulWidget {
  const _EditTask(this.kanbanModel);

  final KanbanModel kanbanModel;

  @override
  State<_EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<_EditTask> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final startDateController = TextEditingController();
  final hoursController = TextEditingController();

  final endDateController = TextEditingController();
  final startDateContoller = TextEditingController();

  String? type = 'Task', column = 'TODO', priority = 'High';
  final priorityList = ['High', 'Low', 'Medium'];

  final typeList = [
    'Task',
    'Bug',
  ];
  final columnType = ['TODO', 'Inprogress', 'Done'];

  String? assignee;

  Future<DateTime?> getDateTime() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 100)),
    );
  }

  @override
  void initState() {
    super.initState();
    type = widget.kanbanModel.type;
    column = widget.kanbanModel.column;
    priority = widget.kanbanModel.priority;
    assignee = widget.kanbanModel.assignee;
    nameController.text = widget.kanbanModel.name;
    descController.text = widget.kanbanModel.description;
    hoursController.text = widget.kanbanModel.hours;
    startDateContoller.text = '${widget.kanbanModel.startDate ?? ""}';
    endDateController.text = '${widget.kanbanModel.endDate}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return CustomScaffold(
      body: SingleChildScrollView(
        child: BlocListener<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskError) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: state.error,
                primaryActionText: 'CLOSE',
              );
            } else if (state is TaskNameValidation) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: 'Ticket name cannot be empty',
                primaryActionText: 'CLOSE',
              );
            } else if (state is TaskHoursValidation) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: 'Ticker hours cannot be empty',
                primaryActionText: 'CLOSE',
              );
            } else if (state is TaskAssigneeValidation) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: 'Please select an Assignee',
                primaryActionText: 'CLOSE',
              );
            }
          },
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserListDate) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        placeholderText: "name".locale(),
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: nameController,
                        focusNode: FocusNode(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        placeholderText: "description".locale(),
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: descController,
                        focusNode: FocusNode(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        placeholderText: "hours".locale(),
                        keyboardType: TextInputType.number,
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: hoursController,
                        focusNode: FocusNode(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: InkWell(
                        onTap: () async {
                          final date = await getDateTime();
                          if (date != null) {
                            final datFormatter = DateFormat('yyyy-MM-dd');
                            startDateContoller.text = datFormatter.format(date);
                          }
                        },
                        child: DesignTextField(
                          placeholderText: "Start Date".locale(),
                          keyboardType: TextInputType.number,
                          status: DesignTextFieldStatus(
                            statusType: DesignTextFieldStatusType.disabled,
                          ),
                          textEditingController: startDateContoller,
                          focusNode: FocusNode(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: InkWell(
                        onTap: () async {
                          final date = await getDateTime();
                          if (date != null) {
                            final datFormatter = DateFormat('yyyy-MM-dd');
                            endDateController.text = datFormatter.format(date);
                          }
                        },
                        child: DesignTextField(
                          placeholderText: "End Date".locale(),
                          keyboardType: TextInputType.number,
                          status: DesignTextFieldStatus(
                            statusType: DesignTextFieldStatusType.disabled,
                          ),
                          textEditingController: endDateController,
                          focusNode: FocusNode(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DropdownButtonFormField(
                        value: assignee,
                        borderRadius: BorderRadius.circular(5),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.colors.neutral.gray05,
                          labelText: 'Select Assignee',
                          labelStyle: theme.textStyles.paragraph_400,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            bottom: theme.spacings.spacing8,
                            left: theme.spacings.spacing16,
                            top: theme.spacings.spacing4,
                            right: theme.spacings.spacing16,
                          ),
                        ),
                        items: state.userModel
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e.id,
                                child: Text(e.name ?? 'N/A'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            assignee = v;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DropdownButtonFormField(
                        value: priority,
                        borderRadius: BorderRadius.circular(5),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.colors.neutral.gray05,
                          labelText: 'Select Priority',
                          labelStyle: theme.textStyles.paragraph_400,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            bottom: theme.spacings.spacing8,
                            left: theme.spacings.spacing16,
                            top: theme.spacings.spacing4,
                            right: theme.spacings.spacing16,
                          ), // use token
                        ),
                        items: priorityList
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            priority = v;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DropdownButtonFormField(
                        value: type,
                        borderRadius: BorderRadius.circular(5),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.colors.neutral.gray05,
                          labelText: 'Select Type',
                          labelStyle: theme.textStyles.paragraph_400,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            bottom: theme.spacings.spacing8,
                            left: theme.spacings.spacing16,
                            top: theme.spacings.spacing4,
                            // text field itself has built in padding of 4, we add 4 on top of that
                            right: theme.spacings.spacing16,
                          ), // use token
                        ),
                        items: typeList
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            type = v;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DropdownButtonFormField(
                        value: column,
                        borderRadius: BorderRadius.circular(5),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.colors.neutral.gray05,
                          labelText: 'Select Column',
                          labelStyle: theme.textStyles.paragraph_400,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            bottom: theme.spacings.spacing8,
                            left: theme.spacings.spacing16,
                            top: theme.spacings.spacing4,
                            // text field itself has built in padding of 4, we add 4 on top of that
                            right: theme.spacings.spacing16,
                          ), // use token
                        ),
                        items: columnType
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            column = v;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacings.spacing32,
                        vertical: 12,
                      ),
                      child: BlocConsumer<AddTaskCubit, AddTaskState>(
                        listener: (context, updateState) {
                          if (updateState is UpdateSuccessState) {
                            DesignConfirmationDialog.show(
                              context: context,
                              title: "",
                              subtitle: updateState.updateMessage,
                              primaryActionText: 'Go Home',
                              onPressedPrimaryButton: () {
                                context.read<NavigationCubit>().root(
                                    const MaterialPage(child: KanbanBoard()));
                              },
                            );
                          } else if (updateState is AddTaskError) {
                            DesignConfirmationDialog.show(
                              context: context,
                              title: "",
                              subtitle: updateState.error,
                              primaryActionText: 'CLOSE',
                            );
                          }
                        },
                        builder: (context, updateState) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              DesignContainedButtonMedium(
                                label: 'Update Ticket',
                                onPressed: updateState is AddTaskLoading
                                    ? null
                                    : () {
                                        final taskData = KanbanModel(
                                          id: Generate.timeBasedUniqueString(),
                                          hours: hoursController.text,
                                          docId: widget.kanbanModel.docId,
                                          startDate: DateTime.tryParse(
                                              startDateContoller.text),
                                          endDate: DateTime.tryParse(
                                                  endDateController.text) ??
                                              DateTime.now(),
                                          createdBy: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          updatedAt: DateTime.now(),
                                          createdAt: DateTime.now(),
                                          name: nameController.text,
                                          description: descController.text,
                                          assignee: assignee ?? '0',
                                          type: type ?? '',
                                          priority: priority ?? '',
                                          column: column ?? '',
                                          user:
                                              state.userModel.firstWhereOrNull(
                                            (element) => element.id == assignee,
                                          ),
                                        );

                                        context
                                            .read<AddTaskCubit>()
                                            .updateTicket(taskdata: taskData);
                                      },
                              ),
                              if (updateState is AddTaskLoading)
                                Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(),
                                ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                );
              } else if (state is TaskLoadingError) {
                return const Center(
                  child: Text('Error Occured'),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
