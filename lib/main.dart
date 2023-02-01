import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/domain/models/card_model/card_model.dart';
import 'package:safe_manager/domain/models/notes_model/notes_model.dart';
import 'package:safe_manager/domain/models/password_model.dart';
import 'package:safe_manager/presentation/screens/initial/initial_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(VerifyAccountEvent())),
        BlocProvider(create: (context) => RandomNumberBloc()),
        BlocProvider(create: (context) => CreateAccountBloc()),
        BlocProvider(create: (context) => ThemesBloc()),
        BlocProvider(create: (context) => GeneratePasswordBloc()),
        BlocProvider(create: (context) => GeneralBloc()),
        BlocProvider(create: (context) => PasswordBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SecurityBloc()),
        BlocProvider(create: (context) => CardBloc()),
        BlocProvider(create: (context) => NotesBloc()),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    main();
    super.initState();
  }


  void main() async {

    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final containsEncryptionKey = await secureStorage.containsKey(key: 'key');

    if(!containsEncryptionKey){
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    final key = await secureStorage.read(key: 'key');

    var encryptionKey = base64Url.decode(key!);

    Hive.registerAdapter(PasswordModelAdapter());
    Hive.registerAdapter(CardModelAdapter());
    Hive.registerAdapter(NotesModelAdapter());

    await Hive.openBox<PasswordModel>('encrypt-password-fraved', encryptionCipher: HiveAesCipher(encryptionKey));
    await Hive.openBox<CardModel>('encrypt-card-wallet-fraved', encryptionCipher: HiveAesCipher(encryptionKey));
    await Hive.openBox<NotesModel>('encrypt-notes-fraved', encryptionCipher: HiveAesCipher(encryptionKey));
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark )
    );

    return BlocBuilder<ThemesBloc, ThemesState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Safe Manager',
          debugShowCheckedModeBanner: false,
          theme: ThemesFraved.appTheme,
          darkTheme: ThemesFraved.appThemeDark,
          themeMode: state.isOscure ? ThemeMode.dark : ThemeMode.light,
          home: const InitialScreen(),
        );
      }
    );
  }
}