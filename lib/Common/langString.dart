class BaseLang {
  static LANG currentLang = LANG.ENGLISH;
  static String getSelectLang() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.selectLanguage
        : EnglishLang.selectLanguage;
  }

  static String getLanguageSelection() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.languageSelection
        : EnglishLang.languageSelection;
  }

  static String getSignUp() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.signUp
        : EnglishLang.signUp;
  }

  static String getLogin() {
    return currentLang == LANG.MARATHI ? MarathiLang.login : EnglishLang.login;
  }

  static String getMobileNo() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.mobileNo
        : EnglishLang.mobileNo;
  }

  static String getOtp() {
    return currentLang == LANG.MARATHI ? MarathiLang.otp : EnglishLang.otp;
  }

  static String getFullName() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.fullName
        : EnglishLang.fullName;
  }

  static String getLocation() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.location
        : EnglishLang.location;
  }

  static String getLandSizeOwned() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.landSizeOwned
        : EnglishLang.landSizeOwned;
  }

  static String getBigha() {
    return currentLang == LANG.MARATHI ? MarathiLang.bigha : EnglishLang.bigha;
  }

  static String getState() {
    return currentLang == LANG.MARATHI ? MarathiLang.state : EnglishLang.state;
  }

  static String getDistrict() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.district
        : EnglishLang.district;
  }

  static String getSubmit() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.submit
        : EnglishLang.submit;
  }

  static String getAreaTobBeSearched() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.areaToBeSearched
        : EnglishLang.areaToBeSearched;
  }

  static String getNearestMandiName() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.nearestMandiName
        : EnglishLang.nearestMandiName;
  }

  static String getTypeToSearch() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.typeToSearch
        : EnglishLang.typeToSearch;
  }

  static String getYesterday() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.yesterday
        : EnglishLang.yesterday;
  }

  static String getToday() {
    return currentLang == LANG.MARATHI ? MarathiLang.today : EnglishLang.today;
  }

  static String getKg() {
    return currentLang == LANG.MARATHI ? MarathiLang.kg : EnglishLang.kg;
  }

  static String getValue() {
    return currentLang == LANG.MARATHI ? MarathiLang.value : EnglishLang.value;
  }

  static String getChange() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.change
        : EnglishLang.change;
  }

  static String getSell() {
    return currentLang == LANG.MARATHI ? MarathiLang.sell : EnglishLang.sell;
  }

  static String getPrice() {
    return currentLang == LANG.MARATHI ? MarathiLang.price : EnglishLang.price;
  }

  static String getPriceDetail() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.priceDetail
        : EnglishLang.priceDetail;
  }

  static String getMandiName() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.mandiName
        : EnglishLang.mandiName;
  }

  static String getLowest() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.lowest
        : EnglishLang.lowest;
  }

  static String getHighest() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.highest
        : EnglishLang.highest;
  }

  static String getThisMonthsPrice() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.thisMonthsPrice
        : EnglishLang.thisMonthsPrice;
  }

  static String getThisMonthsGraph() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.thisMonthsPrice
        : EnglishLang.thisMonthsPrice;
  }

  static String getCalculateIncome() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.calculateIncome
        : EnglishLang.calculateIncome;
  }

  static String getSellNow() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.sellNow
        : EnglishLang.sellNow;
  }

  static String getSellLater() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.sellLater
        : EnglishLang.sellLater;
  }

  static String getProduct() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.product
        : EnglishLang.product;
  }

  static String getQuantity() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.quantity
        : EnglishLang.quantity;
  }

  static String getTotalCost() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.totalCost
        : EnglishLang.totalCost;
  }

  static String getProfit() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.profit
        : EnglishLang.profit;
  }

  static String getExtraCost() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.extraCost
        : EnglishLang.extraCost;
  }

  static String getSelectDate() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.selectDate
        : EnglishLang.selectDate;
  }

  static String getExpectedPrice() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.expectedPrice
        : EnglishLang.expectedPrice;
  }

  static String getTrackSells() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.trackSells
        : EnglishLang.trackSells;
  }

  static String getSellHistory() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.sellHistory
        : EnglishLang.sellHistory;
  }

  static String getSupport() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.support
        : EnglishLang.support;
  }

  static String getLogout() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.logout
        : EnglishLang.logout;
  }

  static String getSales() {
    return currentLang == LANG.MARATHI ? MarathiLang.sales : EnglishLang.sales;
  }

  static String getGoods() {
    return currentLang == LANG.MARATHI ? MarathiLang.goods : EnglishLang.goods;
  }

  static String getStatus() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.status
        : EnglishLang.status;
  }

  static String getmMrathi() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.marathi
        : EnglishLang.marathi;
  }

  static String getHome() {
    return currentLang == LANG.MARATHI ? MarathiLang.home : EnglishLang.home;
  }

  static String getmy_location() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.my_location
        : EnglishLang.my_location;
  }

  static String getSelect_State() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.select_state
        : EnglishLang.select_state;
  }

  static String getSelect_City() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.select_city
        : EnglishLang.select_city;
  }

  static String getEnter_Product_Name() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.enter_product_name
        : EnglishLang.enter_product_name;
  }

  static String getenter_quantity() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.enter_quantity
        : EnglishLang.enter_quantity;
  }

  static String getselect_date() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.select_date
        : EnglishLang.select_date;
  }

  static String getsales_history() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.sales_history
        : EnglishLang.sales_history;
  }

  static String getfarmer_name() {
    return currentLang == LANG.MARATHI
        ? MarathiLang.farmer_name
        : EnglishLang.farmer_name;
  }
}

