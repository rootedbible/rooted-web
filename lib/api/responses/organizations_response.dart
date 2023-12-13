
import '../../models/organization_model.dart';
import '../../utils/pretty_print.dart';

class OrganizationsResponse {
  final List<Organization> organizations;

  OrganizationsResponse({
    required this.organizations,
  });

  factory OrganizationsResponse.fromJson(List<dynamic> json) {
    List<Organization> organizations = [];
    for (Map<String, dynamic> organization in json) {
      organizations.add(Organization.fromJson(organization));
      prettyPrintMap(organization);

    }
    return OrganizationsResponse(
      organizations: organizations,
    );
  }
}
