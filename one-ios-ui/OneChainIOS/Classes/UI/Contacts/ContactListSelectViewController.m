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

#import "ContactListSelectViewController.h"

#import "ChatViewController.h"
#import "UserProfileManager.h"
//#import "RedPacketChatViewController.h"


@interface ContactListSelectViewController () <EMUserListViewControllerDelegate,EMUserListViewControllerDataSource>

@end

@implementation ContactListSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    
    self.title = NSLocalizedString(@"title.chooseContact", @"select the contact");
    

}

#pragma mark - EMUserListViewControllerDelegate
- (void)userListViewController:(EaseUsersListViewController *)userListViewController
            didSelectUserModel:(id<IUserModel>)userModel
{
    if (self.messageModel) {
        if (self.messageModel.bodyType == ONEMessageBodyTypeText) {
            ONEMessage *message = [EaseSDKHelper sendTextMessage:self.messageModel.text to:userModel.buddy messageType:ONEChatTypeChat messageExt:self.messageModel.message.ext];

            __weak typeof(self) weakself = self;
            
            [[ONEChatClient sharedClient] sendMessage:message progress:nil completion:^(ONEMessage *message, ONEError *error) {
                
                if (!error) {
                    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:userModel.buddy conversationType:ONEConversationTypeChat];
                      chatController.title = userModel.nickname.length != 0 ? [userModel.nickname copy] : [userModel.buddy copy];
                      [weakself.navigationController pushViewController:chatController animated:YES];
                      [weakself clearNavigation];
                } else {
                    [self showHudInView:self.view hint:NSLocalizedString(@"transpondFail", @"transpond Fail")];
                }
            }];
        } else if (self.messageModel.bodyType == ONEMessageBodyTypeImage) {
            [self showHudInView:self.view hint:NSLocalizedString(@"transponding", @"transpondFailing...")];
            
            UIImage *image = self.messageModel.image;
            if (!image) {
                image = [UIImage imageWithContentsOfFile:self.messageModel.fileLocalPath];
            }
            
            if (!image) {
                [self hideHud];
                [self showHudInView:self.view hint:NSLocalizedString(@"transpondFail", @"transpond Fail")];
                [self performSelector:@selector(backAction) withObject:nil afterDelay:0.5];
                return;
            }
            ONEMessage *message = [EaseSDKHelper transpondImageMessageWithLocalPath:self.messageModel.fileLocalPath to:userModel.buddy messageType:ONEChatTypeChat messageExt:nil];
            
            [[ONEChatClient sharedClient] sendMessage:message progress:nil completion:^(ONEMessage *message, ONEError *error) {
                if (!error) {
                    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:userModel.buddy conversationType:ONEConversationTypeChat];
                    chatController.title = userModel.nickname.length != 0 ? [userModel.nickname copy] : [userModel.buddy copy];
                    [self.navigationController pushViewController:chatController animated:YES];
                    [self clearNavigation];
                } else {
                    [self showHudInView:self.view hint:NSLocalizedString(@"transpondFail", @"transpond Fail")];
                }
            }];
        }
    }
}
            
- (void)clearNavigation
{
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [mArray enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[ChatViewController class]] ) {
            [mArray removeObject:obj];
            *stop = YES;
        }
    }];
    [mArray enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[ContactListSelectViewController class]]) {
            
            [mArray removeObject:obj];
            *stop = YES;
        }
    }];
    self.navigationController.viewControllers = [NSArray arrayWithArray:mArray];
}

#pragma mark - EMUserListViewControllerDataSource
- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                           modelForBuddy:(NSString *)buddy
{
    id<IUserModel> model = nil;
    model = [[EaseUserModel alloc] initWithBuddy:buddy];
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.buddy];
    if (profileEntity) {
        model.nickname= profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
        model.avatarURLPath = profileEntity.imageUrl;
    }
    return model;
}

- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                   userModelForIndexPath:(NSIndexPath *)indexPath
{
    id<IUserModel> model = nil;
    model = [self.dataArray objectAtIndex:indexPath.row];
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.buddy];
    if (profileEntity) {
        model.nickname= profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
        model.avatarURLPath = profileEntity.imageUrl;
    }
    return model;
}

#pragma mark - action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
             
             
             


@end
