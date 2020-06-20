import 'package:html/parser.dart';
import 'package:munin/providers/bangumi/util/parser/Spoiler.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:test/test.dart';

void main() {
  group('addSpoilerAttribute', () {
    const sampleHtml = '''
    <span id="spoiler1" style="background-color:#555;color:#555;border:1px solid #555;">spoiler</span>
  <div class="inner">
    <strong><a href="/user/test" class="l">test</a></strong> <span class="tip_j">(test)</span>
    <div class="topic_content">
        <span id="notSpoiler1">spoiler</span><br>
         <span id="notSpoiler2" style="border:1px">spoiler</span><br>
        testtest<br>
        testtest<img src="/img/smiles/tv/01.gif" smileid="40" alt="(bgm24)"><br>
        <span id="spoiler2" style="background-color:#555;color:#555;border:1px solid #555;">spoiler</span>
</div>


  ''';

    test('adds spoiler tag to matched span', () {
      final document = addSpoilerAttribute(parseFragment(sampleHtml));

      expect(
          MuninCustomHtmlClasses.hasSpoilerClass(
              document.querySelector('#spoiler1')),
          isTrue);
      expect(
          MuninCustomHtmlClasses.hasSpoilerClass(
              document.querySelector('#spoiler2')),
          isTrue);
    });

    test('skips spoiler tag for non-matched span', () {
      final document = addSpoilerAttribute(parseFragment(sampleHtml));

      expect(
          MuninCustomHtmlClasses.hasSpoilerClass(
              document.querySelector('#notSpoiler1')),
          isFalse);

      expect(
          MuninCustomHtmlClasses.hasSpoilerClass(
              document.querySelector('#notSpoiler2')),
          isFalse);
    });
  });
}
