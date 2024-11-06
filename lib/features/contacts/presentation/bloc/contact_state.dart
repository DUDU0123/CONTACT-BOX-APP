part of 'contact_bloc.dart';

class ContactState extends Equatable {
  const ContactState({
    this.contactsList,
    this.countryCode = '+91',this.countryIsoCode = 'IN',
  });
  final Stream<List<ContactEntity>>? contactsList;
  final String? countryCode;
  final String? countryIsoCode;
  ContactState copyWith({
    String? countryCode,
    String? countryIsoCode,
    List<ContactEntity>? cachedContactList,
    Stream<List<ContactEntity>>? contactsList,
  }) {
    return ContactState(
      countryCode: countryCode ?? this.countryCode,
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      contactsList: contactsList??this.contactsList,
    );
  }

  @override
  List<Object> get props =>
      [contactsList ?? [], countryCode ?? ''];
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
