//
//  AboutViewController.m
//  AkTilek
//
//  Created by Marat on 15.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UITextView *textView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting title to the navigationItem
    [self.navigationItem setTitle:@"Біз туралы"];
    //end
    
    //setting up the imageView
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2.0 - 35, 75, 70, 70)];
    self.imageView.image = [UIImage imageNamed:@"Logo.png"];
    [self.view addSubview:self.imageView];
    //end
    
    //setting up the textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(25, 145, CGRectGetWidth(self.view.frame)-50, CGRectGetHeight(self.view.frame)-150)];
    self.textView.text = @"Біз туралы:\n \"Енді тілек айту мәселе емес!\" \nБұл біздің басты мақсатымыз, яғни тілектерді сіздерге көрсетіп көпшілік алдында сөйлеуді жеңілдету.\n\nТілектер/баталармен бөлісу не басқа ұсыныстар болса хабарласыңыз! Байланыстарымыз: \ne-mail: aktilekapp@gmail.com \nтелефон: 8 775 428 99 27 \n\nО нас: \n\"Tеперь говорить тосты не проблема!\" \nЭто приложение для тех кто хочет научится говорить или улучшить качество. \n\nТакже вы узнаете о том, какие бата существуют и в каких случаях их надо говорить. \n\nКак бонус вы сможете найти полезные предложения от компаний, работающих в области организации праздников.Если Вы хотите пополнить содержание или у Вас есть предложения, а также по вопросам рекламы обращайтесь по данным контактам: \ne-mail: aktilekapp@gmail.com \nтелефон:  8 775 428 99 27 \n\n\n";
    if (CGRectGetHeight(self.view.frame) > 568) {
        [self.textView setFont:[UIFont fontWithName:@"Helvetica-Light" size:20]];
    }else{
        [self.textView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18]];
    }
    
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    //end
    
    // Do any additional setup after loading the view.
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
