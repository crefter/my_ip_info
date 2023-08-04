class UserInformation {
  UserInformation({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.currency,
    required this.isp,
    required this.org,
    required this.as,
    required this.asName,
    required this.proxy,
    required this.query,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      status: json['status'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionName: json['regionName'],
      city: json['city'],
      zip: json['zip'],
      lat: json['lat'],
      lon: json['lon'],
      currency: json['currency'],
      isp: json['isp'],
      org: json['org'],
      as: json['as'],
      asName: json['asname'],
      proxy: json['proxy'],
      query: json['query'],
    );
  }

  final String status;
  final String country;
  final String countryCode;
  final String region;
  final String regionName;
  final String city;
  final String zip;
  final double lat;
  final double lon;
  final String currency;
  final String isp;
  final String org;
  final String as;
  final String asName;
  final bool proxy;
  final String query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['country'] = country;
    map['countryCode'] = countryCode;
    map['region'] = region;
    map['regionName'] = regionName;
    map['city'] = city;
    map['zip'] = zip;
    map['lat'] = lat;
    map['lon'] = lon;
    map['currency'] = currency;
    map['isp'] = isp;
    map['org'] = org;
    map['as'] = as;
    map['asname'] = asName;
    map['proxy'] = proxy;
    map['query'] = query;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformation &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          country == other.country &&
          countryCode == other.countryCode &&
          region == other.region &&
          regionName == other.regionName &&
          city == other.city &&
          zip == other.zip &&
          lat == other.lat &&
          lon == other.lon &&
          currency == other.currency &&
          isp == other.isp &&
          org == other.org &&
          as == other.as &&
          asName == other.asName &&
          proxy == other.proxy &&
          query == other.query;

  @override
  int get hashCode =>
      status.hashCode ^
      country.hashCode ^
      countryCode.hashCode ^
      region.hashCode ^
      regionName.hashCode ^
      city.hashCode ^
      zip.hashCode ^
      lat.hashCode ^
      lon.hashCode ^
      currency.hashCode ^
      isp.hashCode ^
      org.hashCode ^
      as.hashCode ^
      asName.hashCode ^
      proxy.hashCode ^
      query.hashCode;
}
