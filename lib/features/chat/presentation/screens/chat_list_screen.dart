import 'dart:convert';
import 'package:bjp_app/core/utils/utils.dart';
import 'package:bjp_app/features/chat/presentation/domain/chat_list_model.dart';
import 'package:intl/intl.dart';
import 'package:bjp_app/core/providers/providers.dart';
import 'package:bjp_app/features/auth/domain/login_response_model.dart' as cm;
import 'package:bjp_app/features/chat/presentation/controllers/chat_list_controller.dart'
as ch;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'chat_screen.dart';

class ChatListScreen extends ConsumerStatefulWidget {

  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen>
    with WidgetsBindingObserver {
  late final FlutterSecureStorage _secureStorage;
  String? from = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _secureStorage = ref.read(secureStorageProvider);
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
        fetchChatList();
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var chatListState = ref.watch(ch.chatControllerProvider);
    return WillPopScope(
      onWillPop: () async {
          return true;

      },
      child: Scaffold(
        body:
        // List of Results
        chatListState.when(
          data: (chatList) {
            lgr.i('member length: ${chatList.length}');
            return chatList.isEmpty
                ? Center(
              child: Text(
                "কোন চ্যাট পাওয়া যায়নি",
                style: TextStyle(fontSize: 16),
              ),
            )
                : buildRecentChatList(sortChatsByLastMessage(chatList),currentUserId:  from!);
          },
          error: (err, st) {
            return Center(
              child: Text(
                "তথ্য পাওয়া যায়নি",
                style: TextStyle(fontSize: 16),
              ),
            );
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }




  void fetchChatList() async {
    try {
      ref
          .read(ch.chatControllerProvider.notifier)
          .fetchChatList();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> _asyncMethod() async {
    var userJson = await _secureStorage.read(key: 'user');
    final user = cm.User.fromJson(jsonDecode(userJson!));
    from = user.id.toString();
  }

  Widget buildRecentChatList(List<ChatList> chats, {required String currentUserId}) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        final lastMessage = chat.lastMessage;
        if (lastMessage == null) return SizedBox.shrink();

        // Determine the other user
        final isCurrentUserSender = lastMessage.fromUserId.toString() == currentUserId;
        final otherUser = isCurrentUserSender && chat.receiverUser.id.toString()!=currentUserId ? chat.receiverUser : chat.fromUser;

        // Format message text
        final messageText = lastMessage.fromUserId.toString() == currentUserId
            ? "Me: ${lastMessage.message}"
            : lastMessage.message;

        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(otherUser.name),
          subtitle: Text(
            messageText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(_formatTime(lastMessage.createdAt)),
          onTap: () async {
            // Navigate to chat screen
          await  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userInfo: otherUser.id.toString(),
                  name: otherUser.name,
                ),
              ),
            );
          fetchChatList();
          },
        );
      },
    );
  }

  String _formatTime(String isoTime) {
    final dateTime = DateTime.parse(isoTime).toLocal();
    final now = DateTime.now();

    final isToday = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    if (isToday) {
      return DateFormat('h:mm a').format(dateTime); // e.g., 3:45 PM
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime); // e.g., Apr 14, 2025
    }
  }

  List<ChatList> sortChatsByLastMessage(List<ChatList> chatList) {
    chatList.sort((a, b) {
      final aTime = a.lastMessage != null
          ? DateTime.parse(a.lastMessage!.createdAt)
          : DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.lastMessage != null
          ? DateTime.parse(b.lastMessage!.createdAt)
          : DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime); // Descending
    });
    return chatList;
  }
}