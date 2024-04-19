import 'package:flutter/material.dart';
import 'package:minly_media_mobile/presentation/widgets/post.dart';

class FeedsTab extends StatefulWidget {
  const FeedsTab({super.key});

  @override
  State<FeedsTab> createState() => _FeedsTabState();
}

class _FeedsTabState extends State<FeedsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Post());
  }
}
