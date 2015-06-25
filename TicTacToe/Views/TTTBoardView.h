#import <UIKit/UIKit.h>

// Protocols
#import "TTTBoxProtocol.h"

@interface TTTBoardView : UIView

@property (weak, nonatomic) id<TTTBoxDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                delegate:(id<TTTBoxDelegate>)delegate;

@end
