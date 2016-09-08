//
//  ALWordCountOperation.m
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import "ALWordCountOperation.h"

@implementation ALWordCountOperation

- (NSString*)processContent:(NSString*)content {
    
    //Split content by new lines and white spaces - these are our "words"
    NSArray *words = [content componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (words.count == 0) {
        //Handle gracefully when we don't have any words in the content
        return NSLocalizedString(@"Content contained no words:(", @"result when content cannot be split to words");
    }
    else {
        //Process content
        NSMutableDictionary *wordsCount = [NSMutableDictionary new];
        
        //Count each word
        for (NSString *word in words) {
            
            NSNumber *count = wordsCount[word];
            
            if (!count) {
                count = @1;
            }
            else {
                count = [NSNumber numberWithInteger:count.integerValue + 1];
            }
            
            wordsCount[word] = count;
        }
        
        //Construct formatted result
        NSMutableString *result = [NSMutableString new];
        for (NSString *word in wordsCount.allKeys) {
            if (result.length) {
                //Separate by spaces
                [result appendString:@" "];
            }
            [result appendString:[NSString stringWithFormat:@"\"%@\": %@", word, wordsCount[word]]];
        }
        
        return result;
    }
}

@end
