import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Post Header
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    'HK',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Hassan Kamel'), Text('2h')],
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
        Container()
      ],
    );
  }
}
