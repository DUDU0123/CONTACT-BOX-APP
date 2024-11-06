import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget emptyText({required String text}) => Center(
      child: TextWidgetCommon(
        text: text,
        textColor: kGrey,
      ),
    );
