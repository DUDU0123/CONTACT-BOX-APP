import 'package:contact_box/core/components/empty_text.dart';
import 'package:contact_box/core/components/single_contact_tile.dart';

import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactErrorState) {
          MessageShowhelper.showSnackbar(snackBarContent: state.message);
        }
      },
      builder: (context, state) {
        return StreamBuilder<List<ContactEntity>>(
            stream: state.contactsList,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return emptyText(text: "No contacts");
              }
              if (snapshot.data!.isEmpty) {
                return emptyText(text: "No contacts");
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  return SingleContactTile(
                    contact: snapshot.data![index],
                  );
                },
                separatorBuilder: (context, index) => kHeight10,
                itemCount: snapshot.data!.length,
              );
            });
      },
    );
  }
}
