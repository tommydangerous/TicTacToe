#import "TTTGameController.h"

// Views
#import "TTTBoxView.h"

@implementation TTTGameController

- (instancetype)init
{
  self = [super init];
  if (!self) { return nil; }

  return self;
}

#pragma mark - Protocols

#pragma mark - Protocols TTTBoxProtocol

- (void)boxTapped:(TTTBoxView *)boxView;
{
  [boxView setValue:0];
}

@end
