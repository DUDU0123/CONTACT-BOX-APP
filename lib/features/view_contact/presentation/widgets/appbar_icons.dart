import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/components/common_icon_button.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:contact_box/features/favourite/presentation/bloc/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Widget> appBarIconsOnContactView({
  ContactEntity? contact,
}) {
  navigatorKey.currentContext!
      .read<FavoriteBloc>()
      .add(CheckIsInFav(id: contact?.contactId));
  return [
    commonIconButton(
      icon: Icons.edit_outlined,
      onPressed: () {
        navigatorKey.currentState
            ?.pushNamed(AppRoutesName.editContact, arguments: contact);
      },
    ),
    BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return commonIconButton(
          icon: state.isInFavorite ? Icons.star : Icons.star_outline,
          onPressed: () async {
            if (contact != null) {
              if (contact.contactId != null) {
                final isExists = await CommonFunctions.isInFavorite(
                    contactId: contact.contactId!);
                if (!isExists) {
                  navigatorKey.currentContext!
                      .read<FavoriteBloc>()
                      .add(AddToFavoriteEvent(
                          favoriteContact: FavoriteEntity(
                        favContactId: contact.contactId,
                      )));
                } else {
                  navigatorKey.currentContext!
                      .read<FavoriteBloc>()
                      .add(RemoveByContactId(id: contact.contactId));
                }
              }
            } else {
              MessageShowhelper.showSnackbar(
                  snackBarContent: "Cannot add to favorite");
            }
          },
        );
      },
    ),
    PopupMenuButton(
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              MessageShowhelper.showDialogBox(
                dialogTitle: "Delete contact",
                dialogContent: "Are you sure about deleting this contact?",
                actionButtonName: "Delete",
                buttonActionMethod: () {
                  if (contact != null) {
                    if (contact.contactId != null) {
                      context.read<ContactBloc>().add(
                          DeleteContactEvent(contactId: contact.contactId!));
                    }
                  }
                  navigatorKey.currentState?.pop();
                  Future.delayed(const Duration(milliseconds: 300), () {
                    navigatorKey.currentState?.pop();
                  });
                },
              );
            },
            child: const TextWidgetCommon(
              text: "Delete",
            ),
          ),
        ];
      },
    ),
  ];
}
