#import <Foundation/Foundation.h>

@protocol TTTGameControllerDelegate <NSObject>

- (void)gameComplete:(NSDictionary *)info completion:(void (^)(void))completion;

@optional
- (void)playerMadeMove;

@end
