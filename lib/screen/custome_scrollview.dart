import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewScreen extends StatelessWidget {
  const CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          body: CustomScrollView(

        slivers: [
          SliverAppBar(
            backgroundColor: Colors.indigo,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                color: Colors.white,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(child: Text("Sliver appbar")),
              ),
            ),
            pinned: true,
            // floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/image1.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SliverToBoxAdapter(

            child: ExpandableTextWidget(
              text: " In Hinduism, the peacock feather is often associated with Lord Krishna. He is frequently depicted with a peacock feather in his crown, symbolizing beauty, knowledge, and prosperity. It is also associated with Saraswati, the goddess of wisdom, music, and art. Peacocks have been symbols of beauty and royalty in Indian culture for centuries. The feathers, known for their iridescent colors and eye-like patterns, are often used in traditional dance costumes and decorations. Peacock feathers are commonly used in religious rituals and ceremonies. They are believed to ward off evil spirits and bring good luck.The feathers are used in home decor, traditional crafts, and as accessories in dance performances, reflecting their aesthetic appeal. In Hinduism, the peacock feather is often associated with Lord Krishna. He is frequently depicted with a peacock feather in his crown, symbolizing beauty, knowledge, and prosperity. It is also associated with Saraswati, the goddess of wisdom, music, and art. Peacocks have been symbols of beauty and royalty in Indian culture for centuries. The feathers, known for their iridescent colors and eye-like patterns, are often used in traditional dance costumes and decorations. Peacock feathers are commonly used in religious rituals and ceremonies. They are believed to ward off evil spirits and bring good luck.The feathers are used in home decor, traditional crafts, and as accessories in dance performances, reflecting their aesthetic appeal.",
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), ),

          )
        ],
      )),
    );
  }
}

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ExpandableTextWidget({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: secondHalf.isEmpty
          ? Text(firstHalf, style: widget.style)
          : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10
            ).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                      style: widget.style),
                  InkWell(
                    child: Text(

                      flag ? "show more" : "show less",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ],
              ),
          ),
    );
  }
}
