import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ordered_image_list_view/ordered_image_list_view.dart';

sealed class Result<T extends Object?> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T? value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final Object? error;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ordered Image',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B7BF3)),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<String> images = [
    for (int i = 0; i < 10; i++)
      'https://picsum.photos/id/${(Random().nextInt(100) + 1)}/300/300',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordered Image'),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CustomScrollViewScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: OrderedImageListView.network(
        urls: [
          for (final image in images) Uri.parse(image),
        ],
      ),
    );
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  CustomScrollViewScreen({super.key});

  final List<String> images = [
    for (int i = 0; i < 10; i++)
      'https://picsum.photos/id/${(Random().nextInt(100) + 1)}/300/300',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Custom Scroll View'),
          ),
          SliverOrderedImageListView.network(
            urls: [
              for (final image in images) Uri.parse(image),
            ],
          ),
        ],
      ),
    );
  }
}
