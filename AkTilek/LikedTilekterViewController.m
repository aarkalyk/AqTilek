//
//  LikedTilekterViewController.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "SubCategoryCollectionViewCell.h"
#import "LikedTilekterViewController.h"
#import "TilekViewController.h"
#import "Tilek.h"

@interface LikedTilekterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *likedTilekterNames;
@property (nonatomic) NSMutableArray *likedTilekterDescr;
@property (nonatomic) UIColor *customPurple;
@property (nonatomic) Tilek *tilek;
@property (nonatomic) UILabel *placeHolderText;

@end

@implementation LikedTilekterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.placeHolderText = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/2, CGRectGetWidth(self.view.frame)-50, 30)];
    
    self.customPurple = [UIColor colorWithRed:209/255.0 green:138/255.0 blue:206/255.0 alpha:0.7];
    
    //setting up the backgound
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    backgroundView.image = [UIImage imageNamed:@"tilekBackground.png"];
    [self.view insertSubview:backgroundView atIndex:0];
    //end
    
    [self.navigationItem setTitle:@"Ұнатқан тілектеріңіз"];
    //getting data from local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.likedTilekterNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"likedTilekterNames"]];
    self.likedTilekterDescr = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"likedTilekterDescr"]];
    if ([self.likedTilekterNames count] == 0) {
        self.likedTilekterNames = [NSMutableArray new];
        self.likedTilekterDescr = [NSMutableArray new];
    }
    
    //setting up the collectionView
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SubCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.likedTilekterNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"likedTilekterNames"]];
    self.likedTilekterDescr = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"likedTilekterDescr"]];
    [self.view addSubview:self.placeHolderText];
    self.placeHolderText.hidden = YES;
    NSLog(@"%i", (int)self.likedTilekterNames.count);
    if ([self.likedTilekterNames count] == 0) {
        /*
        UIImageView *placeHolder = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 65, CGRectGetHeight(self.view.frame)/2 - 50, 75, 75)];
        placeHolder.image = [UIImage imageNamed:@"starGray.png"];
        [self.view addSubview:placeHolder];
        */

        self.placeHolderText.text = @" Ұнатқан тілектеріңіз жоқ";
        self.placeHolderText.textAlignment = UITextAlignmentCenter;
        [self.placeHolderText setFont:[UIFont fontWithName:@"Helvetica-Light" size:20]];
        self.placeHolderText.textColor = [UIColor grayColor];
        self.placeHolderText.hidden = NO;
        self.likedTilekterNames = [NSMutableArray new];
        self.likedTilekterDescr = [NSMutableArray new];
    }
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.likedTilekterNames count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.nameLabel.text = self.likedTilekterNames[(self.likedTilekterNames.count-1)];
    }else{
        cell.nameLabel.text = self.likedTilekterNames[indexPath.row%(self.likedTilekterNames.count-1)];
    }
    
    //cell.line.backgroundColor = [UIColor grayColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name;
    NSString *descr;
    if (indexPath.row == 0) {
        name = self.likedTilekterNames[(self.likedTilekterNames.count-1)];
        descr = self.likedTilekterDescr[(self.likedTilekterNames.count-1)];
    }else{
        name = self.likedTilekterNames[indexPath.row%(self.likedTilekterNames.count-1)];
        descr = self.likedTilekterDescr[indexPath.row%(self.likedTilekterDescr.count-1)];
    }
    
    self.tilek = [[Tilek alloc] initWithName:name andDescr:descr andisLiked:YES];
    [self performSegueWithIdentifier:@"toLikedTilek" sender:self];
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.purpleLight.backgroundColor = self.customPurple;
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.purpleLight.backgroundColor = [UIColor clearColor];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 60);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TilekViewController class]]) {
        TilekViewController *VC = segue.destinationViewController;
        VC.tilek = self.tilek;
    }
}


@end
