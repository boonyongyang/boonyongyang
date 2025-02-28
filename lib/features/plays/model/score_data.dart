class ScoreData {
  final int score;
  final DateTime timestamp;

  ScoreData({
    required this.score,
    required this.timestamp,
  });
}

class HighScores {
  static final List<ScoreData> _scores = [];
  static int _highestScore = 0;

  static List<ScoreData> get scores => List.unmodifiable(_scores);
  static int get highestScore => _highestScore;

  static void addScore(int score) {
    _scores.add(ScoreData(
      score: score,
      timestamp: DateTime.now(),
    ));

    // Keep only top 10 scores
    if (_scores.length > 10) {
      _scores.sort((a, b) => b.score.compareTo(a.score));
      _scores.removeLast();
    }

    // Update highest score if necessary
    if (score > _highestScore) {
      _highestScore = score;
    }
  }

  static void reset() {
    _scores.clear();
    _highestScore = 0;
  }
}
