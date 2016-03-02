//
//  Response.h
//  amocrmTest
//
//  Created by Nikolay on 01.03.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Leads.h"

@protocol Response
@end
@interface Response : JSONModel
@property (assign, nonatomic) NSInteger server_time;
@property (strong, nonatomic) NSArray<Leads> * leads;
@end
