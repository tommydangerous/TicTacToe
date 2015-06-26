#import "TTTScoreView.h"

#import "FBShimmeringView.h"

@interface TTTScoreView ()
{
  FBShimmeringView *player1Name;
  UILabel *player1Score;
  FBShimmeringView *player2Name;
  UILabel *player2Score;
}

@end

@implementation TTTScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (!self) { return nil; }

  [self createPlayerLabels];

  return self;
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
    shimmeringView.shimmering = YES;

    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(
      width * [value[1] intValue], 20 + CGRectGetHeight(label.frame),
      width, (height - CGRectGetHeight(label.frame)) - 20
    )];
    score.font = label.font;
    score.text = @"0";
    score.textAlignment = label.textAlignment;
    [self addSubview: score];

    if ([value[0] intValue] == 1) {
      player1Name = shimmeringView;
      player1Score = score;
    } else {
      player2Name = shimmeringView;
      player2Score = score;
    }
  }
}

@end
