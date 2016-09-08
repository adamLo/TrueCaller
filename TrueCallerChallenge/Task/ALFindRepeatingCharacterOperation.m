//
//  ALFindRepeatingCharacterOperation.m
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import "ALFindRepeatingCharacterOperation.h"

@implementation ALFindRepeatingCharacterOperation

NSInteger const alCharacterRepeatValue = 10;

- (NSString*)processContent:(NSString*)content {
    
    if (content.length < alCharacterRepeatValue) {
        //Handle gracfully if content is shorter than first index
        return [NSString stringWithFormat:NSLocalizedString(@"Content shorter than %li", @"string format when Content too short"), alCharacterRepeatValue];
    }
    else {
        //Iterate through content
        NSMutableString *result = [NSMutableString new];
        
        NSInteger index = alCharacterRepeatValue;
        
        while (index < content.length) {
            
            NSString *currentCharResult = [NSString stringWithFormat:NSLocalizedString(@"%lith: \"%@\"", @"String format when iterating result"), index, [content substringWithRange:NSMakeRange(index, 1)]];
            
            if (result.length) {
                //Separate result
                [result appendString:@" "];
            }
            
            [result appendString:currentCharResult];
            
            index += alCharacterRepeatValue;
        }
        
        return result;
    }
}

@end
