import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_app/providers/theme_provider.dart';
import 'package:pokemon_app/repos/hive_repo.dart';
import 'package:pokemon_app/theme/style.dart';
import 'package:pokemon_app/ui/screens/all_pokemon_screen.dart';

Future main() async{
//To insure that all channels for native and flutter connection are properly set up. 
WidgetsFlutterBinding.ensureInitialized();
//to initialze the hive 
 await Hive.initFlutter();
 
 HiveRepo().registerAdapter();



  runApp(const 
  ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget{
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override 
  void initState() {
    super.initState();
    Future.microtask(() async {
          await ref.read(themeProvider.notifier).getSavedTheme();
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(themeProvider);
    return  MaterialApp(
      theme:Styles.themeData(isDarkTheme: isDarkTheme),
      home: AllPokemonScreen(),
    );
  }
}

