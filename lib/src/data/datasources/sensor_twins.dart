import 'dart:math';

class SensorTwins {
  final Random random = Random();
  static const int maxTemp = 40; // допустимая максимальная температура
  static const int minTemp = -40; // допустимая минимальная температура
  late double currTemp; // текущая температура
  late double currHumid; // текущая влажность
  late int steps = 0; // кол-во шагов
  static const Duration delayedDuration = Duration(seconds: 1); // задержка шага
  // Текущий диапазон температуры
  final Map<String, int> currentRange = {
    'max': 0,
    'min': 0,
  };

  // генерирует начальную температуру
  void initStartTemp() {
    currTemp = random.nextDouble() + random.nextInt(maxTemp) - random.nextInt(minTemp.abs());
  }

  // генерирует количество шагов
  void genSteps() {
    steps = 1 + random.nextInt(10);
  }

  // генерирует диапазон значений
  void genRange() {
    final int delta;
    delta = 1 + random.nextInt(3);

    final int nextMaxTemp = (currTemp + delta).round();
    if (nextMaxTemp < maxTemp) {
      currentRange['max'] = nextMaxTemp;
    } else {
      currentRange['max'] = maxTemp;
    }

    final int nextMinTemp = (currTemp - delta).round();
    if (nextMinTemp > minTemp) {
      currentRange['min'] = nextMinTemp;
    } else {
      currentRange['min'] = minTemp;
    }
  }

  // генерирует текущую температуру
  double genCurrTemp() {
    final int minRange = currentRange['min']!;
    int a = currentRange['max']! - minRange;

    currTemp = minRange + (random.nextInt(a) - random.nextDouble()).abs();
    steps = steps - 1;

    return currTemp;
  }

  // генерирует текущую относительную влажность
  double genCurrHumidity() {
    final double currE = 6.11 * exp((17.67 * currTemp) / (currTemp + 243.5));
    final double dewPoint = currTemp / 1.5;
    final double currEs = 6.11 * exp((17.67 * dewPoint) / (dewPoint + 243.5));
    currHumid = 100 * currE / currEs;

    return currHumid / 2.15 - 5;
  }

  // функция для изменения текущего значения (быстрое и среднее изменение)
  Future<bool> changeCurrTemp() async {
    final double chance = random.nextDouble();
    const double maxChangeChance = 0.05;

    if (chance <= maxChangeChance) {
      steps = 2 + random.nextInt(4);
      final int sign = random.nextDouble() <= 0.55 ? 1 : -1;
      while (steps > 0) {
        double changeTemp = currTemp + sign * (3 + random.nextInt(6));
        if (changeTemp > maxTemp) {
          currTemp = maxTemp.toDouble();
          break;
        } else if (changeTemp < minTemp) {
          currTemp = minTemp.toDouble();
          break;
        } else {
          currTemp = changeTemp;
        }
        genCurrTemp();
        genCurrHumidity();
        steps = steps - 1;
        await Future.delayed(delayedDuration);
      }

      return true;
    } else if (chance > maxChangeChance && chance <= 0.25) {
      steps = 1 + random.nextInt(5);
      final int sign = random.nextDouble() <= 0.55 ? 1 : -1;
      while (steps > 0) {
        double changeTemp = currTemp + sign * (1 + random.nextInt(3));
        if (changeTemp > maxTemp) {
          currTemp = maxTemp.toDouble();
          break;
        } else if (changeTemp < minTemp) {
          currTemp = minTemp.toDouble();
          break;
        } else {
          currTemp = changeTemp;
        }

        genCurrTemp();
        genCurrHumidity();
        steps = steps - 1;
        await Future.delayed(delayedDuration);
      }

      return true;
    }

    return false;
  }

  // функция для запуска двойника
  void activityTwin() async {
    initStartTemp();
    while (true) {
      if (steps == 0) {
        if (await changeCurrTemp()) {
          continue;
        }
        genSteps();
        genRange();
      }
      genCurrTemp();
      genCurrHumidity();

      await Future.delayed(delayedDuration);
    }
  }
}

void main() async {
  final SensorTwins digitalTwin = SensorTwins();
  digitalTwin.activityTwin();
}
