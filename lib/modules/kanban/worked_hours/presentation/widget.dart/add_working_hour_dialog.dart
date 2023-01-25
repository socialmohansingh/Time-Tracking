import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:intl/intl.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/cubit/worked_hours_cubit.dart';

class AddWokingHoursDialog extends StatefulWidget {
  const AddWokingHoursDialog(
      {super.key, required this.ticketDocumentId, required this.kanbanModel});

  final String ticketDocumentId;

  final KanbanModel kanbanModel;

  @override
  State<AddWokingHoursDialog> createState() => _AddWokingHoursDialogState();
}

class _AddWokingHoursDialogState extends State<AddWokingHoursDialog> {
  final workedhoursCompleted = TextEditingController();
  final logDate = TextEditingController();
  final summaryController = TextEditingController();

  Future<DateTime?> getDateTime() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract((const Duration(days: 30))),
      lastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final spacing = theme.spacings;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: theme.spacings.spacing16,
            vertical: theme.spacings.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: theme.spacings.spacing16,
                    vertical: theme.spacings.spacing24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Work Log',
                      style: theme.textStyles.heading3_500.copyWith(),
                    ),
                    SizedBox(
                      height: spacing.spacing12,
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
                        textEditingController: workedhoursCompleted,
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
                            final datFormatter = DateFormat('yyyy-MM-dd hh:mm');
                            logDate.text = datFormatter.format(date);
                          }
                        },
                        child: DesignTextField(
                          placeholderText: "Log Date".locale(),
                          keyboardType: TextInputType.text,
                          status: DesignTextFieldStatus(
                            statusType: DesignTextFieldStatusType.disabled,
                          ),
                          textEditingController: logDate,
                          focusNode: FocusNode(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        placeholderText: "summary".locale(),
                        keyboardType: TextInputType.text,
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: summaryController,
                        focusNode: FocusNode(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.spacing56,
                      ),
                      child: BlocConsumer<WorkedHoursCubit, WorkedHoursState>(
                        listener: (context, state) {
                          if (state is LogDateValidationError) {
                            DesignConfirmationDialog.show(
                              context: context,
                              title: "",
                              subtitle: 'Date cannot be empty',
                              primaryActionText: 'CLOSE',
                            );
                          } else if (state is HoursValidationError) {
                            DesignConfirmationDialog.show(
                              context: context,
                              title: "",
                              subtitle: 'Hours value is invalid',
                              primaryActionText: 'CLOSE',
                            );
                          } else if (state is WorkedHoursAddedState) {
                            DesignConfirmationDialog.show(
                              context: context,
                              title: "",
                              subtitle: state.success,
                              primaryActionText: 'CLOSE',
                            );
                          } else if (state is WorkedHoursError) {
                            DesignConfirmationDialog.show(
                              context: context,
                              title: "",
                              subtitle: state.error,
                              primaryActionText: 'CLOSE',
                            );
                          }
                        },
                        builder: (context, state) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              if (state is WorkedHoursLoading)
                                Transform.scale(
                                  scale: 0.5,
                                  child: CircularProgressIndicator(
                                    color: theme.colors.brand.main,
                                  ),
                                ),
                              DesignContainedButtonSmall(
                                label: 'Add Work Log',
                                onPressed: state is WorkedHoursLoading
                                    ? null
                                    : () {
                                        context
                                            .read<WorkedHoursCubit>()
                                            .storeWorkedHours(
                                              logModel: WorkedHoursModel(
                                                  name: FirebaseAuth.instance
                                                      .currentUser?.displayName,
                                                  summary:
                                                      summaryController.text,
                                                  logDate: DateTime.tryParse(
                                                      logDate.text),
                                                  workedHours: double.tryParse(
                                                          workedhoursCompleted
                                                              .text) ??
                                                      0.0,
                                                  userId: FirebaseAuth.instance
                                                      .currentUser?.uid,
                                                  updatedAt: DateTime.now()),
                                              docId: widget.ticketDocumentId,
                                            );
                                        Navigator.pop(context);
                                      },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
