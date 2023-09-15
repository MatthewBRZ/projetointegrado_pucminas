import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Models/Attendant.dart';
import '../Views/OptionsViewPage.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final attendant = Get.find<Attendant>();
  final navController = ScreenNavController();

  Future<bool> authenticate(String uid, String pass) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: '$uid@bakery.app',
        password: pass,
      );
      final User? user = userCredential.user;
      attendant.id = int.parse(uid);

      if (user != null) {
        // Authentication successful, navigate to the next screen here
        navController.navigateToScreen(const OptionsViewPage());
        return true;
      }
    } catch (e) {
      // Handle authentication errors and print for debug purposes
      print('Error: $e');
    }
    return false; // Return false in case of any errors
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
