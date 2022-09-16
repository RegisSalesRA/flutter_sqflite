import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../model/model.dart';
import '../../widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  final Music music;
  final bool isLoading = false;
  const DetailScreen({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar:
          const AppBarWidget(title: "Detail Screen", actionsAppBar: SizedBox()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Center(
                            child: Icon(
                              Icons.assignment,
                              size: 100,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                            color: Palette.primaryColorDark,
                          ),
                          Text(
                            "Musica - Dream Theater - ${music.id}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const Divider(
                            thickness: 2,
                            color: Palette.primaryColorDark,
                          ),
                          Text(
                            "Categoria - Heavy Metal",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const Divider(
                            thickness: 2,
                            color: Palette.primaryColorDark,
                          ),
                          Text(
                            "Album - The black Clouds And Silver ",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const Divider(
                            thickness: 2,
                            color: Palette.primaryColorDark,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: ExpansionTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clique aqui para mais detalhes',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        childrenPadding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.   Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,                 when an unknown printer took a galley of type and scrambled it to make a type specimen book. It                          has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It w                          as popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop                            publishing software like Aldus PageMaker including versions of Lorem Ipsum       Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,                 when an unknown printer took a galley of type and scrambled it to make a type specimen book. It                          has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It w                          as popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop                            publishing software like Aldus PageMaker including versions of Lorem Ipsum       Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,                 when an unknown printer took a galley of type and scrambled it to make a type specimen book. It                          has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It w                          as popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop                            publishing software like Aldus PageMaker including versions of Lorem Ipsum     ",
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
