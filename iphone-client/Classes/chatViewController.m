//
//  chatViewController.m
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "chatViewController.h"
#import "AsyncSocket.h"

@implementation chatViewController
@synthesize chatView;
@synthesize messageField;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Initiate AsyncSocket and connect
	chatSocket = [[AsyncSocket alloc] initWithDelegate:self];
	
	NSError *err;
	if (![chatSocket connectToHost:@"localhost" onPort:5001 error:&err]) {
		NSLog(@"Error Connecting to server");
	}
	
	// Clear the chatView
	chatView.text = @"";
	
	messageField.delegate = self;
	
	// Show the keyboard immediately
	[messageField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

// TextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	chatClient *client = [[chatClient alloc] initWithDelegate:self];
	[client sendMessage:messageField.text];
    messageField.text = @"";
    return YES;
}

// AsyncSocket Delegates
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
	NSLog(@"Client Disconnected: %@:%hu", [sock connectedHost], [sock connectedPort]);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {

}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
	NSLog(@"Message sent.");
	[sock readDataToData:[AsyncSocket ZeroData] withTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
	NSLog(@"Client Connected: %@:%i", host, port);
	NSString *subscribeMessage = @"{\"command\": \"subscribe\", \"channels\": [\"iphone\"]}\0";
	NSData *subscribeData = [subscribeMessage dataUsingEncoding:NSUTF8StringEncoding];	
	[chatSocket writeData:subscribeData withTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
	NSString *msg = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
	if(msg)
	{
		chatView.text = [[[NSString alloc] initWithFormat:@"%@\n%@", msg, chatView.text] autorelease];
	}
	else
	{
		NSLog(@"Error converting received data into UTF-8 String");
	}
	[sock readDataToData:[AsyncSocket ZeroData] withTimeout:-1 tag:0];
}

- (void)dealloc {
    [super dealloc];
}

@end
