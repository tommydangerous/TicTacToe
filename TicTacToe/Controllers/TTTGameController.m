#import "TTTGameController.h"

// Constants
#import "TTTGameConstants.h"

// Models
#import "TTTPlayerMove.h"

// Validator
#import "TTTGameValidator.h"

@interface TTTGameController ()
{
  TTTGameValidator *gameValidator;
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

  gameValidator = [TTTGameValidator new];

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
  TTTGameValidatorResult result = [gameValidator isGameOver:recentPlayerMove
                                                 matrix:matrix
                                                 numberOfMoves:numberOfMoves];

  if (result != TTTGameValidatorResultIncomplete) {
    if (_delegate && [_delegate respondsToSelector:@selector(gameComplete:)]) {
      [_delegate gameComplete:[self gameCompletionInfo:result]];
    }
  }
}

- (NSDictionary *)gameCompletionInfo:(TTTGameValidatorResult)result
{
  NSString *message;
  NSString *title;
  if (result == TTTGameValidatorResultTieGame) {
    message = @"No winner this time";
    title = @"Cat's Game";
  } else {
    int playerNumber = 1;
    if (result == TTTGameValidatorResultPlayer2Victory) {
      playerNumber = 2;
    }
    message = [NSString stringWithFormat:@"Player %i has won", playerNumber];
    title = @"Victory";
  }
  return @{
    @"message": message,
    @"title": title
  };
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
