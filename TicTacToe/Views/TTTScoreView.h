#import <UIKit/UIKit.h>

@interface TTTScoreView : UIView

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)changePlayerTurn;
- (void)resetPlayerTurns;
- (void)updateScores:(NSArray *)scores;

@end
