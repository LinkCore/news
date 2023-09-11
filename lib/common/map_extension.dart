extension MapExtension on Map<String, dynamic> {
  T valueFrom<T>(String key, T placeholder) {
    if (keys.contains(key) && this[key] is T) {
      return this[key] as T;
    } else {
      return placeholder;
    }
  }
}
