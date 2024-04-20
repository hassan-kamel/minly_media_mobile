import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class MinlyPlayer extends StatefulWidget {
  const MinlyPlayer({super.key, required this.url});
  final String url;

  @override
  State<MinlyPlayer> createState() => _MinlyPlayerState();
}

class _MinlyPlayerState extends State<MinlyPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildWidget;
    try {
      buildWidget = AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            widget.url,
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
            ),
          ));
    } catch (e) {
      buildWidget = Center(child: Text(e.toString()));
    }
    return buildWidget;
  }
}
