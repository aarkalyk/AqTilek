//
//  ViewController.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//
#import "SubCategoriesViewController.h"
#import "CategoryCollectionViewCell.h"
#import "AdsViewController.h"
#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *categoryNames;
@property (nonatomic) NSArray *categoryNamesKaz;
@property (nonatomic) NSString *categoryName;
@property (nonatomic) NSString *categoryNameKaz;
@property (nonatomic) int hudIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Loaded!!!");
    //setting images to tabbar items
    [[[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"homePurple.png"] withFinishedUnselectedImage:[[UIImage imageNamed:@"homeWhite.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.tabBarController.viewControllers objectAtIndex:1] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"starPurple.png"] withFinishedUnselectedImage:[[UIImage imageNamed:@"starWhite.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.tabBarController.viewControllers objectAtIndex:2] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"aboutPurple.png"] withFinishedUnselectedImage:[[UIImage imageNamed:@"aboutWhite.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //end
    
    //setting up the navigation bar
    self.navigationItem.title = @"Ақ Тілек";
    //end
    
    //background image
    if (CGRectGetHeight(self.view.frame) < 519) {
        double width = 240;
        double height = 320;
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-width, 60, width, height)];
        backgroundImageView.image = [UIImage imageNamed:@"background.png"];
        [self.view insertSubview:backgroundImageView atIndex:0];
    }else{
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        backgroundImageView.image = [UIImage imageNamed:@"background.png"];
        [self.view insertSubview:backgroundImageView atIndex:0];
    }
    
    
    if (CGRectGetHeight(self.view.frame) > 568) {
        UIImageView *bottomOrnamnetView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, CGRectGetHeight(self.view.frame)-150, 170, 80)];
        bottomOrnamnetView.image = [UIImage imageNamed:@"bottomOrnament.png"];
        [self.view addSubview:bottomOrnamnetView];
    }
    //end
    
    //setting up the collectionView
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    /*setting a background image to the collectionView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame))];
    imageView.image = [UIImage imageNamed:@"background.png"];
    self.collectionView.backgroundView = imageView;
    */
    
    //setting up the categories array
    self.categoryNames = [NSArray arrayWithObjects:@"National", @"Lifetime", @"Batas", @"Offers", nil];
    self.categoryNamesKaz = [NSArray arrayWithObjects:@"Халық мерекелері", @"Жеке тұлға", @"Баталар", @"Пайдалы ақпарат", nil];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.categoryNames count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.name.text = self.categoryNamesKaz[indexPath.row];
    cell.name.textAlignment = UITextAlignmentCenter;
    cell.name.textColor = [UIColor whiteColor];
    
    if(CGRectGetHeight(self.view.frame) > 568){
        [cell.name setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:15]];
    }else{
        [cell.name setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:13]];
    }
    cell.imageView.image = [UIImage imageNamed:@"image.png"];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.categoryName = self.categoryNames[indexPath.row];
    self.categoryNameKaz = self.categoryNamesKaz[indexPath.row];
    if ([self.categoryName isEqualToString:@"Offers"]) {
        NSLog(@"%@", self.categoryName);
        [self performSegueWithIdentifier:@"toOffer" sender:self];
    }else{
        NSLog(@"%i ---", indexPath.row);
        self.hudIndex = indexPath.row;
        [self performSegueWithIdentifier:@"toSubCategory" sender:self];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)/4, 70);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    NSLog(@"%f", CGRectGetHeight(self.view.frame));
    if (CGRectGetHeight(self.view.frame) < 519) {
        return UIEdgeInsetsMake(50, 0, 0, 0);
    }
    if (CGRectGetHeight(self.view.frame) == 519) {
        return UIEdgeInsetsMake(136, 0, 0, 0);
    }if(CGRectGetHeight(self.view.frame) == 618){
        return UIEdgeInsetsMake(166, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(205, 0, 0, 0);
    }
}

#pragma mark - Segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[SubCategoriesViewController class]]) {
        SubCategoriesViewController *VC = segue.destinationViewController;
        VC.categoryName = self.categoryName;
        VC.categoryNameKaz = self.categoryNameKaz;
        VC.hudIndex = self.hudIndex;
    }
}

@end
