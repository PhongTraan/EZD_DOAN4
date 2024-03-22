import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CollaPage extends StatelessWidget {
  const CollaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(''), // Bỏ trống để không hiển thị tiêu đề
                background: Image.asset(
                  'images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần ảnh đại diện và tên
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Ảnh đại diện
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'images/logo.png'), // Thay đổi đường dẫn tương ứng
                    ),
                    SizedBox(width: 16),

                    // Thông tin cá nhân
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên Người Dùng',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text('Địa chỉ email, số điện thoại, v.v.'),
                      ],
                    ),
                  ],
                ),
              ),

              // Phần thông tin trò chơi
              Container(
                height: 150, // Điều chỉnh chiều cao theo ý muốn của bạn
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên Trò Chơi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),

                    // Giá trên trận
                    Row(
                      children: [
                        // Hình ảnh đồng tiền hoặc biểu tượng trận
                        Image.asset(
                          'images/dong.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 8),
                        // Giá trên trận
                        Text('/10 trận'),
                        Spacer(), // Đặt Spacer để chia đều không gian
                      ],
                    ),

                    // Đánh giá và số lượt đã phục vụ
                    SizedBox(height: 19),
                    Row(
                      children: [
                        Text("Đánh giá :  "),
                        // Đánh giá (có thể sử dụng Flutter Rating Bar)
                        RatingBar.builder(
                          initialRating: 4,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 16, // Điều chỉnh kích thước ở đây
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Xử lý khi đánh giá thay đổi
                          },
                        ),
                        SizedBox(width: 8),
                        Spacer(),
                        // Số lượt đã phục vụ
                        Text(
                          'Đã phục vụ: 10',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 14,
              ),
              // Phần ảnh kỹ năng
              Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin kỹ năng',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      // Các thông tin khác hoặc widget khác có thể được thêm vào đây
                    ],
                  ),
                ),
              ),

              // Phần thông tin kỹ năng
              // Phần ảnh kỹ năng
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 202, 202, 202).withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'images/logo.png', // Thay đổi đường dẫn tương ứng
                    fit: BoxFit.cover,
                    width: double.infinity, // Đặt chiều rộng là không giới hạn
                    height: 170, // Điều chỉnh chiều cao theo ý muốn của bạn
                  ),
                ),
              ),

              SizedBox(
                height: 14,
              ),
              // Phần xếp hạng và vị trí
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Xếp hạng
                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Xếp hạng",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // Vị trí
                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Vị trí",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Phần danh sách đánh giá
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    1, // Số lượng đánh giá (đây chỉ là ví dụ, bạn có thể thay đổi)
                itemBuilder: (context, index) {
                  return buildReviewItem();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          // Hình đại diện cho đánh giá
          const CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage('images/logo.png'), // Thay đổi đường dẫn tương ứng
          ),
          const SizedBox(width: 10),

          // Tên người đánh giá và câu đánh giá
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Người Đánh Giá',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Câu đánh giá của người này'),
            ],
          ),
          Spacer(), // Đặt Spacer để chia đều không gian

          // Số sao đánh giá
          RatingBar.builder(
            initialRating: 4,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 10, // Điều chỉnh kích thước ở đây
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              // Xử lý khi đánh giá thay đổi
            },
          ),
        ],
      ),
    );
  }
}
