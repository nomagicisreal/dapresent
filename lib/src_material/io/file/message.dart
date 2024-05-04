///
/// this file contains:
/// [ChatPage]
///
///
part of dapresent_io;

///
///
///
///
class ChatPage extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;
  final String userAvatar;

  const ChatPage({
    super.key,
    required this.peerNickname,
    required this.peerAvatar,
    required this.peerId,
    required this.userAvatar,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String currentUserId;

  List<String> listMessages = [];

  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId = '';

  File? imageFile;
  bool isLoading = false;
  bool stickerShowed = false;
  String imageUrl = '';

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode
        .addFocusChangedListener(() => setState(() => stickerShowed = false));
    scrollController.addListener(_scrollListener);

    groupChatId = currentUserId.compareTo(widget.peerId) > 0
        ? '$currentUserId - ${widget.peerId}'
        : '${widget.peerId} - $currentUserId';
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() => _limit += _limitIncrement);
    }
  }

  void _callPhoneNumber(String phoneNumber) {
    throw UnimplementedError();
  }

  void showSticker() {
    focusNode.unfocus();
    setState(() => stickerShowed = !stickerShowed);
  }

  Future<bool> onBackPressed() {
    if (stickerShowed) {
      setState(() => stickerShowed = false);
    } else {}
    return Future.value(false);
  }

  void onSendMessage(String content, MessageType type) {
    if (content.isNotEmpty) {
      textController.clear();
      scrollController.animateTo(
        0,
        duration: KCore.durationMilli300,
        curve: Curves.easeOut,
      );
    }
  }

  bool checkIfMessageReceived(int index) {
    throw UnimplementedError();
  }

  bool checkIfMessageSent(int index) {
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.peerNickname),
        actions: [
          IconButton(
            onPressed: () async => _callPhoneNumber(""),
            icon: WIconMaterial.phone,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: KEdgeInsets.symH_8,
          child: Column(children: [messageList, messageInput]),
        ),
      ),
    );
  }

  Widget get messageList => Flexible(
        child: groupChatId.isNotEmpty
            ? StreamBuilder<int>(
                stream: FStream.ofInts(),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data! % 5 == 0
                        ? ListView.builder(
                            padding: KEdgeInsets.all_10,
                            itemCount: snapshot.data!,
                            reverse: true,
                            controller: scrollController,
                            itemBuilder: (context, index) =>
                                messageListItemOf(index, snapshot.data!))
                        : const Center(child: Text('No messages...'))
                    : const Center(child: WProgressIndicator.circularBlueGrey),
              )
            : const Center(child: WIconMaterial.accountCircleStyle1),
      );

  Widget messageListItemOf(int index, int number) {
    if (number == 0) {
      final messages = ChatMessages(
        idFrom: 'idFrom',
        idTo: 'idTo',
        timestamp: 'timestamp',
        content: 'content',
        type: MessageType.text,
      );

      return number.isEven
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    messages.type == MessageType.text
                        ? ChatMessage(
                            chatContent: messages.content,
                            color: Colors.blue,
                            colorText: Colors.white,
                            margin: KEdgeInsets.onlyRight_10,
                          )
                        : messages.type == MessageType.image
                            ? Container(
                                margin: KEdgeInsets.onlyRightTop_10,
                                child: ChatImage(
                                  imageSrc: messages.content,
                                  onTap: FListener.none,
                                ),
                              )
                            : WSizedBox.shrink,
                    checkIfMessageSent(index)
                        ? Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: FDecorationBox.circle(),
                            child: Image.network(
                              widget.userAvatar,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              loadingBuilder: WImageLoadingBuilder.style1,
                              errorBuilder:
                                  WImageErrorWidgetBuilder.accountStyle2,
                            ),
                          )
                        : Container(width: 35),
                  ],
                ),
                checkIfMessageSent(index)
                    ? Container(
                        margin: KEdgeInsets.ltrb_50_6_0_8,
                        child: Text(
                          DateTimeExtension.parseTimestamp(
                              messages.timestamp),
                          style: KTextStyle.italicGrey_12,
                        ),
                      )
                    : WSizedBox.shrink,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    checkIfMessageReceived(index)
                        // left side (received message)
                        ? Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: FDecorationBox.rectangle(
                              borderRadius: KBorderRadius.allCircular_10 * 2,
                            ),
                            child: Image.network(
                              widget.peerAvatar,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              loadingBuilder: WImageLoadingBuilder.style3,
                              errorBuilder:
                                  WImageErrorWidgetBuilder.accountStyle2,
                            ),
                          )
                        : Container(width: 35),
                    messages.type == MessageType.text
                        ? ChatMessage(
                            color: Colors.blueGrey,
                            colorText: Colors.white,
                            chatContent: messages.content,
                            margin: KEdgeInsets.onlyLeft_10,
                          )
                        : messages.type == MessageType.image
                            ? Container(
                                margin: KEdgeInsets.onlyLeftTop_10 * 10,
                                child: ChatImage(
                                  imageSrc: messages.content,
                                  onTap: FListener.none,
                                ),
                              )
                            : WSizedBox.shrink,
                  ],
                ),
                checkIfMessageReceived(index)
                    ? Container(
                        margin: KEdgeInsets.ltrb_50_6_0_8,
                        child: Text(
                          DateTimeExtension.parseTimestamp(messages.timestamp),
                          style: KTextStyle.italicGrey_12,
                        ),
                      )
                    : WSizedBox.shrink,
              ],
            );
    } else {
      return WSizedBox.shrink;
    }
  }

  Widget get messageInput => SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Container(
              margin: KEdgeInsets.onlyRight_4,
              decoration: FDecorationBox.rectangle(
                borderRadius: KBorderRadius.allCircular_10,
                color: Colors.grey,
              ),
              child: const IconButton(
                onPressed: FListener.none,
                icon: WIconMaterial.photo_28,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: TextField(
                focusNode: focusNode,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: textController,
                decoration: FDecorationInput.style1(
                  enabledBorder: FBorderInput.outline(
                    borderRadius: KBorderRadius.allCircular_10,
                  ),
                ).copyWith(hintText: 'write...'),
              ),
            ),
            Container(
              margin: KEdgeInsets.onlyLeft_4,
              decoration: FDecorationBox.rectangle(
                borderRadius: KBorderRadius.allCircular_10 * 3,
                color: Colors.blueGrey,
              ),
              child: IconButton(
                onPressed: () => onSendMessage(
                  textController.text,
                  MessageType.text,
                ),
                icon: WIconMaterial.send,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
}
