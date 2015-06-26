#import "TTTApplicationViewController.h"

// Controllers
#import "TTTGameController.h"

// Views
#import "TTTBoardView.h"

@interface TTTApplicationViewController ()
{
  TTTBoardView *boardView;
  TTTGameController *gameController;
}

@end

@implementation TTTApplicationViewController

#pragma mark - Override

#pragma mark - Override UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  gameController = [TTTGameController new];
  boardView = [[TTTBoardView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                    viewController:self
                                    boxViewDelegate:gameController];
  [self.view addSubview:boardView];

  gameController.delegate = boardView;
}

@end
