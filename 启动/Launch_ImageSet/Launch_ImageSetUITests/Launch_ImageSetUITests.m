//
//  Launch_ImageSetUITests.m
//  Launch_ImageSetUITests
//
//  Created by baidu on 2017/10/25.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Launch_ImageSetUITests : XCTestCase


@end

@implementation Launch_ImageSetUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
   
    [[[XCUIApplication alloc] init] launch];
    
    [NSTimer scheduledTimerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [[[XCUIApplication alloc] init] launch];
        [[[XCUIApplication alloc] init] terminate];
        
    }];
    
   
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
 
    
   
}

@end
