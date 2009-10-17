//
//  chatClient.h
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "httpClient.h"


@interface chatClient : httpClient {

}

- (void)sendMessage:(NSString*)message;

@end
