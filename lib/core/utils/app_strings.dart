abstract class AppStrings {
  /* ================= App ================= */
  static const String appName = 'GrowIQ';
  static const String appNamed = 'GᵣₒwᵢQ';
  static const String appSlogan = 'The Future of Smart Growth';

  /* ================= General ================= */
  static const String next = 'Next';
  static const String start = 'Start';
  static const String skip = 'Skip';
  static const String done = 'Done';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';
  static const String retry = 'Retry';
  static const String loading = 'Loading...';

  /* ================= Splash ================= */
  static const String splashTitle = 'GrowIQ';
  static const String splashSubtitle = 'The Future of Smart Growth';

  /* ================= Onboarding ================= */
  static const String onboardingTitle1 = 'Manual Farming Is Hard';
  static const String onboardingDesc1 =
      'More effort, more time, and less control';

  static const String onboardingTitle2 = 'Needs Constant Attention';
  static const String onboardingDesc2 =
      'Manual monitoring leads to mistakes and waste';

  static const String onboardingTitle3 = 'Smart Farming with GrowIQ';
  static const String onboardingDesc3 =
      'Monitor, control, and grow better with AI';

  /* ================= Auth ================= */
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String logout = 'Logout';
  static const String name = 'Enter Your Name';

  static const String email = 'Enter Your Email';
  static const String password = 'Enter Your Password';
  static const String confirmPassword = 'Confirm Your Password';

  static const String loginSubtitle = 'Welcome back !';
  static const String signupSubtitle = 'Create your account !';

  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';

  static const String dontHaveAccount = "Don’t have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';

  /* ================= OTP ================= */
  static const String verifyOtp = 'Verify OTP';
  static const String otpSubtitle =
      'Please enter the verification code sent to your email';

  /* ================= Home ================= */
  static const String home = 'Home';
  static const String welcome = 'Welcome';

  static const String dashboard = 'Dashboard';

  static const String temperature = 'Temperature';
  static const String humidity = 'Humidity';
  static const String soilMoisture = 'Soil Moisture';
  static const String waterLevel = 'Water Level';

  /* ================= Control ================= */
  static const String control = 'Control';
  static const String devices = 'Devices';
  static const String deviceStatus = 'Device Status';
  static const String turnOn = 'Turn On';
  static const String turnOff = 'Turn Off';

  /* ================= Device ================= */
  static const String device = 'Device';
  static const String deviceDetails = 'Device Details';
  static const String addDevice = 'Add Device';
  static const String removeDevice = 'Remove Device';

  /* ================= Chat ================= */

  static const String personalassistant = ' Personal assistant';
  static const String hello = ' Hello!';
  static const String slogn =
      ' I’m Your Personal assistant,How can I help you?';
  static const String chatbt = ' Let’s chat!';

  static const String chat = 'Chat';
  static const String chatbot = 'AI Assistant';
  static const String chatHint = 'Ask GrowIQ assistant...';
  static const String typeMessage = 'Type your message here...';
  static const String welcomeMessage = 'Hello! Welcome to GrowIQ AI';
  static const String arabic = 'Arabic';
  static const String english = 'English';

  static const String arabicPrompt =
      "تحدث بالعربية فقط. أنت مساعد GrowIQ الزراعي. اكتب النص التالي بدقة:\n"
      "أنا هنا لمساعدتك في إدارة محاصيلك وتربتك ونظام الري بدقة وعناية. كيف يمكنني مساعدتك اليوم؟\n\n"
      "هل تبحث عن نصائح بخصوص:\n"
      "١. جدولة الري\n"
      "٢. صحة التربة وإدارة العناصر الغذائية\n"
      "٣. اختيار المحاصيل وتخطيطها\n"
      "٤. مكافحة الآفات والأمراض\n"
      "٥. أي شيء آخر؟";

  static const String englishPrompt =
      "Speak English only. Act as GrowIQ assistant. Write exactly:\n"
      "I'm here to help you manage your crops, soil, and irrigation with precision and care. How can I assist you today?\n\n"
      "Are you looking for advice on:\n"
      "1. Irrigation scheduling\n"
      "2. Soil health and nutrient management\n"
      "3. Crop selection and planning\n"
      "4. Pest and disease control\n"
      "5. Something else?";

  /* ================= Profile ================= */
  static const String profile = 'Profile';
  static const String editProfile = 'Edit Profile';
  static const String myAccount = 'My Account';

  /* ================= Settings ================= */
  static const String settings = 'Settings';
  static const String notifications = 'Notifications';
  static const String language = 'Language';
  static const String darkMode = 'Dark Mode';
  static const String privacyPolicy = 'Privacy Policy';
  static const String aboutApp = 'About App';

  /* ================= About ================= */
  static const String aboutGrowIQTitle = 'About GrowIQ';

  static const String aboutGrowIQDesc = '''
  GrowIQ is a smart farming system that combines IoT sensors, Firebase, and machine learning to help users monitor and control their environment easily.The ESP device sends real-time sensor data to Firebase, while the mobile app allows users to view readings and control the system manually or automatically.In auto mode, a machine learning model adjusts the system based on live conditions to maintain the best environment for plant growth.
''';

  /* ================= Errors ================= */
  static const String somethingWentWrong = 'Something went wrong';
  static const String noInternetConnection = 'No internet connection';
  static const String invalidEmail = 'Invalid email address';
  static const String weakPassword = 'Password is too weak';
}
