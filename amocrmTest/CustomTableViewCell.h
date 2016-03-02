//
//  CustomTableViewCell.h
//  amocrmTest
//
//  Created by Nikolay on 01.03.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dealName;
@property (weak, nonatomic) IBOutlet UILabel *dealPrice;
@property (weak, nonatomic) IBOutlet UILabel *dealDate;

@end
