
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'organizations_event.dart';

part 'organizations_state.dart';

class OrganizationsBloc extends Bloc<OrganizationsEvent, OrganizationsState> {
  OrganizationsBloc() : super(OrganizationsInitial()) {
    on<OrganizationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
