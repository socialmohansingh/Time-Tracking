import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:time_tracking/modules/auth/features/register/model/register_model.dart';
import 'package:time_tracking/modules/auth/features/register/presentation/cubit/email_register_cubit_cubit.dart';
import 'package:time_tracking/modules/kanban/kanban_board/presentation/kanban_board.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key, required this.emailRegister});
  final EmailRegisterCubit emailRegister;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => emailRegister,
      child: RegisterScreen(
        emailRegister: emailRegister,
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  final EmailRegisterCubit emailRegister;

  const RegisterScreen({
    required this.emailRegister,
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

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
        child: BlocConsumer<EmailRegisterCubit, EmailRegisterCubitState>(
          listener: (context, state) {
            if (state is RegisterSuccessfulState) {
              context
                  .read<NavigationCubit>()
                  .root(const MaterialPage(child: KanbanBoard()));
            } else if (state is RegisterErrorState) {
              DesignConfirmationDialog.show(
                context: context,
                title: '',
                subtitle: state.error,
                primaryActionText: 'Ok',
              );
            } else if (state is FullNameValidationState) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: state.errorMessage,
                primaryActionText: 'Ok',
              );
            } else if (state is EmailValidationState) {
              DesignConfirmationDialog.show(
                context: context,
                title: "",
                subtitle: state.errorMessage,
                primaryActionText: 'Ok',
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
                        placeholderText: "Full Name".locale(),
                        status: DesignTextFieldStatus(
                          statusType: DesignTextFieldStatusType.active,
                        ),
                        textEditingController: fullnameController,
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: theme.spacings.spacing32, vertical: 12),
                      child: DesignTextField(
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacings.spacing32,
                        vertical: 12,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DesignContainedButtonMedium(
                            label: "Register".locale(),
                            onPressed: state is EmailRegisterLoading
                                ? null
                                : () {
                                    context
                                        .read<EmailRegisterCubit>()
                                        .registerUser(
                                          data: RegisterModel(
                                            fullName: fullnameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  },
                          ),
                          if (state is EmailRegisterLoading)
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
