//
//  TilekterViewController.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//
#import "SubCategoryCollectionViewCell.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import "TilekterViewController.h"
#import "TilekViewController.h"
#import <Parse/Parse.h>
#import "Tilek.h"

@interface TilekterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *tilekter;
@property (nonatomic) NSMutableArray *onlineTilekter;
@property (nonatomic) Tilek *tilek;
@property (nonatomic) UIColor *customPuprle;
@property (nonatomic) NSArray *hudTexts;
@property JGProgressHUD *HUD;

@end

@implementation TilekterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
    self.hudTexts = [[NSArray alloc] initWithObjects:@"Eң бастысы - шын жүректен айту :)", @"Айтар тілегіңіз қабыл болсын!", @"Жауынменен жер көгерер, батаменен ер көгерер", nil];
    NSLog(@"%i - index", self.hudIndex);
    
    self.customPuprle = [UIColor colorWithRed:209/255.0 green:138/255.0 blue:206/255.0 alpha:0.7];
    
    //setting up the backgound
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    backgroundView.image = [UIImage imageNamed:@"tilekBackground.png"];
    [self.view insertSubview:backgroundView atIndex:0];
    //end
    
    [self.navigationItem setTitle:self.subCategoryNameKaz];
    //setting up the collectionView
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SubCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.tilekter = [NSMutableArray new];
    self.onlineTilekter = [NSMutableArray new];
    
    /*
    Tilek *bataTuraly = [[Tilek alloc] initWithName:@"Bata beru turaly" andDescr:@"" andisLiked:NO];
    [self.tilekter addObject:bataTuraly];
    */
    
    [self getLocalData];
    [self getDataFromParse];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse methods
-(void) getDataFromParse{
    PFQuery *query = [PFQuery queryWithClassName:self.subCategoryName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                NSString *descr = object[@"descr"];
                Tilek *tilek = [[Tilek alloc] initWithName:name andDescr:descr andisLiked:NO];
                BOOL exists = NO;
                for (int i = 0; i < (int)self.tilekter.count; i++) {
                    Tilek *localTilek = self.tilekter[i];
                    if ([name isEqualToString:localTilek.name]) {
                        exists = YES;
                    }
                }
                if (!exists) {
                    [self.tilekter addObject:tilek];
                    [self.collectionView reloadData];
                    [object pinInBackground];
                }
                [self.onlineTilekter addObject:tilek];
            }
            for (int i = 0; i < (int)self.tilekter.count; i++) {
                BOOL exists = false;
                for (int j = 0; j < (int)self.onlineTilekter.count; j++) {
                    Tilek *localTilek = self.tilekter[i];
                    Tilek *onlineTilek = self.onlineTilekter[j];
                    if ([localTilek.name isEqualToString:onlineTilek.name] && [localTilek.descr isEqualToString:onlineTilek.descr]) {
                        exists = true;
                    }
                }
                if (!exists) {
                    for (PFObject *object in objects) {
                        Tilek *localTilek = self.tilekter[i];
                        NSString *name = localTilek.name;
                        if ([object[@"name"] isEqualToString:name]) {
                            [object unpinInBackground];
                            break;
                        }
                    }
                    [self.tilekter removeObjectAtIndex:i];
                    [self.collectionView reloadData];
                }
            }
            [self.HUD dismissAnimated:YES];
        }else{
            [self.HUD dismissAnimated:YES];
            NSLog(@"%@", error);
        }
    }];
}

-(void) getLocalData{
    PFQuery *query = [PFQuery queryWithClassName:self.subCategoryName];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                NSString *descr = object[@"descr"];
                Tilek *tilek = [[Tilek alloc] initWithName:name andDescr:descr andisLiked:NO];
                [self.tilekter addObject:tilek];
                [self.collectionView reloadData];
            }
            if ([self.tilekter count] == 0) {
                self.HUD.textLabel.text = self.hudTexts[self.hudIndex];
                [self.HUD showInView:self.view];
            }
        }else{
            NSLog(@"%@", error);
        }
    }];
}


#pragma mark - Collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.tilekter count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Tilek *tilek = self.tilekter[indexPath.row];
    cell.nameLabel.text = tilek.name;
    //cell.line.backgroundColor = [UIColor grayColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Tilek *tilek = self.tilekter[indexPath.row];
    self.tilek = tilek;
    [self performSegueWithIdentifier:@"ToTilek" sender:self];
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.purpleLight.backgroundColor = self.customPuprle;
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.purpleLight.backgroundColor = [UIColor clearColor];
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 60);
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
