/// Determines whether the status code is a canonical http status 2xx code
bool is2xxCode(int code) {
  return code != null && code >= 200 && code < 300;
}

/// Bangumi sometimes doesn't use regular http status code
/// Instead it always returns http status code 200, and in the json there is a
/// `code` field which contains the actual status code
/// if this `code` field is null, we assume it also means successful
bool isBangumi2xxCode(int code) {
  return code != null && code >= 200 && code < 300;
}
