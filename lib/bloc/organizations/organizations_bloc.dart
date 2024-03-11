// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import '../../api/services/organizations_service.dart';
// import '../../models/organization_model.dart';
// import '../../models/user_model.dart';
//
// part 'organizations_event.dart';
//
// part 'organizations_state.dart';
//
// class OrganizationsBloc extends Bloc<OrganizationsEvent, OrganizationsState> {
//   List<User> requestUsers = [];
//   List<User> invitedUsers = [];
//
//   List<User> memberUsers = [];
//   List<Organization> organizations = [];
//
//   OrganizationsBloc() : super(OrganizationLoading()) {
//     on<GetOrgUsers>((event, emit) async {
//       try {
//         emit(OrganizationLoading());
//         requestUsers = (await OrganizationsService().getOrgUsers(
//           organizationId: event.uniqueId,
//           status: 'requested',
//         ))
//             .users;
//         invitedUsers = (await OrganizationsService().getOrgUsers(
//           organizationId: event.uniqueId,
//           status: 'invited',
//         ))
//             .users;
//         memberUsers = [];
//         memberUsers.addAll(
//           (await OrganizationsService()
//                   .getOrgUsers(organizationId: event.uniqueId, status: 'admin'))
//               .users,
//         );
//         memberUsers.addAll(
//           (await OrganizationsService().getOrgUsers(
//             organizationId: event.uniqueId,
//             status: 'moderator',
//           ))
//               .users,
//         );
//         memberUsers.addAll(
//           (await OrganizationsService().getOrgUsers(
//             organizationId: event.uniqueId,
//             status: 'member',
//           ))
//               .users,
//         );
//
//         emit(OrganizationLoaded());
//       } catch (e) {
//         debugPrint('Error on Get Org Users: $e ');
//         emit(OrganizationError(e.toString()));
//       }
//     });
//
//     on<GetMyOrganizations>((event, emit) async {
//       try {
//         emit(OrganizationLoading());
//         organizations =
//             (await OrganizationsService().getMyOrganizations()).organizations;
//         emit(OrganizationLoaded());
//       } catch (e) {
//         debugPrint('Error on Get My Organizations: $e ');
//         emit(OrganizationError(e.toString()));
//       }
//     });
//
//     on<RemoveUser>((event, emit) async {
//       memberUsers.removeAt(event.index);
//       emit(OrganizationLoaded());
//     });
//
//     on<ToggleRequest>((event, emit) async {
//       requestUsers.removeWhere((user) => user.uniqueId == event.user.uniqueId);
//       if (event.accepted) {
//         memberUsers.insert(0, event.user.copyWith(orgStatus: 'member'));
//       }
//       emit(OrganizationLoaded());
//     });
//   }
// }
