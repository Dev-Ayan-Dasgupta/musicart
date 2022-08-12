import 'package:flutter/material.dart';
import 'package:musicart/global_variables/global_variables.dart';

class ChooseAddressCard extends StatefulWidget {
  const ChooseAddressCard({
    Key? key,
    required this.width,
    required this.height,
    required this.isCurrentAddress,
    required this.addressPersonName,
    required this.addressLine1,
    required this.addressLine2,
    this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    //this.type,
    required this.onTap,
    required this.onEditTap,
    required this.onDeleteTap,
  }) : super(key: key);

  final double width;
  final double height;
  final bool isCurrentAddress;
  final String addressPersonName;
  final String addressLine1;
  final String addressLine2;
  final String? landmark;
  final String city;
  final String state;
  final String pinCode;
  //final String? type;
  final VoidCallback onTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  @override
  State<ChooseAddressCard> createState() => _ChooseAddressCardState();
}

class _ChooseAddressCardState extends State<ChooseAddressCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: widget.width * 0.025,
                right: widget.width * 0.025,
                top: widget.width * 0.025,
                bottom: widget.width * 0.015),
            child: Container(
              width: widget.width,
              height: widget.height * 0.9,
              decoration: BoxDecoration(
                border: Border.all(
                  width: (widget.isCurrentAddress) ? 5 : 0.25,
                  color: (widget.isCurrentAddress) ? primaryColor : Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.width * 0.025,
                    vertical: widget.height * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.addressPersonName,
                      style: globalTextStyle.copyWith(
                        color: primaryColor,
                        fontSize: widget.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.04)),
                    Text(
                      widget.addressLine1,
                      style: globalTextStyle.copyWith(
                        color: secondaryColor,
                        fontSize: widget.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.04)),
                    Text(
                      widget.addressLine2,
                      style: globalTextStyle.copyWith(
                        color: secondaryColor,
                        fontSize: widget.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.04)),
                    Text(
                      widget.landmark!,
                      style: globalTextStyle.copyWith(
                        color: secondaryColor,
                        fontSize: widget.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.04)),
                    Text(
                      "${widget.city}, ${widget.state}, ${widget.pinCode}",
                      style: globalTextStyle.copyWith(
                        color: secondaryColor,
                        fontSize: widget.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.02)),
                    // Text(
                    //   widget.type!,
                    //   style: globalTextStyle.copyWith(
                    //     color: secondaryColor,
                    //     fontSize: widget.width * 0.02,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: widget.onEditTap,
                icon: Icon(
                  Icons.edit_location_alt_rounded,
                  size: widget.width * 0.05,
                ),
                color: Colors.grey,
              ),
              Padding(padding: EdgeInsets.only(right: widget.width * 0.02)),
              IconButton(
                onPressed: widget.onDeleteTap,
                icon: Icon(
                  Icons.delete_rounded,
                  size: widget.width * 0.05,
                ),
                color: Colors.grey,
              ),
              Padding(padding: EdgeInsets.only(right: widget.width * 0.02)),
            ],
          ),
        ],
      ),
    );
  }
}
