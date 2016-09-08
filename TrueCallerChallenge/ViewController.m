//
//  ViewController.m
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import "ViewController.h"
#import "ALFindCharacterOperation.h"
#import "ALFindRepeatingCharacterOperation.h"
#import "ALWordCountOperation.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *feedBackTextView;

@end

@implementation ViewController

#pragma mark - Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - UI Customizations and setup

- (void)setupUI {
    
    //reset feedback content
    self.feedBackTextView.text = @"";
}

#pragma mark - Actions

- (IBAction)executeButtonTouched:(id)sender {
    
    //Execute operation(s)
    [self executeOperations];
}

#pragma mark - Private

- (void)executeOperations {
    
    __weak typeof(self) weakSelf = self;
    
    //Create a find 10th character operation
    ALFindCharacterOperation *op1 = [[ALFindCharacterOperation alloc] initWithCompletion:^(NSString *result, NSError *error) {
        [weakSelf appendResult:@"-----------------------------------\n"];
        [weakSelf appendResult:[NSString stringWithFormat:@"%@ Find 10th character operation finished with result\n", [NSDate date]]];
        if (result) {
            [weakSelf appendResult:result];
        }
        else {
            [weakSelf appendResult:error.localizedDescription];
        }
        [weakSelf appendResult:@"\n"];
    }];
    
    //Create a find every 10th character operaton
    ALFindRepeatingCharacterOperation *op2 = [[ALFindRepeatingCharacterOperation alloc] initWithCompletion:^(NSString *result, NSError *error) {
        [weakSelf appendResult:@"-----------------------------------\n"];
        [weakSelf appendResult:[NSString stringWithFormat:@"%@ Find every 10th character operation finished with result\n", [NSDate date]]];
        if (result) {
            [weakSelf appendResult:result];
        }
        else {
            [weakSelf appendResult:error.localizedDescription];
        }
        [weakSelf appendResult:@"\n"];
    }];
    
    //Create a count words operation
    ALWordCountOperation *op3 = [[ALWordCountOperation alloc] initWithCompletion:^(NSString *result, NSError *error) {
        [weakSelf appendResult:@"-----------------------------------\n"];
        [weakSelf appendResult:[NSString stringWithFormat:@"%@ Count words operation finished with result\n", [NSDate date]]];
        if (result) {
            [weakSelf appendResult:result];
        }
        else {
            [weakSelf appendResult:error.localizedDescription];
        }
        [weakSelf appendResult:@"\n"];
    }];
    
    //Log and execute
    
    [weakSelf appendResult:[NSString stringWithFormat:@"%@ Starting Find 10th character operation\n", [NSDate date]]];
    [op1 execute];
    
    [weakSelf appendResult:[NSString stringWithFormat:@"%@ Starting Find every 10th character operation\n", [NSDate date]]];
    [op2 execute];
    
    [weakSelf appendResult:[NSString stringWithFormat:@"%@ Starting Count words operation\n", [NSDate date]]];
    [op3 execute];
}

- (void)appendResult:(NSString*)result {
    
    //Synchronizing this operation ensures UI won't get messed up even if accessed simulaneously
    @synchronized (self) {
        NSMutableString *content = [NSMutableString stringWithString:self.feedBackTextView.text];
        [content appendString:result];
        self.feedBackTextView.text = content;
    }
}

@end
