#import "TTTGameController.h"

@interface TTTGameController ()
{
  NSMutableArray *matrix;
  int numberOfMoves;
}

@end

@implementation TTTGameController

- (instancetype)init
{
  self = [super init];
  if (!self) { return nil; }

  [self resetMatrix];

  numberOfMoves = 0;

  return self;
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)checkWinningCondition:(int)row column:(int)column
{

}

- (void)printMatrix
{
  NSLog(
    @"\n%@ %@ %@\n%@ %@ %@\n%@ %@ %@",
    matrix[0][0], matrix[0][1], matrix[0][2],
    matrix[1][0], matrix[1][1], matrix[1][2],
    matrix[2][0], matrix[2][1], matrix[2][2]
  );
}

- (void)registerMove:(NSNumber *)value row:(int)row column:(int)column
{
  NSMutableArray *array = [matrix objectAtIndex:row];
  [array replaceObjectAtIndex:column withObject:value];
}

- (void)resetMatrix
{
  matrix = [NSMutableArray array];
  for (int i = 0; i < 3; i++) {
    [matrix addObject:[NSMutableArray arrayWithObjects:@9, @9, @9, nil]];
  }
}

#pragma mark - Protocols

#pragma mark - Protocols TTTBoxProtocol

- (void)boxTappedWithValues:(NSDictionary *)coordinates
        completion:(void (^)(NSNumber *value))completion
{
  NSNumber *value = @(numberOfMoves % 2);
  completion(value);

  int column = [coordinates[@"column"] intValue];
  int row = [coordinates[@"row"] intValue];
  [self registerMove:value row:row column:column];

  numberOfMoves++;

  if (numberOfMoves >= 5) {
    [self checkWinningCondition:row column:column];
  }

  [self printMatrix];
}

@end
