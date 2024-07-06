import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mosaic_communities/constants/appwrite.dart';
import 'package:mosaic_communities/core/core.dart';
import 'package:mosaic_communities/core/providers.dart';
import 'package:mosaic_communities/models/user_model.dart';

import '../core/typedef.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);

  Future<Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.userCollection,
          documentId: userModel.uid,
          data: userModel.toMap());
      return Either.right(null);
    } on AppwriteException catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    } catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    }
  }

  @override
  Future<Document> getUserData(String uid) async {
    var data;

    try {
       data = await _db.getDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.userCollection,
          documentId: uid);
    } catch (e) {
      print(e);
    }
    return data;
  }
}
