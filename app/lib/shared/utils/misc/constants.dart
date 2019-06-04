import 'package:munin/config/application.dart';

const String bangumiAssetsServer = 'lain.bgm.tv';
final bangumiNonCdnHostUri = Uri.parse(
    'https://${Application.environmentValue.bangumiNonCdnHost}');

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

final String bangumiTextOnlyGroupIcon = 'https://lain.bgm.tv/pic/icon/m/no_icon.jpg';

const String checkWebVersionPrompt = '查看网页版';
const String appOrBangumiHasAnError = '应用或bangumi出错';
const String openInBrowser = '在浏览器中打开';


final double avatarSize = 48.0;