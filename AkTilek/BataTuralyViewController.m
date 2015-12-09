//
//  BataTuralyViewController.m
//  AkTilek
//
//  Created by Marat on 12/6/15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "BataTuralyViewController.h"
#import <Parse/Parse.h>

@interface BataTuralyViewController ()
@property (nonatomic) NSString *bataName;
@property (nonatomic) UITextView *textView;
@end

@implementation BataTuralyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Бата беру туралы"];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    backgroundImageView.image = [UIImage imageNamed:@"tilekBackground.png"];
    [self.view addSubview:backgroundImageView];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(25, 60, CGRectGetWidth(self.view.frame)-100, CGRectGetHeight(self.view.frame)-120)];
    self.textView.textAlignment = UITextAlignmentCenter;
    self.textView.editable = NO;
    if (CGRectGetHeight(self.view.frame) > 568) {
        [self.textView setFont:[UIFont fontWithName:@"Helvetica-Light" size:20]];
    }else{
        [self.textView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18]];
    }
    [self.view addSubview:self.textView];
    [self getLocalData];
    [self getDataFromParse];
    // Do any additional setup after loading the view.
}

#pragma mark - Parse methods

-(void)getDataFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Batalar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                NSString *descr = object[@"descr"];
                if (![descr isEqualToString:self.textView.text] && [name isEqualToString:@"Bata Turaly"]) {
                    self.textView.text = descr;
                    self.bataName = name;
                    [object pinInBackground];
                }
            }
        }else{
            NSLog(@"%@", error);
        }
    }];
}

-(void)getLocalData{
    PFQuery *query = [PFQuery queryWithClassName:@"Batalar"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *descr = object[@"descr"];
                NSString *name = object[@"name"];
                self.textView.text = descr;
                self.bataName = name;
            }
        }else{
            NSLog(@"%@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
