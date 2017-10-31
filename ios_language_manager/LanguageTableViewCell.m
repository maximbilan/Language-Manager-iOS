//
//  LanguageTableViewCell.m
//  ios_language_manager
//
//  Created by Ali Riahipour on 10/31/17.
//  Copyright © 2017 Maxim Bilan. All rights reserved.
//

#import "LanguageTableViewCell.h"

@interface LanguageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *languageNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tickImage;

@end

@implementation LanguageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLanguageName:(NSString *)name andIsSelected:(BOOL)selected {
    self.languageNameLabel.text = name;
    [self.tickImage setHidden:!selected];
}

@end
