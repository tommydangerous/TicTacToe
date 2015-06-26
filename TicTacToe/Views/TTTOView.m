#import "TTTOView.h"

@implementation TTTOView

- (instancetype)initWithFrame:(CGRect)frame
{
  float fullDimension = CGRectGetWidth(frame);
  float dimension = pow(pow(fullDimension, 2) / 2, 0.5);

  CGRect newFrame = CGRectMake(
    (fullDimension - dimension) * 0.5, (fullDimension - dimension) * 0.5,
    dimension, dimension
  );

  self = [super initWithFrame:newFrame];
  if (!self) { return nil; }

  self.layer.cornerRadius = dimension * 0.5;
  self.layer.borderColor = [UIColor blueColor].CGColor;
  self.layer.borderWidth = 3;

  return self;
}

@end
