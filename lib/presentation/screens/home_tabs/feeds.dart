import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minly_media_mobile/business-logic/bloc/post/post_bloc.dart';
import 'package:minly_media_mobile/presentation/widgets/post.dart';

class FeedsTab extends StatefulWidget {
  const FeedsTab({super.key});

  @override
  State<FeedsTab> createState() => _FeedsTabState();
}

class _FeedsTabState extends State<FeedsTab> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<PostsBloc>(context)
        .add(PostsFetchEvent(pageNumber: 1, pageSize: 10));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        // initial state
        if (state is PostsInitial ||
            state is PostFetchedSuccessfully && state.posts.isEmpty) {
          return const Center(
            child: Text('No Data'),
          );
        }

        // fetching state
        if (state is PostsFetching || state is PostsInitial) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        // error state
        if (state is PostFetchError) {
          return Center(
            child: Text(state.message),
          );
        }

        // success state
        if (state is PostFetchedSuccessfully) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostWidget(post: state.posts[index]);
            },
          );
        }

        // unknown state
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
