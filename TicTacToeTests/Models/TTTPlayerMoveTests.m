#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TTTPlayerMove.h"

@interface TTTPlayerMoveTests : XCTestCase
{
  int column;
  TTTPlayerMove *playerMove;
  int row;
  NSNumber *value;
}

@end

@implementation TTTPlayerMoveTests

- (void)setUp
{
  [super setUp];
  column = 1;
  row = 1;
  value = @1;
  playerMove =
    [[TTTPlayerMove alloc] initWithValue:value row:row column:column];
}

- (void)tearDown {
  playerMove = nil;
  [super tearDown];
}

- (void)testColumn
{
  XCTAssertEqual(column, playerMove.column, @"should be equal");
}

- (void)testRow
{
  XCTAssertEqual(row, playerMove.row, @"should be equal");
}

- (void)testValue
{
  XCTAssertEqual(
    [value intValue], [playerMove.value intValue], @"should be equal"
  );
}

@end
