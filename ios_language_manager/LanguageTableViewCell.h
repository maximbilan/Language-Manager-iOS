//
//  LanguageTableViewCell.h
//  ios_language_manager
//
//  Created by Ali Riahipour on 10/31/17.
//  Copyright © 2017 Maxim Bilan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageTableViewCell : UITableViewCell
- (void)setLanguageName:(NSString *)name andIsSelected:(BOOL)selected;
@end
