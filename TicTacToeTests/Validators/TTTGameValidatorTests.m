#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TTTGameValidator.h"

// Models
#import "TTTPlayerMove.h"

@interface TTTGameValidatorTests : XCTestCase
{
  TTTGameValidator *gameValidator;
  NSMutableArray *matrix;
}

@end

@implementation TTTGameValidatorTests

- (void)setUp
{
  [super setUp];

  gameValidator = [[TTTGameValidator alloc] init];
  matrix = [NSMutableArray array];
  for (int i = 0; i < 3; i++) {
    matrix[i] = [NSMutableArray arrayWithObjects: @9, @9, @9, nil];
  }
}

- (void)tearDown
{
  gameValidator = nil;
  matrix = nil;

  [super tearDown];
}

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)testGameOverWhenIncomplete
{
  TTTPlayerMove *playerMove = [[TTTPlayerMove alloc] initWithValue:@0
                                                     row:0
                                                     column:0];
  XCTAssertEqual([gameValidator isGameOver:playerMove
                                matrix:matrix
                                numberOfMoves:1],
    TTTGameValidatorResultIncomplete, @"should return incomplete"
  );
}

- (void)testGameOverWhenPlayer1Wins
{
  matrix[0] = @[@1, @1, @0];
  matrix[1] = @[@1, @1, @0];
  matrix[2] = @[@0, @0, @9];
  TTTPlayerMove *playerMove = [[TTTPlayerMove alloc] initWithValue:@0
                                                     row:2
                                                     column:2];

  XCTAssertEqual([gameValidator isGameOver:playerMove
                                matrix:matrix
                                numberOfMoves:9],
    TTTGameValidatorResultPlayer1Victory, @"should return player 1 victory"
  );
}

- (void)testGameOverWhenPlayer2Wins
{
  matrix[0] = @[@1, @1, @0];
  matrix[1] = @[@1, @0, @0];
  matrix[2] = @[@9, @1, @9];
  TTTPlayerMove *playerMove = [[TTTPlayerMove alloc] initWithValue:@1
                                                     row:2
                                                     column:0];

  XCTAssertEqual([gameValidator isGameOver:playerMove
                                matrix:matrix
                                numberOfMoves:8],
    TTTGameValidatorResultPlayer2Victory, @"should return player 2 victory"
  );
}

- (void)testGameOverWhenTie
{
  matrix[0] = @[@1, @0, @1];
  matrix[1] = @[@1, @0, @9];
  matrix[2] = @[@0, @1, @0];
  TTTPlayerMove *playerMove = [[TTTPlayerMove alloc] initWithValue:@1
                                                     row:1
                                                     column:2];

  XCTAssertEqual([gameValidator isGameOver:playerMove
                                matrix:matrix
                                numberOfMoves:9],
    TTTGameValidatorResultTieGame, @"should return tie"
  );
}

@end
