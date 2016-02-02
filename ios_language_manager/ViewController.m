//
//  ViewController.m
//  ios_language_manager
//
//  Created by Maxim Bilan on 12/23/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"
#import "AppDelegate.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSArray *data;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomRightLabel;
@property (weak, nonatomic) IBOutlet UIButton *imagePickerButton;

@property (nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    data = [LanguageManager languageStrings];
    
    self.bottomLeftLabel.text = NSLocalizedString(@"Happy New Year", @"");
    self.bottomRightLabel.text = @"ПТНПНХ";
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
    if (indexPath.row == [LanguageManager currentLanguageIndex]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [LanguageManager saveLanguageByIndex:indexPath.row];

    [self.tableView reloadData];
    [self reloadRootViewController];
}

- (void)reloadRootViewController
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSString *storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    delegate.window.rootViewController = [storyboard instantiateInitialViewController];
}

#pragma mark - UIImagePickerController

- (IBAction)imagePickerButton:(UIButton *)sender
{
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	
	self.imagePickerController = imagePickerController;
	[self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissViewControllerAnimated:YES completion:NULL];
	self.imagePickerController = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
