enum FeedLoadType {
  /// feeds are currently empty, it's the initial load
  Initial,

  /// trying to load an older feed
  Older,

  /// trying to load feed between a gap(i.e. feed1,feed2....feed12,feed13, wants to load feed3-feed11),
  /// currently not in use, supporting Gap loading is non-trivial and might require
  /// Bangumi's official API
  Gap,

  /// trying to load a newer feed
  Newer,
}
