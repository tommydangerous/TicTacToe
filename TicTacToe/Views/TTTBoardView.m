#import "TTTBoardView.h"

// View models
#import "TTTBoxViewModel.h"

// Views
#import "TTTBoxView.h"

@interface TTTBoardView ()
{
  UIView *board;
}

@end

@implementation TTTBoardView

- (instancetype)initWithFrame:(CGRect)frame
                delegate:(id<TTTBoxDelegate>)delegate
{
  self = [super initWithFrame:frame];
  if (!self) { return nil; }

  self.backgroundColor = [UIColor whiteColor];
  self.delegate = delegate;

  [self createBoard];
  [self layoutBoxes];

  return self;
}

#pragma Mark - Instance Methods

#pragma mark - Private Methods

- (void)createBoard
{
  CGFloat screenHeight = CGRectGetHeight(self.frame);
  CGFloat screenWidth = CGRectGetWidth(self.frame);

  CGFloat boardWidth = screenWidth - 20;

  CGRect boardFrame = CGRectMake(
    10, (screenHeight - boardWidth) * 0.5, boardWidth, boardWidth
  );
  board = [[UIView alloc] initWithFrame:boardFrame];

  [self addSubview:board];
}

- (void)layoutBoxes
{
  CGFloat dimension = CGRectGetWidth(board.frame) / 3;
  for (int i = 0; i < 9; i++) {
    TTTBoxViewModel *viewModel =
      [[TTTBoxViewModel alloc] initWithDimension:dimension
                               row:i / 3 column:i % 3];

    TTTBoxView *box = [[TTTBoxView alloc] initWithBoxViewModel:viewModel];
    box.delegate = _delegate;
    [board addSubview:box];
  }
}

@end
