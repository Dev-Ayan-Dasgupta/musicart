import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class SearchWidget extends StatefulWidget {
  final double width;
  final Function(String)? onChanged;
  final TextEditingController? searchController;
  final VoidCallback? onTap;
  final String? hintText;
  const SearchWidget({
    Key? key,
    required this.width,
    this.onChanged,
    this.searchController,
    this.onTap,
    this.hintText,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;
  bool isForward = false;

  //TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.easeOutExpo);

    animation = Tween<double>(begin: 0, end: 110).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: SizedBox(
          width: widget.width,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: animation.value,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: TextField(
                    //autofocus: true,
                    controller: widget.searchController,
                    onChanged: widget.onChanged,
                    cursorColor: Colors.white54,
                    style: globalTextStyle.copyWith(
                        color: Colors.white54, fontSize: 12),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: globalTextStyle.copyWith(
                          color: Colors.white30,
                          fontSize: 12), //TextStyle(color: Colors.white30),
                    ),
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: animation.value > 1
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(40),
                        )
                      : BorderRadius.circular(40),
                ),
                child: IconButton(
                  onPressed: () {
                    if (!isForward) {
                      animController.forward();
                      isForward = true;
                    } else if (isForward &&
                        widget.searchController!.text != "") {
                      widget.searchController!.clear();
                    } else {
                      animController.reverse();
                      isForward = false;
                    }
                    widget.onTap!();
                  },
                  icon: (!isForward)
                      ? const Icon(
                          Icons.search,
                          color: Colors.white54,
                        )
                      : const Icon(
                          Icons.close_rounded,
                          color: Colors.white54,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
