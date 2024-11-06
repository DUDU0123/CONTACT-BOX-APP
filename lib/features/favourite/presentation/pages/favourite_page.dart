import 'package:contact_box/core/components/common_loading.dart';
import 'package:contact_box/core/components/empty_text.dart';
import 'package:contact_box/core/components/single_contact_tile.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:contact_box/features/favourite/presentation/bloc/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(GetAllFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteErrorState) {
            MessageShowhelper.showSnackbar(snackBarContent: state.message);
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return commonLoading();
          }
          return StreamBuilder<List<FavoriteEntity>>(
              stream: state.favoriteList,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return emptyText(text: "No favorite contacts found");
                }
                if (snapshot.data!.isEmpty) {
                  return emptyText(text: "No favorite contacts found");
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder<ContactEntity?>(
                        stream: snapshot.data![index].favContactId != null
                            ? CommonFunctions.getContactById(
                                contactId: snapshot.data![index].favContactId!)
                            : null,
                        builder: (context, contactSnap) {
                          if (contactSnap.data != null) {
                            return SingleContactTile(
                              contact: contactSnap.data!,
                              favId: snapshot.data![index].favId,
                              isFavButtonNeeded: true,
                            );
                          } else {
                            return zeroMeasuredWidget;
                          }
                        });
                  },
                  separatorBuilder: (context, index) => kHeight10,
                );
              });
        },
      ),
    );
  }
}
