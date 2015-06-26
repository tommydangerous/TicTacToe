#import "TTTGameController.h"

// Constants
#import "TTTGameConstants.h"

// Models
#import "TTTPlayerMove.h"

@interface TTTGameController ()
{
  NSMutableArray *matrix;
  int numberOfMoves;
  TTTPlayerMove *recentPlayerMove;
}

@end

@implementation TTTGameController

- (instancetype)init
{
  self = [super init];
  if (!self) { return nil; }

  [self resetGame];

  return self;
}

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)resetGame
{
  numberOfMoves = 0;
  matrix = [NSMutableArray array];
  for (int i = 0; i < GameRows; i++) {
    [matrix addObject:[NSMutableArray arrayWithObjects:@9, @9, @9, nil]];
  }
  recentPlayerMove = nil;
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)checkWinningCondition
{
  NSNumber *consecutive = @1;
  [self checkHorizontal:&consecutive];

  if ([self isGameOver:consecutive]) {
    if (_delegate && [_delegate respondsToSelector:@selector(gameComplete:)]) {
      [_delegate gameComplete:[self gameCompletionInfo:consecutive]];
    }
  }

  NSLog(@"Consecutive: %i", [consecutive intValue]);
}

- (void)checkHorizontal:(NSNumber **)consecutive
{
  int leftPointer = recentPlayerMove.column;
  while (leftPointer > 0) {
    leftPointer--;
    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:recentPlayerMove.row] objectAtIndex:leftPointer];
    if ([recentPlayerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }

  int rightPointer = recentPlayerMove.column;
  while (rightPointer < GameColumns - 1) {
    rightPointer++;
    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:recentPlayerMove.row] objectAtIndex:rightPointer];
    if ([recentPlayerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }
}

- (NSDictionary *)gameCompletionInfo:(NSNumber *)consecutive
{
  NSString *message;
  NSString *title;
  if ([consecutive intValue] >= GameNeededToWin) {
    message = [NSString stringWithFormat:@"Player %i has won",
      [recentPlayerMove.value intValue] + 1];
    title = @"Victory";
  } else if (numberOfMoves >= GameRows * GameColumns) {
    message = @"No winner this time";
    title = @"Cat's Game";
  }
  return @{
    @"message": message,
    @"title": title
  };
}

- (BOOL)isGameOver:(NSNumber *)consecutive
{
  return [consecutive intValue] >= GameNeededToWin ||
    numberOfMoves >= GameRows * GameColumns;
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

  recentPlayerMove =
    [[TTTPlayerMove alloc] initWithValue:value row:row column:column];
}

#pragma mark - Protocols

#pragma mark - Protocols TTTBoxProtocol

- (void)boxTappedWithValues:(NSDictionary *)coordinates
        completion:(void (^)(NSNumber *value))completion
{
  NSNumber *value = @(numberOfMoves % 2);
  completion(value);

  [self registerMove:value
        row:[coordinates[@"row"] intValue]
        column:[coordinates[@"column"] intValue]];

  numberOfMoves++;

  if (numberOfMoves >= (GameRows + GameColumns) - 1) {
    [self checkWinningCondition];
  }

  [self printMatrix];
}

@end
