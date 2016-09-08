//
//  ALWebOperation.m
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import "ALWebOperation.h"
#import "AppDelegate.h"

NSString* const alTargetURLString = @"http://www.truecaller.com";

@implementation ALWebOperation

- (id)initWithCompletion:(completionBlock)completion {
    
    self = [super init];
    if (self) {
        [self commonInit];
        self.completion = completion;
    }
    
    return self;
}

/**
 *  Common initialization block
 */
- (void)commonInit {
    
    self.completion = nil;
    _result = nil;
    _originalContent = nil;
}

- (void)execute {
    
    //Fetch and process data
    [self fetchContentfromURL:alTargetURLString completion:self.completion];
}

#pragma mark - Fetch Web

/**
 *  Fetches content from an URL and executes completion block if defined
 *
 *  @param urlString  URL to fetch content from
 *  @param completion Completion block to execute
 */
- (void)fetchContentfromURL:(NSString*)urlString completion:(completionBlock)completion {
    
    //Show network indicator if needed
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] increaseNetworkIndicatorCount];
    
    //Construct fetch operation
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    __weak typeof(self) weakSelf = self;
    
    [session resetWithCompletionHandler:^{
        
        NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data,
                                                                NSURLResponse *response,
                                                                NSError *error) {
                                                
                                                //Dismiss network indicator if not needed anymore
                                                [(AppDelegate*)[[UIApplication sharedApplication] delegate] decreaseNetworkIndicatorCount];
                                                
                                                if (error) {
                                                    //Houston, we have a problem
                                                    if (completion) {
                                                        //Tell dispatcher what went wrong
                                                        dispatch_async(dispatch_get_main_queue(), ^(void){
                                                            //Operate on mian thread so UI can be updated
                                                            completion(nil, error);
                                                        });
                                                    }
                                                }
                                                else {
                                                    //We have fetched some content
                                                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                                                        
                                                        //processing should happen on a background thread
                                                        
                                                        //Decode fetched data
                                                        NSString *contents = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                        
                                                        //Process content (subclasses should handle different)
                                                        NSString *result = [weakSelf processContent:contents];
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^(void){
                                                            
                                                            //Dispatch back to main thread so UI can be updated
                                                            
                                                            //Retain original content and result so they can be accessed if needed
                                                            _result = result;
                                                            _originalContent = contents;
                                                            
                                                            //Execute completion if defined
                                                            if (completion) {
                                                                completion(result, error);
                                                            }
                                                            
                                                        });
                                                    });
                                                }
                                            }];
        // Start the task.
        [task resume];
    }];
}

/**
 *  Virtual function to process Data. Should be overridden when subclassing
 *
 *  @param content Content to process
 *
 *  @return Processed content as result
 */
- (NSString*)processContent:(NSString*)content {
    
    //This dummy function just returns what passed
    return content;
}

@end
