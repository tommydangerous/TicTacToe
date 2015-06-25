#import <UIKit/UIKit.h>

@interface TTTBoxViewModel : NSObject

@property int column;
@property int row;

- (instancetype)initWithDimension:(CGFloat)d row:(int)row column:(int)column;

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (CGRect)frame;
- (CALayer *)horizontalBorder;
- (CALayer *)verticalBorder;

@end
