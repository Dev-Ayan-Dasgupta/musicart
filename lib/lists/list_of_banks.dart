import 'package:musicart/models/bank_object.dart';

List<BankObject> filterBanksBySearch = [];

bool isSearching = false;

void populateSearchList(String search) {
  filterBanksBySearch.clear();
  if (isSearching) {
    for (int i = 0; i < bankList.length; i++) {
      if (bankList[i].bankName.toLowerCase().contains(search.toLowerCase())) {
        filterBanksBySearch.add(bankList[i]);
      }
    }
    if (search != "") {
      filteredBanks = filterBanksBySearch;
    } else {
      filteredBanks = bankList;
    }
  }
}

List myBanks = [];

List<BankObject> popularBankList = [
  BankObject(
    bankName: "ICICI Bank",
    bankUrl:
        "https://infinity.icicibank.com/corp/AuthenticationController?FORMSGROUP_ID__=AuthenticationFG&__START_TRAN_FLAG__=Y&FG_BUTTONS__=LOAD&ACTION.LOAD=Y&AuthenticationFG.LOGIN_FLAG=1&BANK_ID=ICI",
    bankImgUrl:
        "https://media-exp1.licdn.com/dms/image/C4D0BAQGeIcnR-LkMpw/company-logo_200_200/0/1638338279206?e=1668038400&v=beta&t=8AXkr02nOxYnc0Pz5n4k2P1iNlklXWZZUmW8LlsiyPY",
  ),
  BankObject(
    bankName: "HDFC Bank",
    bankUrl: "https://netbanking.hdfcbank.com/netbanking/",
    bankImgUrl:
        "https://assets.upstox.com/content/dam/aem-content-integration/assets/images/logos/HDFCBANK/HDFCBANK.png",
  ),
  BankObject(
    bankName: "Axis Bank",
    bankUrl:
        "https://retail.axisbank.co.in/wps/portal/rBanking/axisebanking/AxisRetailLogin/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOKNAzxMjIwNjLwsQp0MDBw9PUOd3HwdDQwMjIEKIoEKDHAARwNC-sP1o_ArMYIqwGNFQW6EQaajoiIAVNL82A!!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/",
    bankImgUrl:
        "https://play-lh.googleusercontent.com/nNyS8pk_qjq2BNwGO6ESd8B52HRiMWDvDabNKyUu28uwmVUgxcBWOGkEraUNEQmZHPA",
  ),
  BankObject(
    bankName: "State Bank of India",
    bankUrl: "https://retail.onlinesbi.com/retail/login.htm",
    bankImgUrl: "https://s3-symbol-logo.tradingview.com/state-bank--600.png",
  ),
  BankObject(
    bankName: "Kotak Mahindra",
    bankUrl:
        "https://www.kotak.com/en/digital-banking/ways-to-bank/net-banking.html",
    bankImgUrl:
        "https://skyerglobalinvestment.com/uploads/news/1611249270.jfif",
  ),
];

