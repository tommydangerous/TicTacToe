#import "TTTXView.h"

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

@implementation TTTXView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (!self) { return nil; }

  for (NSNumber *i in @[@45, @-45]) {
    UIView *line = [self createLine];
    CGAffineTransform transform = CGAffineTransformRotate(
      line.transform, DEGREES_TO_RADIANS([i intValue])
    );
    line.transform = transform;
    [self addSubview:line];
  }

  return self;
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (UIView *)createLine
{
  CGRect lineRect = CGRectMake(
    0, (CGRectGetHeight(self.bounds) - 5) * 0.5, CGRectGetWidth(self.bounds), 5
  );
  UIView *line = [[UIView alloc] initWithFrame:lineRect];
  line.backgroundColor = [UIColor redColor];

  return line;
}

@end
