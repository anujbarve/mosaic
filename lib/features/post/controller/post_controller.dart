import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosaic_communities/apis/post_api.dart';
import 'package:mosaic_communities/core/enums/post_type.dart';
import 'package:mosaic_communities/core/utils.dart';
import 'package:mosaic_communities/features/auth/controller/auth_controller.dart';
import 'package:mosaic_communities/models/post_model.dart';

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  return PostController(ref, ref.watch(postAPIProvider));
});

class PostController extends StateNotifier<bool> {
  final PostAPI _postAPI;
  final Ref _ref;

  PostController(this._ref, this._postAPI) : super(false);

  void sharePost(
      {required List<File> images,
      required String text,
      required BuildContext context}) {
    if (text.isEmpty) {
      showSnackBar(context, "Please Enter Text");
    }

    if (images.isNotEmpty) {
      _shareImagePost(images: images, text: text, context: context);
    } else {
      _shareTextPost(text: text, context: context);
    }
  }

  void _shareImagePost(
      {required List<File> images,
      required String text,
      required BuildContext context}) {}

  void _shareTextPost(
      {required String text, required BuildContext context}) async {
    state = true;
    final hastags = _getHashtagsFromText(text);
    final link = _getLinkFromText(text);

    final user = _ref.read(currentUserDetailsProvider).value!;
    final post = Post(
        text: text,
        hashtags: hastags,
        link: link,
        imageLinks: [],
        uid: user.uid,
        postType: PostType.text,
        postedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: '',
        reshareCount: 0,
        repostedBy: "",
        repliedTo: "");

    final res = await _postAPI.sharePost(post);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith("https://") || word.startsWith("www.")) {
        link = word;
      }
      ;
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith("#")) {
        hashtags.add(word);
      }
      ;
    }
    return hashtags;
  }
}
