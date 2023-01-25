import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/di/dependency_container.dart';
import 'package:time_tracking/firebase_options.dart';
import 'package:time_tracking/modules/auth/features/login/presentation/cubit/email_login_cubit.dart';
import 'package:time_tracking/modules/auth/features/login/presentation/login_screen.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/kanban_board.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(
    GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterDesignApp(
      home: RootNavigatorWidget(
        navigatorKey: _navigatorKey,
        initialPages: () {
          return [
            MaterialPage(
              child: FirebaseAuth.instance.currentUser == null
                  ? LoginView(
                      emailLogin: GetIt.I.get<EmailLoginCubit>(),
                    )
                  : const KanbanBoard(),
            ),
          ];
        },
        dependencyContainer: AppDependencyContainer(),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {}
