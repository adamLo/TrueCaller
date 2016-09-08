//
//  ALFindCharacterOperation.m
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import "ALFindCharacterOperation.h"

@implementation ALFindCharacterOperation

/**
 *  Index of character to look up
 */
NSInteger const alCharacterLookupIndex = 10;

- (NSString*)processContent:(NSString*)content {
    
    if (content.length > alCharacterLookupIndex) {
        //Handle gracefully if content is shorter than expected
        return [NSString stringWithFormat:NSLocalizedString(@"%lith character is: \"%@\"", @"String format when index found"), alCharacterLookupIndex, [content substringWithRange:NSMakeRange(alCharacterLookupIndex, 1)]];
    }
    else {
        //We do have a result
        return [NSString stringWithFormat:NSLocalizedString(@"%lith character not found:(", @"string format when index not found"), alCharacterLookupIndex];
    }
}

@end
