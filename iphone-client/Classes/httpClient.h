//
//  httpClient.h
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIMEOUT_SEC		30.0

@class httpClient;

@protocol HttpClientDelegate
- (void)httpClientSucceeded:(httpClient*)sender messages:(NSMutableArray*)messages;
- (void)httpClientFailed:(httpClient*)sender;
@end

@interface httpClient : NSObject {
	NSURLConnection *connection;
	NSMutableData *receivedData;
	int statusCode;
	BOOL postMethod;
	NSObject<HttpClientDelegate> *delegate;
	NSString* method;
}

- (id)initWithDelegate:(NSObject<HttpClientDelegate>*)delegate;

- (void)requestGET:(NSString*)url;
- (void)requestPOST:(NSString*)url body:(NSString*)body;

- (void)requestSucceeded;
- (void)requestFailed:(NSError*)error;

@property (readonly) NSMutableData *receivedData;
@property (readonly) int statusCode;
@property (readonly) BOOL postMethod;
@property (nonatomic, readonly) NSString* method;

@end

