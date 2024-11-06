part of 'contact_bloc.dart';

class ContactState extends Equatable {
  const ContactState({
    this.contactsList,
    this.cachedContactList,
    this.countryCode,
  });
  final Stream<List<ContactEntity>>? contactsList;
  final List<ContactEntity>? cachedContactList;
  final String? countryCode;
  ContactState copyWith({
    String? countryCode,
    List<ContactEntity>? cachedContactList,
    Stream<List<ContactEntity>>? contactsList,
  }) {
    return ContactState(
      countryCode: countryCode ?? this.countryCode,
      cachedContactList: cachedContactList??this.cachedContactList,
      contactsList: contactsList??this.contactsList,
    );
  }

  @override
  List<Object> get props =>
      [contactsList ?? [], cachedContactList ?? [], countryCode ?? ''];
}

final class ContactInitial extends ContactState {}

class ContactLoadingState extends ContactState {}

class ContactErrorState extends ContactState {
  final String message;
  const ContactErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [
        message,
      ];
}
