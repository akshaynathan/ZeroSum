//
//  ZSViewController.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSViewController.h"
#import "ZSMenuScene.h"

@implementation ZSViewController

// This is necessary to create an SKView instead of an UIView
- (void)loadView {
  CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
  SKView *skView = [[SKView alloc] initWithFrame:applicationFrame];
  self.view = skView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Configure the view.
  SKView *skView = (SKView *)self.view;

  // Create and configure the scene.
  SKScene *scene = [ZSMenuScene sceneWithSize:skView.bounds.size];
  scene.scaleMode = SKSceneScaleModeAspectFill;
  scene.backgroundColor = [UIColor whiteColor];

  // Present the scene.
  [skView presentScene:scene];
}

// The game is only played in landscape mode
- (BOOL)shouldAutorotate {
  return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"Memory Warning! This shouldn't happen.");
}

// Hide the status bar
- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end
