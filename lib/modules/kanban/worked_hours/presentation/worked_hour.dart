import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:time_tracking/core/extensions/extenstions.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/bloc/get_worked_hour_cubit.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/cubit/worked_hours_cubit.dart';

class WorkedHoursList extends StatelessWidget {
  const WorkedHoursList({super.key, required this.ticketDocId});

  final String ticketDocId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<WorkedHoursCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<GetWorkedHourBloc>()
            ..add(GetDataWorkedHourEvent(ticketDocId)),
        ),
      ],
      child: _WorkedHourList(
        ticketDocId: ticketDocId,
      ),
    );
  }
}

class _WorkedHourList extends StatelessWidget {
  const _WorkedHourList({required this.ticketDocId});
  final String ticketDocId;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<GetWorkedHourBloc, GetWorkedHourState>(
      builder: (context, state) {
        if (state is GetWorkedHourLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetWorkedHourData) {
          if (state.logModel.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: theme.spacings.spacing12),
              child: const Center(
                child: Text('Empty work log'),
              ),
            );
          }
          return Column(
            children: state.logModel.map((e) {
              return ListTile(
                title: Text(e.name?.capitalize() ?? ''),
                trailing: Text(
                  '${e.workedHours} hrs ',
                ),
              );
            }).toList(),
          );
        } else if (state is GetWorkedHourError) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
