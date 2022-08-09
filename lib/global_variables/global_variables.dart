import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/animated_bottom_bar.dart';

TextStyle globalTextStyle = GoogleFonts.lato();

Color primaryColor = Colors.black;
Color secondaryColor = Colors.black54;
Color tertiaryColor = Colors.white70;

List<BottomNavyBarItem> navBarItems = [
  BottomNavyBarItem(
    icon: const Icon(Icons.home_rounded),
    title: Text(
      'Home',
      style: globalTextStyle.copyWith(fontSize: 14, color: _activeColor),
    ),
    activeColor: _activeColor,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.category_rounded),
    title: Text(
      'Categories',
      style: globalTextStyle.copyWith(fontSize: 14, color: _activeColor),
    ),
    activeColor: _activeColor,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.message),
    title: Text(
      'Messages ',
      style: globalTextStyle.copyWith(fontSize: 14, color: _activeColor),
    ),
    activeColor: _activeColor,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.person_rounded),
    title: Text(
      'User',
      style: globalTextStyle.copyWith(fontSize: 14, color: _activeColor),
    ),
    activeColor: _activeColor,
    inactiveColor: _inactiveColor,
    textAlign: TextAlign.center,
  ),
];

const _inactiveColor = Colors.grey;
const _activeColor = Colors.white70;

List<String> carouselImageList = [
  "https://cdn.shopify.com/s/files/1/0657/6821/files/NEW-RELEASE.jpg?v=1645172487",
  "https://cdn.shopify.com/s/files/1/0657/6821/files/new-fixed-banner-_1.jpg?v=1634560616",
  "https://cdn.shopify.com/s/files/1/0657/6821/files/podcast-banner-new.jpg?v=1643875596",
  "https://cdn.shopify.com/s/files/1/0657/6821/files/ukuleles_99ce5da1-a7e7-448d-b50c-c3949b738ebe.jpg?v=1613366967",
  "https://cdn.shopify.com/s/files/1/0657/6821/files/MI-for-kids.jpg?v=1645172487",
];

List<Map<String, dynamic>> brandLogos = [
  {
    "brand": "fender",
    "img-url":
        "https://png.pngitem.com/pimgs/s/159-1597814_fender-guitar-hd-png-download.png",
  },
  {
    "brand": "yamaha",
    "img-url":
        "https://www.motoroids.com/wp-content/uploads/2011/03/Yamaha-logo.jpg",
  },
  {
    "brand": "ibanez",
    "img-url":
        "https://s0.bukalapak.com/img/57118379431/large/IBANEZ_GUITAR_sticker_logo_ibanez_gitar_stiker_murah_8cm.jpg",
  },
  {
    "brand": "gibson",
    "img-url":
        "https://i.etsystatic.com/34531699/r/il/cd1ba7/3800299077/il_340x270.3800299077_1e91.jpg",
  },
  {
    "brand": "tama",
    "img-url": "https://www.vector-logo.net/logo_preview/eps/t/Tama.png",
  },
];

