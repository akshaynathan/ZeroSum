//
//  ZSScoreTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSScore.h"

@interface ZSScoreTest : XCTestCase

@end

@implementation ZSScoreTest

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testUpdateScore {
  ZSScore *score = [[ZSScore alloc] init];
  XCTAssert(score.score == 0, "New ZSScore should have 0 for score value.");
  [score updateScore:15];
  XCTAssert(score.score == 15, "ZSScore should add updateValue to score.");
  [score updateScore:15];
  XCTAssert(score.score == 30, "ZSScore should add updateValue to score.");
  SKLabelNode *scoreNode = [score.children firstObject];
  [[NSRunLoop currentRunLoop]
      runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
  XCTAssert([scoreNode.text isEqualToString:@"30"]);
}

@end
