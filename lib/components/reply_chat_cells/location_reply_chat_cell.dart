import 'package:dropout/helper/imports/chat_imports.dart';
import 'package:dropout/helper/imports/common_import.dart';

class ReplyLocationChatTile extends StatelessWidget {
  final ChatMessageModel message;
  final Function(ChatMessageModel) replyMessageTapHandler;
  final Function(ChatMessageModel) messageTapHandler;

  const ReplyLocationChatTile(
      {Key? key,
        required this.message,
        required this.replyMessageTapHandler,
        required this.messageTapHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 70,
            color: message.isMineMessage
                ? AppColorConstants.disabledColor
                : AppColorConstants.themeColor.withOpacity(0.2),
            child: ReplyOriginalMessageTile(
                message: message.repliedOnMessage,
                replyMessageTapHandler: replyMessageTapHandler))
            .round(8),
        const SizedBox(
          height: 10,
        ),
        LocationChatTile(message: message).ripple(() {
          messageTapHandler(message);
        }),
      ],
    );
  }
}
