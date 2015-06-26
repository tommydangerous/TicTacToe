#import <Foundation/Foundation.h>

// Protocols
#import "TTTBoxProtocol.h"
#import "TTTGameControllerProtocol.h"

@interface TTTGameController : NSObject <TTTBoxDelegate>

@property (weak, nonatomic) id<TTTGameControllerDelegate> delegate;

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)resetGame;

@end