List<Map<String, dynamic>> instruments = [
  {
    "instrument": "Guitar",
    "name": "Fender Stratocaster",
    "brand": "Fender",
    "mrp": 62000,
    "price": 58900,
    "rating": 4.7,
    "reviews": 11,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/FEN-0144522500_grande.jpg?v=1639964521",
    "del-days": 3,
  },
  {
    "instrument": "Guitar",
    "name": "Squier Bullet Strat",
    "brand": "Fender",
    "mrp": 17280,
    "price": 11900,
    "rating": 4.5,
    "reviews": 188,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/SQUIERBULLETSTRAT_0934fec6-212d-4e8e-84d2-27c52f31c427_large.jpg?v=1653118647",
    "del-days": 2,
  },
  {
    "instrument": "Guitar",
    "name": "Les Paul Studio LT",
    "brand": "Epiphone",
    "mrp": 29999,
    "price": 24604,
    "rating": 4.4,
    "reviews": 11,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/EPI-LPSTULTHS.jpg?v=1653993043",
    "del-days": 5,
  },
  {
    "instrument": "Guitar",
    "name": "KX 100 HT",
    "brand": "Cort",
    "mrp": 21542,
    "price": 17176,
    "rating": 5.0,
    "reviews": 2,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/io_large.jpg?v=1640775516",
    "del-days": 2,
  },
  {
    "instrument": "Guitar",
    "name": "Jet-1",
    "brand": "Aria",
    "mrp": 15174,
    "price": 14416,
    "rating": 4.0,
    "reviews": 1,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/ARI-JET1BK_large.jpg?v=1639700162",
    "del-days": 1,
  },
  {
    "instrument": "Bass",
    "name": "Cort Action Bass 4",
    "brand": "Cort",
    "mrp": 17600,
    "price": 16720,
    "rating": 4.8,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/CRT-ABPLHBK_large.jpg?v=1571270312",
    "del-days": 2,
  },
  {
    "instrument": "Bass",
    "name": "Sqiuer Affinity Jazz 4",
    "brand": "Fender",
    "mrp": 29240,
    "price": 27778,
    "rating": 5.0,
    "reviews": 2,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/FEN-0378602500_d7ecae7b-7de2-4408-8a99-de71b8c7dc57_large.jpg?v=1649239263",
    "del-days": 7,
  },
  {
    "instrument": "Bass",
    "name": "Fender American Ultra Jazz 4",
    "brand": "Fender",
    "mrp": 213500,
    "price": 202825,
    "rating": 0.0,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/FEN-0199020734_large.jpg?v=1640055182",
    "del-days": 1,
  },
  {
    "instrument": "Bass",
    "name": "LTD B-154DX Flame",
    "brand": "ESP",
    "mrp": 31103,
    "price": 29548,
    "rating": 4.0,
    "reviews": 1,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/1_615b2590-4eb7-4f10-b9fb-3ea66c4b9619_large.jpg?v=1571265179",
    "del-days": 4,
  },
  {
    "instrument": "Bass",
    "name": "Tobias Toby Deluxe",
    "brand": "Epiphone",
    "mrp": 33499,
    "price": 27500,
    "rating": 5.0,
    "reviews": 9,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/POP_TobyDlxIV-TR_large.jpg?v=1635357398",
    "del-days": 2,
  },
  {
    "instrument": "Drums",
    "name": "Stagestar SG52KH5",
    "brand": "Tama",
    "mrp": 40000,
    "price": 37360,
    "rating": 5.0,
    "reviews": 15,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/TAM-SG52KH5WR_large.jpg?v=1649231316",
    "del-days": 4,
  },
  {
    "instrument": "Drums",
    "name": "CL50RS Super Star",
    "brand": "Tama",
    "mrp": 74640,
    "price": 70908,
    "rating": 0.0,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/TAM-CL50RSCFF_large.jpg?v=1659011269",
    "del-days": 3,
  },
  {
    "instrument": "Drums",
    "name": "Cafe Racer Series TJ",
    "brand": "Natal",
    "mrp": 123333,
    "price": 113415,
    "rating": 4.9,
    "reviews": 5,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/NTL-KTWTJCPS_1_large.jpg?v=1649316121",
    "del-days": 3,
  },
  {
    "instrument": "Drums",
    "name": "Roadshow",
    "brand": "Pearl",
    "mrp": 48795,
    "price": 34767,
    "rating": 0,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/PRL-RS525SCC-BZM_15ce4492-6c20-4b67-b1b5-02c7b8cbf1db_large.jpg?v=1639788541",
    "del-days": 6,
  },
  {
    "instrument": "Drums",
    "name": "Tornado",
    "brand": "Mapex",
    "mrp": 39400,
    "price": 36000,
    "rating": 5.0,
    "reviews": 15,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/MAPEXTNM5254TCUDR_large.jpg?v=1649149045",
    "del-days": 9,
  },
  {
    "instrument": "Keyboard",
    "name": "PSR-E273",
    "brand": "Yamaha",
    "mrp": 19770,
    "price": 8600,
    "rating": 4.5,
    "reviews": 54,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/yam-psre273_large.jpg?v=1654239555",
    "del-days": 10,
  },
  {
    "instrument": "Keyboard",
    "name": "Jupiter-XM Rising",
    "brand": "Roland",
    "mrp": 172959,
    "price": 164311,
    "rating": 0,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/ROL-JUPITERXM_large.jpg?v=1635193010",
    "del-days": 1,
  },
  {
    "instrument": "Keyboard",
    "name": "GP-500 Celviano Grand Hybrid",
    "brand": "Casio",
    "mrp": 399995,
    "price": 379995,
    "rating": 0,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/CAS-GP500BP_large.jpg?v=1656744416",
    "del-days": 4,
  },
  {
    "instrument": "Keyboard",
    "name": "SPD-30",
    "brand": "Roland",
    "mrp": 92408,
    "price": 80788,
    "rating": 5,
    "reviews": 4,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/YAM-PSREZ300_large.jpg?v=1639815482",
    "del-days": 2,
  },
  {
    "instrument": "Wind Instrument",
    "name": "HA1000",
    "brand": "Vault",
    "mrp": 999,
    "price": 369,
    "rating": 4.4,
    "reviews": 110,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/VAU-HA1000-6_a911cfc4-76e5-44be-944c-e470432db2c2_large.jpg?v=1639566782",
    "del-days": 5,
  },
  {
    "instrument": "Wind Instrument",
    "name": "M1105AY Alto",
    "brand": "Havana",
    "mrp": 31450,
    "price": 27900,
    "rating": 5.0,
    "reviews": 35,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/HAVANAM1105AALTOSAX_large.jpg?v=1640000821",
    "del-days": 1,
  },
  {
    "instrument": "Wind Instrument",
    "name": "JYCL 1301",
    "brand": "Pluto",
    "mrp": 12730,
    "price": 12094,
    "rating": 0.0,
    "reviews": 0,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/JYCL1301_large.jpg?v=1571270477",
    "del-days": 2,
  },
  {
    "instrument": "Wind Instrument",
    "name": "M5210 Bb",
    "brand": "Havana",
    "mrp": 15225,
    "price": 14464,
    "rating": 5.0,
    "reviews": 2,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/HAV-M5210BBGL_large.jpg?v=1640007963",
    "del-days": 3,
  },
  {
    "instrument": "Wind Instrument",
    "name": "Guru Concert Bansuri",
    "brand": "Ultimate",
    "mrp": 4000,
    "price": 3500,
    "rating": 3.5,
    "reviews": 4,
    "img-url":
        "https://cdn.shopify.com/s/files/1/0657/6821/products/ULTIMATEGURUCONCERTBANSURIA_large.jpg?v=1639916041",
    "del-days": 4,
  },
];

