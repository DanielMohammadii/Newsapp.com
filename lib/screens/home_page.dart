import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_api_0/apis/newsapi.dart';
import 'package:get_api_0/helper/date.dart';
import 'package:get_api_0/models/articles_models.dart';
import 'package:get_api_0/models/categroy_model.dart';
import 'package:get_api_0/screens/article_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = List<CategoryModel>();
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    _newsModel = NewsApi().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                /// Catergories
                Container(
                  height: 70,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    },
                  ),
                ),
                //Block of Articles
                Container(
                    padding: EdgeInsets.only(
                      top: 16,
                    ),
                    child: FutureBuilder<NewsModel>(
                      future: _newsModel,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data.articles.length,
                            itemBuilder: (context, index) {
                              var article = snapshot.data.articles[index];
                              if (article.urlToImage != null &&
                                  article.description != null) {
                                return BlogTile(
                                  imageUrl: article.urlToImage,
                                  title: article.title,
                                  desc: article.description,
                                  url: article.url,
                                );
                              } else
                                return null;
                            },
                          );
                        } else
                          return Center(child: CircularProgressIndicator());
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl;
  final categoryName;

  const CategoryTile({Key key, this.imageUrl, this.categoryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black45,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String title, imageUrl, desc, url;

  BlogTile({this.title, this.imageUrl, this.desc, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Articles(
                blogUrl: url,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(imageUrl: imageUrl)),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
