import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'GrowIQ'**
  String get appName;

  /// No description provided for @appNamed.
  ///
  /// In en, this message translates to:
  /// **'GᵣₒwᵢQ'**
  String get appNamed;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'The Future of Smart Growth'**
  String get appSlogan;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'GrowIQ'**
  String get splashTitle;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The Future of Smart Growth'**
  String get splashSubtitle;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Manual Farming Is Hard'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'More effort, more time, and less control'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Needs Constant Attention'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Manual monitoring leads to mistakes and waste'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Smart Farming with GrowIQ'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Monitor, control, and grow better with AI'**
  String get onboardingDesc3;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Password'**
  String get confirmPassword;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back !'**
  String get loginSubtitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account !'**
  String get signupSubtitle;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code sent to your email'**
  String get otpSubtitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guestUser;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @soilMoisture.
  ///
  /// In en, this message translates to:
  /// **'Soil Moisture'**
  String get soilMoisture;

  /// No description provided for @waterLevel.
  ///
  /// In en, this message translates to:
  /// **'Water Level'**
  String get waterLevel;

  /// No description provided for @control.
  ///
  /// In en, this message translates to:
  /// **'Control'**
  String get control;

  /// No description provided for @devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get devices;

  /// No description provided for @deviceStatus.
  ///
  /// In en, this message translates to:
  /// **'Device Status'**
  String get deviceStatus;

  /// No description provided for @turnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn On'**
  String get turnOn;

  /// No description provided for @turnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn Off'**
  String get turnOff;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get device;

  /// No description provided for @deviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Device Details'**
  String get deviceDetails;

  /// No description provided for @addDevice.
  ///
  /// In en, this message translates to:
  /// **'Add Device'**
  String get addDevice;

  /// No description provided for @removeDevice.
  ///
  /// In en, this message translates to:
  /// **'Remove Device'**
  String get removeDevice;

  /// No description provided for @farmAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Farm added successfully!'**
  String get farmAddedSuccess;

  /// No description provided for @checkingDevices.
  ///
  /// In en, this message translates to:
  /// **'Checking for devices...'**
  String get checkingDevices;

  /// No description provided for @noFarmsLinked.
  ///
  /// In en, this message translates to:
  /// **'No Farms Linked Yet'**
  String get noFarmsLinked;

  /// No description provided for @addYourDevice.
  ///
  /// In en, this message translates to:
  /// **'Add Your Device'**
  String get addYourDevice;

  /// No description provided for @enterDeviceId.
  ///
  /// In en, this message translates to:
  /// **'Enter Device ID'**
  String get enterDeviceId;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @addNewFarm.
  ///
  /// In en, this message translates to:
  /// **'Add New Farm'**
  String get addNewFarm;

  /// No description provided for @personalassistant.
  ///
  /// In en, this message translates to:
  /// **'Personal assistant'**
  String get personalassistant;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @slogn.
  ///
  /// In en, this message translates to:
  /// **'I’m Your Personal assistant,How can I help you?'**
  String get slogn;

  /// No description provided for @chatbt.
  ///
  /// In en, this message translates to:
  /// **'Let’s chat!'**
  String get chatbt;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @chatbot.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get chatbot;

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Ask GrowIQ assistant...'**
  String get chatHint;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message here...'**
  String get typeMessage;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello! Welcome to GrowIQ AI'**
  String get welcomeMessage;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabicPrompt.
  ///
  /// In en, this message translates to:
  /// **'تحدث بالعربية فقط. أنت مساعد GrowIQ الزراعي. اكتب النص التالي بدقة:\nأنا هنا لمساعدتك في إدارة محاصيلك وتربتك ونظام الري بدقة وعناية. كيف يمكنني مساعدتك اليوم؟\nهل تبحث عن نصائح بخصوص:\n١. جدولة الري\n٢. صحة التربة وإدارة العناصر الغذائية\n٣. اختيار المحاصيل وتخطيطها\n٤. مكافحة الآفات والأمراض\n٥. أي شيء آخر؟'**
  String get arabicPrompt;

  /// No description provided for @englishPrompt.
  ///
  /// In en, this message translates to:
  /// **'Speak English only. Act as GrowIQ assistant. Write exactly:\nI\'m here to help you manage your crops, soil, and irrigation with precision and care. How can I assist you today?\nAre you looking for advice on:\n1. Irrigation scheduling\n2. Soil health and nutrient management\n3. Crop selection and planning\n4. Pest and disease control\n5. Something else?'**
  String get englishPrompt;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @aboutGrowIQTitle.
  ///
  /// In en, this message translates to:
  /// **'About GrowIQ'**
  String get aboutGrowIQTitle;

  /// No description provided for @aboutGrowIQDesc.
  ///
  /// In en, this message translates to:
  /// **'GrowIQ is a smart farming system that combines IoT sensors, Firebase, and machine learning to help users monitor and control their environment easily. The ESP device sends real-time sensor data to Firebase, while the mobile app allows users to view readings and control the system manually or automatically. In auto mode, a machine learning model adjusts the system based on live conditions to maintain the best environment for plant growth.'**
  String get aboutGrowIQDesc;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile Updated Successfully'**
  String get profileUpdatedSuccess;

  /// No description provided for @ourTeam.
  ///
  /// In en, this message translates to:
  /// **'Our Team'**
  String get ourTeam;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No Email'**
  String get noEmail;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get errorPrefix;

  /// No description provided for @noDevicesFound.
  ///
  /// In en, this message translates to:
  /// **'No devices found'**
  String get noDevicesFound;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Edit Name'**
  String get editName;

  /// No description provided for @deleteDevice.
  ///
  /// In en, this message translates to:
  /// **'Delete Device'**
  String get deleteDevice;

  /// No description provided for @deviceOffline.
  ///
  /// In en, this message translates to:
  /// **'Device is Offline'**
  String get deviceOffline;

  /// No description provided for @environmentalOverview.
  ///
  /// In en, this message translates to:
  /// **'Environmental Overview'**
  String get environmentalOverview;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @perfect.
  ///
  /// In en, this message translates to:
  /// **'Perfect'**
  String get perfect;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @smartControls.
  ///
  /// In en, this message translates to:
  /// **'Smart Controls'**
  String get smartControls;

  /// No description provided for @aiAutoMode.
  ///
  /// In en, this message translates to:
  /// **'AI Auto Mode'**
  String get aiAutoMode;

  /// No description provided for @aiManageFarm.
  ///
  /// In en, this message translates to:
  /// **'Let AI manage the farm'**
  String get aiManageFarm;

  /// No description provided for @renameDevice.
  ///
  /// In en, this message translates to:
  /// **'Rename Device'**
  String get renameDevice;

  /// No description provided for @enterNewName.
  ///
  /// In en, this message translates to:
  /// **'Enter new name'**
  String get enterNewName;

  /// No description provided for @deleteDeviceConfirmPrefix.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove \''**
  String get deleteDeviceConfirmPrefix;

  /// No description provided for @deleteDeviceConfirmSuffix.
  ///
  /// In en, this message translates to:
  /// **'\'?'**
  String get deleteDeviceConfirmSuffix;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectCropType.
  ///
  /// In en, this message translates to:
  /// **'Select Crop Type'**
  String get selectCropType;

  /// No description provided for @whatAreYouGrowing.
  ///
  /// In en, this message translates to:
  /// **'What are you growing in this farm?\nThis helps us set the ideal environment thresholds.'**
  String get whatAreYouGrowing;

  /// No description provided for @saveConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Save Configuration'**
  String get saveConfiguration;

  /// No description provided for @enableAiModeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Enable AI Auto Mode?'**
  String get enableAiModeQuestion;

  /// No description provided for @disableAiModeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Disable AI Auto Mode?'**
  String get disableAiModeQuestion;

  /// No description provided for @enableAiModeDesc.
  ///
  /// In en, this message translates to:
  /// **'The AI will take full control of the water pump, fans, and lights based on the selected crop\'s ideal thresholds. Manual controls will be overridden.'**
  String get enableAiModeDesc;

  /// No description provided for @disableAiModeDesc.
  ///
  /// In en, this message translates to:
  /// **'You will regain manual control over the water pump, fans, and lights. The AI will no longer automate these for you.'**
  String get disableAiModeDesc;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disable;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @followUs.
  ///
  /// In en, this message translates to:
  /// **'Follow us on social media'**
  String get followUs;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @linkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedIn;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @plantsInformation.
  ///
  /// In en, this message translates to:
  /// **'Plants Information'**
  String get plantsInformation;

  /// No description provided for @searchPlants.
  ///
  /// In en, this message translates to:
  /// **'Search plants...'**
  String get searchPlants;

  /// No description provided for @airTemperature.
  ///
  /// In en, this message translates to:
  /// **'Air Temperature'**
  String get airTemperature;

  /// No description provided for @soilTemperature.
  ///
  /// In en, this message translates to:
  /// **'Soil Temperature'**
  String get soilTemperature;

  /// No description provided for @lightLevel.
  ///
  /// In en, this message translates to:
  /// **'Light Level'**
  String get lightLevel;

  /// No description provided for @airQuality.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get airQuality;

  /// No description provided for @pump.
  ///
  /// In en, this message translates to:
  /// **'PUMP'**
  String get pump;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'LIGHT'**
  String get light;

  /// No description provided for @fan.
  ///
  /// In en, this message translates to:
  /// **'FAN'**
  String get fan;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @tomato.
  ///
  /// In en, this message translates to:
  /// **'Tomato'**
  String get tomato;

  /// No description provided for @mint.
  ///
  /// In en, this message translates to:
  /// **'Mint'**
  String get mint;

  /// No description provided for @lettuce.
  ///
  /// In en, this message translates to:
  /// **'Lettuce'**
  String get lettuce;

  /// No description provided for @basil.
  ///
  /// In en, this message translates to:
  /// **'Basil'**
  String get basil;

  /// No description provided for @pepper.
  ///
  /// In en, this message translates to:
  /// **'Pepper'**
  String get pepper;

  /// No description provided for @cucumber.
  ///
  /// In en, this message translates to:
  /// **'Cucumber'**
  String get cucumber;

  /// No description provided for @strawberry.
  ///
  /// In en, this message translates to:
  /// **'Strawberry'**
  String get strawberry;

  /// No description provided for @spinach.
  ///
  /// In en, this message translates to:
  /// **'Spinach'**
  String get spinach;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// No description provided for @changePlant.
  ///
  /// In en, this message translates to:
  /// **'Change Plant'**
  String get changePlant;

  /// No description provided for @aiModeActive.
  ///
  /// In en, this message translates to:
  /// **'AI Mode Active'**
  String get aiModeActive;

  /// No description provided for @manualMode.
  ///
  /// In en, this message translates to:
  /// **'Manual Mode'**
  String get manualMode;

  /// No description provided for @farmIsHealthy.
  ///
  /// In en, this message translates to:
  /// **'Farm is Healthy'**
  String get farmIsHealthy;

  /// No description provided for @issueDetected.
  ///
  /// In en, this message translates to:
  /// **'Issue Detected'**
  String get issueDetected;

  /// No description provided for @systemsRunningOptimally.
  ///
  /// In en, this message translates to:
  /// **'All systems are running optimally.'**
  String get systemsRunningOptimally;

  /// No description provided for @aiConfidence.
  ///
  /// In en, this message translates to:
  /// **'AI Confidence'**
  String get aiConfidence;

  /// No description provided for @orLogin.
  ///
  /// In en, this message translates to:
  /// **'or login'**
  String get orLogin;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @orSignup.
  ///
  /// In en, this message translates to:
  /// **'or signup'**
  String get orSignup;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginAction;

  /// No description provided for @forgetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPasswordTitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetPasswordButton;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your Email'**
  String get checkYourEmail;

  /// No description provided for @resetEmailSentDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a link to reset your password. Please check your email inbox and follow the instructions to create a new password.'**
  String get resetEmailSentDesc;

  /// No description provided for @didNotReceiveEmail.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive any code?'**
  String get didNotReceiveEmail;

  /// No description provided for @resendAgain.
  ///
  /// In en, this message translates to:
  /// **'Resend Again'**
  String get resendAgain;

  /// No description provided for @requestCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Request new code in'**
  String get requestCodeIn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
