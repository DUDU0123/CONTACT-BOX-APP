import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/features/contacts/presentation/pages/contacts_home.dart';
import 'package:contact_box/features/contacts/presentation/widgets/contacts_search_field.dart';
import 'package:contact_box/features/favourite/presentation/pages/favourite_page.dart';
import 'package:contact_box/features/main_entry/presentation/bloc/cubit/page_select_cubit.dart';
import 'package:contact_box/features/main_entry/presentation/widgets/bottom_nav_bar.dart';
import 'package:contact_box/features/main_entry/presentation/widgets/appbar_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final pages = [
  const ContactsHome(),
  const FavouritePage(),
];

class MainEntry extends StatelessWidget {
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          final currentIndex =
              context.watch<PageSelectCubit>().state.currentIndex;
          return [
            SliverAppBar(
              title: TextWidgetCommon(
                text: currentIndex == 0 ? "Contacts" : "Favorites",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              actions: [
                if (currentIndex != 1) ...contactHomeAppBarIcons(),
              ],
              bottom: currentIndex == 0
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: currentIndex == 0
                          ? const ContactSearchField()
                          : zeroMeasuredWidget,
                    )
                  : null,
            ),
          ];
        },
        body: BlocBuilder<PageSelectCubit, PageSelectState>(
          builder: (context, state) {
            return pages[state.currentIndex];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
