import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contact_box/features/contacts/presentation/widgets/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsHome extends StatefulWidget {
  const ContactsHome({super.key});

  @override
  State<ContactsHome> createState() => _ContactsHomeState();
}

class _ContactsHomeState extends State<ContactsHome> {
  @override
  void initState() {
    context.read<ContactBloc>().add(GetAllContactsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ContactsList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDarkishBlack,
        onPressed: () {
          navigatorKey.currentState?.pushNamed(AppRoutesName.addContact);
        },
        child: const Icon(
          Icons.add,
          color: kWhite,
          size: 30,
        ),
      ),
    );
  }
}
