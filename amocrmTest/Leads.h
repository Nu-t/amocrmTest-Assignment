//
//  Leads.h
//  amocrmTest
//
//  Created by Nikolay on 01.03.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Leads
@end

@interface Leads : JSONModel
@property (strong, nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger price;
@property (assign,nonatomic) NSInteger date_create;
@end
