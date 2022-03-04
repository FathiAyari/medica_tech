import 'package:firebase_auth/firebase_auth.dart';

class Authservices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
