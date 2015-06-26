#import <Foundation/Foundation.h>

@class TTTPlayerMove;

typedef NS_ENUM(NSInteger, TTTGameValidatorResult) {
  TTTGameValidatorResultPlayer1Victory,
  TTTGameValidatorResultPlayer2Victory,
  TTTGameValidatorResultTieGame,
  TTTGameValidatorResultIncomplete
};

@interface TTTGameValidator : NSObject

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (TTTGameValidatorResult)isGameOver:(TTTPlayerMove *)playerMove
                          matrix:(NSArray *)matrix
                          numberOfMoves:(int)numberOfMoves;

@end
