#import <Foundation/Foundation.h>

@class TTTBoxView;

@protocol TTTBoxDelegate <NSObject>

- (void)boxTappedWithValues:(NSDictionary *)coordinates
        completion:(void (^)(NSNumber *value))completion;

@end
