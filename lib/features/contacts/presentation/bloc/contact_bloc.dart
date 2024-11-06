import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/core/service_locator/service_locator.dart';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/usecase/add_contact_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/delete_contact_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/edit_contact_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/get_all_contacts_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/get_cache_contact_data.dart';
import 'package:contact_box/features/favourite/presentation/bloc/bloc/favorite_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final GetAllContactsUsecase _getAllContactsUsecase;
  final DeleteContactUsecase _deleteContactUsecase;
  final EditContactUsecase _editContactUsecase;
  final AddContactUsecase _addContactUsecase;
  final GetCacheContactDataUseCase _getCacheContactDataUseCase;
  ContactBloc({
    required GetAllContactsUsecase getAllContactsUsecase,
    required DeleteContactUsecase deleteContactUsecase,
    required EditContactUsecase editContactUsecase,
    required AddContactUsecase addContactUsecase,
    required GetCacheContactDataUseCase getCacheContactDataUseCase,
  })  : _getAllContactsUsecase = getAllContactsUsecase,
        _addContactUsecase = addContactUsecase,
        _editContactUsecase = editContactUsecase,
        _getCacheContactDataUseCase = getCacheContactDataUseCase,
        _deleteContactUsecase = deleteContactUsecase,
        super(ContactInitial()) {
    on<GetAllContactsEvent>(getAllContactsEvent);
    on<AddContactEvent>(addContactEvent);
    on<EditContactEvent>(editContactEvent);
    on<DeleteContactEvent>(deleteContactEvent);
    on<GetCacheContactEvent>(getCacheContactEvent);
    on<GetCountryCodeEvent>(getCountryCodeEvent);
    on<SearchContactEvent>(searchContactEvent);
  }

  FutureOr<void> getAllContactsEvent(
      GetAllContactsEvent event, Emitter<ContactState> emit) async {
    try {
      final result = await _getAllContactsUsecase(params: null);
      result.fold(
        (failure) {
          emit(ContactErrorState(message: failure.message));
        },
        (contactList) {
          emit(ContactState(contactsList: contactList));
        },
      );
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

  FutureOr<void> addContactEvent(
      AddContactEvent event, Emitter<ContactState> emit) async {
    try {
      final result = await _addContactUsecase(params: event.newContact);
      result.fold(
        (failure) {
          emit(ContactErrorState(message: failure.message));
        },
        (contactList) {
          add(GetAllContactsEvent());
        },
      );
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

  FutureOr<void> editContactEvent(
      EditContactEvent event, Emitter<ContactState> emit) async {
    try {
      final result = await _editContactUsecase(params: event.updatedContact);
      result.fold(
        (failure) {
          emit(ContactErrorState(message: failure.message));
        },
        (contactList) {
          add(GetAllContactsEvent());
        },
      );
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

  FutureOr<void> deleteContactEvent(
      DeleteContactEvent event, Emitter<ContactState> emit) async {
    try {
      final result = await _deleteContactUsecase(params: event.contactId);
      final isExist =
          await CommonFunctions.isInFavorite(contactId: event.contactId);
      if (isExist) {
        navigatorKey.currentContext
            ?.read<FavoriteBloc>()
            .add(RemoveByContactId(id: event.contactId));
      }
      result.fold(
        (failure) {
          emit(ContactErrorState(message: failure.message));
        },
        (contactList) {
          add(GetAllContactsEvent());
        },
      );
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

  FutureOr<void> getCacheContactEvent(
      GetCacheContactEvent event, Emitter<ContactState> emit) async {
    try {
      final res = await _getCacheContactDataUseCase(params: null);
      res.fold(
        (failure) {
          emit(ContactErrorState(message: failure.message));
        },
        (contacts) {
          emit(ContactState(cachedContactList: contacts));
        },
      );
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

  FutureOr<void> getCountryCodeEvent(
      GetCountryCodeEvent event, Emitter<ContactState> emit) {
    try {
      emit(state.copyWith(countryCode: event.countryCode));
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

  Future<void> searchContactEvent(
    SearchContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      if (event.query.isNotEmpty) {
        // If the search query is not empty, get the filtered contacts stream
        Stream<List<ContactEntity>> contactsStream =
            _getContactsStream(event.query);
        emit(state.copyWith(contactsList: contactsStream));
      } else {
        // If the search query is empty, emit the full contact list
        final result = await _getAllContactsUsecase(params: null);
        result.fold(
          (failure) {
            emit(ContactErrorState(message: failure.message));
          },
          (contactList) {
            emit(ContactState(contactsList: contactList));
          },
        );
      }
    } catch (e) {
      emit(ContactErrorState(message: e.toString()));
    }
  }

// Function to return a stream of contacts based on the search query
  Stream<List<ContactEntity>> _getContactsStream(String query) {
    final queryRef = serviceLocator<FirebaseFirestore>()
        .collection(usersCollection)
        .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
        .collection(contactsCollection)
        .where(dbContactFullName, isGreaterThanOrEqualTo: query)
        .where(dbContactFullName, isLessThanOrEqualTo: '$query\uf8ff');

    return queryRef.snapshots().map((contactSnapshot) {
      return contactSnapshot.docs.map((doc) {
        return ContactModel.fromJson(doc.data());
      }).toList();
    });
  }
}
