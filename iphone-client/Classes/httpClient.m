//
//  httpClient.m
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "httpClient.h"


@implementation httpClient
@synthesize receivedData, statusCode, postMethod, method;

- (void)dealloc {
	[connection release];
	[receivedData release];
	
	[super dealloc];
}

- (id)init {
	self = [super init];
	
	return self;
}

- (id)initWithDelegate:(NSObject<HttpClientDelegate>*)aDelegate {
	if ((self = [super init])) {
		delegate = aDelegate;
		[delegate retain];
	}
	return self;
}

- (void)reset {
	if (connection != nil) [connection cancel];
	[receivedData release];
	receivedData = [[NSMutableData alloc] init];
	[connection release];
	connection = nil;
	
	statusCode = 0;	
}

- (NSMutableURLRequest*)makeRequest:(NSString*)url {
	url = [url stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
	NSString *encodedUrl = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)url, NULL, NULL, kCFStringEncodingUTF8);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	
	[request setURL:[NSURL URLWithString:encodedUrl]];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setTimeoutInterval:TIMEOUT_SEC];
	[request setHTTPShouldHandleCookies:FALSE];
	[encodedUrl release];
	
	return request;
}

- (void)requestGET:(NSString*)url {
	[self reset];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSMutableURLRequest *request = [self makeRequest:url];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)requestPOST:(NSString*)url body:(NSString*)body {
	[self reset];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSMutableURLRequest *request = [self makeRequest:url];
	[request setHTTPMethod:@"POST"];
	if (body) {
		body = [body stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
		[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	}
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)requestSucceeded {
	//implement by subclass.
}

- (void)requestFailed:(NSError*)error {
	//implement by subclass.
}

#pragma mark -
#pragma mark Connection Delegates
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
	statusCode = [(NSHTTPURLResponse*)response statusCode];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
	[receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[self requestSucceeded];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self reset];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[self requestFailed:error];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self reset];
}

@end