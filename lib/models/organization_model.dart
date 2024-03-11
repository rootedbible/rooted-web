// import 'package:rooted_web/const.dart';
// import 'package:rooted_web/models/subscription_model.dart';
// import 'package:rooted_web/utils/pretty_print.dart';
//
// class Organization {
//   // Unique Stuff
//   final int uniqueId;
//   final String username;
//   final String name;
//   final String? description;
//   final String? profileUrl;
//   final String? phone;
//   final String email;
//   final String? address;
//   final String? addressTwo;
//   final String? city;
//   final String? state;
//   final String? zip;
//   final String? website;
//   final String? facebook;
//   final String? instagram;
//   final String? tiktok;
//   final String? x;
//   final bool isPrivate;
//   final String? status;
//   final int numMembers;
//   final Subscription subscription;
//
//   Organization({
//     required this.email,
//     required this.username,
//     required this.facebook,
//     required this.uniqueId,
//     required this.state,
//     required this.name,
//     required this.address,
//     required this.addressTwo,
//     required this.city,
//     required this.description,
//     required this.profileUrl,
//     required this.zip,
//     required this.phone,
//     required this.instagram,
//     required this.tiktok,
//     required this.website,
//     required this.x,
//     required this.numMembers,
//     required this.status,
//     required this.isPrivate,
//     required this.subscription,
//   });
//
//   factory Organization.fromJson(Map<String, dynamic> json) {
//     prettyPrintMap(json);
//     return Organization(
//       email: json['email'],
//       isPrivate: json['invite_only'],
//       uniqueId: json['id'],
//       state: json['state'],
//       name: json['name'],
//       address: json['address'],
//       addressTwo: json['address_two'],
//       description: json['description'],
//       profileUrl:
//           json['profile_image_url'] ?? 'https://i.imgur.com/jNNT4LE.png',
//       zip: json['zip'],
//       phone: json['phone'],
//       instagram: json['instagram'],
//       tiktok: json['tiktok'],
//       website: json['website'],
//       x: json['x'],
//       city: json['city'],
//       numMembers: json['total_members'],
//       status: json['status'],
//       facebook: json['facebook'],
//       username: json['unique_name'],
//       subscription: Subscription.fromJson(json['subscription']),
//     );
//   }
//
//   static final empty = Organization(
//     subscription: Subscription(
//       id: 0,
//       expiration: '',
//       isActive: false,
//       userId: 0,
//       isCanceled: false,
//       type: individualType,
//     ),
//     username: 'msmary',
//     facebook: 'msmary',
//     uniqueId: 1,
//     state: 'MD',
//     name: 'Chapel of the Immaculate Conception',
//     address: '16300 Old Emmitsburg Rd',
//     addressTwo: null,
//     city: 'Emmitsburg',
//     description:
//         'This is an organization description and mission statement. I am now putting in some filler text',
//     profileUrl:
//         'https://rsmowery.com/wp-content/uploads/2017/03/mt-st-marys-3.jpg',
//     zip: '21727',
//     phone: '123-456-7890',
//     instagram: 'msmary',
//     tiktok: 'msmary',
//     website: 'https://msmary.edu',
//     x: 'msmary',
//     isPrivate: false,
//     email: 'test@email.com',
//     numMembers: 10,
//     status: 'admin',
//   );
//
//   Organization copyWith({
//     String? email,
//     String? username,
//     String? facebook,
//     int? uniqueId,
//     String? state,
//     String? name,
//     String? address,
//     String? addressTwo,
//     String? city,
//     String? description,
//     String? profileUrl,
//     String? zip,
//     String? phone,
//     String? instagram,
//     String? tiktok,
//     String? website,
//     String? x,
//     int? numMembers,
//     String? status,
//     bool? isPrivate,
//     Subscription? subscription,
//     String? uniqueName,
//   }) {
//     return Organization(
//       email: email ?? this.email,
//       username: username ?? this.username,
//       facebook: facebook ?? this.facebook,
//       uniqueId: uniqueId ?? this.uniqueId,
//       state: state ?? this.state,
//       name: name ?? this.name,
//       address: address ?? this.address,
//       addressTwo: addressTwo ?? this.addressTwo,
//       city: city ?? this.city,
//       description: description ?? this.description,
//       profileUrl: profileUrl ?? this.profileUrl,
//       zip: zip ?? this.zip,
//       phone: phone ?? this.phone,
//       instagram: instagram ?? this.instagram,
//       tiktok: tiktok ?? this.tiktok,
//       website: website ?? this.website,
//       x: x ?? this.x,
//       numMembers: numMembers ?? this.numMembers,
//       status: status ?? this.status,
//       isPrivate: isPrivate ?? this.isPrivate,
//       subscription: subscription ?? this.subscription,
//     );
//   }
// }
