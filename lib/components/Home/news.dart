import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("News",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff))),
        const SizedBox(
          height: 10,
        ),
        // create a fixed size scrollable container
        Expanded(
          flex: 1,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: NewsCard(
                    newsUrl: "",
                    imageUrl:
                        "https://c8.alamy.com/comp/2HAB3PK/a-news-or-article-card-for-a-website-web-interface-template-user-interface-vector-illustration-2HAB3PK.jpg",
                    title:
                        "in ante metus dictum at tempor commodo ullamcorper a lacus",
                    description:
                        "Description of the news article. lorem ipsum dolor sit amet. leosdlfjlsdkf lorem  dlkjlkdlkfjsdlfdfjsdjfdjflksdjf dlfjdlskjfl  liksdjflksdj jfglsdkjl  sfjsdl j sddkfjdsl jf sdlkfjsdl j"),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String newsUrl;

  const NewsCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.newsUrl,
  }) : super(key: key);

  Future<void> _launchURL(String url, context) async {
    try {
      final newsUri = Uri.parse(url);
      await launchUrl(newsUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Create a pop up to show the error
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
        backgroundColor: Colors.redAccent,
          content: Text("Error : Cannot open the News Artical"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL(newsUrl, context);
      },
      child: Card(
        color: Colors.transparent,
        child: Row(
          children: [
            // render image using network image Url
            Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    height: 90,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imageUrl,
                    ),
                  ),
                )),
            // Add title and description here
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 90.0, // Set the height you want here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xccffffff),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
