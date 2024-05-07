import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minly_media_mobile/business-logic/bloc/post/post_bloc.dart';
import 'package:minly_media_mobile/data/models/post/post.dart';
import 'package:minly_media_mobile/presentation/widgets/post.dart';

class FeedsTab extends StatefulWidget {
  const FeedsTab({super.key});

  @override
  State<FeedsTab> createState() => _FeedsTabState();
}

class _FeedsTabState extends State<FeedsTab> {
  BuildContext? dialogContext;
  late ScrollController _scrollController;

  int currentPage = 1;
  List<Post> posts = [];

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      currentPage++;
      PostsState state = BlocProvider.of<PostsBloc>(context).state;
      BlocProvider.of<PostsBloc>(context).add(PostsFetchEvent(
          pageNumber: currentPage,
          pageSize: 50,
          posts: state is PostFetchedSuccessfully ? state.posts : null));
    }
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PostsBloc>(context)
        .add(PostsFetchEvent(pageNumber: 1, pageSize: 50));

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: (context, state) {
        // initial state
        if (state is PostsInitial || state is PostFetchedSuccessfully) {
          setState(() {
            posts = state is PostFetchedSuccessfully
                ? state.posts
                : List<Post>.empty();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Posts loaded successfully'),
            ),
          );
          if (dialogContext != null) {
            Navigator.pop(dialogContext!);
          }
        }

        // fetching state
        if (state is PostsFetching || state is PostsInitial) {
          showDialog(
              context: context,
              builder: (context) {
                dialogContext = context;
                return const Center(child: CircularProgressIndicator());
              });
        }
        // error state
        if (state is PostFetchError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.message),
                );
              });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        // success  state
        if (state is PostFetchedSuccessfully) {
          return RefreshIndicator(
            onRefresh: () async {
              currentPage = 1;
              BlocProvider.of<PostsBloc>(context)
                  .add(PostsFetchEvent(pageNumber: 1, pageSize: 50));
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return PostWidget(post: posts[index]);
              },
            ),
          );
        }

        return const Center(child: Text('No posts yet'));
      },
    );
  }
}