enum LANG { MARATHI, ENGLISH }

class MarathiLang {
  static String selectLanguage = "कृपया आपली भाषा निवडा:";
  static String languageSelection = "भाषा निवड";
  static String signUp = "नोंदणी करा";
  static String login = "लॉगिन";
  static String mobileNo = "मोबाईल क्रमांक";
  static String otp = "ओटीपी";
  static String fullName = "पूर्ण नाव";
  static String location = "स्थान";
  static String landSizeOwned = "जमीन आकार मालकीचा:";
  static String bigha = "एकर";
  static String state = "राज्य";
  static String district = "जिल्हा";
  static String submit = "प्रस्तुत करणे";
  static String areaToBeSearched = "शोधले जाणारे क्षेत्र";
  static String nearestMandiName = "जवळचे मंडी नाव";
  static String typeToSearch = "शोधा टाइप करा";
  static String yesterday = "काल";
  static String today = "आज";
  static String kg = "किलो";
  static String value = "मूल्य";
  static String change = "बदला";
  static String sell = "विक्री करा";
  static String price = "किंमत";
  static String priceDetail = "किंमत तपशील";
  static String mandiName = "मंडी नाव";
  static String lowest = "सर्वात कमी";
  static String highest = "सर्वोच्च";
  static String thisMonthsPrice = "या महिन्याची किंमत";
  static String thisMonthsGraph = "या महिन्याचा आलेख";
  static String calculateIncome = "उत्पन्नाची गणना करा";
  static String sellNow = "आता विक्री करा";
  static String sellLater = "नंतर विक्री करा";
  static String product = "उत्पादन";
  static String quantity = "प्रमाण";
  static String totalCost = "एकूण किंमत";
  static String profit = "नफा";
  static String extraCost = "अतिरिक्त किंमत";
  static String selectDate = "तारीख निवडा";
  static String expectedPrice = "अपेक्षित किंमत";
  static String trackSells = "तपशील विक्री";
  static String sellHistory = "विक्री इतिहास";
  static String support = "आधार";
  static String logout = "बाहेर पडणे";
  static String sales = "इतिहास विक्री";
  static String goods = "वस्तू";
  static String status = "स्थिती";
  static String marathi = "मराठी";
  static String home = "होम";
  static String my_location = "माझे स्थान";
  static String select_state = "राज्य निवडा";
  static String select_city = "शहर निवडा";
  static String enter_product_name = "उत्पादन नाव प्रविष्ट करा";
  static String enter_quantity = "प्रमाण प्रविष्ट करा";
  static String select_date = "तारीख निवडा";
  static String sales_history = "इतिहास विक्री करा";
  static String farmer_name = "शेतकरी नाव";
}

class EnglishLang {
  static String selectLanguage = "Please Select Your Language:";
  static String languageSelection = "Language Selection";
  static String signUp = "Register";
  static String login = "Login";
  static String mobileNo = "Mobile No";
  static String otp = "OTP";
  static String fullName = "Full Name";
  static String location = "Location";
  static String landSizeOwned = "Land Size Owned:";
  static String bigha = "Acre";
  static String state = "State";
  static String district = "District";
  static String submit = "Submit";
  static String areaToBeSearched = "Area to be Searched";
  static String nearestMandiName = "Nearest Mandi Name";
  static String typeToSearch = "Type to Search";
  static String yesterday = "yesterday";
  static String today = "today";
  static String kg = "Quintal";
  static String value = "Value";
  static String change = "Change";
  static String sell = "Sell";
  static String price = "Price";
  static String priceDetail = "Price Detail";
  static String mandiName = "Mandi Name";
  static String lowest = "Lowest";
  static String highest = "Highest";
  static String thisMonthsPrice = "This Month's Price";
  static String thisMonthsGraph = "This Month's Graph";
  static String calculateIncome = "Calculate Income";
  static String sellNow = "Sell Now";
  static String sellLater = "Sell Later";
  static String product = "Product";
  static String quantity = "Quantity";
  static String totalCost = "Total Cost";
  static String profit = "Profit";
  static String extraCost = "Extra Cost";
  static String selectDate = "Select Date";
  static String expectedPrice = "Expected Price";
  static String trackSells = "Track Sales";
  static String sellHistory = "Sells History";
  static String support = "Support";
  static String logout = "Logout";
  static String sales = "Track Sales";
  static String goods = "Goods";
  static String status = "Status";
  static String marathi = "MARATHI";
  static String home = "Home";
  static String my_location = "My Location";
  static String select_state = "Select State";
  static String select_city = "Select City";
  static String enter_product_name = "Enter Product Name";
  static String enter_quantity = "Enter Quantity";
  static String select_date = "Select Date";
  static String sales_history = "Select/History";
  static String farmer_name = "Farmer Name";
}
