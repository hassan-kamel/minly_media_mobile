import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minly_media_mobile/data/models/post/post.dart';
import 'package:minly_media_mobile/presentation/widgets/minly_player.dart';
import 'package:minly_media_mobile/utils/get_time.dart';
import 'package:recase/recase.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.post});
  final Post post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    super.initState();

    debugPrint(widget.post.mediaUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Post Header
        Container(
          margin: const EdgeInsets.all(20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    widget.post.author.fullName!.substring(0, 2).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // ReCase(widget.post.author.fullName!).titleCase,
                        widget.post.author.fullName!.titleCase,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // capitalize: true
                        ),
                      ),
                      Text(getTime(widget.post.createdAt.toString()))
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                debugPrint("details");
              },
              icon: const Icon(Icons.more_vert),
            ),
          ]),
        ),
        //  Post Media
        widget.post.type == 'IMAGE'
            ? CachedNetworkImage(
                imageUrl: widget.post.mediaUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  debugPrint(error.toString());
                  return const Icon(Icons.error);
                },
                width: MediaQuery.of(context).size.width,
                height: 400,
                fit: BoxFit.cover,
              )
            :

            // const Center(
            //     child: CircularProgressIndicator(),
            //   ),

            MinlyPlayer(url: widget.post.mediaUrl),

        // Post Footer
        Container(
          margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/heart-lined.svg',
                            width: 30),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/comment.svg'),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_outlined),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/bookmark.svg'),
                  ),
                ],
              ),

              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.post.likedBy.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "${widget.post.likedBy.length.toString()} likes",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(),

                    // Post Caption
                    Text(widget.post.caption.titleCase),
                  ],
                ),
              )
              // Post Likes
            ],
          ),
        ),
      ],
    );
  }
}
