import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:munin/config/application.dart';
import 'package:munin/providers/bangumi/BangumiOauthService.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/analytics/Constants.dart';
import 'package:munin/shared/utils/http/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/privacy/PrivacySettingWidget.dart';
import 'package:munin/widgets/shared/button/MuninOutlineButton.dart';
import 'package:munin/widgets/shared/common/SingleChildExpandedRow.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:quiver/strings.dart';

const _iOSUserAgent =
    'Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac OS X) '
    'AppleWebKit/605.1.15 (KHTML, like Gecko)'
    'Version/12.1.1 Mobile/15E148 Safari/604.1 Munin';
const _defaultUserAgent = 'Mozilla/5.0 (Linux; Android 9; Pixel) '
    'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.101 '
    'Mobile Safari/537.36, Munin';

final _userAgent = Platform.isIOS ? _iOSUserAgent : _defaultUserAgent;

class MuninLoginPage extends StatefulWidget {
  const MuninLoginPage({Key key}) : super(key: key);

  @override
  _MuninLoginPageState createState() => _MuninLoginPageState();
}

class _MuninLoginPageState extends State<MuninLoginPage> {
  // Svg logo has 1/[screenSvgRatio] size of the shortest side of the screen.
  static const screenSvgRatio = 4;
  static const captchaLength = 5;
  static final String bangumiAuthWebUrl =
      'https://${Application.environmentValue.bangumiNonCdnHost}';
  static final bangumiAuthWebUri = Uri.parse(bangumiAuthWebUrl);

