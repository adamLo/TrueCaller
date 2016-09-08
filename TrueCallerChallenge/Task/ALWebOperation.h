//
//  ALWebOperation.h
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionBlock)(NSString *result, NSError *error);

/**
 *  Base class of web operations
 */
@interface ALWebOperation : NSObject

/**
 *  Completion block executed at the end of processing web content
 */
@property (nonatomic, copy) completionBlock completion;

/**
 *  Original content of fetched web page so it can be accessed if needed
 */
@property (nonatomic, strong, readonly) NSString *originalContent;

/**
 *  Processed content of web page
 */
@property (nonatomic, strong, readonly) NSString *result;

/**
 *  Initializes operation with completion block
 *
 *  @param completion Completion block to execute at the end
 *
 *  @return Instance
 */
- (id)initWithCompletion:(completionBlock)completion;

/**
 *  Executes operation
 */
- (void)execute;

@end
