#import <Foundation/Foundation.h>

@interface TTTPlayerMove : NSObject

- (instancetype)initWithValue:(NSNumber *)value row:(int)row column:(int)column;

@property (nonatomic) int column;
@property (nonatomic) int row;
@property (strong, nonatomic) NSNumber *value;

@end
