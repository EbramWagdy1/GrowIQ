class PlantConfig {
  static const Map<String, Map<String, Map<String, double>>>
  defaultThresholds = {
    "Tomato": {
      "air temperature": {
        "min": 18.0,
        "max": 27.0,
      }, // الحرارة المثالية لعقد الثمار
      "humidity": {
        "min": 50.0,
        "max": 70.0,
      }, // الرطوبة العالية تسبب أمراض فطرية
      "soil moisture": {"min": 60.0, "max": 80.0}, // الطماطم محبة للماء بانتظام
      "soil temperature": {"min": 18.0, "max": 24.0},
      "light level": {"min": 15000.0, "max": 30000.0}, // تحتاج إضاءة قوية جداً
      "air quality": {
        "min": 0.0,
        "max": 400.0,
      }, // CO2 المرتفع مفيد لكن التلوث ضار
    },
    "Mint": {
      "air temperature": {"min": 15.0, "max": 25.0},
      "humidity": {"min": 60.0, "max": 80.0},
      "soil moisture": {
        "min": 70.0,
        "max": 85.0,
      }, // النعناع يفضل التربة الرطبة جداً
      "soil temperature": {"min": 15.0, "max": 22.0},
      "light level": {"min": 8000.0, "max": 15000.0}, // ينمو في الظل الجزئي
      "air quality": {"min": 0.0, "max": 350.0},
    },
    "Lettuce": {
      "air temperature": {
        "min": 12.0,
        "max": 22.0,
      }, // نبات شتوي، الحرارة العالية تجعله مراً
      "humidity": {"min": 50.0, "max": 70.0},
      "soil moisture": {"min": 50.0, "max": 70.0},
      "soil temperature": {"min": 10.0, "max": 18.0},
      "light level": {"min": 10000.0, "max": 18000.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
    "Basil": {
      "air temperature": {"min": 20.0, "max": 30.0}, // الريحان استوائي بامتياز
      "humidity": {"min": 45.0, "max": 65.0},
      "soil moisture": {"min": 50.0, "max": 70.0},
      "soil temperature": {"min": 20.0, "max": 26.0},
      "light level": {"min": 12000.0, "max": 25000.0},
      "air quality": {"min": 0.0, "max": 350.0},
    },
    "Pepper": {
      "air temperature": {
        "min": 21.0,
        "max": 32.0,
      }, // يحتاج حرارة أعلى من الطماطم
      "humidity": {"min": 50.0, "max": 65.0},
      "soil moisture": {"min": 55.0, "max": 75.0},
      "soil temperature": {"min": 20.0, "max": 28.0},
      "light level": {"min": 15000.0, "max": 35000.0},
      "air quality": {"min": 0.0, "max": 400.0},
    },
    "Cucumber": {
      "air temperature": {"min": 22.0, "max": 30.0},
      "humidity": {
        "min": 70.0,
        "max": 90.0,
      }, // الخيار يحتاج رطوبة جوية عالية جداً
      "soil moisture": {"min": 65.0, "max": 85.0},
      "soil temperature": {"min": 20.0, "max": 26.0},
      "light level": {"min": 12000.0, "max": 22000.0},
      "air quality": {"min": 0.0, "max": 350.0},
    },
    "Strawberry": {
      "air temperature": {"min": 15.0, "max": 25.0},
      "humidity": {"min": 55.0, "max": 75.0},
      "soil moisture": {"min": 50.0, "max": 70.0},
      "soil temperature": {
        "min": 14.0,
        "max": 20.0,
      }, // جذور الفراولة حساسة للحرارة
      "light level": {"min": 15000.0, "max": 25000.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
    "Spinach": {
      "air temperature": {
        "min": 10.0,
        "max": 21.0,
      }, // حساس جداً للحرارة (يزهر بسرعة إذا ارتفعت)
      "humidity": {"min": 50.0, "max": 70.0},
      "soil moisture": {"min": 45.0, "max": 65.0},
      "soil temperature": {"min": 7.0, "max": 16.0},
      "light level": {"min": 8000.0, "max": 15000.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
    "Spinh": {
      "air temperature": {
        "min": 10.0,
        "max": 21.0,
      }, // حساس جداً للحرارة (يزهر بسرعة إذا ارتفعت)
      "humidity": {"min": 50.0, "max": 70.0},
      "soil moisture": {"min": 45.0, "max": 65.0},
      "soil temperature": {"min": 7.0, "max": 16.0},
      "light level": {"min": 8000.0, "max": 15000.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
    "Spch": {
      "air temperature": {
        "min": 10.0,
        "max": 21.0,
      }, // حساس جداً للحرارة (يزهر بسرعة إذا ارتفعت)
      "humidity": {"min": 50.0, "max": 70.0},
      "soil moisture": {"min": 45.0, "max": 65.0},
      "soil temperature": {"min": 7.0, "max": 16.0},
      "light level": {"min": 8000.0, "max": 15000.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
  };
}
