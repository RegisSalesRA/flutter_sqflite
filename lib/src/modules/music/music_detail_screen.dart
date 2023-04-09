import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/widgets/widgets.dart';
import '../../../config/config.dart';
import '../../../data/database_service.dart';
import '../../../model/model.dart';
import 'package:textwrap/textwrap.dart';

class DetailScreen extends StatefulWidget {
  final Music music;
  const DetailScreen({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final bool isLoading = false;
  final DatabaseService _databaseService = DatabaseService();

  Category categoryName = Category();
  Album albumMusic = Album();

  Future categoryById() async {
    var data = await _databaseService.category(widget.music.categoryId);
    if (widget.music.categoryId! > 0 && data != null) {
      setState(() {
        categoryName = data;
      });
    }
    return null;
  }

  Future albumById() async {
    var data = await _databaseService.album(widget.music.albumId);
    if (widget.music.albumId! > 0 && data != null) {
      setState(() {
        albumMusic = data;
      });
    }
    return null;
  }

  var text = """Wasted years!
One, two, three-
From the coast of gold, across the seven seas
Travelin' on, far and wide
But now it seems I'm just a stranger to myself
And all the things I sometimes do, it isn't me but someone else
I close my eyes and I think of home
Another city goes by in the night
Ain't it funny how it is? You never miss it til' it's gone away
And my heart is lying there, will be 'til my dying day, Adrian!
So understand
Don't waste your time always searching for those wasted years
Face up, make your stand
Realize you're living in the golden years
Too much time on my hands, I got you on my mind
Can't ease this pain so easily
When you can't find the words to say, hard to make it through another day
And it makes me wanna cry, throw my hands up to the sky
So understand
Don't waste your time always searching for those wasted years
Face up, make your stand
Realize you're living in the golden years, hey!
So understand, Adrian!
Don't waste your time always searching for those wasted years
Face up, make your stand
Realize you're living in the golden years
So understand
Don't waste your time always searching for those wasted years
Face up, make your stand
Realize you're living in the golden years, hey!""";
  String wrappedText = '';

  wrapText(String text, int maxCharsPerLine) {
    int start = 0;
    int end = maxCharsPerLine;
    while (start < text.length) {
      if (end >= text.length) {
        end = text.length;
      } else {
        int lastSpace = text.substring(start, end).lastIndexOf(' ');
        if (lastSpace != -1 && lastSpace != end - start) {
          end = start + lastSpace + 1;
        }
      }
      wrappedText +=
          '${text.substring(start, end)}\n\n'; // adiciona espaço extra
      start = end;
      end += maxCharsPerLine;
      wrappedText.split(' ');
    }
    setState(() {
      wrappedText = wrappedText;
    });
  }

  @override
  void initState() {
    super.initState();
    wrapText(widget.music.lyric!, 100);
    categoryById();
    albumById();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final wrapper = TextWrapper(width: 80);

    final paragrafosDivididos = wrapper.wrap(widget.music.lyric!);

    final versos = [];

    final paragrafos = versos.join('');
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.assignment,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    widget.music.albumId != 0 && albumMusic.name != null
                        ? albumMusic.name.toString()
                        : "No registered album",
                  ),
                  content: Text(widget.music.description!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Icon(Icons.cancel),
                    ),
                  ]),
            );
          },
        ),
        appBar: AppBarWidget(
          title: 'Details',
          onTap: () => Navigator.of(context).pop(),
          actions: widget.music.isFavorite == 1
              ? const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.favorite, color: Colors.red))
              : Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.grey.shade400,
                  ),
                ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: size.height * 0.05,
              bottom: 100,
              right: 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/detailPageImage.png',
                  ),
                )),
              ),
            ),
            Positioned(
              top: size.height * 0.35,
              right: 30,
              bottom: 0,
              left: 30,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: size.width,
                            height: size.height * 0.40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                            ),
                            child: Column(children: [
                              Center(
                                  child: Text(
                                widget.music.categoryId != 0 &&
                                        categoryName.name != null
                                    ? " ${categoryName.name.toString()} "
                                    : "No registered category",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Palette.primaryColorLight),
                              )),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Text(wrappedText.toString()),
                                      ],
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
