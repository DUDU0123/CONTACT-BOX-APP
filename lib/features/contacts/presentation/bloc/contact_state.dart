part of 'contact_bloc.dart';

class ContactState extends Equatable {
  const ContactState({
    this.contactsList,
    this.countryCode = '+91',this.countryIsoCode = 'IN',this.numberOnly
  });
  final Stream<List<ContactEntity>>? contactsList;
  final String? countryCode;
  final String? countryIsoCode;
  final String? numberOnly;
  ContactState copyWith({
    String? countryCode,
    String? countryIsoCode,
    List<ContactEntity>? cachedContactList,
    Stream<List<ContactEntity>>? contactsList,
    String? numberOnly,
  }) {
    return ContactState(
      countryCode: countryCode ?? this.countryCode,
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      contactsList: contactsList??this.contactsList,
      numberOnly: numberOnly??this.numberOnly,
    );
  }

  @override
  List<Object> get props =>
      [contactsList ?? [], countryCode ?? '', numberOnly??''];
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
