#import "TTTApplicationViewController.h"

// Controllers
#import "TTTGameController.h"

// Views
#import "TTTBoardView.h"

@interface TTTApplicationViewController ()
{
  TTTGameController *gameController;
}

@end

@implementation TTTApplicationViewController

- (instancetype)init
{
  self = [super init];
  if (!self) { return nil; }

  gameController = [TTTGameController new];

  return self;
}

#pragma mark - Override

#pragma mark - Override UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  TTTBoardView *board =
    [[TTTBoardView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                          delegate:gameController];
  [self.view addSubview:board];
}

@end
