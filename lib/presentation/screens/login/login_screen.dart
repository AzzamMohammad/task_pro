import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pro/business/login_bloc/login_bloc.dart';
import 'package:task_pro/consetant/page_routes.dart';
import 'package:task_pro/presentation/components/loding_message.dart';
import '../../components/empty_space.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _formKay;
  late bool _passwordIsHead;
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _formKay = GlobalKey<FormState>();
    _passwordIsHead = false;
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.h),
          children: [
            _appLogo(),
            EmptySpace(height: 100.h),
            _inputFields(),
            EmptySpace(height: 30.h),
            _sendButton(),
          ],
        ),
      ),
    );
  }

  Widget _appLogo() {
    return SizedBox(
      height: 250.h,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            text: 'task '.toUpperCase(),
            style: TextStyle(
              fontSize: 40.spMin,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black,
            ),
            children: [
              TextSpan(
                text: 'pro'.toUpperCase(),
                style: TextStyle(
                  fontSize: 40.spMin,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputFields() {
    return Form(
      key: _formKay,
      child: Column(
        children: [
          _userName(),
          const EmptySpace(
            height: 20,
          ),
          _password(),
        ],
      ),
    );
  }

  Widget _userName() {
    return TextFormField(
      controller: _userNameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.user_name),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        return _validateUserNameValue(value);
      },
    );
  }

  _validateUserNameValue(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.user_name_is_required;
    }
    return null;
  }

  Widget _password() {
    return TextFormField(
      obscureText: _passwordIsHead,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.password),
        prefixIcon: const Icon(Icons.password),
        suffixIcon: _visiblePasswordIcon(),
      ),
      validator: (value) {
        return _validatePasswordValue(value);
      },
    );
  }

  Widget _visiblePasswordIcon() {
    return IconButton(
      icon: _passwordIsHead
          ? const Icon(
              Icons.visibility_off,
            )
          : const Icon(
              Icons.visibility,
            ),
      onPressed: () {
        setState(() {
          _passwordIsHead = !_passwordIsHead;
        });
      },
    );
  }

  _validatePasswordValue(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.password_is_required;
    }
    return null;
  }

  Widget _sendButton() {
    return FilledButton(
      onPressed: () {
        _loginUser();
      },
      child: Text(AppLocalizations.of(context)!.send),
    );
  }

  void _loginUser() async {
    bool validation = _formKay.currentState!.validate();
    if (validation) {
      // we can send data to login
      //1- set loading
      LoadingMessage.displayLoading(Theme.of(context).cardColor, Colors.blue);
      // 2- call event
      BlocProvider.of<LoginBloc>(context).add(
          LoginUserWithUserNameAndPasswordEvent(
              userName: _userNameController.text,
              password: _passwordController.text,
          ),);
      // 3- listen to state changing
      _listenToChanges();
    }
  }
  void _listenToChanges(){
    BlocProvider.of<LoginBloc>(context).stream.listen((event) {
      if (event is LoginSuccessfullyState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.login_successfully, false);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(PageRoutes.homeScreen, (route) => false);
      }
      if (event is LoginFailedByInfoErrorState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.error_in_user_name_or_password, false);
      }
      if (event is LoginFailedWhileSavingErrorState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.an_error_happen, false);
      }
    });
  }
}
