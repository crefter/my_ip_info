import 'package:my_ip_info/core/exception/abstract_exception.dart';

class GeolocationDeniedException extends AbstractException {
  GeolocationDeniedException(super.message);
}
