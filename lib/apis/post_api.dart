import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mosaic_communities/core/core.dart';
import 'package:mosaic_communities/core/providers.dart';

import '../constants/appwrite.dart';
import '../models/post_model.dart';

final postAPIProvider = Provider((ref) {
  return PostAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IPostAPI{
  FutureEither<Document> sharePost(Post post);
}

class PostAPI extends IPostAPI{

  final Databases _db;
  PostAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> sharePost(Post post) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.postCollection,
          documentId: ID.unique(),
          data: post.toMap());
      return Either.right(document);
    } on AppwriteException catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    } catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    }
  }

}