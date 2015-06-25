#import <Foundation/Foundation.h>

@class TTTBoxView;

@protocol TTTBoxDelegate <NSObject>

- (void)boxTapped:(TTTBoxView *)boxView;

@end
