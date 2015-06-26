#import <UIKit/UIKit.h>

// Protocols
#import "TTTBoxProtocol.h"

@interface TTTBoardView : UIView

@property (weak, nonatomic) id<TTTBoxDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                delegate:(id<TTTBoxDelegate>)delegate;

#pragma Mark - Instance Methods

#pragma mark - Public Methods

- (void)resetBoard;

@end