List<Map<String, dynamic>> wishList = [];
List<Map<String, dynamic>> cartList = [];

Map<Map<String, dynamic>, int> cartMap = HashMap();

double cartValue = 0;
double myCartValue = 0;

List<Category> categoryTileImageUrls = [
  Category(
    "https://images.unsplash.com/photo-1580745089072-032cbde08507?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fGd1aXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    "Acoustic Guitars",
    "/acoustic-guitars",
  ),
  Category(
    "https://images.unsplash.com/photo-1568193755668-aae18714a9f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZWxlY3RyaWMlMjBndWl0YXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    "Electric Guitar",
    "/electric-guitars",
  ),
  Category(
    "https://images.unsplash.com/photo-1629055870408-489772ca88d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
    "Bass Guitars",
    "/bass-guitars",
  ),
  Category(
    "https://images.unsplash.com/photo-1607513272385-b4f42e08fb16?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dWt1bGVsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    "Ukuleles",
    "/ukuleles",
  ),
  Category(
    "https://images.unsplash.com/photo-1578410170179-bb10594ed395?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8a2V5Ym9hcmQlMjBpbnN0cnVtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    "Keyboards",
    "/keyboards",
  ),
  Category(
    "https://images.unsplash.com/photo-1576487236230-eaa4afe9b453?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHBpYW5vfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    "Pianos",
    "/pianos",
  ),
  Category(
    "https://images.unsplash.com/photo-1543443258-92b04ad5ec6b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZHJ1bXN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    "Drums",
    "/drums",
  ),
  Category(
    "https://images.unsplash.com/photo-1499314722718-0827eb4deb71?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=683&q=80",
    "Wind Instruments",
    "/wind-instruments",
  ),
  Category(
    "https://images.unsplash.com/photo-1646765495885-8a61595cb9cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c2l0YXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    "Indian Classical",
    "/indian-classical",
  ),
  Category(
    "https://images.unsplash.com/photo-1531651008558-ed1740375b39?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fG1pY3JvcGhvbmUlMjByZWNvcmRpbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    "Microphones",
    "/microphones",
  ),
  Category(
    "https://images.unsplash.com/photo-1583236753467-456b21f4a1ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fGFtcGxpZmllcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    "Amplifiers",
    "/amplifiers",
  ),
  Category(
    "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGolMjAlMjBnZWFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    "DJ Kits",
    "/dj-kits",
  ),
  Category(
    "https://images.unsplash.com/photo-1655213739608-671ac545aeb8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGRqJTIwJTIwZ2VhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    "Headphones",
    "/headphones",
  ),
];

class Category {
  String imgUrl;
  String title;
  String routeName;

  Category(
    this.imgUrl,
    this.title,
    this.routeName,
  );
}