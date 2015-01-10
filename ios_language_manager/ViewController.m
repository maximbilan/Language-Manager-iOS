//
//  ViewController.m
//  ios_language_manager
//
//  Created by Maxim Bilan on 12/23/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *data;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    data = [LanguageManager languageStrings];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ELanguageCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
