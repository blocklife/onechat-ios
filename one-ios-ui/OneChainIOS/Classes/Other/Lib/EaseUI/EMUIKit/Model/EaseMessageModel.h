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

#import <Foundation/Foundation.h>

#import "IMessageModel.h"
@interface EaseMessageModel : NSObject<IMessageModel>

@property (nonatomic) CGFloat cellHeight;

@property (strong, nonatomic, readonly) ONEMessage *message;
@property (strong, nonatomic, readonly) ONEMessageBody *firstMessageBody;
@property (strong, nonatomic, readonly) NSString *messageId;
@property (nonatomic, readonly) ONEMessageBodyType bodyType;
@property (nonatomic, readonly) ONEMessageStatus messageStatus;
@property (nonatomic, readonly) ONEChatType messageType;
@property (nonatomic) BOOL isMessageRead;
// if the current login user is message sender
@property (nonatomic) BOOL isSender;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *avatarURLPath;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSAttributedString *attrBody;
@property (strong, nonatomic) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
//Placeholder image for network error
@property (strong, nonatomic) NSString *failImageName;
@property (nonatomic) CGSize imageSize;
@property (nonatomic) CGSize thumbnailImageSize;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *thumbnailImage;
@property (nonatomic) BOOL isMediaPlaying;
@property (nonatomic) BOOL isMediaPlayed;
@property (nonatomic, copy) NSString *voiceLocalPath;
@property (nonatomic) CGFloat mediaDuration;
@property (strong, nonatomic) NSString *fileIconName;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *fileSizeDes;
@property (nonatomic) CGFloat fileSize;

@property (nonatomic, strong) UIImage *exceedImage;
//progress of uploading or downloading the attachment message
@property (nonatomic) float progress;
@property (strong, nonatomic, readonly) NSString *fileLocalPath;
@property (strong, nonatomic) NSString *thumbnailFileLocalPath;
@property (strong, nonatomic) NSString *fileURLPath;
@property (strong, nonatomic) NSString *thumbnailFileURLPath;

//Transfer Message
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *amount;
// Redpacket Message
@property (nonatomic, copy) NSString *red_msg;
@property (nonatomic, strong) UIImage *red_bgImage;
@property (nonatomic, copy) NSString *red_id;
@property (nonatomic) BOOL isChecked;
@property (nonatomic, assign) NSInteger roleType;


- (instancetype)initWithMessage:(ONEMessage *)message;

@end
