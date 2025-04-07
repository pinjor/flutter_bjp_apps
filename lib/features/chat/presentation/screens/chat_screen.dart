import 'dart:convert';

import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/core/providers/providers.dart';
import 'package:bjp_app/core/ui/custom_loader.dart';
import 'package:bjp_app/features/auth/domain/login_response_model.dart';
import 'package:bjp_app/features/chat/presentation/controllers/chat_controller.dart'
    as ch;
import 'package:bjp_app/features/chat/presentation/domain/chat_model.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends ConsumerStatefulWidget {
  final userInfo;
  final name;

  const ChatPage({Key? key, required this.userInfo, required this.name})
    : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage>
    with WidgetsBindingObserver {
  // final _chatKey = GlobalKey<ChatState>();
  var _user ;
  var _user2 ;
  var chatController = ChatController(
    initialMessageList: [],
    scrollController: ScrollController(),
    currentUser: ChatUser(id: '1', name: 'Admin'),
    otherUsers: [
      ChatUser(
        id: '2',
        name: "Member",
      ),
    ],
  );
  late final FlutterSecureStorage _secureStorage;
  final TextEditingController _textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  bool isFileClicked = false;

  get bgColor => null;
  String? from = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        _asyncMethod();
        getAllMessage();
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    });
    ref
        .read(notificationServiceProvider)
        .showLocalNotification(
          id: 0,
          title: 'New Chat Message',
          body: 'You got a new message!',
          payload: 'chat', // still using this to navigate
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPaused();
        break;
      case AppLifecycleState.paused:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void onResumed() {
    try {
      if (!isFileClicked) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          setState(() {
            isFileClicked = false;
          });
          try {
            _asyncMethod();
            getAllMessage();
          } catch (err) {
            if (kDebugMode) {
              print(err);
            }
          }
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  void onPaused() {}

  void onInactive() {}

  void onDetached() {}

  @override
  Widget build(BuildContext context) {
    var messagesState = ref.watch(ch.chatControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        // globals.chatUserId = '-1';
        // globals.chatReceived = null;
        if (widget.name) {
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     dashboardRoute, (Route<dynamic> route) => false);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('চ্যাট'),
          leading: Visibility(
            visible: Navigator.canPop(context),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30), // custom icon
              onPressed: () {Navigator.of(context).pop();},
            ),
          ),
          automaticallyImplyLeading: false, // this is true by default
        ),
        backgroundColor: bgColor,
        body: messagesState.when(
          data: (data) {
             chatController = ChatController(
              initialMessageList: loadMessages(data),
              scrollController: ScrollController(),
              currentUser: ChatUser(id: _user.toString(), name: 'Admin'),
              otherUsers: [
                ChatUser(
                  id: widget.userInfo.toString(),
                  name: widget.name.toString(),
                ),
              ],
            );
            return ChatView(
              scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
                backgroundColor: Colors.black26,
                border: Border.all(
                  color:  Colors.grey,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  weight: 10,
                  size: 30,
                ),
              ),
              sendMessageConfig: SendMessageConfiguration(
                sendButtonIcon: Icon(Icons.send,color: Colors.black54,),
                enableCameraImagePicker: false,
                enableGalleryImagePicker: false,
                allowRecordingVoice: false,
                textFieldConfig: TextFieldConfiguration(
                  onMessageTyping: (status) {
                    debugPrint(status.toString());
                  },
                  compositionThresholdTime: const Duration(seconds: 1),
                  textStyle: TextStyle(color: Colors.black54),
                ),
              ),
              chatController: chatController,
              onSendTap: onSendTap,
              chatViewState:
                  ChatViewState
                      .hasMessages, // Add this state once data is available.
            );
          },
          error: (err, stack) {
            return Center(child: Text("Something went wrong!"));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }


  void onSendTap(
    String text,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    final message = Message(
      // id: '3',
      message: text,
      createdAt: DateTime.now(),
      sentBy: _user.toString(),
      replyMessage: replyMessage,
      messageType: messageType,
    );
    // setState(() {
      chatController.addMessage(message);
    // });
    sendMessage(text);
  }

  void sendMessage(String text) async {
    ref
        .read(ch.chatControllerProvider.notifier)
        .sendMessage(context, '${widget.userInfo}', text);
  }

  void getAllMessage() async {
    try {
      ref
          .read(ch.chatControllerProvider.notifier)
          .fetchChatMessages('${widget.userInfo}');
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }



  void _asyncMethod() async {
    _secureStorage = ref.watch(secureStorageProvider);
    var userJson = await _secureStorage.read(key: 'user');

    final user = User.fromJson(jsonDecode(userJson!));
    _user =user.id.toString();
    _user2 = widget.userInfo.toString();
    from = _user;

  }

  List<Message> loadMessages(List<ChatModel> x) {
    return x.map((chat) {
      return Message(
        sentBy: chat.from_user_id.toString() == from ? _user.toString() : _user2.toString(),
        createdAt: DateTime.parse(chat.createdAt!),
        id: chat.messageId.toString(),
        message: chat.message ?? '',
        messageType: MessageType.text
      );
    }).toList();
  }
}
