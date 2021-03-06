/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseBubbleView+Voice.h"

#define ISREAD_VIEW_SIZE 10.f

@implementation EaseBubbleView (Voice)

#pragma mark - private


- (void)_setupVoiceBubbleMarginConstraints
{
    [self.marginConstraints removeAllObjects];
    
    //image view

    NSLayoutConstraint *imageCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.marginConstraints addObject:imageCenterYConstraint];
    //duration label
    NSLayoutConstraint *durationWithMarginTopConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *durationWithMarginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    [self.marginConstraints addObject:durationWithMarginTopConstraint];
    [self.marginConstraints addObject:durationWithMarginBottomConstraint];
    
    if(self.isSender){
        NSLayoutConstraint *imageWithMarginRightConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
        [self.marginConstraints addObject:imageWithMarginRightConstraint];

        NSLayoutConstraint *durationRightConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.voiceImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5];
        [self.marginConstraints addObject:durationRightConstraint];

    }
    else{
        NSLayoutConstraint *imageWithMarginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
        [self.marginConstraints addObject:imageWithMarginLeftConstraint];
        
        NSLayoutConstraint *durationLeftConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.voiceImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
        [self.marginConstraints addObject:durationLeftConstraint];

        
        [self.marginConstraints addObject:[NSLayoutConstraint constraintWithItem:self.isReadView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:4]];
        [self.marginConstraints addObject:[NSLayoutConstraint constraintWithItem:self.isReadView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    }
    [self addConstraints:self.marginConstraints];
}

- (void)_setupVoiceBubbleConstraints
{
    if (self.isSender) {
        self.isReadView.hidden = YES;
    }
    [self _setupVoiceBubbleMarginConstraints];
}

#pragma mark - public

- (void)setupVoiceBubbleView
{
    self.voiceImageView = [[UIImageView alloc] init];
    self.voiceImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.voiceImageView.backgroundColor = [UIColor clearColor];
    [self.voiceImageView sizeToFit];
    self.voiceImageView.animationDuration = 1;
    [self.backgroundImageView addSubview:self.voiceImageView];
    
    self.voiceDurationLabel = [[UILabel alloc] init];
    self.voiceDurationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.voiceDurationLabel.backgroundColor = [UIColor clearColor];
    [self.backgroundImageView addSubview:self.voiceDurationLabel];
    
    self.isReadView = [[UIImageView alloc] init];
    self.isReadView.translatesAutoresizingMaskIntoConstraints = NO;

    self.isReadView.image = [UIImage imageNamed:@"Voice_unread_flag"];
    [self.backgroundImageView addSubview:self.isReadView];
    
    [self _setupVoiceBubbleConstraints];
}

- (void)updateVoiceMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    [self _setupVoiceBubbleMarginConstraints];
}

@end
