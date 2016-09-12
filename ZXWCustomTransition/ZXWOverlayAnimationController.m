//
//  ZXWOverlayAnimationController.m
//  ZXWCustomTransition
//
//  Created by 庄晓伟 on 16/3/16.
//  Copyright © 2016年 庄晓伟. All rights reserved.
//

#import "ZXWOverlayAnimationController.h"

@implementation ZXWOverlayAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (!fromVC || !toVC) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    if (!containerView) {
        return;
    }
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];
        CGFloat toViewWidth = CGRectGetWidth(containerView.frame) * 2 / 3;
        CGFloat toViewHeight = CGRectGetHeight(containerView.frame) * 2 / 3;
        toView.center = containerView.center;
        toView.bounds = (CGRect){CGPointZero, 1, toViewHeight};
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
            [UIView animateWithDuration:duration animations:^{
                toView.bounds = (CGRect){CGPointZero, toViewWidth, toViewHeight};
            } completion:^(BOOL finished) {
                BOOL isCancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!isCancelled];
            }];
        }
        else {
            UIView *dimmingView = [UIView new];
            [containerView insertSubview:dimmingView belowSubview:toView];
            dimmingView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
            dimmingView.center = containerView.center;
            dimmingView.bounds = (CGRect){CGPointZero, toViewWidth, toViewHeight};
            [UIView animateWithDuration:duration animations:^{
                dimmingView.bounds = containerView.bounds;
                toView.bounds = (CGRect){CGPointZero, toViewWidth, toViewHeight};
            } completion:^(BOOL finished) {
                BOOL isCancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!isCancelled];
            }];
        }
    }
    
    if (fromVC.isBeingDismissed) {
        CGFloat fromViewHeight = CGRectGetHeight(fromView.bounds);
        [UIView animateWithDuration:duration animations:^{
            fromView.bounds = (CGRect){CGPointZero, 1, fromViewHeight};
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:isCancelled];
        }];
    }
    
}

@end
