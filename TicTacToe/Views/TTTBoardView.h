#import <UIKit/UIKit.h>

// Protocols
#import "TTTBoxProtocol.h"
#import "TTTGameControllerProtocol.h"

@interface TTTBoardView : UIView <TTTGameControllerDelegate>

- (instancetype)initWithFrame:(CGRect)frame
                viewController:(UIViewController *)vc
                boxViewDelegate:(id<TTTBoxDelegate>)delegate;

#pragma Mark - Instance Methods

#pragma mark - Public Methods

- (void)resetBoard;

@end
