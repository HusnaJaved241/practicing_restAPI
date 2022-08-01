class NameModel {
  final String? name;
  final List<Country>? country;

  NameModel({
    this.name,
    this.country,
  });

  NameModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        country = (json['country'] as List?)
            ?.map((dynamic e) => Country.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'name': name, 'country': country?.map((e) => e.toJson()).toList()};
}

class Country {
  final String? countryId;
  final double? probability;

  Country({
    this.countryId,
    this.probability,
  });

  Country.fromJson(Map<String, dynamic> json)
      : countryId = json['country_id'] as String?,
        probability = json['probability'] as double?;

  Map<String, dynamic> toJson() =>
      {'country_id': countryId, 'probability': probability};
}