  // https://emailregex.com/
  // Note this is a loose validation comparing to bangumi's requirement
  // as bangumi's actual email validation is unknown.
  static final validEmailRegex = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]'
      r'\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|'
      r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static final validCaptchaRegex = RegExp(r'\w+');
  static final loginErrorPromptRegex = RegExp('验证码错误|(?:用户名|密码).*尝试|累计.*不能登录');

  Dio dio;
  CookieJar cookieJar;

  final BangumiOauthService _oauthService = getIt.get<BangumiOauthService>();
  final BangumiUserService _userService = getIt.get<BangumiUserService>();

  Uint8List captchaImageData;
  String xsrfToken;
  String errorText;
  var refreshCaptchaInProgress = false;
  var loginInProgress = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final captchaController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final captchaFocusNode = FocusNode();
  var _shouldObscurePassword = true;

  bool isEmailFieldPristine = true;
  bool isPasswordFieldPristine = true;
  bool isCaptchaFieldPristine = true;
  bool isFormValid = false;

  bool get formHasPristineFields =>
      isEmailFieldPristine || isPasswordFieldPristine || isCaptchaFieldPristine;

  void _createNewDio() {
    dio = Dio(BaseOptions(
      headers: {
        HttpHeaders.userAgentHeader: _userAgent,
      },
    ));
//    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    cookieJar = DefaultCookieJar();
    // Cookies are stored as singleton in static by [DefaultCookieJar].
    // Needs to clear them out.
    (cookieJar as DefaultCookieJar).deleteAll();

    dio.interceptors.addAll([
      CookieManager(cookieJar),
    ]);
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(_listenToEmailNodeFocusChanges);
    passwordFocusNode.addListener(_listenToPasswordNodeFocusChanges);
    captchaFocusNode.addListener(_listenToCaptchaNodeFocusChanges);
    captchaController.addListener(_listenToCaptchaFieldChanges);
    _createNewDio();
    _initLoginData();
    isEmailFieldPristine = isEmpty(emailController.text);
    isPasswordFieldPristine = isEmpty(passWordController.text);
    isCaptchaFieldPristine = isEmpty(captchaController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    passWordController.dispose();
    passwordFocusNode.dispose();
    captchaController.dispose();
    captchaFocusNode.dispose();
    super.dispose();
  }

  /// Listens to form fields and rebuilds.
  /// Maybe find a way to rebuild login button only?
  void _listenToFormFieldChanges() {
    if (!formHasPristineFields) {
      setState(() {});
    }
  }

  void _listenToCaptchaFieldChanges() {
    if (isCaptchaFieldPristine) {
      final inputLength = captchaController.text.length ?? 0;
      if (inputLength == captchaLength) {
        captchaFocusNode.unfocus();
      }
    } else {
      _listenToFormFieldChanges();
    }
  }

  /// Listens to email node focus, removes listener after loosing first
  /// focus.
  void _listenToEmailNodeFocusChanges() {
    if (!emailFocusNode.hasFocus) {
      emailFocusNode.removeListener(_listenToEmailNodeFocusChanges);
      emailController.addListener(_listenToFormFieldChanges);
      setState(() {
        isEmailFieldPristine = false;
      });
    }
  }

  /// Listens to password node focus, removes listener after loosing first
  /// focus.
  void _listenToPasswordNodeFocusChanges() {
    if (!passwordFocusNode.hasFocus) {
      passwordFocusNode.removeListener(_listenToPasswordNodeFocusChanges);
      passWordController.addListener(_listenToFormFieldChanges);
      setState(() {
        isPasswordFieldPristine = false;
      });
    }
  }

  /// Listens to captcha node focus, removes listener after loosing first
  /// focus.
  void _listenToCaptchaNodeFocusChanges() {
    if (!captchaFocusNode.hasFocus) {
      captchaFocusNode.removeListener(_listenToCaptchaNodeFocusChanges);
      setState(() {
        isCaptchaFieldPristine = false;
      });
    }
  }

  Future<void> showErrorDialog({
    @required String title,
    String actionLabel,
    Function retryCallback,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            actions: <Widget>[
              FlatButton(
                child: Text(actionLabel ?? retryCallback == null ? 'OK' : '重试'),
                onPressed: () {
                  Navigator.pop(context);
                  if (retryCallback != null) {
                    retryCallback();
                  }
                },
              ),
            ],
          );
        });
  }

  /// Initializes data that are necessary for login:
  /// xsrf token and captcha
  Future<void> _initLoginData() async {
    final response = await dio.get('$bangumiAuthWebUrl/login');

    xsrfToken = attributesValueOrNull(
        parseFragment(response.data).querySelector('input[name=formhash]'),
        'value');

    if (xsrfToken == null) {
      reportError(BangumiResponseIncomprehensibleException(
          'Failed to obtain xsrf token'));
      // It's actually not 'failed to get verification code'(instead, it's
      // xsrfToken). But roughly speaking xsrf token is also a verification
      // code, and this way it's much easier for user to understand.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(title: '获取验证码失败', retryCallback: _initLoginData);
      });
      return;
    } else {
      await _refreshCaptcha();
    }
  }

  Future<void> _refreshCaptcha() async {
    try {
      setState(() {
        refreshCaptchaInProgress = true;
      });
      final captchaResponse = await dio.get(
        '$bangumiAuthWebUrl/signup/captcha',
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      setState(() {
        captchaImageData = Uint8List.fromList(captchaResponse.data);
        refreshCaptchaInProgress = false;
      });
    } catch (error, stack) {
      reportError(
        error,
        stack: stack,
      );
      await showErrorDialog(
        title: '获取验证码失败',
        retryCallback: _refreshCaptcha,
      );
    }
  }

  _resetDioAndRefreshCaptcha({
    popContext = false,
  }) async {
    if (popContext) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
    setState(() {
      captchaController.text = '';
      xsrfToken = null;
      captchaImageData = null;
    });
    _createNewDio();
    await _initLoginData();
  }


  _submitLoginFormAndReportError() async {
    try {
      await _submitLoginForm();
    } catch (error, stack) {
      _resetDioAndRefreshCaptcha(popContext: true);
      errorText ??= '未知错误';
      reportError(error, stack: stack);
      FirebaseAnalytics()
          .logEvent(name: LoginErrorEvent.name);
      showErrorDialog(title: errorText);
    }
  }

  /// Submits login form to bangumi. There are mainly three steps
  /// 1. Submits email/password to bangumi, gets auth cookie.
  /// 2. Visits oauth page to get xsrf token
  /// 3. Gets user profile.
  _submitLoginForm() async {
    final loginStopWatch = Stopwatch()
      ..start();
    Map<String, int> loginMetrics = {};
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Center(child: Text('登录中')),
            content: AdaptiveProgressIndicator(),
          );
        });

    // clear previous error.
    setState(() {
      errorText = null;
    });

    /// 1. Submits email/password to bangumi, gets auth cookie.
    String sessionCookie;
    String expiresOnInSecondsStr;
    String authCookie;
    try {
      /// Tries to invalidate previous cookie if user has logged in

      Map<String, String> body = {
        'formhash': xsrfToken,
        'referer': '',
        'dreferer': '',
        'email': emailController.text,
        'password': passWordController.text,
        'captcha_challenge_field': captchaController.text,
        'loginsubmit': '登录',
      };

      final loginResponse = await dio.post<String>(
        '$bangumiAuthWebUrl/FollowTheRabbit',
        data: body,
        options: Options(
          contentType: ExtraContentType.xWwwFormUrlencoded,
        ),
      );

      final bangumiCookies = cookieJar.loadForRequest(bangumiAuthWebUri);
      for (var cookie in bangumiCookies) {
        switch (cookie.name) {
          case 'chii_auth':
            authCookie = cookie.value;
            break;
          case 'chii_sid':
            sessionCookie = cookie.value;
            break;
          case 'chii_cookietime':
            expiresOnInSecondsStr = cookie.value;
            break;
          default:
            continue;
        }
      }

      /// These cookies must be present, otherwise authentication have
      /// failed.
      if (authCookie == null ||
          sessionCookie == null ||
          expiresOnInSecondsStr == null) {
        final errorMatch =
        loginErrorPromptRegex.firstMatch(loginResponse.data);

        if (errorMatch == null) {
          // Try to find unknown error message element.
          // Use a strict element selector to reduce the chance that a wrong
          // element is selected.
          final errorMessageOrNull = parseFragment(loginResponse.data)
              .querySelector('#colunmNotice .text')
              ?.text;

          if (errorMessageOrNull == null) {
            errorText = '未知错误: 无法从Bangumi获取认证信息。';
          } else {
            errorText = '未知错误: 可能是因为:\n${errorMessageOrNull.trim()}';
          }
        } else {
          errorText = errorMatch.group(0);
        }

        throw BangumiResponseIncomprehensibleException('''
      Authentication cookies are missing.
      authCookie exists: ${authCookie != null},
      sessionCookie exists:  ${sessionCookie != null},
      expiresOnInSecondsStr exists: ${expiresOnInSecondsStr != null},
      ''');
      }
    } catch (error) {
      errorText ??= '未知错误: 无法从Bangumi获取认证信息。';
      rethrow;
    }
    loginMetrics[LoginElapsedTimeEvent.afterPostLoginCredentials] =
        loginStopWatch.elapsed.inMilliseconds;

    /// 2. Gets auth cookie, visit oauth page to get xsrf token
    final String host = Application.environmentValue.bangumiNonCdnHost;
    final String clientId =
        Application.environmentValue.bangumiOauthClientIdentifier;
    final authorizationUrl =
        'https://$host/oauth/authorize?response_type=code&client_id=$clientId';

    Response oauthResponse;
    try {
      final authorizationPage = (await dio.get(authorizationUrl)).data;
      final oauthXsrf = attributesValueOrNull(
          parseFragment(authorizationPage)
              .querySelector('input[name=formhash]'),
          'value');
      if (oauthXsrf == null) {
        throw BangumiResponseIncomprehensibleException(
            'Oauth xsrf token is null.');
      }
      final oauthBody = {
        'formhash': oauthXsrf,
        'redirect_uri': Application.environmentValue.bangumiRedirectUrl,
        'client_id':
        Application.environmentValue.bangumiOauthClientIdentifier,
        'submit': '授权',
      };
      oauthResponse = await dio.post(
        authorizationUrl,
        data: oauthBody,
        options: Options(
            contentType: ExtraContentType.xWwwFormUrlencoded,
            headers: {
              HttpHeaders.refererHeader: authorizationUrl,
            },
            // Oauth returns a 307 redirect which results in a 302 redirect.
            // Hence status < 400 is valid here, and no need to follow redirect.
            followRedirects: false,
            validateStatus: (statusCode) => statusCode < 400),
      );
      final code =
      Uri
          .parse(oauthResponse.headers.value(HttpHeaders.locationHeader))
          .queryParameters['code'];
      if (code == null) {
        throw BangumiResponseIncomprehensibleException(
            'Oauth code is invalid.');
      }

      await _oauthService.processAuthentication(
        oauthCode: code,
        sessionCookie: sessionCookie,
        expiresOnInSecondsStr: expiresOnInSecondsStr,
        authCookie: authCookie,
        userAgent: _userAgent,
      );
    } catch (error) {
      errorText = '登录出错: 无法从Bangumi获得授权信息';
      rethrow;
    }

    loginMetrics[LoginElapsedTimeEvent.afterPostOauthCredentials] =
        loginStopWatch.elapsed.inMilliseconds;

    /// 3. Gets user profile.
    try {
      final userId = await _oauthService.verifyUser();
      final userInfo = await _userService.getUserBasicInfo(userId.toString());
      findStore(context).dispatch(
          UpdateLoginDataAction(context: context, userInfo: userInfo));
    } catch (error) {
      errorText = '登录出错: 无法验证授权用户身份';
      rethrow;
    }

    loginStopWatch.stop();
    loginMetrics[LoginElapsedTimeEvent.afterGetUserProfile] =
        loginStopWatch.elapsed.inMilliseconds;
    loginMetrics[LoginElapsedTimeEvent.totalMilliSeconds] =
    loginMetrics[LoginElapsedTimeEvent.afterGetUserProfile];
    FirebaseAnalytics()
        .logEvent(name: LoginElapsedTimeEvent.name, parameters: loginMetrics);
  }

  _buildTosAndPrivacy(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.body1,
        children: <TextSpan>[
          TextSpan(text: '点击登录即代表您同意BangumiN的'),
          ...tosAndPrivacyLinks(context),
        ],
      ),
    );
  }

  Widget _buildCaptcha() {
    final captchaImageOrPlaceholder = GestureDetector(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          if (captchaImageData != null)
            Opacity(
              opacity: refreshCaptchaInProgress ? 0.1 : 1,
              child: Image.memory(
                captchaImageData,
                semanticLabel: '验证码',
              ),
            ),
          if (captchaImageData == null || refreshCaptchaInProgress)
            AdaptiveProgressIndicator(),
        ],
      ),
      onTap: refreshCaptchaInProgress ? null : _refreshCaptcha,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: mediumOffset),
      child: Row(
        crossAxisAlignment: captchaImageData == null
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: captchaController,
              focusNode: captchaFocusNode,
              autocorrect: false,
              autovalidate: !isCaptchaFieldPristine,
              decoration: InputDecoration(
                labelText: '验证码',
                hintText: '$captchaLength位字母',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(captchaLength),
                WhitelistingTextInputFormatter(validCaptchaRegex),
              ],
              validator: (input) {
                final inputLength = input?.length ?? 0;
                if (inputLength == captchaLength) {
                  return null;
                }
                return '验证码为$captchaLength位';
              },
            ),
            flex: 3,
          ),
          ExcludeSemantics(
            child: Padding(
              padding: EdgeInsets.only(left: baseOffset),
              child: Container(),
            ),
          ),
          Expanded(
            child: captchaImageOrPlaceholder,
            flex: 3,
          )
        ],
      ),
    );
  }

  Widget _buildPassword() {
    const passwordLength = 6;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: mediumOffset),
      child: TextFormField(
        controller: passWordController,
        focusNode: passwordFocusNode,
        autocorrect: false,
        autovalidate: !isPasswordFieldPristine,
        obscureText: _shouldObscurePassword,
        decoration: InputDecoration(
          labelText: '密码',
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _shouldObscurePassword = !_shouldObscurePassword;
              });
            },
            child: Icon(
              _shouldObscurePassword
                  ? OMIcons.visibilityOff
                  : OMIcons.visibility,
              semanticLabel: _shouldObscurePassword ? '显示密码' : '隐藏密码',
            ),
          ),
        ),
        validator: (input) {
          final inputLength = input?.length ?? 0;
          if (inputLength >= passwordLength) {
            return null;
          }
          return '密码至少$passwordLength位,已输入$inputLength位';
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: baseOffset4x, bottom: mediumOffset),
      child: TextFormField(
        controller: emailController,
        focusNode: emailFocusNode,
        autocorrect: false,
        autovalidate: !isEmailFieldPristine,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: '邮箱',
          hintText: '输入Bangumi邮箱',
          border: OutlineInputBorder(),
        ),
        validator: (input) {
          if (input != null && validEmailRegex.hasMatch(input)) {
            return null;
          }

          String containsSpacePrompt = '';
          if (input.contains(' ')) {
            containsSpacePrompt = '(含有空格？)';
          }
          return '邮箱格式无效$containsSpacePrompt';
        },
      ),
    );
  }

  Widget _buildLoginPage(BuildContext context) {
    final svgSize = MediaQuery.of(context).size.shortestSide / screenSvgRatio;
    final Widget bangumiNLogo = SvgPicture.asset(
      'assets/logo/munin_logo_rounded.svg',
      semanticsLabel: 'BangumiN Logo',
      width: svgSize,
      height: svgSize,
    );

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(baseOffset * 6),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: bangumiNLogo,
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: Column(children: <Widget>[
                    _buildEmail(),
                    _buildPassword(),
                    _buildCaptcha(),
                    if (errorText != null)
                      Text(
                        errorText,
                        style: body1ErrorText(context),
                      ),
                    SingleChildExpandedRow(
                      child: MuninOutlineButton(
                        onPressed: (!formHasPristineFields &&
                            _formKey.currentState.validate())
                            ? _submitLoginFormAndReportError
                            : null,
                        child: Text(
                          '登录到Bangumi',
                        ),
                      ),
                    ),
                    _buildTosAndPrivacy(context),
                  ]),
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoginPage(context);
  }
}
