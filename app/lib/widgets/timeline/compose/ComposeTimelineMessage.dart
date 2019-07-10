import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/form/SimpleFormSubmitWidget.dart';
import 'package:quiver/strings.dart';
import 'package:redux/redux.dart';

class ComposeTimelineMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ComposeTimelineMessageState();
  }
}

class _ComposeTimelineMessageState extends State<ComposeTimelineMessage> {
  final _formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();

  /// maintains current message validation status to avoid rebuilding the whole
  /// widget every time user types a message character
  /// see [_listenToMessageController]
  bool _isMessageFieldValid = true;

  /// This is the length limitation set by Bangumi and cannot be modified by us
  static const int maxMessageLength = 123;

  RequestStatus messageSubmissionStatus = RequestStatus.Initial;

  @override
  void initState() {
    super.initState();
    messageController.addListener(_listenToMessageController);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  bool messageHasError({@required String message}) {
    return message.length > maxMessageLength;
  }

  bool get _canSubmitForm {
    return isNotEmpty(messageController.text) &&
        !messageHasError(message: messageController.text);
  }

  /// listen to message controller, set [_isMessageFieldValid] if form is currently invalid
  /// triggers a rebuild only if message validation status has changed
  _listenToMessageController() {
    if (!_canSubmitForm) {
      /// TODO: investigate how to correctly(?) disable submit button
      if (!_isMessageFieldValid) {
        setState(() {
          _isMessageFieldValid = true;
        });
      }
    } else {
      if (_isMessageFieldValid) {
        setState(() {
          _isMessageFieldValid = false;
        });
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (isEmpty(messageController.text)) {
      return true;
    }

    return await showMuninYesNoDialog(context, title: '确认放弃编辑这条消息？') ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store store) => _ViewModel.fromStore(store),
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return ScaffoldWithRegularAppBar(
            appBar: AppBar(
              actions: <Widget>[
                SimpleFormSubmitWidget(
                  loadingStatus: messageSubmissionStatus,
                  canSubmit: _canSubmitForm,
                  onSubmitPressed: (BuildContext context) async {
                    try {
                      if (mounted) {
                        setState(() {
                          messageSubmissionStatus = RequestStatus.Loading;
                        });
                      }
                      await vm.createTimelineMessage(
                          context, messageController.text);
                    } catch (error) {
                      if (mounted) {
                        setState(() {
                          messageSubmissionStatus =
                              RequestStatus.UnknownException;
                        });
                      }
                    }
                  },
                )
              ],
            ),
            safeAreaChild: Form(
              key: _formKey,
              autovalidate: true,
              onWillPop: _onWillPop,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: messageController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: '有什么想说的？',
                      hintText: '最多$maxMessageLength字',
                    ),
                    validator: (value) {
                      if (messageHasError(message: value)) {
                        return '最多只能输入$maxMessageLength字,当前已输入${value.length}字';
                      }
                    },
                    maxLines: 3,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final Future<void> Function(BuildContext context, String message)
  createTimelineMessage;

  factory _ViewModel.fromStore(Store<AppState> store) {
    Future<void> _createTimelineMessage(BuildContext context, String message) {
      final action =
      CreateMainPublicMessageRequestAction(context: context, message: message);
      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(createTimelineMessage: _createTimelineMessage);
  }

  _ViewModel({
    @required this.createTimelineMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
