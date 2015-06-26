#import <Foundation/Foundation.h>

@protocol TTTGameControllerDelegate <NSObject>

- (void)gameComplete:(NSDictionary *)info;

@end
