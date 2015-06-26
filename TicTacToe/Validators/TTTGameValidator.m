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
  [self check:playerMove
        matrix:matrix
        indexPointer:playerMove.column
        maximum:GameColumns - 1
        row:@(playerMove.row)
        column:nil
        consecutive:&consecutive];

  if ([consecutive intValue] < GameNeededToWin) {
    consecutive = @1;
    [self check:playerMove
          matrix:matrix
          indexPointer:playerMove.row
          maximum:GameRows - 1
          row:nil
          column:@(playerMove.column)
          consecutive:&consecutive];
  }

  NSArray *points = @[@[@-1, @-1], @[@1, @1], @[@1, @-1], @[@-1, @1]];
  for (NSArray *point in points) {
    if ([consecutive intValue] < GameNeededToWin) {
      consecutive = @1;
      [self checkDiagnol:playerMove
            matrix:matrix
            rowIncrement:[point[0] intValue]
            columnIncrement:[point[1] intValue]
            consecutive:&consecutive];
    }
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

- (void)check:(TTTPlayerMove *)playerMove
        matrix:(NSArray *)matrix
        indexPointer:(int)indexPointer
        maximum:(int)maximum
        row:(NSNumber *)row
        column:(NSNumber *)column
        consecutive:(NSNumber **)consecutive
{
  int lowerPointer = indexPointer;
  while (lowerPointer > 0) {
    lowerPointer--;
    NSNumber *valueAtPoint;
    if (row) {
      valueAtPoint = [[matrix objectAtIndex:[row intValue]] objectAtIndex:
        lowerPointer];
    } else {
      valueAtPoint = [[matrix objectAtIndex:lowerPointer] objectAtIndex:
        [column intValue]];
    }
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }

  int upperPointer = indexPointer;
  while (upperPointer < maximum) {
    upperPointer++;
    NSNumber *valueAtPoint;
    if (row) {
      valueAtPoint = [[matrix objectAtIndex:[row intValue]] objectAtIndex:
        upperPointer];
    } else {
      valueAtPoint = [[matrix objectAtIndex:upperPointer] objectAtIndex:
        [column intValue]];
    }
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }
  }
}

- (void)checkDiagnol:(TTTPlayerMove *)playerMove
        matrix:(NSArray *)matrix
        rowIncrement:(int)rowIncrement
        columnIncrement:(int)columnIncrement
        consecutive:(NSNumber **)consecutive
{
  int rowPointer = playerMove.row + rowIncrement;
  int columnPointer = playerMove.column + columnIncrement;

  while (columnPointer >= 0 && rowPointer >= 0 &&
    columnPointer <= GameColumns - 1 && rowPointer <= GameRows - 1) {

    NSNumber *valueAtPoint =
      [[matrix objectAtIndex:rowPointer] objectAtIndex:columnPointer];
    if ([playerMove.value intValue] == [valueAtPoint intValue]) {
      *consecutive = @([*consecutive intValue] + 1);
    }

    columnPointer = columnPointer + columnIncrement;
    rowPointer = rowPointer + rowIncrement;
  }
}

@end
