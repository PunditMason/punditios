//
//  BLCountriesVC.m
//  WowzaGoCoderSDKSampleApp
//
//  Created by Gaurav Verma on 14/10/16.
//  Copyright © 2016 Wowza, Inc. All rights reserved.
//

#import "BLCountriesVC.h"
#import "BLCountriesCell.h"


@interface BLCountriesVC (){
    BOOL mIsSearching;
}

@end

@implementation BLCountriesVC

@synthesize mSearchResults,mAllRecods,mSectionIndexArray,mDataDict;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mIsSearching = false;
    mSearchResults = [[NSMutableArray alloc] init];
    mAllRecods = [[NSMutableArray alloc] initWithArray:[self fetchCountries]];
    
    mSectionIndexArray = [[NSMutableArray alloc] init];
    //self.mSectionIndexArray = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    

    self.mDataDict = [self fillingDictionary:self.mAllRecods];
    self.mTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.mTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.mTableView.sectionIndexColor = [UIColor darkGrayColor];
    self.mTableView.hidden = NO;
    self.mNoDataLable.hidden = YES;
}

-(NSMutableDictionary *)fillingDictionary:(NSMutableArray *)ary {
    for(BLCountry *obj in self.mAllRecods) {
        
        //if ([obj objectForKey:kUSER_LN]) {
        char charval=[obj.mCountryName characterAtIndex:0];
        NSString *charStr=[NSString stringWithUTF8String:&charval];
        charStr = [obj.mCountryName substringToIndex:1];
        if (![self.mSectionIndexArray containsObject:charStr]) {
        [self.mSectionIndexArray addObject:charStr];    
        }
        
    }
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    for (NSString *str in self.mSectionIndexArray) {
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
    for(BLCountry *obj in self.mAllRecods) {
        
            //if ([obj objectForKey:kUSER_LN]) {
            char charval=[obj.mCountryName characterAtIndex:0];
            NSString *charStr=[NSString stringWithUTF8String:&charval];
            charStr = [obj.mCountryName substringToIndex:1];
            charStr = [charStr uppercaseString];
        if ([charStr isEqualToString:str]) {
            [subArray addObject:obj];
        }
        
    }
        [dic setObject:subArray forKey:str];
        }
    return dic;
}


- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark------------------------------------------------------------------
#pragma mark Table View Delegates
#pragma mark------------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (mIsSearching == true) {
        return 1;
    }
    else {
    return [self.mSectionIndexArray count];
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (mIsSearching == true) {
        return [self.mSearchResults count];
    }
    else {
        
        
        return [(NSArray *) [self.mDataDict objectForKey:[self.mSectionIndexArray objectAtIndex:section]] count];
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"serchcell";
    BLCountriesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (mIsSearching == true) {
        [cell setCountry:[self.mSearchResults objectAtIndex:indexPath.row]];
    }
    else {
        
        
    [cell setCountry:[[self.mDataDict objectForKey:[self.mSectionIndexArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dct = nil;
    
    
    if (mIsSearching == true) {
        dct = [NSDictionary dictionaryWithObjectsAndKeys:[self.mSearchResults objectAtIndex:indexPath.row],@"val", nil];
    }
    else {
        dct = [NSDictionary dictionaryWithObjectsAndKeys:[[self.mDataDict objectForKey:[self.mSectionIndexArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row],@"val", nil];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNOTIFICATION_COUNTRIES" object:nil userInfo:dct];
    
    

    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString* searchString = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    if ([searchString length]>0) {
        mIsSearching = true;
    }
    else {
        mIsSearching = false;
    }
    if(searchString.length > 0 ) {
        
        [self filterContentForSearchText:searchString scope:@""];
        NSLog(@"%@",searchString);
    }
    else{
        self.mSearchBar.text = @"";
        
        
        [self setUpInitialData];
        
    }
    [self.mTableView reloadData];
    return YES;
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"mSearchString contains[c] %@", searchText];
    NSArray *tempSearchAry = [mAllRecods filteredArrayUsingPredicate:resultPredicate];
    [self.mSearchResults removeAllObjects];
    [self.mSearchResults addObjectsFromArray:tempSearchAry];
    [self.mSearchResults sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"mCountryName" ascending:YES]]];
    [self.mTableView reloadData];
    
    if ([self.mSearchResults count]>0) {
        self.mTableView.hidden = NO;
        self.mNoDataLable.hidden = YES;
    }
    else {
        self.mTableView.hidden = YES;
        self.mNoDataLable.hidden = NO;
    }
}

-(void)setUpInitialData {
    [self.mSearchBar resignFirstResponder];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!mAllRecods) {
            mAllRecods = [[NSMutableArray alloc] init];
        }
        [self.mAllRecods removeAllObjects];
        [self.mAllRecods addObjectsFromArray:[self fetchCountries]];
        [self.mAllRecods sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"mCountryName" ascending:YES]]];
        [self.mTableView reloadData];
    });
    
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (mIsSearching == true) {
        return nil;
    }
    else {
    return self.mSectionIndexArray;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    if (mIsSearching == true) {
        return 0;
    }
    else {
    return index;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (mIsSearching == true) {
        return @"";
    }
    else {
    return [self.mSectionIndexArray objectAtIndex:section];
    }
    return @"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    mIsSearching = false;
    [self setUpInitialData];
    self.mNoDataLable.hidden = YES;
    self.mTableView.hidden = NO;
}





#pragma mark Fetch all Countries


-(NSArray *)fetchCountries {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // NSLog(@"%@",data);
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray *countryModelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *countryDict in json) {
        BLCountry *country = [[BLCountry alloc] init];
        NSString *mSearchString = [NSString stringWithFormat:@"%@%@",[countryDict objectForKey:@"name"],[countryDict objectForKey:@"dial_code"]];
        country.mCountryName = [countryDict objectForKey:@"name"];
        country.mCountryCode = [countryDict objectForKey:@"dial_code"];
        country.mSearchString = mSearchString;
        [countryModelArray addObject:country];
    }
    return (NSArray *)countryModelArray;
}





@end
