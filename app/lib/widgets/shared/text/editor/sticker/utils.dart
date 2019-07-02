/// Utils for calculating sticker attributes based on sticker id.

/// Gets sticker file extension.
/// The first 22 stickers(except 11) are png, others are gif.
String _idToStickerExtension(int id) {
  if (id <= 22 && id != 11) {
    return 'png';
  }

  return 'gif';
}

/// Bangumi names all stickers with id<10 as '01', '02'.. hence they need a
/// padding, otherwise returns its original number in string format.
String _idToBangumiName(int id) {
  return '${id.toString().padLeft(2, '0')}';
}

String idToFullFileName(int id) {
  return '${_idToBangumiName(id)}.${_idToStickerExtension(id)}';
}

/// Sticker code: (bgm01) ... (bgm23)
String idToBangumiStickerCode(int id) {
  return '(bgm${_idToBangumiName(id)})';
}
