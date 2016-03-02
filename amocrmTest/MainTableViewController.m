//
//  MainTableViewController.m
//  amocrmTest
//
//  Created by Nikolay on 01.03.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import "MainTableViewController.h"
#import <JSONModelLib.h>
#import <AFNetworking.h>
#import "Response.h"
#import "Leads.h"
#import "Json.h"
#import "CustomTableViewCell.h"

@interface MainTableViewController ()
@property (strong, nonatomic) Json * json;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

  
    [self userAuth:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getLeads];
        });
    }];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];

    

}

-(void)refresh:(UIRefreshControl *)refreshed{
    [self getLeads];
    [refreshed endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

-(void) userrAuth{
    
    NSURL *baseURL = [NSURL URLWithString:@"https://nuttt.amocrm.ru/"];
    
    NSString *path = @"private/api/auth.php?type=json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"nikolay.malofeev@gmail.com" forKey:@"USER_LOGIN"];
    [parameters setObject:@"54c3eb970367457cccb29bd7229b85a3" forKey:@"USER_HASH"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];


}


- (void)userAuth:(void (^)(void))completion
{
    NSURL *baseURL = [NSURL URLWithString:@"https://nuttt.amocrm.ru/"];
    
    NSString *path = @"private/api/auth.php?type=json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"nikolay.malofeev@gmail.com" forKey:@"USER_LOGIN"];
    [parameters setObject:@"54c3eb970367457cccb29bd7229b85a3" forKey:@"USER_HASH"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion();
        }
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    
}

- (void)getLeads {
    self.json = [[Json alloc] initFromURLWithString:@"https://nuttt.amocrm.ru/private/api/v2/json/leads/list" completion:^(JSONModel *model, JSONModelError *err) {
        [self.tableView reloadData];
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Response *response = self.json.response;
    return response.leads.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Response *response = self.json.response;
    Leads *lead = [response.leads objectAtIndex:indexPath.row];
    
    cell.dealName.text = [NSString stringWithFormat:@"%@", lead.name];
    cell.dealPrice.text = [NSString stringWithFormat:@"%ld руб", (long)lead.price];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:lead.date_create];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *newdate=[formatter stringFromDate:date];
    cell.dealDate.text = [NSString stringWithFormat:@"%@",newdate];
    
    return cell;
}



@end
