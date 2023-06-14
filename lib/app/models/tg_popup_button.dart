class TGPopupButton {
  String id;
  TGPopupButtonType? type;
  String? text;
  TGPopupButton({
    required this.id,
    this.type,
    this.text,
  });
}

enum TGPopupButtonType { cancel, ok, close, destructive }
