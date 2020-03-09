

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }

  /// si el tryParse no puede convertir el valor a un numero
  /// devuelve un null
  final n = num.tryParse(s);

  /// preguntamos si es null devolvemos false sino
  /// devolvemos true
  return ( n == null ) ? false : true;
}

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
