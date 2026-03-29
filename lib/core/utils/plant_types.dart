class PlantConfig {
  static const Map<String, Map<String, Map<String, double>>>
  defaultThresholds = {
    "Tomato": {
      "air temperature": {
        "min": 18.0,
        "max": 27.0,
      },
      "humidity": {
        "min": 50.0,
        "max": 70.0,
      },
      "soil moisture": {"min": 60.0, "max": 80.0},
      "soil temperature": {"min": 18.0, "max": 24.0},
      "light level": {"min": 70.0, "max": 95.0}, // إضاءة قوية جداً
      "air quality": {
        "min": 0.0,
        "max": 400.0,
      },
    },
    "Mint": {
      "air temperature": {"min": 15.0, "max": 25.0},
      "humidity": {"min": 60.0, "max": 80.0},
      "soil moisture": {
        "min": 70.0,
        "max": 85.0,
      },
      "soil temperature": {"min": 15.0, "max": 22.0},
      "light level": {"min": 40.0, "max": 70.0}, // ظل جزئي
      "air quality": {"min": 0.0, "max": 350.0},
    },
    "Lettuce": {
      "air temperature": {
        "min": 12.0,
        "max": 22.0,
      },
      "humidity": {"min": 50.0, "max": 70.0},
      "soil moisture": {"min": 50.0, "max": 70.0},
      "soil temperature": {"min": 10.0, "max": 18.0},
      "light level": {"min": 50.0, "max": 80.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
    "Basil": {
      "air temperature": {"min": 20.0, "max": 30.0},
      "humidity": {"min": 45.0, "max": 65.0},
      "soil moisture": {"min": 50.0, "max": 70.0},
      "soil temperature": {"min": 20.0, "max": 26.0},
      "light level": {"min": 60.0, "max": 90.0},
      "air quality": {"min": 0.0, "max": 350.0},
    },
    "Pepper": {
      "air temperature": {
        "min": 21.0,
        "max": 32.0,
      },
      "humidity": {"min": 50.0, "max": 65.0},
      "soil moisture": {"min": 55.0, "max": 75.0},
      "soil temperature": {"min": 20.0, "max": 28.0},
      "light level": {"min": 75.0, "max": 100.0},
      "air quality": {"min": 0.0, "max": 400.0},
    },
    "Cucumber": {
      "air temperature": {"min": 22.0, "max": 30.0},
      "humidity": {
        "min": 70.0,
        "max": 90.0,
      },
      "soil moisture": {"min": 65.0, "max": 85.0},
      "soil temperature": {"min": 20.0, "max": 26.0},
      "light level": {"min": 60.0, "max": 85.0},
      "air quality": {"min": 0.0, "max": 350.0},
    },
    "Strawberry": {
      "air temperature": {"min": 15.0, "max": 25.0},
      "humidity": {"min": 55.0, "max": 75.0},
      "soil moisture": {"min": 50.0, "max": 70.0},
      "soil temperature": {
        "min": 14.0,
        "max": 20.0,
      },
      "light level": {"min": 70.0, "max": 90.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
    "Spinach": {
      "air temperature": {
        "min": 10.0,
        "max": 21.0,
      },
      "humidity": {"min": 50.0, "max": 70.0},
      "soil moisture": {"min": 45.0, "max": 65.0},
      "soil temperature": {"min": 7.0, "max": 16.0},
      "light level": {"min": 40.0, "max": 70.0},
      "air quality": {"min": 0.0, "max": 300.0},
    },
  };
}
