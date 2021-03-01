import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify/amplifyconfiguration.dart';
import 'package:flutter_aws_amplify/pages/camera_flow_page.dart';
import 'package:flutter_aws_amplify/pages/login_page.dart';
import 'package:flutter_aws_amplify/pages/signup_page.dart';
import 'package:flutter_aws_amplify/pages/verification_page.dart';
import 'package:flutter_aws_amplify/services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();
  final _amplify = Amplify();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
    //_authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AWS Amplify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoginPage(),
      // home: Navigator(
      //   pages: [
      //     MaterialPage(child: LoginPage()),
      //     MaterialPage(child: SignUpPage())
      //   ],
      //   onPopPage: (route, result) => route.didPop(result),
      // ),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // Show Login Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                    child: LoginPage(
                      didProvideCredentials: _authService.loginWithCredentials,
                      shouldShowSignUp: _authService.showSignUp,
                    ),
                  ),

                // Show Sign Up Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                    child: SignUpPage(
                      didProvideCredentials: _authService.signUpWithCredentials,
                      shouldShowLogin: _authService.showLogin,
                    ),
                  ),

                // Show Verification Code Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(
                    child: VerificationPage(
                        didProvideVerificationCode: _authService.verifyCode),
                  ),

                // Show Camera Flow
                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(
                    child: CameraFlow(shouldLogOut: _authService.logOut),
                  ),
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _configureAmplify() async {
    _amplify.addPlugin(
        authPlugins: [AmplifyAuthCognito()],
        storagePlugins: [AmplifyStorageS3()],
        analyticsPlugins: [AmplifyAnalyticsPinpoint()]);
    try {
      await _amplify.configure(amplifyconfig);
      print('Successfully configured Amplify 🎉');
    } catch (e) {
      print('Could not configure Amplify ☠️');
    }
  }
}
