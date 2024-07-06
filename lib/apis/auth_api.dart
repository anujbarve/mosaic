import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mosaic_communities/core/providers.dart';

import '../core/core.dart';

final authApiProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  FutureEither<model.User> signUp(
      {required String email, required String pass});

  FutureEither<model.Session> logIn(
      {required String email, required String pass});

  Future<model.User?> currentUserAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signUp(
      {required String email, required String pass}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: pass);
      return Either.right(account);
    } on AppwriteException catch (e, stackTrace) {
      return Either.left(
          Failure(e.message ?? "Unexpected Error Occured", stackTrace));
    } catch (e, stackTrace) {
      return Either.left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> logIn(
      {required String email, required String pass}) async {
    try {
      final session = await _account.createEmailPasswordSession(
          email: email, password: pass);
      return Either.right(session);
    } on AppwriteException catch (e, stackTrace) {
      return Either.left(
          Failure(e.message ?? "Unexpected Error Occured", stackTrace));
    } catch (e, stackTrace) {
      return Either.left(Failure(e.toString(), stackTrace));
    }
  }
}
