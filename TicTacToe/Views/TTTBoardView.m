#import "TTTBoardView.h"

// View models
#import "TTTBoxViewModel.h"

// Views
#import "TTTScoreView.h"
#import "TTTBoxView.h"

@interface TTTBoardView ()
{
  UIView *board;
  NSMutableArray *boxes;
  TTTScoreView *scoreView;
  UIViewController *viewController;
}

@end

@implementation TTTBoardView

- (instancetype)initWithFrame:(CGRect)frame
                viewController:(UIViewController *)vc
                boxViewDelegate:(id<TTTBoxDelegate>)delegate
{
  self = [super initWithFrame:frame];
  if (!self) { return nil; }

  boxes = [NSMutableArray array];
  viewController = vc;

  self.backgroundColor = [UIColor whiteColor];

  [self createScoreView];
  [self createBoard];
  [self layoutBoxes:delegate];

  return self;
}

#pragma Mark - Instance Methods

#pragma mark - Public Methods

- (void)resetBoard
{
  for (TTTBoxView *box in boxes) {
    [box resetBox];
  }
}

#pragma Mark - Instance Methods

#pragma mark - Private Methods

- (void)createBoard
{
  CGFloat boardWidth = CGRectGetWidth(self.frame) - 20;
  CGFloat originY = (CGRectGetHeight(scoreView.frame) +
    (CGRectGetHeight(self.frame) - boardWidth)) * 0.5;
  CGRect boardFrame = CGRectMake(10, originY, boardWidth, boardWidth);
  board = [[UIView alloc] initWithFrame:boardFrame];

  [self addSubview:board];
}

- (void)layoutBoxes:(id<TTTBoxDelegate>)delegate
{
  CGFloat dimension = CGRectGetWidth(board.frame) / 3;
  for (int i = 0; i < 9; i++) {
    TTTBoxViewModel *viewModel =
      [[TTTBoxViewModel alloc] initWithDimension:dimension
                               row:i / 3 column:i % 3];

    TTTBoxView *box = [[TTTBoxView alloc] initWithBoxViewModel:viewModel];
    box.delegate = delegate;
    [board addSubview:box];

    [boxes addObject:box];
  }
}

- (void)createScoreView
{
  scoreView = [[TTTScoreView alloc] initWithFrame:
    CGRectMake(0, 0,
      CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.2
    )
  ];
  [self addSubview:scoreView];
}

#pragma mark - Protocols

#pragma mark - Protocols TTTGameControllerDelegate

- (void)gameComplete:(NSDictionary *)info completion:(void (^)(void))completion
{
  UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:info[@"title"]
                           message:info[@"message"]
                           preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *defaultAction =
    [UIAlertAction actionWithTitle:@"Play again?"
                   style:UIAlertActionStyleDefault
                   handler:^(UIAlertAction *action) {
                     completion();
                     [self resetBoard];
                   }];
  [alert addAction:defaultAction];
  [viewController presentViewController:alert animated:YES completion:nil];
}

@end
