#import <UIKit/UIKit.h>

#import "TTTBoxProtocol.h"

@class TTTBoxViewModel;

@interface TTTBoxView : UIView

@property (weak, nonatomic) id<TTTBoxDelegate> delegate;
@property (strong, nonatomic) NSNumber *value;

- (instancetype)initWithBoxViewModel:(TTTBoxViewModel *)viewModel;

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)showValue;

@end
