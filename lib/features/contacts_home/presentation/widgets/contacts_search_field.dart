import 'package:contact_box/core/components/text_field_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ContactSearchField extends StatefulWidget {
  const ContactSearchField({
    super.key,
  });

  @override
  State<ContactSearchField> createState() => _ContactSearchFieldState();
}

class _ContactSearchFieldState extends State<ContactSearchField> {
  TextEditingController contactController = TextEditingController();
  @override
  void dispose() {
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(left: 15, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          50,
        ),
        color: const Color.fromARGB(255, 44, 44, 44),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: kWhite,
            size: 30,
          ),
          Expanded(
            child: TextFieldCommon(
              hintText: "Search contact",
              textAlign: TextAlign.start,
              controller: contactController,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
