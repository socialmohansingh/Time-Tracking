import 'package:flutter/material.dart';

import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/kanban_board.dart';

import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';


class TicketWidget extends StatelessWidget {
  final KanbanModel item;

  const TicketWidget({Key? key, required this.item}) : super(key: key);
  ListTile makeListTile(KanbanModel item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text("listId: ${item.column}"),
        onTap: () {},
      );
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colors.brand.secondary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colors.brand.main,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.colors.brand.main,
                    ),
                    child: Text(
                      item.priority,
                      style: TextStyle(
                          fontSize: 10, color: theme.colors.neutral.white),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.colors.brand.main,
                    ),
                    child: Text(
                      item.type,
                      style: TextStyle(
                          fontSize: 10, color: theme.colors.neutral.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
