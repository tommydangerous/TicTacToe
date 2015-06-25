#import "TTTBoxViewModel.h"

@interface TTTBoxViewModel ()
{
  CGFloat dimension;
}

@end

@implementation TTTBoxViewModel

- (instancetype)initWithDimension:(CGFloat)d row:(int)row column:(int)column
{
  self = [super init];
  if (!self) { return nil; }

  self.column = column;
  dimension = d;
  self.row = row;

  return self;
}

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (CGRect)frame
{
  return CGRectMake(
    self.column * dimension, self.row * dimension, dimension, dimension
  );
}

- (CALayer *)horizontalBorder
{
  return [self border:YES];
}

- (CALayer *)verticalBorder
{
  return [self border:NO];
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (CALayer *)border:(BOOL)horizontal
{
  CALayer *layer = [CALayer layer];
  layer.borderColor = [UIColor blackColor].CGColor;
  layer.borderWidth = 1;
  if (horizontal) {
    layer.frame = CGRectMake(0, 0, dimension, 1);
  } else {
    layer.frame = CGRectMake(0, 0, 1, dimension);
  }
  return layer;
}

@end
