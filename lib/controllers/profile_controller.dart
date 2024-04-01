// import 'dart:ffi';
//
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../services/user_repository.dart';
//
// class ProfileController extends GetxController {
//   static ProfileController get instonce => Get.find();
//
//   final _userRepo = Get.put(UserRepository());
//
//   /// Step 3 - Get User Emoil ond pass to UserRepository to fetch user record.
//   getUserData() {
//     final email = _authRepo.firebaseUser.value ?. email;
//     if(email != null){
//       return _userRepo.getUserDetails(email);
//     } else {
//       Get.snackbar("Error", "Login to continue");
//     }
//   }
// }