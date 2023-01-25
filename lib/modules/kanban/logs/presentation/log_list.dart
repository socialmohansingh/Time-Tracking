import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:time_tracking/core/extensions/extenstions.dart';
import 'package:time_tracking/modules/kanban/logs/presentation/cubit/log_cubit.dart';

class LogsList extends StatelessWidget {
  const LogsList({super.key, required this.docId});

  final String docId;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CustomScaffold(
      title: const Text('Logs'),
      body: BlocProvider(
        create: (context) => GetIt.I.get<LogCubit>()..add(LogFetchEvent(docId)),
        child: BlocBuilder<LogCubit, LogState>(
          builder: (context, state) {
            if (state is LogLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LogDataState) {
              return ListView.builder(
                  itemCount: state.logList.length,
                  itemBuilder: (context, index) {
                    final logData = state.logList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: theme.colors.neutral.white,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colors.neutral.gray10,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: theme.spacings.spacing12,
                              vertical: 5),
                          child: ListTile(
                            title: Text(
                                logData.updatedAt?.getFormattedDateTime() ??
                                    ''),
                            subtitle: Text(
                              logData.description ?? 'N/A',
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
