import 'package:flutter/material.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TikTokSDK.instance.setup(clientKey: 'TikTokAppID');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String loginResult = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await TikTokSDK.instance.login(
                    permissions: {
                      TikTokPermissionType.userInfoBasic,
                    },
                  );
                  setState(() => loginResult = result.toString());
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              Text('Login result: $loginResult'),
            ],
          ),
        ),
      ),
    );
  }
}
