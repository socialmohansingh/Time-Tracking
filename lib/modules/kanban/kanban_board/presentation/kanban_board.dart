import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/modules/auth/features/login/presentation/cubit/email_login_cubit.dart';
import 'package:time_tracking/modules/auth/features/login/presentation/login_screen.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/move_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/bloc/get_task_bloc.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/widget/floating_ticket_widget.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/widget/kanban_header_widget.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/widget/ticket_widget.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/add_task.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CustomScaffold(
      alternativeBackgroundColor: theme.colors.brand.main,
      title: const Text("Kanban Board"),
      actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            context.read<NavigationCubit>().root(MaterialPage(
                    child: LoginView(
                  emailLogin: GetIt.I.get<EmailLoginCubit>(),
                )));
          },
          icon: const Icon(Icons.logout),
        )
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<NavigationCubit>()
              .push(const MaterialPage(child: AddTaskPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              GetIt.I.get<GetTaskBloc>()..add(GetAllTicketEvent()),
          child: const _KanbanBlocBuilder(),
        ),
      ),
    );
  }
}

class _KanbanBlocBuilder extends StatelessWidget {
  const _KanbanBlocBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTaskBloc, GetTaskState>(
      builder: (context, state) {
        if (state is GetTaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AllTaskState) {
          return _KanbanBoardView(state.board);
        } else if (state is GetTaskError) {
          return Center(
              child: Text(
            state.error,
            style: const TextStyle(
              color: Colors.red,
            ),
          ));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// ignore: must_be_immutable
class _KanbanBoardView extends StatefulWidget {
  final double tileHeight = 160;
  final double headerHeight = 80;
  final double tileWidth = 300;

  LinkedHashMap<String, List<KanbanModel>> board;

  _KanbanBoardView(this.board);

  @override
  State<_KanbanBoardView> createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<_KanbanBoardView> {
  @override
  void initState() {
    super.initState();
  }

  buildItemDragTarget(listId, targetPosition, double height, bool isLast) {
    return DragTarget<KanbanModel>(
      onWillAccept: (KanbanModel? data) {
        return widget.board[listId]!.isEmpty ||
            data!.docId != widget.board[listId]![targetPosition].docId;
      },
      onAccept: (KanbanModel data) {
        setState(() {
          widget.board[data.column]?.remove(data);
          data.column = listId;
          if (widget.board[listId]!.length > targetPosition) {
            widget.board[listId]!.insert(targetPosition + 1, data);
          } else {
            widget.board[listId]!.add(data);
          }

          context.read<GetTaskBloc>().add(
                MoveTicketEvent(
                  MoveModel(
                      column: listId,
                      docId: '${data.docId}',
                      fromColumn: data.column),
                ),
              );
        });
      },
      builder: (BuildContext context, List<KanbanModel?> data,
          List<dynamic> rejectedData) {
        if (data.isEmpty) {
          return Column(
            children: [
              Container(
                height: height,
              ),
              Container(
                height: isLast ? MediaQuery.of(context).size.height - 390 : 0,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Container(
                height: height,
              ),
              ...data.map((KanbanModel? item) {
                return Opacity(
                  opacity: 0.5,
                  child: TicketWidget(item: item!),
                );
              }).toList(),
              Container(
                height: isLast ? MediaQuery.of(context).size.height - 390 : 0,
              ),
            ],
          );
        }
      },
    );
  }

  buildHeader(String listId, bool hasTickets) {
    Widget header = SizedBox(
      height: widget.headerHeight,
      child: HeaderWidget(title: listId),
    );

    return Stack(
      children: [
        LongPressDraggable<String>(
          data: listId,
          childWhenDragging: Opacity(
            opacity: 0.2,
            child: header,
          ),
          feedback: Transform.rotate(
            angle: 0.1,
            child: FloatingWidget(
              child: SizedBox(
                width: widget.tileWidth,
                child: header,
              ),
            ),
          ),
          child: header,
        ),
        buildItemDragTarget(listId, 0, widget.headerHeight, !hasTickets),
        DragTarget<String>(
          onWillAccept: (String? incomingListId) {
            return listId != incomingListId;
          },
          onAccept: (String incomingListId) {
            setState(
              () {
                LinkedHashMap<String, List<KanbanModel>> reorderedBoard =
                    LinkedHashMap();
                for (String key in widget.board.keys) {
                  if (key == incomingListId) {
                    reorderedBoard[listId] = widget.board[listId]!;
                  } else if (key == listId) {
                    reorderedBoard[incomingListId] =
                        widget.board[incomingListId]!;
                  } else {
                    reorderedBoard[key] = widget.board[key]!;
                  }
                }
                widget.board = reorderedBoard;
              },
            );
          },
          builder: (BuildContext context, List<String?> data,
              List<dynamic> rejectedData) {
            if (data.isEmpty) {
              return SizedBox(
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    buildKanbanList(String listId, List<KanbanModel> items) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height -
              (Scaffold.of(context).appBarMaxHeight ?? 0),
          margin: const EdgeInsets.only(left: 4, right: 4),
          color: theme.colors.neutral.gray05,
          child: Column(
            children: [
              items.isNotEmpty
                  ? buildHeader(listId, items.isNotEmpty)
                  : Expanded(
                      child: buildHeader(listId, items.isNotEmpty),
                    ),
              if (items.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: widget.tileHeight - 120,
                            ),
                          ),
                          LongPressDraggable<KanbanModel>(
                            data: items[index],
                            childWhenDragging: Opacity(
                              opacity: 0.2,
                              child: TicketWidget(item: items[index]),
                            ),
                            feedback: SizedBox(
                              height: widget.tileHeight,
                              width: widget.tileWidth,
                              child: Transform.rotate(
                                angle: 0.1,
                                child: FloatingWidget(
                                  child: TicketWidget(
                                    item: items[index],
                                  ),
                                ),
                              ),
                            ),
                            child: TicketWidget(
                              item: items[index],
                            ),
                          ),
                          buildItemDragTarget(
                            listId,
                            index,
                            widget.tileHeight,
                            index == items.length - 1,
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.board.keys.map(
          (String key) {
            return SizedBox(
              width: widget.tileWidth,
              child: buildKanbanList(key, widget.board[key]!),
            );
          },
        ).toList(),
      ),
    );
  }
}
