import 'package:contact_box/core/components/single_contact_tile.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return const SingleContactTile();
      },
      separatorBuilder: (context, index) => kHeight10,
      itemCount: 10,
    );
  }
}


