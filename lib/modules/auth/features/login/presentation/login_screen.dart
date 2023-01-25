import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/modules/auth/features/login/model/login_model.dart';
import 'package:time_tracking/modules/auth/features/login/presentation/cubit/email_login_cubit.dart';
import 'package:time_tracking/modules/auth/features/register/presentation/cubit/email_register_cubit_cubit.dart';
import 'package:time_tracking/modules/auth/features/register/presentation/register_screen.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/kanban_board.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.emailLogin});
  final EmailLoginCubit emailLogin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => emailLogin,
      child: LoginScreen(
        emailLogin: emailLogin,
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final EmailLoginCubit emailLogin;

  const LoginScreen({
    required this.emailLogin,
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CustomScaffold(
      title: Text(
        "email_login_title".locale(),
        style: theme.textStyles.heading3_500.copyWith(
          color: theme.colors.brand.main,
        ),
      ),
      centerTitle: false,
      body: SafeArea(
        child: BlocConsumer<EmailLoginCubit, EmailLoginState>(
          listener: (context, state) {
            if (state is EmailLoginData) {
              context
                  .read<NavigationCubit>()
                  .root(const MaterialPage(child: KanbanBoard()));
            } else if (state is EmailLoginError) {
              DesignConfirmationDialog.show(
                context: context,
                title: '',
                subtitle: state.error,
                primaryActionText: 'CLOSE',
              );
            } else if (state is EmailValidationError) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: 'Email is Invalid',
                primaryActionText: 'Ok',
              );
            } else if (state is PasswordValidationError) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: 'Password is invalid',
                primaryActionText: 'Ok',
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        prefixIconData: Icons.email,
                        placeholderText: "email".locale(),
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: emailController,
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        placeholderText: "password".locale(),
                        prefixIconData: Icons.password,
                        obscureText: true,
                        suffixType: DesignTextFieldSuffixType.obscure,
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: passwordController,
                        focusNode: FocusNode(),
                      ),
                    ),

                    // const Spacer(),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: theme.spacings.spacing32, vertical: 12),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: theme.colors.brand.main,
                            ),
                            children: [
                              const TextSpan(text: "Don't have account ?"),
                              TextSpan(
                                text: " Register",
                                style: theme.textStyles.paragraph_700.copyWith(
                                  color: theme.colors.brand.main,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 2,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<NavigationCubit>().push(
                                          MaterialPage(
                                            child: RegisterView(
                                              emailRegister: GetIt.I
                                                  .get<EmailRegisterCubit>(),
                                            ),
                                          ),
                                        );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacings.spacing32,
                        vertical: 12,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DesignContainedButtonMedium(
                            label: "Login".locale(),
                            onPressed: state is EmailLoginLoading
                                ? null
                                : () {
                                    context
                                        .read<EmailLoginCubit>()
                                        .performLogin(
                                          loginData: LoginModel(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  },
                          ),
                          if (state is EmailLoginLoading)
                            Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
