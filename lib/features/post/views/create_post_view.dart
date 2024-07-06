import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_communities/common/loading_page.dart';
import 'package:mosaic_communities/common/rounded_small_button.dart';
import 'package:mosaic_communities/constants/constants.dart';
import 'package:mosaic_communities/features/auth/controller/auth_controller.dart';
import 'package:mosaic_communities/theme/theme.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreatePostScreen());

  const CreatePostScreen({super.key});

  @override
  ConsumerState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final postTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    postTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RoundedSmallButton(
              onTap: () {},
              label: "Post",
              bgColor: Pallete.blueColor,
              txtColor: Pallete.whiteColor,
            ),
          )
        ],
      ),
      body: currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(currentUser.profilePic),
                            radius: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: postTextController,
                              style: const TextStyle(fontSize: 22),
                              decoration: const InputDecoration(
                                  hintText: "What's Happening",
                                  hintStyle:
                                      TextStyle(color: Pallete.greyColor),
                                  border: InputBorder.none),
                              maxLines: null,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Pallete.greyColor,width: 0.3)
          )
        ),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SvgPicture.asset(AssetsConstants.galleryIcon),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SvgPicture.asset(AssetsConstants.emojiIcon),
            )
          ],
        ),
      ),
    );
  }
}
