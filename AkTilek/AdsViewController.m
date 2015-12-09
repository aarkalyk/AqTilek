//
//  AdsViewController.m
//  AkTilek
//
//  Created by Marat on 22.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//
#import <JGProgressHUD/JGProgressHUD.h>
#import "AdsCollectionViewCell.h"
#import "AdsViewController.h"
#import <Parse/Parse.h>
#import "Offer.h"

@interface AdsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *offers;

@end

@implementation AdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Offers"];
    
    self.offers = [NSMutableArray new];
    
    //setting up the colectionView
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[AdsCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    //end
    
    [self getDataFromParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse methods
-(void) getDataFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Offers"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
            HUD.textLabel.text = @"Біздің ұсыныстар тек қана сіз үшін!";
            [HUD showInView:self.view];
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                NSString *descr = object[@"descr"];
                NSString *link = object[@"link"];
                NSLog(@"%@", name);
                PFFile *file = object[@"image"];
                [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                    UIImage *image = [UIImage imageWithData:data];
                    Offer *offer = [[Offer alloc] initWithName:name andDescr:descr andImage:image andURL:link];
                    [self.offers addObject:offer];
                    [self.collectionView reloadData];
                }];
            }
            [HUD dismissAnimated:YES];
        }else{
            NSLog(@"%@", error);
        }
    }];
}


#pragma mark - CollectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.offers count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AdsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Offer *offer = self.offers[indexPath.row];
    
    cell.nameLabel.text = offer.name;
    cell.nameLabel.textColor = [UIColor whiteColor];
    cell.descrTextView.text = offer.descr;
    cell.imageView.image = offer.image;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Offer *offer = self.offers[indexPath.row];
    NSLog(@"pressed");
    NSURL *url = [NSURL URLWithString:offer.stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 140);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
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
