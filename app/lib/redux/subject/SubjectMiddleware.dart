import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/providers/bangumi/subject/BangumiSubjectService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createSubjectMiddleware(
    BangumiSubjectService bangumiSubjectService) {
  final getCollectionInfo = _createGetCollectionInfoEpic(bangumiSubjectService);
  final collectionUpdateRequest =
  _createCollectionUpdateRequestEpic(bangumiSubjectService);

  final getSubjectEpic = _createGetSubjectEpic(bangumiSubjectService);
  return [
    getSubjectEpic,
    getCollectionInfo,
    collectionUpdateRequest,
  ];
}

Stream<dynamic> _getSubject(BangumiSubjectService bangumiSubjectService,
    GetSubjectAction action) async* {
  try {
    yield GetSubjectLoadingAction(subjectId: action.subjectId);

    BangumiSubject subject =
    await bangumiSubjectService.getSubject(subjectId: action.subjectId);

    // If the api call is successful, dispatch the results for display
    yield GetSubjectSuccessAction(subject);
  } catch (error, stack) {
    // If the search call fails, dispatch an error so we can show it
    print(error.toString());
    print(stack);
    Scaffold.of(action.context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
    yield GetSubjectFailureAction.fromUnknownException(
        subjectId: action.subjectId);
  }
}

Epic<AppState> _createGetSubjectEpic(
    BangumiSubjectService bangumiSubjectService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
    // Narrow down to SearchAction actions
        .ofType(TypeToken<GetSubjectAction>())
    // Cancel the previous search and start a new one with switchMap
        .switchMap((action) => _getSubject(bangumiSubjectService, action));
  };
}

Stream<dynamic> _getCollectionInfo(BangumiSubjectService bangumiSubjectService,
    GetCollectionInfoAction action) async* {
  try {
    yield GetCollectionInfoLoadingAction(subjectId: action.subjectId);

    SubjectCollectionInfo subjectCollectionInfo =
    await bangumiSubjectService.getCollectionInfo(action.subjectId);

    yield GetCollectionInfoSuccessAction(
      subjectId: action.subjectId,
      collectionInfo: subjectCollectionInfo,
    );
  } catch (error, stack) {
    // If the search call fails, dispatch an error so we can show it
    print(error.toString());
    print(stack);
    Scaffold.of(action.context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
    yield GetCollectionInfoFailureAction.fromUnknownException(
        subjectId: action.subjectId);
  }
}

Epic<AppState> _createGetCollectionInfoEpic(
    BangumiSubjectService bangumiSubjectService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
    // Narrow down to SearchAction actions
        .ofType(TypeToken<GetCollectionInfoAction>())
    // Cancel the previous search and start a new one with switchMap
        .switchMap(
            (action) => _getCollectionInfo(bangumiSubjectService, action));
  };
}

Stream<dynamic> _collectionUpdateRequest(
    BangumiSubjectService bangumiSubjectService,
    UpdateCollectionRequestAction action) async* {
  try {
    yield UpdateCollectionRequestLoadingAction(subjectId: action.subjectId);

    await bangumiSubjectService.updateCollectionInfoRequest(
        action.subjectId, action.collectionUpdateRequest);
    yield UpdateCollectionRequestSuccessAction(subjectId: action.subjectId);

    ///TODO: Add a snackbar notification upon success
    Navigator.of(action.context).pop();
  } catch (error, stack) {
    // If the search call fails, dispatch an error so we can show it
    print(error.toString());
    print(stack);
    Scaffold.of(action.context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
    yield UpdateCollectionRequestFailureAction.fromUnknownException(
        subjectId: action.subjectId);
  }
}

Epic<AppState> _createCollectionUpdateRequestEpic(
    BangumiSubjectService bangumiSubjectService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
    // Narrow down to SearchAction actions
        .ofType(TypeToken<UpdateCollectionRequestAction>())
    // Cancel the previous search and start a new one with switchMap
        .switchMap((action) =>
        _collectionUpdateRequest(bangumiSubjectService, action));
  };
}
