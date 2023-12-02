part of 'organizations_bloc.dart';

@immutable
abstract class OrganizationsState {}

class OrganizationLoading extends OrganizationsState {}

class OrganizationLoaded extends OrganizationsState {}

class OrganizationError extends OrganizationsState {
  final String error;

  OrganizationError(this.error);
}
