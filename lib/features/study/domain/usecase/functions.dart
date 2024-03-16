part of study;

enum Reward { small, medium, large }

int getReward(Reward reward) {
  var maxReward = switch (reward) {
    Reward.small => 50,
    Reward.medium => 200,
    Reward.large => 1000
  };
  return maxReward +
      Random(Timeline.now).nextInt(50) *
          switch (Random(Timeline.now).nextInt(100)) {
            <= 70 => 1,
            > 70 && <= 85 => 2,
            > 85 && <= 95 => 3,
            _ => 4
          };
}
