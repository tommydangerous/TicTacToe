#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TTTGameController.h"

// Protocols
#import "TTTGameControllerProtocol.h"

// View models
#import "TTTBoxViewModel.h"

// Views
#import "TTTBoxView.h"

@interface TTTGameControllerTests : XCTestCase <TTTGameControllerDelegate>
{
  BOOL gameCompleteCallbackInvoked;
  TTTGameController *gameController;
  BOOL playerMadeMoveCallbackInvoked;
  NSArray *scores;
}

@end

@implementation TTTGameControllerTests

- (void)setUp
{
  [super setUp];
  gameController = [[TTTGameController alloc] init];
  gameController.delegate = self;

  gameCompleteCallbackInvoked = NO;
  playerMadeMoveCallbackInvoked = NO;
  scores = @[];
}

- (void)tearDown
{
  gameController = nil;
  gameCompleteCallbackInvoked = NO;
  playerMadeMoveCallbackInvoked = NO;
  scores = nil;
  [super tearDown];
}

#pragma mark - Protocols

#pragma mark - Protocols TTTGameControllerProtocol

- (void)testGameControllerCallingPlayerMadeMove
{
  [gameController boxTappedWithValues:@{
    @"column": @0,
    @"row": @0
  } completion:nil];
  XCTAssertTrue(playerMadeMoveCallbackInvoked,
    @"should call playerMadeMove on its delegate");
}

- (void)testGameControllerCallingGameComplete
{
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      [gameController boxTappedWithValues:@{
        @"column": @(c),
        @"row": @(r)
      } completion:nil];
    }
  }
  XCTAssertTrue(gameCompleteCallbackInvoked,
    @"should call gameComplete on its delegate");
  XCTAssertEqual([scores[0] intValue], 1,
    @"should return player 1 scoring a victory");
  XCTAssertEqual([scores[1] intValue], 0,
    @"should return player 2 not scoring a victory");

  // resetGame should have been called, testing if it did below:
  gameCompleteCallbackInvoked = NO;

  [gameController boxTappedWithValues:@{
    @"column": @0,
    @"row": @0
  } completion:nil];
  XCTAssertFalse(gameCompleteCallbackInvoked,
    @"should not call gameComplete on its delegate after game has been reset");
}

- (void)gameComplete:(NSDictionary *)info completion:(void (^)(void))completion
{
  gameCompleteCallbackInvoked = YES;
  scores = info[@"scores"];
  completion();
}

- (void)playerMadeMove
{
  playerMadeMoveCallbackInvoked = YES;
}

@end
