import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/core/exceptions/exceptions.dart';
import 'package:contact_box/core/service_locator/service_locator.dart';
import 'package:contact_box/features/contacts/data/data_sources/cache_contact_data.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';

abstract interface class ContactData {
  Future<bool> addContact({
    required ContactModel contactModel,
  });
  Future<bool> editContact({
    required ContactModel updatedModel,
  });
  Future<bool> deleteContact({
    required String contactId,
  });
  Stream<List<ContactModel>> getAllContacts();
}

class ContactDataImpl implements ContactData {
  final FirebaseFirestore firebaseFirestore;
  final CacheContactData cacheContactData;
  ContactDataImpl({
    required this.firebaseFirestore,
    required this.cacheContactData,
  });
  @override
  Future<bool> addContact({
    required ContactModel contactModel,
  }) async {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) {
        throw ServerException(message: "User is null");
      }
      final contactDocRef = await firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(contactsCollection)
          .add(contactModel.toJson());

      final updatedContactModel =
          contactModel.copyWith(contactId: contactDocRef.id);

      firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(contactsCollection)
          .doc(contactDocRef.id)
          .update(
            updatedContactModel.toJson(),
          );
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<ContactModel>> getAllContacts() {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) {
        throw ServerException(message: "User is null");
      }

      return firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(contactsCollection)
          .snapshots()
          .map((data) {
        final contacts = data.docs
            .map(
              (doc) => ContactModel.fromJson(
                doc.data(),
              ),
            )
            .toList();
        cacheContactsLocally(contacts);
        return contacts;
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> cacheContactsLocally(List<ContactModel> contacts) async {
    for (var contact in contacts) {
      await cacheContactData.addContact(contact);
    }
  }

  @override
  Future<bool> editContact({
    required ContactModel updatedModel,
  }) async {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) {
        throw ServerException(message: "User is null");
      }

      firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(contactsCollection)
          .doc(updatedModel.contactId)
          .update(
            updatedModel.toJson(),
          );
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> deleteContact({
    required String contactId,
  }) async {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) {
        throw ServerException(message: "User is null");
      }

      firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(contactsCollection)
          .doc(contactId)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
