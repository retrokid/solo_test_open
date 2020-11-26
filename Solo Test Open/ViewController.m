//
//  ViewController.m
//  Solo Test Open
//
//  Created by efe ertugrul on 18/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    SKView *spriteView=(SKView *)self.view;
    spriteView.showsDrawCount=YES;
    spriteView.showsNodeCount=YES;
    spriteView.showsFPS=YES;
     */
}

-(void)viewWillAppear:(BOOL)animated
{
    PlayScene *playSC=[[PlayScene alloc]initWithSize:self.view.frame.size];
    SKView *spriteView=(SKView *)self.view;
    [spriteView presentScene:playSC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
