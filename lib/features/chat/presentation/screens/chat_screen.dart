import 'dart:convert';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'package:bjp_app/core/providers/providers.dart';

import 'package:bjp_app/features/auth/domain/login_response_model.dart';
import 'package:bjp_app/features/chat/presentation/controllers/chat_controller.dart'
as ch;
import 'package:bjp_app/features/chat/presentation/domain/chat_model.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  var _user;
  var _user2;
  late PusherChannelsFlutter pusher;
  late String channelName;

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
    _secureStorage = ref.read(secureStorageProvider);
    pusher = PusherChannelsFlutter.getInstance();
    // ref
    //     .read(notificationServiceProvider)
    //     .showLocalNotification(
    //   id: 0,
    //   title: 'New Chat Message',
    //   body: 'You got a new message!',
    //   payload: 'chat', // still using this to navigate
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _asyncMethod();
        await initPusher();
        getAllMessage();
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }

  Future<void> initPusher() async {
    try {
      // Initialize Pusher
      await pusher.init(
          onAuthorizer: (String channelName, String socketId, dynamic options) {
            // This should return the auth payload from your server
            return {
              'shared_secret': 'fc0dabced0b57e3f5d1c', // Only for presence channels
            };
          },
          apiKey: '94e4e879e002c03d0994',
          cluster: 'mt1',
          onEvent: (event) {
            if (event.eventName == 'MessageSent') {
              handleIncomingMessage(event.data);
            }
          },
          onError: (String message, int? code, dynamic e) {
            if (kDebugMode) {
              print("onError: $message code: $code exception: $e");
            }
          }
      );


      // Generate channel name based on chat ID
      channelName = 'chat.${_user=="1"? widget.userInfo:_user}';

      // Subscribe to channel
      await pusher.subscribe(channelName: channelName);

      // Connect to Pusher
      await pusher.connect();
      // // Bind to message event
      // await pusher.bind(eventName: 'MessageSent', (event) {
      //   handleIncomingMessage(event?.data);
      // });

      // Handle connection errors
      // pusher.onError(error:)
      // {
      //   if (kDebugMode) {
      //     print("Pusher connection error: $error");
      //   }
      // });

    } catch (e) {
    if (kDebugMode) {
    print("Pusher initialization error: $e");
    }
    }
  }

  void handleIncomingMessage(String? messageData) {
    if (messageData == null) return;

    try {
      final messageJson = jsonDecode(messageData);
      final message = Message(
        id: messageJson['id'].toString(),
        message: messageJson['message'],
        createdAt: DateTime.parse(messageJson['created_at']),
        sentBy: messageJson['from_user_id'].toString(),
        messageType: MessageType.text,
      );

      // Add message to chat controller
      if (message.sentBy != _user.toString()) {
        chatController.addMessage(message);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error processing incoming message: $e");
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textEditingController.dispose();
    focusNode.dispose();
    pusher.unsubscribe(channelName: channelName);
    pusher.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var messagesState = ref.watch(ch.chatControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        if (widget.name) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          //title: const Text('চ্যাট'),
          leading: Visibility(
            visible: Navigator.canPop(context),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          automaticallyImplyLeading: false,
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
                border: Border.all(color: Colors.grey),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  weight: 10,
                  size: 30,
                ),
              ),
              sendMessageConfig: SendMessageConfiguration(
                textFieldBackgroundColor: Color(0xFF00B1B0),
                sendButtonIcon: Icon(Icons.send, color: Colors.black54),
                enableCameraImagePicker: false,
                enableGalleryImagePicker: false,
                allowRecordingVoice: false,
                textFieldConfig: TextFieldConfiguration(
                  hintStyle: TextStyle(color: Colors.white),
                  onMessageTyping: (status) {
                    debugPrint(status.toString());
                  },
                  compositionThresholdTime: const Duration(seconds: 1),
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              chatController: chatController,
              onSendTap: onSendTap,
              chatViewState: ChatViewState.hasMessages,
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

  void onSendTap(String text, ReplyMessage replyMessage,
      MessageType messageType) {
    final message = Message(
      message: text,
      createdAt: DateTime.now(),
      sentBy: _user.toString(),
      replyMessage: replyMessage,
      messageType: messageType,
    );

    chatController.addMessage(message);
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

  Future<void> _asyncMethod() async {
    var userJson = await _secureStorage.read(key: 'user');
    final user = User.fromJson(jsonDecode(userJson!));
    _user = user.id.toString();
    _user2 = widget.userInfo.toString();
    from = _user;
  }

  List<Message> loadMessages(List<ChatModel> x) {
    return x.map((chat) {
      return Message(
          sentBy: chat.from_user_id.toString() == from
              ? _user.toString()
              : _user2.toString(),
          createdAt: DateTime.parse(chat.createdAt!),
          id: chat.messageId.toString(),
          message: chat.message ?? '',
          messageType: MessageType.text
      );
    }).toList();
  }
}