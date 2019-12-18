import 'package:flutter/material.dart';
import 'package:mt/models/post.dart';
import 'package:mt/screen/qna_detail_screen.dart';
import 'package:provider/provider.dart';

import '../provider/posts.dart';
import '../models/post.dart';
import '../screen/post_detail_screen.dart';
import '../provider/qna_provider.dart';
import '../models/qna.dart';
import '../widgets/add_qna.dart';

class QnaScreen extends StatefulWidget {
  static final route = '/qna-screen';

  @override
  _QnaScreenState createState() => _QnaScreenState();
}

class _QnaScreenState extends State<QnaScreen> {
  List<QnAInfo> allQnAList;

  @override
  void initState() {
    super.initState();
    allQnAList = Provider.of<QnA>(context, listen: false).getAllQnAList;
    print('Got All qna list this is it :--  $allQnAList ');
  }

  @override
  Widget build(BuildContext context) {
    print('In Qna Screen');
    // print(allQnAList[0].toString());

    Future<void> refreshPage() {
     // return Provider.of<QnA>(context).getAllQnAList;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Q&A')),
      body: RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: PostTile(allQnAList[index]),
            );
          },
          itemCount: allQnAList == null ? 0 : allQnAList.length,
        ),
        onRefresh: refreshPage,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddQna.route);
        },
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  final QnAInfo singleQnAObject;

  PostTile(this.singleQnAObject);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    final userImgUrl =
        'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';

    //Move IntO assets

    final userImg = Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: h * 0.04,
        backgroundImage: NetworkImage(
          userImgUrl,
        ),
      ),
    );

    // final String topic1 = singleQnAObject.tags;
    // final String topic2 = singleQnAObject.tags;

    /*
    Chip Widget Is HERE .... Format Of CHIP Widget For TOPIC
    // */
    // final chip1 = Chip(
    //   avatar: CircleAvatar(
    //     child: Text(
    //       topic1.substring(0, 1),
    //       style: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
    //     ),
    //     backgroundColor: Colors.white,
    //   ),
    //   backgroundColor: Colors.grey.shade300,
    //   label: Text(
    //     topic1,
    //     style: TextStyle(
    //         fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10),
    //   ),
    // );
    // final chip2 = Chip(
    //   avatar: CircleAvatar(
    //     child: Text(
    //       topic2.substring(0, 1),
    //       style: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
    //     ),
    //     backgroundColor: Colors.white,
    //   ),
    //   backgroundColor: Colors.grey.shade300,
    //   label: Text(
    //     topic2,
    //     style: TextStyle(
    //         fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10),
    //   ),
    // );

    // final topics = [
    //   Padding(
    //     padding: const EdgeInsets.only(right: 4.0),
    //     child: chip1,
    //   ),
    //   Padding(
    //     padding: const EdgeInsets.only(right: 4.0),
    //     child: chip2,
    //   ),
    // ];

    final bookmarkedPost = ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          QNADetailScreen.route,
          arguments: singleQnAObject,
        );
        print('someone pressed qna tile');
        // Navigator.of(context).pushNamed(PostDetailScreen.tag);
      },
      //leading: userImg,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          userImg,
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text(
                singleQnAObject.question['questionContent'],
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (singleQnAObject != null && singleQnAObject.answers[0] == null)
              ? Text('No answer added yet!!')
              : Text(
                  singleQnAObject.answers[0]['answerContent'],
                  maxLines: 2,
                ),
          //Row(children: chipsinRow),//For topics
          // Wrap(
          //   children: topics,
          // )
          //Text('Topic1, Topic2')
        ],
      ),
    );

    return bookmarkedPost;
  }
}
