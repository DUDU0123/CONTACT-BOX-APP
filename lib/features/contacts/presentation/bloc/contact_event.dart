part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class GetAllContactsEvent extends ContactEvent {}

class AddContactEvent extends ContactEvent {
  final ContactEntity newContact;
  const AddContactEvent({
    required this.newContact,
  });
  @override
  List<Object> get props => [
        newContact,
      ];
}

class EditContactEvent extends ContactEvent {
  final ContactEntity updatedContact;
  const EditContactEvent({
    required this.updatedContact,
  });
  @override
  List<Object> get props => [
        updatedContact,
      ];
}

class DeleteContactEvent extends ContactEvent {
  final String contactId;
  const DeleteContactEvent({
    required this.contactId,
  });
  @override
  List<Object> get props => [
        contactId,
      ];
}

class GetCacheContactEvent extends ContactEvent {}

class GetCountryCodeEvent extends ContactEvent {
  final String countryCode;
  final String countryIsoCode;
  final String numberOnly;
  const GetCountryCodeEvent({
    required this.countryCode,
    required this.countryIsoCode,required this.numberOnly,
  });
  @override
  List<Object> get props => [
        countryIsoCode,
        countryCode,numberOnly,
      ];
}

class SearchContactEvent extends ContactEvent {
  final String query;
  const SearchContactEvent({
  required  this.query,
  });
  @override
  List<Object> get props => [query];
}
