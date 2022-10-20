enum SharedPreferencesEnum {
  /// Name of the preference key used by SharedPreferences to display the
  /// on boarding screens
  seenOnboard('seenOnboard'),

  // User auth key preferences
  userId('userId'),
  userType('userType'),
  accessToken('accessToken'),
  keyNotFound('No se encontró la llave de preferencia');

  const SharedPreferencesEnum(this.value);

  final String value;
}
