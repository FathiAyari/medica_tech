import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:medica_tech/patient/PatientView.dart';
import 'package:medica_tech/patient/folder_details.dart';
import 'package:medica_tech/temp/homepage.dart';
import 'package:medica_tech/views/dashboard/dashboard_cnam.dart';
import 'package:medica_tech/views/dashboard/dashboard_medicin.dart';
import 'package:medica_tech/views/dashboard/dashboard_screen.dart';
import 'package:medica_tech/views/login/login_screen.dart';

import 'chat/messages_medicin.dart';
import 'chat/messages_patient.dart';
import 'cnam/CnamView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDnznWZGkjAR9G6NtZQlkCT_YMhIIGrJms",
        authDomain: "medicatech-500d4.firebaseapp.com",
        projectId: "medicatech-500d4",
        storageBucket: "medicatech-500d4.appspot.com",
        messagingSenderId: "904177263784",
        appId: "1:904177263784:web:dec128109961d4935ece9d"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medica Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/patient", page: () => PatientView()),
        GetPage(name: "/cnam", page: () => CnamView()),
        GetPage(name: "/messages_patient", page: () => MessagesPatient()),
        GetPage(name: "/messages_medicin", page: () => MessagesMedicin()),
        GetPage(name: "/dashboard_patient", page: () => DashbaordScreen()),
        GetPage(name: "/dashboard_cnam", page: () => DsashboardCnam()),
        GetPage(name: "/dashboard_medicin", page: () => DashBoardMedicin()),
        GetPage(name: "/folder_details", page: () => FolderDetails()),
      ],
      home: HomePage(),
    );
  }
}
