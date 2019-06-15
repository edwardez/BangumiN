import 'dart:collection';

import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/html/SubjectEpisodes.dart';
import 'package:munin/providers/bangumi/progress/parser/ProgressParser.dart';

LinkedHashMap<int, LinkedHashMap<int, EpisodeProgress>> processProgressPreview(
    String rawHtml) {
  return ProgressParser().processProgressPreview(rawHtml);
}

SubjectEpisodes processSubjectEpisodes(ParseSubjectEpisodesMessage message) {
  return ProgressParser()
      .processSubjectEpisodes(message.html, message.touchedEpisodes);
}

class ParseSubjectEpisodesMessage {
  final String html;

  final Map<int, EpisodeStatus> touchedEpisodes;

  const ParseSubjectEpisodesMessage(this.html, this.touchedEpisodes);
}
