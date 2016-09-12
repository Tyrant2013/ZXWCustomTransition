//
//  ZXWOverlayPresentationController.m
//  ZXWCustomTransition
//
//  Created by 庄晓伟 on 16/3/17.
//  Copyright © 2016年 庄晓伟. All rights reserved.
//

#import "ZXWOverlayPresentationController.h"

@interface ZXWOverlayPresentationController()

@property (nonatomic, strong) UIView                    *dimmingView;

@end

@implementation ZXWOverlayPresentationController

- (id)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        _dimmingView = [UIView new];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    [self.containerView addSubview:self.dimmingView];
    CGFloat dimmingViewInitialWidth = CGRectGetWidth(self.containerView.bounds) / 2 * 3;
    CGFloat dimmingViewInitialHeight = CGRectGetHeight(self.containerView.bounds) / 2 * 3;
    self.dimmingView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = (CGRect){CGPointZero, dimmingViewInitialWidth, dimmingViewInitialHeight};
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.bounds = self.containerView.bounds;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0f;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;
    
    CGFloat width = CGRectGetWidth(self.containerView.bounds) * 2 / 3;
    CGFloat height = CGRectGetHeight(self.containerView.bounds) * 2 / 3;
    self.presentedView.center = self.containerView.center;
    self.presentedView.bounds = (CGRect){CGPointZero, width, height};
}

@end
