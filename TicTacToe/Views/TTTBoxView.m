#import "TTTBoxView.h"

// View models
#import "TTTBoxViewModel.h"

// Views
#import "TTTOView.h"
#import "TTTXView.h"

@interface TTTBoxView ()
{
  TTTOView *oView;
  NSNumber *value;
  TTTXView *xView;
}

@end

@implementation TTTBoxView

- (instancetype)initWithBoxViewModel:(TTTBoxViewModel *)viewModel
{
  self = [super initWithFrame:[viewModel frame]];
  if (!self) { return nil; }

  [self addBorders:viewModel];

  UITapGestureRecognizer *tapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                    action:@selector(tapped:)];
  [self addGestureRecognizer:tapRecognizer];

  return self;
}

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void) setValue:(int)v
{
  value = [NSNumber numberWithInt:v];
  if ([value intValue] == 1) {
    [self showX];
  } else {
    [self showO];
  }
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)addBorders:(TTTBoxViewModel *)viewModel
{
  if (viewModel.column > 0) {
    [self.layer addSublayer:[viewModel verticalBorder]];
  }

  if (viewModel.row > 0) {
    [self.layer addSublayer:[viewModel horizontalBorder]];
  }
}

- (void)showO
{
  if (oView) {
    oView.hidden = NO;
  } else {
    oView = [[TTTOView alloc] initWithFrame:self.bounds];
    [self addSubview:oView];
  }
}

- (void)showX
{
  if (xView) {
    xView.hidden = NO;
  }
  else {
    xView = [[TTTXView alloc] initWithFrame:self.bounds];
    [self addSubview:xView];
  }
}

- (void)tapped:(UITapGestureRecognizer *)tapRecognizer
{
  if (self.delegate &&
    [self.delegate respondsToSelector:@selector(boxTapped:)]) {
    if (value == nil) {
      [self.delegate boxTapped:self];
    } else {
      NSLog(@"THIS BOX IS TAKEN");
    }
  }
}

@end
