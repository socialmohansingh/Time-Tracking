import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/core/extensions/extenstions.dart';

import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';

import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/task_details.dart';

class TicketWidget extends StatelessWidget {
  final KanbanModel item;

  const TicketWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  context.read<NavigationCubit>().push(
                        MaterialPage(
                          child: TaskDetailPage(kanbanModel: item),
                        ),
                      );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colors.brand.background,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colors.neutral.gray40.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name.capitalize(),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.colors.brand.main,
                              ),
                            ),
                          ),
                          if (item.type == "Bug")
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: theme.colors.messaging.error,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                item.type,
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
                                  item.user?.name.nameShortForm() ?? "N/A"),
                            ),
                          ),
                          TaskTypeWidget(value: item.priority),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              Text(
                                "${item.hours} hrs",
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
                          if (item.startDate != null)
                            Text(
                              "${item.startDate?.getFormattedDate()} to ",
                            ),
                          Text(
                            item.endDate.getFormattedDate().toString(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskTypeWidget extends StatelessWidget {
  const TaskTypeWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colors.neutral.white.withOpacity(0.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacings.spacing4,
          horizontal: theme.spacings.spacing12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.stacked_bar_chart_outlined,
              color: theme.colors.brand.main,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colors.brand.main,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
