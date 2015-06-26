#import "TTTScoreView.h"

#import "FBShimmeringView.h"

@interface TTTScoreView ()
{
  int currentPlayerTurn;
  FBShimmeringView *player1Name;
  int player1Score;
  UILabel *player1ScoreLabel;
  FBShimmeringView *player2Name;
  int player2Score;
  UILabel *player2ScoreLabel;
}

@end

@implementation TTTScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (!self) { return nil; }

  player1Score = 0;
  player2Score = 0;
  [self createPlayerLabels];
  [self resetPlayerTurns];

  return self;
}

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)changePlayerTurn
{
  if (currentPlayerTurn == 0) {
    currentPlayerTurn = 1;
    player1Name.shimmering = NO;
    player2Name.shimmering = YES;
  } else {
    currentPlayerTurn = 0;
    player1Name.shimmering = YES;
    player2Name.shimmering = NO;
  }
}

- (void)resetPlayerTurns
{
  currentPlayerTurn = 1;
  [self changePlayerTurn];
}

- (void)updateScores:(NSArray *)scores
{
  player1Score += [scores[0] intValue];
  player2Score += [scores[1] intValue];
  player1ScoreLabel.text = [NSString stringWithFormat:@"%i", player1Score];
  player2ScoreLabel.text = [NSString stringWithFormat:@"%i", player2Score];
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)createPlayerLabels
{
  CGFloat height = CGRectGetHeight(self.frame);
  CGFloat width = CGRectGetWidth(self.frame) * 0.5;

  for (NSArray *value in
    @[@[@1, @0, [UIColor redColor]], @[@2, @1, [UIColor blueColor]]]) {

    CGRect rect = CGRectMake(
      width * [value[1] intValue], 20, width, (height * 0.7) - 20
    );

    FBShimmeringView *shimmeringView =
      [[FBShimmeringView alloc] initWithFrame:rect];
    [self addSubview:shimmeringView];

    UILabel *label = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    label.font = [UIFont systemFontOfSize:21 weight:UIFontWeightMedium];
    label.text = [NSString stringWithFormat:@"Player %i", [value[0] intValue]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = value[2];

    shimmeringView.contentView = label;

    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(
      width * [value[1] intValue], 20 + CGRectGetHeight(label.frame),
      width, (height - CGRectGetHeight(label.frame)) - 20
    )];
    score.font = label.font;
    score.textAlignment = label.textAlignment;
    [self addSubview: score];

    if ([value[0] intValue] == 1) {
      player1Name = shimmeringView;
      player1ScoreLabel = score;
    } else {
      player2Name = shimmeringView;
      player2ScoreLabel = score;
    }
  }

  [self updateScores:@[@(player1Score), @(player2Score)]];
}

@end
