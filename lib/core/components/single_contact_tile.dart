import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/components/common_contact_avatar.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/core/utils/native_action_methods.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/favourite/presentation/bloc/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleContactTile extends StatelessWidget {
  const SingleContactTile({
    super.key,
    required this.contact,
    this.isFavButtonNeeded = false, this.favId,
  });
  final ContactEntity contact;
  final bool isFavButtonNeeded;
  final String? favId;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        navigatorKey.currentState
            ?.pushNamed(AppRoutesName.contactViewPage, arguments: contact);
      },
      leading: CommonContactAvatar(
        avatarContainerSize: 50,
        fontSize: 30,
        centerAlphabet: contact.contactPersonFName?[0],
      ),
      title: TextWidgetCommon(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: "${contact.contactPersonFName} ${contact.contactPersonLName}" ??
            "User name",
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              if (contact.contactPersonNumber != null) {
                await NativeActionMethods.makePhoneCall(
                    contact.contactPersonNumber!);
              } else {
                MessageShowhelper.showSnackbar(
                    snackBarContent: "Cannot make call to this number");
              }
            },
            icon: const Icon(
              Icons.call,
              color: kWhite,
            ),
          ),
          isFavButtonNeeded
              ? IconButton(
                  onPressed: () async {
                   favId!=null? context.read<FavoriteBloc>().add(RemoveFromFavoriteEvent(favId: favId!)):null;
                  },
                  icon: const Icon(
                    Icons.star,
                    color: kWhite,
                  ),
                )
              : zeroMeasuredWidget,
        ],
      ),
    );
  }
}
