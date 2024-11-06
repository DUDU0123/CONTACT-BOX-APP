import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionChecker {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  static ConnectivityResult? currentStatus;
  static checkConnection() async {
    List<ConnectivityResult> connectionStatus =
        await Connectivity().checkConnectivity();
    if (connectionStatus.contains(ConnectivityResult.none)) {
      currentStatus = ConnectivityResult.none;
      networkErrorShowSnackbar();
    } else {
      currentStatus = ConnectivityResult.other;
    }
  }

  static void listenForConnectionChanges() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectionStatus) {
      if (connectionStatus.contains(ConnectivityResult.none)) {
        currentStatus = ConnectivityResult.none;
        navigatorKey.currentContext!
            .read<ContactBloc>()
            .add(GetCacheContactEvent());
        networkErrorShowSnackbar();
      } else {
        // call the event that you want for fetch data
        currentStatus = ConnectivityResult.other;
        navigatorKey.currentContext!
            .read<ContactBloc>()
            .add(GetAllContactsEvent());
      }
    });
  }

  static void cancelConnectionSubscription() {
    _subscription?.cancel();
  }

  static void networkErrorShowSnackbar({
    String? message,
  }) {
    MessageShowhelper.showSnackbar(
        snackBarContent: message ?? "Please check your network connection");
  }
}
