//
//  TilekViewController.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "TilekViewController.h"

@interface TilekViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSMutableArray *likedTilekterDescr;
@property (nonatomic) NSMutableArray *likedTilekterNames;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation TilekViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting up the backgound
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    backgroundView.image = [UIImage imageNamed:@"tilekBackground.png"];
    [self.view insertSubview:backgroundView atIndex:0];
    //end
    
    [self.navigationItem setTitle:self.tilek.name];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.likedTilekterDescr = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"likedTilekterDescr"]];
    self.likedTilekterNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"likedTilekterNames"]];
    
    if ([self.likedTilekterDescr count] == 0) {
        self.likedTilekterDescr = [NSMutableArray new];
        self.likedTilekterNames = [NSMutableArray new];
    }
    [self.likeButton setTitle:@"" forState:UIControlStateNormal];
    [self.likeButton setBackgroundImage:[UIImage imageNamed:@"starGray.png"] forState:UIControlStateNormal];
    
    
    //[self.likeButton setImage:[UIImage imageNamed:@"starGray.png"] forState:UIControlStateNormal];
    
    if (self.tilek.isLiked == 0) {
        NSLog(@"tilek: %@ isLiked: %i",self.tilek.name, self.tilek.isLiked);
        for (int i = 0; i < self.likedTilekterNames.count; i++) {
            //NSLog(@"---%@\n", self.likedTilekterNames[i]);
            if ([self.likedTilekterNames[i] isEqualToString:self.tilek.name]) {
                NSLog(@"%@ == %@", self.likedTilekterNames[i], self.tilek.name);
                [self.likeButton setBackgroundImage:[UIImage imageNamed:@"starYellow.png"] forState:UIControlStateNormal];
                //[self.likeButton setTitle:@"Liked" forState:UIControlStateNormal];
                self.tilek.isLiked = YES;
            }
        }
    }else{
        NSLog(@"Liked already!");
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"starYellow.png"] forState:UIControlStateNormal];
    }
    
    //setting up the textView
    self.textView.delegate = self;
    [self.textView setBackgroundColor:[UIColor clearColor]];
    self.textView.text = self.tilek.descr;
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
    //end
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)likeButtonPressed:(UIButton *)sender {
    NSLog(@"like button pressed!");
    if (self.tilek.isLiked == 0) {
        self.tilek.isLiked = YES;
        [self.likedTilekterNames addObject:self.tilek.name];
        [self.likedTilekterDescr addObject:self.tilek.descr];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"starYellow.png"] forState:UIControlStateNormal];
        //[self.likeButton setTitle:@"Liked" forState:UIControlStateNormal];
    }else{
        self.tilek.isLiked = NO;
        [self.likedTilekterNames removeObject:self.tilek.name];
        [self.likedTilekterDescr removeObject:self.tilek.descr];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"starGray.png"] forState:UIControlStateNormal];
        //[self.likeButton setTitle:@"Not Liked" forState:UIControlStateNormal];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.likedTilekterDescr forKey:@"likedTilekterDescr"];
    [userDefaults setObject:self.likedTilekterNames forKey:@"likedTilekterNames"];
}

#pragma mark - Textview delegate
-(void)textViewDidChange:(UITextView *)textView{
    UIEdgeInsets inset = UIEdgeInsetsZero;
    inset.top = textView.bounds.size.height-textView.contentSize.height;
    textView.contentInset = inset;
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
