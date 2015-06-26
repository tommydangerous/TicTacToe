#import "TTTApplicationViewController.h"

// Controllers
#import "TTTGameController.h"

// Protocols
#import "TTTGameControllerProtocol.h"

// Views
#import "TTTBoardView.h"

@interface TTTApplicationViewController () <TTTGameControllerDelegate>
{
  TTTBoardView *boardView;
  TTTGameController *gameController;
}

@end

@implementation TTTApplicationViewController

- (instancetype)init
{
  self = [super init];
  if (!self) { return nil; }

  gameController = [TTTGameController new];
  gameController.delegate = self;

  return self;
}

#pragma mark - Override

#pragma mark - Override UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  boardView = [[TTTBoardView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                    delegate:gameController];
  [self.view addSubview:boardView];
}

#pragma mark - Protocols

#pragma mark - Protocols TTTGameControllerDelegate

- (void)gameComplete:(NSDictionary *)info
{
  UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:info[@"title"]
                         message:info[@"message"]
                         delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"Play again?", nil];
  [alertView show];
}

#pragma mark - Protocols UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView
        clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 0) {
    [gameController resetGame];
    [boardView resetBoard];
  }
}

@end