List<BankObject> bankList = [
  BankObject(
    bankName: "ICICI Bank",
    bankUrl:
        "https://infinity.icicibank.com/corp/AuthenticationController?FORMSGROUP_ID__=AuthenticationFG&__START_TRAN_FLAG__=Y&FG_BUTTONS__=LOAD&ACTION.LOAD=Y&AuthenticationFG.LOGIN_FLAG=1&BANK_ID=ICI",
    bankImgUrl:
        "https://media-exp1.licdn.com/dms/image/C4D0BAQGeIcnR-LkMpw/company-logo_200_200/0/1638338279206?e=1668038400&v=beta&t=8AXkr02nOxYnc0Pz5n4k2P1iNlklXWZZUmW8LlsiyPY",
  ),
  BankObject(
    bankName: "HDFC Bank",
    bankUrl: "https://netbanking.hdfcbank.com/netbanking/",
    bankImgUrl:
        "https://assets.upstox.com/content/dam/aem-content-integration/assets/images/logos/HDFCBANK/HDFCBANK.png",
  ),
  BankObject(
    bankName: "Axis Bank",
    bankUrl:
        "https://retail.axisbank.co.in/wps/portal/rBanking/axisebanking/AxisRetailLogin/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOKNAzxMjIwNjLwsQp0MDBw9PUOd3HwdDQwMjIEKIoEKDHAARwNC-sP1o_ArMYIqwGNFQW6EQaajoiIAVNL82A!!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/",
    bankImgUrl:
        "https://play-lh.googleusercontent.com/nNyS8pk_qjq2BNwGO6ESd8B52HRiMWDvDabNKyUu28uwmVUgxcBWOGkEraUNEQmZHPA",
  ),
  BankObject(
    bankName: "State Bank of India",
    bankUrl: "https://retail.onlinesbi.com/retail/login.htm",
    bankImgUrl: "https://s3-symbol-logo.tradingview.com/state-bank--600.png",
  ),
  BankObject(
    bankName: "Kotak Mahindra Bank",
    bankUrl:
        "https://www.kotak.com/en/digital-banking/ways-to-bank/net-banking.html",
    bankImgUrl:
        "https://skyerglobalinvestment.com/uploads/news/1611249270.jfif",
  ),
  BankObject(
    bankName: "Airtel Payments Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWeqhu0X0decTgqLEkDEcMVuMxbjb3KeGmIV4ItVvmI9r-MlVVxb0gYXJeMZFcxiAIcdg&usqp=CAU",
  ),
  BankObject(
    bankName: "Bank of India",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://www.thebusinessquiz.com/wp-content/uploads/2014/11/Bank-of-India-logo.png",
  ),
  BankObject(
    bankName: "Bank of Baroda",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://media.glassdoor.com/sqll/38315/bank-of-baroda-squarelogo.png",
  ),
  BankObject(
    bankName: "Central Bank of India",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://play-lh.googleusercontent.com/KCWCkEKN0sERmBkX3pUqzd3Q4tDNgPhX1D9NThalHNf5mwYMw04WlZgNkFVq-yhA1lo=w280-h280",
  ),
  BankObject(
    bankName: "Canara Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://pbs.twimg.com/profile_images/459208729234116608/e4jxHOu9_400x400.png",
  ),
  BankObject(
    bankName: "Corporation Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://www.logosurfer.com/wp-content/uploads/2018/03/Corporation20Bank20Logo.jpg",
  ),
  BankObject(
    bankName: "Dena Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "http://www.logotaglines.com/wp-content/uploads/2016/08/Dena-Bank-Logo.png",
  ),
  BankObject(
    bankName: "Deutsche Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://media2.vault.com/14343906/210709_deutsche-bank_logo.png",
  ),
  BankObject(
    bankName: "Dhanlaxmi Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://kikkidu.com/wp-content/uploads/2010/12/DhanLaxmiBank.jpg",
  ),
  BankObject(
    bankName: "IDBI Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl: "https://s3-symbol-logo.tradingview.com/idbi-bank--600.png",
  ),
  BankObject(
    bankName: "Indian Overseas Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://www.deccanherald.com/sites/dh/files/article_images/2020/05/19/uciMr62n-1522282384-1581451263.jpg",
  ),
  BankObject(
    bankName: "Indusind Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/ztlyxtseicvaxibzg3cv",
  ),
  BankObject(
    bankName: "Karnataka Bank",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://www.logotaglines.com/wp-content/uploads/2016/07/karnatakabank1-e1487656527748.jpg",
  ),
  BankObject(
    bankName: "Karur Vysya",
    bankUrl: "https://www.google.com/",
    bankImgUrl:
        "https://cracku.in/latest-govt-jobs/wp-content/uploads/2019/09/karur-vysya-bank-logo.jpg",
  ),
];

List<BankObject> filteredBanks = [];
