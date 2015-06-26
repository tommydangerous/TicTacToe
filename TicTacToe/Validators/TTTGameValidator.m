#import "TTTGameValidator.h"

// Constants
#import "TTTGameConstants.h"

// Models
#import "TTTPlayerMove.h"

@implementation TTTGameValidator

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (TTTGameValidatorResult)isGameOver:(TTTPlayerMove *)playerMove
                          matrix:(NSArray *)matrix
                          numberOfMoves:(int)numberOfMoves
{
  NSNumber *consecutive = @1;
  [self checkHorizontal:playerMove matrix:matrix consecutive:&consecutive];

  if ([consecutive intValue] < GameNeededToWin) {
    [self checkVertical:playerMove matrix:matrix consecutive:&consecutive];
  }

  if ([consecutive intValue] >= GameNeededToWin) {
    if ([playerMove.value intValue] == 0) {
      return TTTGameValidatorResultPlayer1Victory;
    } else {
      return TTTGameValidatorResultPlayer2Victory;
    }
  } else if (numberOfMoves >= GameRows * GameColumns) {
    return TTTGameValidatorResultTieGame;
  }

  return TTTGameValidatorResultIncomplete;
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)checkHorizontal:(TTTPlayerMove *)playerMove
        matrix:(NSArray *)matrix
        consecutive:(NSNumber **)consecutive
{
  int leftPointer = playerMove.column;
  while (leftPointer > 0) {
    leftPointer--;
    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:playerMove.row] objectAtIndex:leftPointer];
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }

  int rightPointer = playerMove.column;
  while (rightPointer < GameColumns - 1) {
    rightPointer++;
    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:playerMove.row] objectAtIndex:rightPointer];
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }
}

- (void)checkVertical:(TTTPlayerMove *)playerMove
        matrix:(NSArray *)matrix
        consecutive:(NSNumber **)consecutive
{
  int topPointer = playerMove.row;
  while (topPointer > 0) {
    topPointer--;
    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:topPointer] objectAtIndex:playerMove.column];
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }

  int bottomPointer = playerMove.row;
  while (bottomPointer < GameRows - 1) {
    bottomPointer++;
    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:bottomPointer] objectAtIndex:playerMove.column];
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }
}

@end
