#import "TTTBoxView.h"

// View models
#import "TTTBoxViewModel.h"

// Views
#import "TTTOView.h"
#import "TTTXView.h"

@interface TTTBoxView ()
{
  TTTOView *oView;
  TTTBoxViewModel *viewModel;
  TTTXView *xView;
}

@end

@implementation TTTBoxView

- (instancetype)initWithBoxViewModel:(TTTBoxViewModel *)vm
{
  self = [super initWithFrame:[vm frame]];
  if (!self) { return nil; }

  viewModel = vm;

  [self addBorders];

  UITapGestureRecognizer *tapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                    action:@selector(tapped:)];
  [self addGestureRecognizer:tapRecognizer];

  return self;
}

#pragma mark - Public Methods

#pragma mark - Instance Methods

- (void)showValue
{
  if ([_value intValue] == 0) {
    [self showX];
  } else {
    [self showO];
  }
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)addBorders
{
  if (viewModel.column > 0) {
    [self.layer addSublayer:[viewModel verticalBorder]];
  }

  if (viewModel.row > 0) {
    [self.layer addSublayer:[viewModel horizontalBorder]];
  }
}

- (NSDictionary *)coordinatesOnBoard
{
  return @{
    @"column": @(viewModel.column),
    @"row": @(viewModel.row)
  };
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
    [self.delegate respondsToSelector:
      @selector(boxTappedWithValues:completion:)]) {

    if (_value == nil) {
      [self.delegate boxTappedWithValues:[self coordinatesOnBoard]
                     completion:^(NSNumber *value) {
                       self.value = value;
                       [self showValue];
                     }];
    }
  }
}

@end
