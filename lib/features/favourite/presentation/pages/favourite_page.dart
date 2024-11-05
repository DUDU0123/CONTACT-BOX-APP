import 'package:contact_box/core/components/single_contact_tile.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const SingleContactTile();
        },
        separatorBuilder: (context, index) => kHeight10,
      ),
    );
  }
}
