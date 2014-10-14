//
//  SpaceScoutViewController.m
//  Space Scout
//
//  Created by Josh Collier on 8/11/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutViewController.h"
#import "SpaceScoutMyScene.h"

@interface SpaceScoutViewController ()

@property SKSpriteNode* sprite;

@end

@implementation SpaceScoutViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    SKScene * scene = [SpaceScoutMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
