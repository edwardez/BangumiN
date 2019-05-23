import 'package:munin/config/application.dart';

const String bangumiAssetsServer = 'lain.bgm.tv';

final String bangumiHomePageUrl =
    'https://${Application.environmentValue.bangumiMainHost}';
final String bangumiTimelineUrl =
    'https://${Application.environmentValue.bangumiMainHost}/timeline';
final String rakuenMobileUrl =
    'https://${Application.environmentValue.bangumiMainHost}/m';
const String bangumiAnonymousUserMediumAvatar =
    'https://$bangumiAssetsServer/pic/user/m/icon.jpg';

final String bangumiTextOnlySubjectCover = 'https://${Application
    .environmentValue.bangumiMainHost}/img/no_icon_subject.png';


const String checkWebVersionPrompt = '查看网页版';
const String appOrBangumiHasAnError = '应用或bangumi出错';
