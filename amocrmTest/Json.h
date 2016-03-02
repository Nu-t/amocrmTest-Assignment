//
//  Json.h
//  amocrmTest
//
//  Created by Nikolay on 01.03.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Response.h"

@interface Json : JSONModel
@property (strong, nonatomic) Response *response;

@end
