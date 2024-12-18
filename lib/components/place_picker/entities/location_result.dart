import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dropout/components/place_picker/entities/address_component.dart';

/// The result returned after completing location selection.
class LocationResult {
  /// The human readable name of the location. This is primarily the
  /// name of the road. But in cases where the place was selected from Nearby
  /// places list, we use the <b>name</b> provided on the list item.
  String? name; // or road

  /// The human readable locality of the location.
  String? locality;

  /// Latitude/Longitude of the selected location.
  LatLng? latLng;

  /// Formatted address suggested by Google
  String? formattedAddress;

  AddressComponent? country;

  AddressComponent? city;

  AddressComponent? administrativeAreaLevel1;

  AddressComponent? administrativeAreaLevel2;

  AddressComponent? subLocalityLevel1;

  AddressComponent? subLocalityLevel2;

  String? postalCode;

  String? placeId;

  LocationResult({
    this.name,
    this.locality,
    this.latLng,
    this.formattedAddress,
    this.country,
    this.city,
    this.administrativeAreaLevel1,
    this.administrativeAreaLevel2,
    this.subLocalityLevel1,
    this.subLocalityLevel2,
    this.postalCode,
    this.placeId,
  });
}
