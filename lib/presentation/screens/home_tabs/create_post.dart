import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:minly_media_mobile/business-logic/bloc/post/post_bloc.dart';
import 'package:minly_media_mobile/presentation/widgets/button.dart';
import 'package:minly_media_mobile/presentation/widgets/minly_player.dart';
import 'package:minly_media_mobile/presentation/widgets/text_field.dart';

class CreatePostTab extends StatefulWidget {
  const CreatePostTab({super.key});

  @override
  State<CreatePostTab> createState() => _CreatePostTabState();
}

class _CreatePostTabState extends State<CreatePostTab> {
  File? _selectedFile;

  final captionController = TextEditingController();

  BuildContext? dialogContext;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png', 'mp4', 'mkv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // Check if the selected file is an image or video based on MIME type
      if (_isImageOrVideo(file)) {
        setState(() {
          _selectedFile = File(file.path!);
        });
      } else {
        // Show error message if the selected file is not an image or video
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a valid image or video file'),
        ));
      }
    }
  }

  // Function to check if a file is an image or video based on MIME type
  bool _isImageOrVideo(PlatformFile file) {
    String? mimeType = lookupMimeType(file.path!);
    if (mimeType != null) {
      MediaType mediaType = MediaType.parse(mimeType);
      return mediaType.type == 'image' || mediaType.type == 'video';
    }
    return false;
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (_selectedFile == null) {
      return;
    }

    String? mimeType = lookupMimeType(_selectedFile!.path);
    if (mimeType == null) {
      return;
    }
    MediaType mediaType = MediaType.parse(mimeType);

    FormData formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        _selectedFile!.path,
        contentType: mediaType,
      ),
      'caption': captionController.text,
    });

    // debugPrint("formData $formData");

    BlocProvider.of<PostsBloc>(context).add(CreatePostEvent(post: formData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state is PostCreatedSuccessfully) {
          captionController.clear();
          _selectedFile = null;
          if (dialogContext != null) {
            Navigator.pop(dialogContext!);
          }
          ScaffoldMessenger.of(context).clearSnackBars();
          BlocProvider.of<PostsBloc>(context)
              .add(PostsFetchEvent(pageNumber: 1, pageSize: 10));
          context.go('/feeds');
        }

        if (state is PostCreatedError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }

        if (state is PostsFetching) {
          showDialog(
            context: context,
            builder: (context) {
              dialogContext = context;

              return const Center(child: CircularProgressIndicator());
            },
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyButton(
                  onTap: _pickFile,
                  text: 'Pick Image or Video',
                ),
                const SizedBox(height: 20),
                if (_selectedFile != null) ...[
                  if (_selectedFile!.path.endsWith('.mp4') ||
                      _selectedFile!.path
                          .endsWith('.mov')) // Check if selected file is video
                    MinlyPlayer(url: 'none', file: _selectedFile!.path)
                  else
                    Image.file(_selectedFile!), // Display image
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: captionController,
                    hintText: 'Caption',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  MyButton(
                    onTap: () {
                      _uploadFile(context);
                    },
                    text: 'Add Post',
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
