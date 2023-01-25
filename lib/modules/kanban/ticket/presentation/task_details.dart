import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/core/extensions/extenstions.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/widget/ticket_widget.dart';
import 'package:time_tracking/modules/kanban/logs/presentation/log_list.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/cubit/add_task_cubit.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/edit_task.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/cubit/worked_hours_cubit.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/widget.dart/add_working_hour_dialog.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/worked_hour.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key, required this.kanbanModel});

  final KanbanModel kanbanModel;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final workedhoursCompleted = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final spacing = theme.spacings;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<WorkedHoursCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<AddTaskCubit>(),
        ),
      ],
      child: CustomScaffold(
        actions: [
          IconButton(
            onPressed: () {
              context.read<NavigationCubit>().push(MaterialPage(
                    child: EditTaskPage(
                      kanbanModel: widget.kanbanModel,
                    ),
                  ));
            },
            icon: const Icon(Icons.edit),
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                context
                    .read<AddTaskCubit>()
                    .deleteTicket(docId: widget.kanbanModel.docId!);
                context.read<NavigationCubit>().pop();
              },
              icon: const Icon(Icons.delete),
            );
          }),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                context.read<NavigationCubit>().push(
                      MaterialPage(
                        child: LogsList(
                          docId: '${widget.kanbanModel.docId}',
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.history),
            );
          }),
        ],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: spacing.spacing12,
                horizontal: spacing.spacing8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.kanbanModel.name.capitalize(),
                          style: theme.textStyles.heading3_700.copyWith(
                            color: theme.colors.brand.main,
                          ),
                        ),
                      ),
                      if (widget.kanbanModel.type == "Bug")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                              color: theme.colors.messaging.error,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            widget.kanbanModel.type,
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.colors.neutral.white,
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: theme.spacings.spacing8,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: theme.colors.neutral.gray05),
                        child: Center(
                          child: Text(
                              widget.kanbanModel.user?.name.nameShortForm() ??
                                  "N/A"),
                        ),
                      ),
                      TaskTypeWidget(value: widget.kanbanModel.priority),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          Text(
                            "${widget.kanbanModel.totalWorkedHours ?? '0'}/${widget.kanbanModel.hours} hrs",
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: theme.spacings.spacing8,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      if (widget.kanbanModel.startDate != null)
                        Text(
                          "${widget.kanbanModel.startDate?.getFormattedDate()} to ",
                        ),
                      Text(
                        widget.kanbanModel.endDate
                            .getFormattedDate()
                            .toString(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: spacing.spacing16,
                  ),
                  Text(
                    widget.kanbanModel.description,
                    style: theme.textStyles.paragraph_400,
                  ),
                  SizedBox(
                    height: spacing.spacing32,
                  ),
                  Container(
                    color: theme.colors.neutral.gray05,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Work log history',
                            style: theme.textStyles.heading3_500
                                .copyWith(color: theme.colors.brand.main),
                          ),
                        ),
                        Builder(builder: (context) {
                          return DesignContainedButtonMedium(
                            label: "Add Work Log",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return BlocProvider<WorkedHoursCubit>.value(
                                    value: BlocProvider.of<WorkedHoursCubit>(
                                        context),
                                    child: AddWokingHoursDialog(
                                      kanbanModel: widget.kanbanModel,
                                      ticketDocumentId:
                                          '${widget.kanbanModel.docId}',
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),
                  WorkedHoursList(
                    ticketDocId: '${widget.kanbanModel.docId}',
                  ),
                  SizedBox(
                    height: spacing.spacing12,
                  ),
                  SizedBox(
                    height: spacing.spacing12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  const MemberTile({
    Key? key,
    required this.kanbanModel,
  }) : super(key: key);

  final KanbanModel kanbanModel;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Members',
          style: theme.textStyles.heading3_500
              .copyWith(color: theme.colors.brand.main),
        ),
        SizedBox(
          height: theme.spacings.spacing8,
        ),
        Text(
          kanbanModel.user?.name?.capitalize() ?? '',
          style: theme.textStyles.paragraph_400,
        ),
      ],
    );
  }
}
