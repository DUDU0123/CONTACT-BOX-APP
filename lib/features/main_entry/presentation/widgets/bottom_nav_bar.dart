import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/features/main_entry/presentation/bloc/cubit/page_select_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageSelectCubit, PageSelectState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: kBlack,
            enableFeedback: false,
            elevation: 0,
            currentIndex: state.currentIndex,
            onTap: (currentIndex) {
              context.read<PageSelectCubit>().selectIndex(
                    selectedIndex: currentIndex,
                  );
            },
            selectedItemColor: kWhite,
            unselectedItemColor: kGrey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contact_page_outlined,
                  ),
                  label: 'Conatcts'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star_outline_rounded,
                  ),
                  label: 'Favourites'),
            ],
          ),
        );
      },
    );
  }
}
