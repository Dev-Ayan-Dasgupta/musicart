//import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:musicart/lists/list_of_banks.dart';
import 'package:musicart/widgets/payments_screen_subtile.dart';
import 'package:musicart/widgets/text_label.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/animated_bottom_bar.dart';
import '../widgets/custom_appbar.dart';
import '../global_variables/global_variables.dart' as gv;
import '../widgets/popular_bank_tile.dart';
//import '../utils/methods.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({Key? key}) : super(key: key);

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  final TextEditingController _searchBoxController = TextEditingController();
  final String _hintText = "Search instruments...";
  int _currentIndex = 3;
  final TextEditingController bankSearchController = TextEditingController();
  int count = 0;
  String searchText = "";

  final Stream<QuerySnapshot> banksStream =
      FirebaseFirestore.instance.collection("banks").snapshots();

  final Stream<QuerySnapshot> popularBanksStream =
      FirebaseFirestore.instance.collection("popular banks").snapshots();

  List filteredStoredBanks = [];
  List filteredStoredBanksBySearch = [];
  bool isSearchingBanks = false;
  List storedBanks = [];

  List storedPopularBanks = [];

  get navBarItems => null;

  @override
  void initState() {
    super.initState();
    storedBanks.sort(
        (a, b) => a["bankName"].toString().compareTo(b["bankName"].toString()));
    filteredStoredBanks = storedBanks;
  }

  Future<void> _launchUrl(String inpUrl) async {
    Uri uri = Uri.parse(inpUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              searchBoxController: _searchBoxController,
              hintText: _hintText,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: TextLabel(
                width: screenWidth * 0.185,
                labelText: "Popular Banks",
                fontSize: screenWidth * 0.0225,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),

            StreamBuilder<QuerySnapshot>(
              stream: popularBanksStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print("Someting went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  storedPopularBanks.clear();
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    storedPopularBanks.add(a);
                  }).toList();

                  //Row of icons of 5 popular banks - START
                  return SizedBox(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.1,
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: storedPopularBanks.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.05),
                                      child: PopularBankTile(
                                          screenHeight: screenHeight,
                                          screenWidth: screenWidth,
                                          foregroundImage: NetworkImage(
                                              storedPopularBanks[index]
                                                      ["bankImgUrl"]
                                                  .toString()),
                                          text: storedPopularBanks[index]
                                                  ["bankName"]
                                              .toString(),
                                          onBankTap: () {
                                            _launchUrl(storedPopularBanks[index]
                                                    ["bankUrl"]
                                                .toString());
                                            if (myBanks.contains(
                                                    popularBankList[index]) ==
                                                false) {
                                              myBanks
                                                  .add(popularBankList[index]);
                                            }
                                          }),
                                    );
                                  })),
                        ],
                      ),
                    ),
                  );
                  //Row of icons of 5 popular banks - END
                }
              },
            ),

            Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),

            StreamBuilder<QuerySnapshot>(
                stream: banksStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Someting went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Center(
                            child: Container(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.05,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.35,
                                  color: Colors.grey,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02),
                                child: TextField(
                                  controller: bankSearchController,
                                  onChanged: (p0) {
                                    setState(() {
                                      count++;
                                      isSearchingBanks = true;
                                      searchText = p0;
                                      //filterBanksBySearch.clear();
                                      populateSearchList(searchText);
                                      if (p0 == "") {
                                        isSearchingBanks = false;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                          if (!isSearching) {
                                            isSearching = true;
                                          } else {
                                            bankSearchController.text = "";
                                            isSearching = false;
                                            filteredBanks = bankList;
                                          }
                                        });
                                      },
                                      icon: (isSearching)
                                          ? Icon(
                                              Icons.close_rounded,
                                              color: Colors.grey,
                                              size: screenWidth * 0.05,
                                            )
                                          : Icon(
                                              Icons.search_rounded,
                                              color: Colors.grey,
                                              size: screenWidth * 0.05,
                                            ),
                                    ),
                                    hintText: "Search for other banks...",
                                    hintStyle: gv.globalTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                  style: gv.globalTextStyle.copyWith(
                                    color: Colors.grey,
                                    fontSize: screenWidth * 0.03,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), //SEARCH BAR for bank search -- END
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: TextLabel(
                            width: screenWidth * 0.14,
                            labelText: "All Banks",
                            fontSize: screenWidth * 0.0225,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02)),
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    );
                  } else {
                    storedBanks.clear();
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedBanks.add(a);
                    }).toList();

                    storedBanks.sort((a, b) => a["bankName"]
                        .toString()
                        .compareTo(b["bankName"].toString()));

                    // filteredStoredBanks = storedBanks;

                    void populateSearchedStoredBanks(String search) {
                      filteredStoredBanksBySearch.clear();
                      if (isSearchingBanks) {
                        for (int i = 0; i < storedBanks.length; i++) {
                          if (storedBanks[i]["bankName"]
                              .toString()
                              .toLowerCase()
                              .contains(search.toLowerCase())) {
                            filteredStoredBanksBySearch.add(storedBanks[i]);
                          }
                        }
                        if (search != "") {
                          filteredStoredBanks = filteredStoredBanksBySearch;
                        } else {
                          filteredStoredBanks = storedBanks;
                        }
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Center(
                            child: Container(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.05,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.35,
                                  color: Colors.grey,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02),
                                child: TextField(
                                  controller: bankSearchController,
                                  onChanged: (p0) {
                                    setState(() {
                                      //print(filteredStoredBanksBySearch.length);
                                      count++;
                                      isSearchingBanks = true;
                                      searchText = p0;
                                      //filterBanksBySearch.clear();
                                      populateSearchedStoredBanks(searchText);
                                      if (p0 == "") {
                                        isSearchingBanks = false;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                          if (!isSearchingBanks) {
                                            isSearchingBanks = true;
                                          } else {
                                            bankSearchController.text = "";
                                            isSearchingBanks = false;
                                            filteredStoredBanks = storedBanks;
                                          }
                                        });
                                      },
                                      icon: (isSearchingBanks)
                                          ? Icon(
                                              Icons.close_rounded,
                                              color: Colors.grey,
                                              size: screenWidth * 0.05,
                                            )
                                          : Icon(
                                              Icons.search_rounded,
                                              color: Colors.grey,
                                              size: screenWidth * 0.05,
                                            ),
                                    ),
                                    hintText: "Search for other banks...",
                                    hintStyle: gv.globalTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                  style: gv.globalTextStyle.copyWith(
                                    color: Colors.grey,
                                    fontSize: screenWidth * 0.03,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), //SEARCH BAR for bank search -- END
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: TextLabel(
                            width: screenWidth * 0.14,
                            labelText: "All Banks",
                            fontSize: screenWidth * 0.0225,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02)),
                        SizedBox(
                          width: screenWidth * 0.95,
                          height: screenHeight * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AnimationLimiter(
                                  key: ValueKey("list $count"),
                                  child: ListView.builder(
                                    itemCount: filteredStoredBanks.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          child: FadeInAnimation(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.05),
                                              child: PaymentsScreenSubTile(
                                                screenWidth: screenWidth * 0.8,
                                                screenHeight:
                                                    screenHeight * 0.8,
                                                onTap: () {
                                                  _launchUrl(
                                                      filteredStoredBanks[index]
                                                          ["bankUrl"]);
                                                  if (myBanks.contains(
                                                          filteredBanks[
                                                              index]) ==
                                                      false) {
                                                    myBanks.add(
                                                        filteredBanks[index]);
                                                  }
                                                },
                                                onIconTap: () {
                                                  _launchUrl(
                                                      filteredStoredBanks[index]
                                                          ["bankUrl"]);
                                                  if (myBanks.contains(
                                                          filteredBanks[
                                                              index]) ==
                                                      false) {
                                                    myBanks.add(
                                                        filteredBanks[index]);
                                                  }
                                                },
                                                text: filteredStoredBanks[index]
                                                        ["bankName"]
                                                    .toString(),
                                                imgUrl:
                                                    filteredStoredBanks[index]
                                                            ["bankImgUrl"]
                                                        .toString(),
                                                iconData: Icons.chevron_right,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),

            //SEARCH BAR for bank search -- START
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
            //   child: Center(
            //     child: Container(
            //       width: screenWidth * 0.9,
            //       height: screenHeight * 0.05,
            //       alignment: Alignment.centerLeft,
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           width: 0.35,
            //           color: Colors.grey,
            //         ),
            //         borderRadius: const BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //       ),
            //       child: Padding(
            //         padding:
            //             EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            //         child: TextField(
            //           controller: bankSearchController,
            //           onChanged: (p0) {
            //             setState(() {
            //               count++;
            //               isSearchingBanks = true;
            //               searchText = p0;
            //               //filterBanksBySearch.clear();
            //               populateSearchList(searchText);
            //               if (p0 == "") {
            //                 isSearchingBanks = false;
            //               }
            //             });
            //           },
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //             suffixIcon: IconButton(
            //               onPressed: () {
            //                 setState(() {
            //                   count++;
            //                   if (!isSearching) {
            //                     isSearching = true;
            //                   } else {
            //                     bankSearchController.text = "";
            //                     isSearching = false;
            //                     filteredBanks = bankList;
            //                   }
            //                 });
            //               },
            //               icon: (isSearching)
            //                   ? Icon(
            //                       Icons.close_rounded,
            //                       color: Colors.grey,
            //                       size: screenWidth * 0.05,
            //                     )
            //                   : Icon(
            //                       Icons.search_rounded,
            //                       color: Colors.grey,
            //                       size: screenWidth * 0.05,
            //                     ),
            //             ),
            //             hintText: "Search for other banks...",
            //             hintStyle: gv.globalTextStyle.copyWith(
            //               color: Colors.grey,
            //               fontSize: screenWidth * 0.03,
            //             ),
            //           ),
            //           style: gv.globalTextStyle.copyWith(
            //             color: Colors.grey,
            //             fontSize: screenWidth * 0.03,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ), //SEARCH BAR for bank search -- END
            // Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            //   child: TextLabel(
            //     width: screenWidth * 0.14,
            //     labelText: "All Banks",
            //     fontSize: screenWidth * 0.0225,
            //   ),
            // ),
            // Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
            //LISTVIEW for OTHER BANKS - START
            // SizedBox(
            //   width: screenWidth * 0.95,
            //   height: screenHeight * 0.5,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Expanded(
            //         child: AnimationLimiter(
            //           key: ValueKey("list $count"),
            //           child: ListView.builder(
            //             itemCount: storedBanks.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return AnimationConfiguration.staggeredList(
            //                 position: index,
            //                 duration: const Duration(milliseconds: 375),
            //                 child: SlideAnimation(
            //                   child: FadeInAnimation(
            //                     child: Padding(
            //                       padding:
            //                           EdgeInsets.only(left: screenWidth * 0.05),
            //                       child: PaymentsScreenSubTile(
            //                         screenWidth: screenWidth * 0.8,
            //                         screenHeight: screenHeight * 0.8,
            //                         onTap: () {
            //                           _launchUrl(filteredStoredBanks[index]
            //                               ["bankUrl"]);
            //                           if (myBanks
            //                                   .contains(filteredBanks[index]) ==
            //                               false) {
            //                             myBanks.add(filteredBanks[index]);
            //                           }
            //                         },
            //                         onIconTap: () {
            //                           _launchUrl(filteredStoredBanks[index]
            //                               ["bankUrl"]);
            //                           if (myBanks
            //                                   .contains(filteredBanks[index]) ==
            //                               false) {
            //                             myBanks.add(filteredBanks[index]);
            //                           }
            //                         },
            //                         text: filteredStoredBanks[index]["bankName"]
            //                             .toString(),
            //                         imgUrl: filteredStoredBanks[index]
            //                                 ["bankImgUrl"]
            //                             .toString(),
            //                         iconData: Icons.chevron_right,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            //LISTVIEW for OTHER BANKS - END
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025, vertical: screenHeight * 0.015),
          child: CustomAnimatedBottomBar(
            containerHeight: screenHeight * 0.06,
            backgroundColor: Colors.black87,
            selectedIndex: _currentIndex,
            showElevation: true,
            itemCornerRadius: 10,
            curve: Curves.easeIn,
            items: gv.navBarItems,
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
