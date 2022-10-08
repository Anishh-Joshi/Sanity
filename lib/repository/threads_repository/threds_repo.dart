import 'dart:convert';
import 'package:sanity/apis/apis.dart';
import 'package:http/http.dart' as http;

class ThreadsRepo {
  final APIs api = APIs();
  final client = http.Client();

  Future<Map> getUpVotes() async {
    final http.Response response =
        await client.get(Uri.parse(api.loginUrl), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final upVotes = json.decode(response.body);
    return upVotes;
  }

  Future<Map> getThreads() async {
    final http.Response response =
        await client.get(Uri.parse(api.fetchAllThreads), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final threads = json.decode(response.body);
    return threads;
  }

  Future<Map> upVote({required int threadId, required int userId}) async {
    final http.Response response = await client.post(Uri.parse(api.upVote),
        body: jsonEncode({"thread_upvote_fk": threadId, "by_user": userId}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final upVote = json.decode(response.body);
    return upVote;
  }

  Future<Map> downVote({required int threadId,required int userId}) async {
    final http.Response response =
        await client.delete(Uri.parse(api.downVote(id: threadId,userId:userId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final downVote = json.decode(response.body);
    return downVote;
  }

  Future<Map> addThread(
      {required int userId,
      required String title,
      required String content}) async {
    final http.Response response = await client.post(Uri.parse(api.addThread),
        body: jsonEncode({
          "added_by_user": userId,
          "title": title,
          "content": content,
          "docs_involved": 0
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final threadResponse = json.decode(response.body);
    return threadResponse;
  }

  Future<Map> addComment(
      {required int userId,
      required String comment,
      required int threadId}) async {
    final http.Response response = await client.post(Uri.parse(api.addComment),
        body: jsonEncode({
          "thread_comment_fk": threadId,
          "comment": comment,
          "by_user": userId,
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final threadResponse = json.decode(response.body);

    return threadResponse;
  }

  Future<Map> addReply(
      {required String reply,
      required int userId,
      required int threadId,
      required int commentId}) async {

    final http.Response response = await client.post(Uri.parse(api.addReply),
        body: jsonEncode({
          "thread_reply_fk": commentId,
          "reply": reply,
          "by_user": userId,
          "thread_id": threadId,
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final threadResponse = json.decode(response.body);
    return threadResponse;
  }

  Future<Map> deleteThread({required int threadId}) async {
    final http.Response response =
        await client.delete(Uri.parse(api.deleteThread(threadId: threadId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final deleteThread = json.decode(response.body);
    return deleteThread;
  }

  Future<Map> updateThread(
      {required int threadId, String? title, String? content}) async {
    final http.Response response = await client
        .put(Uri.parse(api.signInUrl), body: jsonEncode({}), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final updateThread = json.decode(response.body);
    return updateThread;
  }

  Future<Map> doctorInvolved({required int threadId}) async {
    final http.Response response = await client
        .put(Uri.parse(api.updateDocsInvolved(threadId: threadId)), body: jsonEncode({}), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final updateThread = json.decode(response.body);
    return updateThread;
  }

    Future<Map> deleteComment({required int commentId}) async {
    final http.Response response =
        await client.delete(Uri.parse(api.removeComment(commentId: commentId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final deleteThread = json.decode(response.body);
    return deleteThread;
  }
    Future<Map> deleteReply({required int replyId}) async {
    final http.Response response =
        await client.delete(Uri.parse(api.removeReply(replyId: replyId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final deleteThread = json.decode(response.body);
    return deleteThread;
  }


    Future<Map> getComments({required int threadId}) async {
    final http.Response response =
        await client.get(Uri.parse(api.getComment(threadId: threadId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final comments = json.decode(response.body);
    return comments;
  }

    Future<Map> getReplies({required int commentId}) async {
    final http.Response response =
        await client.get(Uri.parse(api.getReplies(commentId: commentId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final replies = json.decode(response.body);
    return replies;
  }
}
