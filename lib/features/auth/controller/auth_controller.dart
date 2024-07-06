import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosaic_communities/core/utils.dart';
import 'package:mosaic_communities/features/auth/view/login_view.dart';
import 'package:mosaic_communities/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as models;
import 'package:mosaic_communities/models/user_model.dart';

import '../../../apis/auth_api.dart';
import '../../../apis/user_api.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authApiProvider), userAPI: ref.watch(userAPIProvider));
});

final currentUserAccountProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

final userDetailsProvider = FutureProvider.family((ref, String uid) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserDetailsProvider = FutureProvider((ref) async {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  // state isLoading

  Future<models.User?> currentUser() => _authAPI.currentUserAccount();

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.signUp(email: email, pass: password);

    state = false;
    response.fold((l) {
      showSnackBar(context, l.message);
    }, (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isPremium: false);

      final res = await _userAPI.saveUserData(userModel);
      res.fold((l) {
        showSnackBar(context, l.message);
      }, (_) {
        showSnackBar(context, "Account Created, Please Login");
        Navigator.pushReplacement(context, LoginView.route());
      });
    });
  }

  void logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.logIn(email: email, pass: password);

    state = false;
    response.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, "Login Successful");
      Navigator.pushReplacement(context, HomeView.route());
    });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);

    final updatedUser = UserModel.fromMap(document.data);

    return updatedUser;
  }
}
