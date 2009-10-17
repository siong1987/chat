//
//  chatClient.m
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "chatClient.h"


@implementation chatClient

- (void)sendMessage:(NSString *)message {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSString *url = [[NSString alloc] initWithString:@"http://localhost:3000/chat/send_data"];
	NSString *paramters = [[NSString alloc] initWithFormat:@"chat_input=%@", message];
	
	[super requestPOST:url body:paramters];
	[url release];
	[paramters release];
}

- (void)requestSucceeded {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"Chat message sent.");
	[self autorelease];
}


- (void)requestFailed:(NSError*)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"Chat message sending failed.");
	[self autorelease];
}

@end
