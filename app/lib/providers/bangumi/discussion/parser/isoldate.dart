import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/providers/bangumi/discussion/parser/DiscussionParser.dart';
import 'package:munin/providers/bangumi/discussion/parser/ThreadParser.dart';

List<DiscussionItem> processDiscussion(ParseDiscussionMessage message) {
  return DiscussionParser(message.muteSetting)
      .processDiscussionItems(message.html);
}

class ParseDiscussionMessage {
  final String html;

  final MuteSetting muteSetting;

  const ParseDiscussionMessage(this.html, this.muteSetting);
}

BlogThread processBlogThread(ParseThreadMessage message) {
  return ThreadParser(
    mutedUsers: message.mutedUsers,
    captionTextColor: message.captionTextColor,
  ).processBlogThread(
    message.html,
    message.threadId,
  );
}

EpisodeThread processEpisodeThread(ParseThreadMessage message) {
  return ThreadParser(
    mutedUsers: message.mutedUsers,
    captionTextColor: message.captionTextColor,
  ).processEpisodeThread(
    message.html,
    message.threadId,
  );
}

SubjectTopicThread processSubjectTopicThread(ParseThreadMessage message) {
  return ThreadParser(
    mutedUsers: message.mutedUsers,
    captionTextColor: message.captionTextColor,
  ).processSubjectTopicThread(
    message.html,
    message.threadId,
  );
}

GroupThread processGroupThread(ParseThreadMessage message) {
  return ThreadParser(
    mutedUsers: message.mutedUsers,
    captionTextColor: message.captionTextColor,
  ).processGroupThread(
    message.html,
    message.threadId,
  );
}

class ParseThreadMessage {
  final String html;

  final int threadId;

  final BuiltMap<String, MutedUser> mutedUsers;

  final Color captionTextColor;

  const ParseThreadMessage(this.html, this.mutedUsers, this.threadId,
      this.captionTextColor);
}
