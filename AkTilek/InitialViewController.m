//
//  InitialViewController.m
//  AkTilek
//
//  Created by Marat on 22.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundColor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    backgroundColor.image = [UIImage imageNamed:@"backgroundColor.png"];
    [self.view insertSubview:backgroundColor atIndex:0];
    
    double logoWidth = 100.0;
    double logoHeight = 100.0;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2.0-logoWidth/2.0, CGRectGetHeight(self.view.frame)/2.0-logoHeight/2.0, logoWidth, logoHeight)];
    logoView.image = [UIImage imageNamed:@"initialLogo.png"];
    [self.view addSubview:logoView];
    
    double nameWidth = 50.0;
    double nameHeight = 50.0;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - nameWidth/2, CGRectGetHeight(self.view.frame)+nameHeight, nameWidth, nameHeight)];
    nameLabel.text = @"Aq Tilek";
    [self.view addSubview:nameLabel];
    
    double delayInSeconds = 2.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"initialSegue" sender:self];
    });
    
    [self preferredStatusBarStyle];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
