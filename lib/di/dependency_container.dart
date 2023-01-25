import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/modules/auth/features/login/domain/repository/login_repository.dart';
import 'package:time_tracking/modules/auth/features/login/domain/usecase/login_use_case.dart';
import 'package:time_tracking/modules/auth/features/login/presentation/cubit/email_login_cubit.dart';
import 'package:time_tracking/modules/auth/features/register/data/register_remote_data_source.dart';
import 'package:time_tracking/modules/auth/features/register/data/register_remote_data_source_impl.dart';
import 'package:time_tracking/modules/auth/features/register/domain/repository/register_repository.dart';
import 'package:time_tracking/modules/auth/features/register/domain/repository/register_repository_impl.dart';
import 'package:time_tracking/modules/auth/features/register/domain/usecase/register_use_case.dart';
import 'package:time_tracking/modules/auth/features/register/presentation/cubit/email_register_cubit_cubit.dart';
import 'package:time_tracking/modules/kanban/kanban_board/data/kanban_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/kanban_board/data/kanban_remote_data_source_impl.dart';
import 'package:time_tracking/modules/kanban/kanban_board/domain/repository/kanban_repository.dart';
import 'package:time_tracking/modules/kanban/kanban_board/domain/repository/kanban_repository_impl.dart';
import 'package:time_tracking/modules/kanban/kanban_board/domain/usecase/kanban_usecase.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/bloc/get_task_bloc.dart';
import 'package:time_tracking/modules/kanban/logs/data/log_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/logs/data/log_remote_data_source_impl.dart';
import 'package:time_tracking/modules/kanban/logs/domain/repository/log_repository.dart';
import 'package:time_tracking/modules/kanban/logs/domain/repository/log_repository_impl.dart';
import 'package:time_tracking/modules/kanban/logs/domain/usecase/log_user_case.dart';
import 'package:time_tracking/modules/kanban/logs/presentation/cubit/log_cubit.dart';
import 'package:time_tracking/modules/kanban/ticket/data/ticket_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/ticket/data/ticket_remote_data_source_impl.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/repository/ticket_repository.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/repository/ticket_repository_impl.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/usecase/ticket_usecase.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/bloc/task_bloc.dart';
import 'package:time_tracking/modules/kanban/ticket/presentation/cubit/add_task_cubit.dart';
import 'package:time_tracking/modules/kanban/worked_hours/data/worked_hours_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/worked_hours/data/worked_hours_remote_data_source_impl.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/repository/worked_hour_repository.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/repository/worked_hour_repository_impl.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/usecase/work_hour_usecase.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/bloc/get_worked_hour_cubit.dart';
import 'package:time_tracking/modules/kanban/worked_hours/presentation/cubit/worked_hours_cubit.dart';

import '../modules/auth/features/login/data/login_remote_data_source.dart';
import '../modules/auth/features/login/data/login_remote_data_source_impl.dart';
import '../modules/auth/features/login/domain/repository/login_repository_impl.dart';

