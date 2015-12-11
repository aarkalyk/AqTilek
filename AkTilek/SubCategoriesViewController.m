//
//  SubCategoriesViewController.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "SubCategoryCollectionViewCell.h"
#import "SubCategoriesViewController.h"
#import "TilekterViewController.h"
#import <Parse/Parse.h>

@interface SubCategoriesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *Lifetime;
@property (nonatomic) NSArray *National;
@property (nonatomic) NSArray *Batas;
@property (nonatomic) NSArray *LifetimeKaz;
@property (nonatomic) NSArray *NationalKaz;
@property (nonatomic) NSArray *BatasKaz;

@property (nonatomic) NSMutableArray *mainArray;
@property (nonatomic) NSMutableArray *mainArrayKaz;
@property (nonatomic) NSMutableArray *onlineBatalar;

@property (nonatomic) NSString *subCategoryName;
@property (nonatomic) NSString *subCategoryNameKaz;
@property (nonatomic) UIColor *customPuprle;


@end

@implementation SubCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting up the backgound
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    backgroundView.image = [UIImage imageNamed:@"tilekBackground.png"];
    [self.view insertSubview:backgroundView atIndex:0];
    //end
    
    self.customPuprle = [UIColor colorWithRed:209/255.0 green:138/255.0 blue:206/255.0 alpha:0.7];
    
    [self.navigationItem setTitle:self.categoryNameKaz];
    
    self.Lifetime = [[NSArray alloc] initWithObjects:@"Shildekhana", @"Besik", @"Sundet", @"Tusaukeser", @"Tilashar", @"SchoolCollege", @"SyrgaTagu", @"Kudalyk", @"QyzUzatu", @"Wedding", @"Konys", @"KumisToy", @"AltynToy", @"Brithday", @"ToyOwner", nil];
    self.National = [[NSArray alloc] initWithObjects:@"NewYear", @"WomensDay", @"Nauryz", @"Kurban", @"NationUnionDay", @"ConstitutionDay", @"VictoryDay", @"DefendersDay", @"IndependenceDay", nil];
    self.Batas = [[NSArray alloc] initWithObjects:@"Sadaqa", @"Sundet", nil];
    self.LifetimeKaz = [[NSArray alloc] initWithObjects:@"Шілдехана", @"Бесік тойы", @"Сүндет той", @"Тұсаукесер", @"Тілашар", @"Мектеп/Университет түлегі тойы", @"Сырға тағу", @"Құдалық", @"Қыз ұзату", @"Үйлену тойы", @"Қоныс тойы", @"Күміс Той", @"Алтын Той", @"Туған күн", @"Той иесінің сөзі", nil];
    self.NationalKaz = [[NSArray alloc] initWithObjects:@"Жаңа жыл", @"Әйелдер күні", @"Наурыз", @"Құрбан айт", @"Қазақстан халқының бірлігі күні", @"Конституция күні", @"Жеңіс күні", @"Отан қорғаушылар күні", @"Тәуелсіздік күні", nil];
    
    if ([self.categoryName isEqualToString: @"Lifetime"]) {
        self.mainArray = [[NSMutableArray alloc] initWithArray:self.Lifetime];
        self.mainArrayKaz = [[NSMutableArray alloc] initWithArray:self.LifetimeKaz];
    }
    if ([self.categoryName isEqualToString: @"National"]) {
        self.mainArray = [[NSMutableArray alloc] initWithArray:self.National];
        self.mainArrayKaz = [[NSMutableArray alloc] initWithArray:self.NationalKaz];
    }
    if ([self.categoryName isEqualToString: @"Batas"]) {
        self.mainArray = [NSMutableArray new];
        self.mainArrayKaz = [NSMutableArray new];
        self.onlineBatalar = [NSMutableArray new];
        [self.mainArray addObject:@"BataTuraly"];
        [self.mainArrayKaz addObject:@"Бата туралы"];
        
        [self getLocalBatas];
        [self getBatasFromParse];
    }
    
    //setting up the colectionView
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SubCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    NSLog(@"%@", self.categoryName);
    
    [self.collectionView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Parse delegate
-(void) getBatasFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"BataCategories"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *nameKaz = object[@"nameKaz"];
                NSString *nameEng = object[@"nameEng"];
                
                BOOL exists = NO;
                for (int i = 1; i < (int)self.mainArray.count; i++) {
                    if ([nameKaz isEqualToString:self.mainArrayKaz[i]]) {
                        exists = YES;
                        break;
                    }
                }
                [self.onlineBatalar addObject:nameEng];
                
                if (!exists) {
                    [self.mainArray addObject:nameEng];
                    [self.mainArrayKaz addObject:nameKaz];
                    [object pinInBackground];
                }
            }
        }else{
            NSLog(@"%@", error);
        }
    }];
}

-(void) getLocalBatas{
    PFQuery *query = [PFQuery queryWithClassName:@"BataCategories"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *nameKaz = object[@"nameKaz"];
                NSString *nameEng = object[@"nameEng"];
                [self.mainArray addObject:nameEng];
                [self.mainArrayKaz addObject:nameKaz];
            }
            [self.collectionView reloadData];
        }else{
            NSLog(@"%@", error);
        }
    }];
}

-(void) updateLocalData{
    PFQuery *query = [PFQuery queryWithClassName:@"BataCategories"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (int i = 1; i < (int)self.mainArray.count; i++) {
                BOOL exists = NO;
                for (int j = 0; j < (int)self.onlineBatalar.count; j++) {
                    NSString *localName = self.mainArray[i];
                    NSString *onlineName = self.onlineBatalar[j];
                    if ([localName isEqualToString:onlineName]) {
                        exists = YES;
                        break;
                    }
                }
                if (!exists) {
                    for (PFObject *object in objects) {
                        NSString *nameEng = self.mainArray[i];
                        if ([nameEng isEqualToString:object[@"nameEng"]]) {
                            [object unpinInBackground];
                        }
                    }
                    [self.mainArray removeObjectAtIndex:i];
                    [self.mainArrayKaz removeObjectAtIndex:i];
                }
            }
        }else{
            NSLog(@"%@", error);
        }
        [self.collectionView reloadData];
    }];
}


#pragma mark - CollectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.mainArray count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if ([self.categoryName isEqualToString:@"Batas"] && indexPath.row == 0){
        NSLog(@"%@ -- ", self.mainArray[indexPath.row]);
        cell.starImageView.image = [UIImage imageNamed:@"starPurple.png"];
    }else{
        cell.starImageView.image = [UIImage imageNamed:@""];
    }
    
    cell.nameLabel.text = self.mainArrayKaz[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@ -- ", self.mainArray[indexPath.row]);
    if (indexPath.row == 0 && [self.categoryName isEqualToString:@"Batas"]) {
        self.subCategoryName = self.mainArray[indexPath.row];
        self.subCategoryNameKaz = self.mainArrayKaz[indexPath.row];
        [self performSegueWithIdentifier:@"bataTuraly" sender:self];
    }else{
        self.subCategoryName = self.mainArray[indexPath.row];
        self.subCategoryNameKaz = self.mainArrayKaz[indexPath.row];
        [self performSegueWithIdentifier:@"ToTilekter" sender:self];
    }
}


-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    SubCategoryCollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.purpleLight.backgroundColor = self.customPuprle;
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
    if ([segue.destinationViewController isKindOfClass:[TilekterViewController class]]) {
        TilekterViewController *VC = segue.destinationViewController;
        VC.subCategoryName = self.subCategoryName;
        VC.subCategoryNameKaz = self.subCategoryNameKaz;
        VC.hudIndex = self.hudIndex;
    }
}


@end
