# Munin

Flutter + BangumiN == Munin (a new Bangumi App)


# Onboarding new contributor

1. Read [DART language tour](https://www.dartlang.org/guides/language/language-tour)
2. Read [Effective DART](https://www.dartlang.org/guides/language/effective-dart)
3. Go through all codelabs, cookbooks, and development sessions as listed on [Flutter dev docs](https://flutter.dev/docs)
4. Check [flutter_redux](https://pub.dartlang.org/packages/flutter_redux), study main concepts and all flutter examples, this is the state management library we are using

    For complex middleware requests, please use [rxdart](https://pub.dartlang.org/packages/rxdart), if you are new to Rx, please check [learnrxjs](https://www.learnrxjs.io/), it's for js but concepts are the same
5. To create a new json serializer or new sub state, please use [built_value](https://github.com/google/built_value.dart) and [json2builtvalue](https://charafau.github.io/json2builtvalue)

    
# Code styles
1. [Effective DART](https://www.dartlang.org/guides/language/effective-dart)
2. Don't mix package import with relative import as it's [required by one of our library](https://pub.dartlang.org/packages/get_it) 
3. Please fix all lint warnings/errors before submitting code
   - You may want to exclude `*.d.dart` file from formatting to avoid conflict between formatter and
   `*.d.dart` file generator
   

# Special terminology
 - Bangumi Subject: Not to be confused with `Subject` in `Rx`, here `Subject` refers to a work, like a 
    Music, Game...
 - Bangumi Collection: Not to be confused with `Collection` in Dart, here collection indicates a subject that 
   User has marked with some status. i.e. User watched a Movie, then user owns a(and only one) `Collection` of this movie
 - Bangumi Rakuen: Romaji for Japanese `楽園`， it's a place where user can see discussion updates 
  across the whole website
  See https://bgm.tv/m/
 - Bangumi Mono: Romaji for Japanese `物`. A mono can be a non-fictional person, or a fictional character.
