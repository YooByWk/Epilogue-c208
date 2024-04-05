import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:frontend/routes/main_route.dart';
import 'package:frontend/providers/providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


const Color themeColour1 = Color(0xFFF0EBE3);
const Color themeColour2 = Color(0xFFE4DCCF);
const Color themeColour3 = Color(0xFFADC2A9);
const Color themeColour4 = Color(0xFF99A799);
const Color themeColour5 = Color(0xFF617C77);
const Color whiteText = Color(0xFFFFFFFF);
const Color blackText = Color(0xFF121212);
const Color backgroundColour = Color(0xFFF8F6F2);

const storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  debugPrint(await storage.read(key: 'privateKey'));
  debugPrint(await storage.read(key: 'userId'));
  debugPrint(await storage.read(key: 'walletAddress'));
  debugPrint(await storage.read(key: 'mnemonic'));
  // runApp(MyApp());
  runApp(OverlaySupport(child: setupProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'E:pilogue',
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: LoginScreen(),
        onGenerateRoute: generateMainRoute,
      ),
    );
  }
}
