#import "TTTPlayerMove.h"

@implementation TTTPlayerMove

- (instancetype)initWithValue:(NSNumber *)value row:(int)row column:(int)column
{
  self = [super init];
  if (!self) { return nil; }

  self.column = column;
  self.row = row;
  self.value = value;

  return self;
}

@end
