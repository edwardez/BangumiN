import 'package:munin/config/application.dart';

const String bangumiAssetsServer = 'lain.bgm.tv';

final String bangumiTimelineUrl =
    'https://${Application.environmentValue.bangumiMainHost}/timeline';
final String rakuenMobileUrl =
    'https://${Application.environmentValue.bangumiMainHost}/m';
const String bangumiAnonymousUserMediumAvatar =
    'https://$bangumiAssetsServer/pic/user/m/icon.jpg';

final String bangumiTextOnlySubjectCover = 'https://${Application
    .environmentValue.bangumiMainHost}/img/no_icon_subject.png';