class AppDependencyContainer extends DependencyContainer {
  @override
  Future<void> init() async {
    GetIt.I.pushNewScope();
    GetIt.instance
        .registerSingleton<LoginRemoteDataSource>(LoginRemoteDataSourceImpl());
    GetIt.instance.registerSingleton<LoginRepository>(LoginRespositoryImpl(
      GetIt.I.get<LoginRemoteDataSource>(),
    ));
    GetIt.instance.registerSingleton<LoginUseCase>(
        LoginUseCase(GetIt.I.get<LoginRepository>()));

    GetIt.instance
        .registerFactory(() => EmailLoginCubit(GetIt.I.get<LoginUseCase>()));

    ///
    GetIt.instance.registerSingleton<RegisterRemoteDataSource>(
        RegisterRemoteDataSourceImpl());
    GetIt.instance.registerSingleton<RegisterRepository>(RegisterRepositoryImpl(
      GetIt.I.get<RegisterRemoteDataSource>(),
    ));
    GetIt.instance.registerSingleton<RegisterUseCase>(
        RegisterUseCase(GetIt.I.get<RegisterRepository>()));

    GetIt.instance.registerFactory(
        () => EmailRegisterCubit(GetIt.I.get<RegisterUseCase>()));
//
    GetIt.instance.registerSingleton<KanbanRemoteDataSource>(
        KanbanRemoteDataSourceImpl());
    GetIt.instance.registerSingleton<KanbanRepository>(KanbanRepositoryImpl(
      GetIt.I.get<KanbanRemoteDataSource>(),
    ));

    GetIt.instance.registerSingleton<TicketRemoteDataSource>(
        TicketRemoteDataSourceImpl());
    GetIt.instance.registerSingleton<TicketRepository>(
        TicketRepositoryImpl(GetIt.I.get<TicketRemoteDataSource>()));
    GetIt.instance.registerSingleton<CreateTaskUseCase>(
        CreateTaskUseCase(GetIt.I.get<TicketRepository>()));
    GetIt.instance.registerSingleton<UpdateTicketUseCase>(
        UpdateTicketUseCase(GetIt.I.get<TicketRepository>()));

    // DeleteTicketUseCase
    GetIt.instance.registerSingleton<DeleteTicketUseCase>(
        DeleteTicketUseCase(GetIt.I.get<TicketRepository>()));

    GetIt.instance.registerFactory<AddTaskCubit>(() => AddTaskCubit(
        GetIt.I.get<CreateTaskUseCase>(),
        GetIt.I.get<UpdateTicketUseCase>(),
        GetIt.I.get<DeleteTicketUseCase>()));

    ///
    GetIt.instance.registerSingleton<FetchAllTaskUseCase>(
        FetchAllTaskUseCase(GetIt.I.get<KanbanRepository>()));
    GetIt.instance.registerSingleton<MoveTicketUsecase>(
        MoveTicketUsecase(GetIt.instance.get<KanbanRepository>()));

    GetIt.instance.registerFactory(() => GetTaskBloc(
        GetIt.I.get<FetchAllTaskUseCase>(), GetIt.I.get<MoveTicketUsecase>()));

    GetIt.instance.registerSingleton<GetUserDataUseCase>(
        GetUserDataUseCase(GetIt.I.get<TicketRepository>()));

    GetIt.instance.registerFactory<TaskBloc>(
        () => TaskBloc(GetIt.I.get<GetUserDataUseCase>()));

    //
    GetIt.I.registerSingleton<WorkedHourRemoteDataSource>(
        WorkedHourRemoteDataSourceImpl());
    GetIt.I.registerSingleton<WorkedHourRepository>(
        WorkedHourRepositoryImpl(GetIt.I.get<WorkedHourRemoteDataSource>()));
    GetIt.I.registerSingleton<WorkedHourDeleteUseCase>(
        WorkedHourDeleteUseCase(GetIt.I.get<WorkedHourRepository>()));
    GetIt.I.registerSingleton<AddWorkedHourUseCase>(
        AddWorkedHourUseCase(GetIt.I.get<WorkedHourRepository>()));
    GetIt.I.registerFactory<WorkedHoursCubit>(() => WorkedHoursCubit(
        GetIt.I.get<WorkedHourDeleteUseCase>(),
        GetIt.I.get<AddWorkedHourUseCase>()));
    //
    GetIt.I.registerSingleton<AllWorkedHoursUseCase>(
        AllWorkedHoursUseCase(GetIt.I.get<WorkedHourRepository>()));
    GetIt.I.registerFactory<GetWorkedHourBloc>(
      () => GetWorkedHourBloc(
        GetIt.I.get<AllWorkedHoursUseCase>(),
      ),
    );
    //log di
    GetIt.instance.registerSingleton<LogRemoteDataSource>(LogRemoteDataSourceImpl());
    GetIt.instance.registerSingleton<LogRepository>(LogRepositoryImpl(GetIt.I.get<LogRemoteDataSource>()));
    GetIt.instance.registerSingleton<LogUseCase>(LogUseCase(GetIt.I.get<LogRepository>()));
     GetIt.instance.registerFactory<LogCubit>(()=>LogCubit(GetIt.I.get<LogUseCase>()));

  }

  @override
  Future<void> dispose() async {}
}
