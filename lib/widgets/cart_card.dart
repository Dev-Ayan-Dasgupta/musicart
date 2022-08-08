import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';
import 'package:musicart/widgets/flip_counter.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onCardTap,
    required this.onRemoveTap,
    required this.onMoveToWishlist,
    required this.onAddTap,
    required this.onReduceTap,
    required this.width,
    required this.height,
    required this.unitsBought,
    required this.instrument,
    required this.delDate,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onCardTap;
  final VoidCallback onRemoveTap;
  final VoidCallback onMoveToWishlist;
  final VoidCallback onAddTap;
  final VoidCallback onReduceTap;
  final double width;
  final double height;
  final int unitsBought;
  final Map<String, dynamic> instrument;
  final String delDate;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * 0.95,
      height: widget.height * 0.16,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: widget.onCardTap,
              child: Container(
                width: widget.width * 0.95,
                height: widget.height * 0.08,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.25,
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  title: widget.title,
                  leading: widget.leading,
                  subtitle: widget.subtitle,
                  trailing: widget.trailing,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: widget.height * 0.01,
                horizontal: widget.width * 0.025),
            child: SizedBox(
              width: widget.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widget.width * 0.005),
                    child: InkWell(
                      onTap: widget.onMoveToWishlist,
                      child: (wishList.contains(widget.instrument))
                          ? Icon(
                              Icons.favorite_rounded,
                              color: Colors.red.shade900,
                            )
                          : const Icon(Icons.favorite_outline_rounded),
                    ),
                  ),
                  InkWell(
                    onTap: widget.onRemoveTap,
                    child: const Icon(Icons.delete_outline_rounded),
                  ),
                  FlipCounter(
                      count: widget.unitsBought,
                      onAdd: widget.onAddTap,
                      onRemove: widget.onReduceTap,
                      value: widget.unitsBought.toDouble()),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.width * 0.06),
                child: Text(
                  "Expected delivery on ${widget.delDate}",
                  style: globalTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
