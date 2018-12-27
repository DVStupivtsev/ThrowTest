//  Created by Dmitriy Stupivtsev on 21.09.2018.

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStackView *stack = [UIStackView new];
    stack.distribution = UIStackViewDistributionFillEqually;
    stack.layoutMarginsRelativeArrangement = YES;
    stack.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);
    stack.spacing = 10;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stack];
    [stack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [stack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [stack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [stack.heightAnchor constraintEqualToConstant:50].active = YES;
    
    UIButton *leakingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leakingButton setTitle:@"Leak memory" forState:UIControlStateNormal];
    leakingButton.tintColor = UIColor.whiteColor;
    leakingButton.backgroundColor = UIColor.grayColor;
    [leakingButton addTarget:self action:@selector(leakMemory) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:leakingButton];
    
    UIButton *safeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [safeButton setTitle:@"Not leak memory" forState:UIControlStateNormal];
    safeButton.tintColor = UIColor.whiteColor;
    safeButton.backgroundColor = UIColor.grayColor;
    [safeButton addTarget:self action:@selector(releaseMemory) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:safeButton];
}

- (void)releaseMemory {
    // array should be released
    NSMutableArray *array;
    
    @try {
        array = [NSMutableArray new];
        for (int i = 0; i < 1000; i++) {
            UIViewController *vc = [UIViewController new];
            [array addObject:vc];
        }
        
        [self throwingMethod];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    NSLog(@"Memory will be released");
}

- (void)leakMemory {
    // array shouldn't be released
    @try {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 1000; i++) {
            UIViewController *vc = [UIViewController new];
            [array addObject:vc];
        }
        
        [self throwingMethod];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    NSLog(@"Memory will not be released");
}

- (void)throwingMethod {
    @throw [[NSException alloc] initWithName:@"Throwing method" reason:@"reason" userInfo:@{}];
}

@end
