//
//  chatViewController.h
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chatClient.h"

@class AsyncSocket;

@interface chatViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
	AsyncSocket *chatSocket;
	
	IBOutlet UITextView *chatView;
	IBOutlet UITextField *messageField;
}

@property (retain, nonatomic) UITextView *chatView;
@property (retain, nonatomic) UITextField *messageField;

@end

