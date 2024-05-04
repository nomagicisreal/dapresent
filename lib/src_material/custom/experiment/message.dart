///
/// this file contains:
/// [MessageType]
/// [ChatUser]
/// [ChatMessages]
/// [ChatMessage]
/// [ChatImage]
///
///
part of dapresent_custom;

enum MessageType { text, image, sticker }

///
///
///
class ChatUser {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;

  const ChatUser(
      {required this.id,
        required this.photoUrl,
        required this.displayName,
        required this.phoneNumber,
        required this.aboutMe});
}

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  MessageType type;

  ChatMessages({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });
}

class ChatImage extends StatelessWidget {
  const ChatImage({
    super.key,
    required this.imageSrc,
    required this.onTap,
  });

  final String imageSrc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      child: Image.network(
        imageSrc,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        loadingBuilder: WImageLoadingBuilder.style4,
        errorBuilder: WImageErrorWidgetBuilder.errorStyle1,
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    this.margin,
    this.color,
    this.colorText,
    required this.chatContent,
  });

  final String chatContent;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: KEdgeInsets.all_10,
      margin: margin,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: KBorderRadius.allCircular_10,
      ),
      child: Text(
        chatContent,
        style: TextStyle(fontSize: 16, color: colorText),
      ),
    );
  }
}
