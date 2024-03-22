import 'package:flutter/material.dart';

class Comment {
  final String avatar;
  final String userName;
  final String date;
  final String comment;
  final int rating;

  Comment({
    required this.avatar,
    required this.userName,
    required this.date,
    required this.comment,
    required this.rating,
  });
}

class CommentList extends StatefulWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final List<Comment> comments = [
    Comment(
      avatar: "images/logo1.png",
      userName: "User 1",
      date: "22-8-2023",
      comment: "Comment 1",
      rating: 4,
    ),
    Comment(
      avatar: "images/logo1.png",
      userName: "User 2",
      date: "23-8-2023",
      comment: "Comment 2",
      rating: 5,
    ),
    Comment(
      avatar: "images/logo1.png",
      userName: "User 1",
      date: "22-8-2023",
      comment: "Comment 1",
      rating: 4,
    ),
    Comment(
      avatar: "images/logo3.jpg",
      userName: "User 2",
      date: "23-8-2023",
      comment: "Comment 2",
      rating: 5,
    ),
    Comment(
      avatar: "images/logo1.png",
      userName: "User 1",
      date: "22-8-2023",
      comment: "Comment 1",
      rating: 4,
    ),
    Comment(
      avatar: "images/logo1.png",
      userName: "User 2",
      date: "23-8-2023",
      comment: "Comment 2",
      rating: 5,
    ),
    Comment(
      avatar: "images/logo1.png",
      userName: "User 1",
      date: "22-8-2023",
      comment: "Comment 1",
      rating: 4,
    ),
    Comment(
      // avatar: "images/game4.jpg",
      avatar: "images/logo1.png",
      userName: "User 2",
      date: "23-8-2023",
      comment: "Comment 2",
      rating: 5,
    ),
    // Thêm các comments khác tương tự ở đây
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < comments.length; i++)
              _buildCommentCard(comments[i]),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard(Comment comment) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      comment.avatar,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      comment.date,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      comment.comment,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${comment.rating}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text("Comments"),
//       ),
//       body: CommentList(),
//     ),
//   ));
// }
