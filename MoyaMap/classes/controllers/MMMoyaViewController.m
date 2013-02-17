//
//  MMMoyaViewController.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaViewController.h"
#import "MMMoyaTag.h"
#import "MMMoyaActivity.h"
#import "MMMoyaActivityCell.h"
#import "MMLoadingCell.h"

@interface MMMoyaViewController ()
{
    NSArray *moyas;
}
@end

@implementation MMMoyaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *resource_uri = _moyatag.resource_uri;
    NSString *slug = [resource_uri substringFromIndex:[@"/api/tag" length] + 1];
    NSArray *keys = [NSArray arrayWithObjects:@"format", @"limit", @"page__page_tags__tags__slug", nil];
    NSArray *values = [NSArray arrayWithObjects:@"json", @"0", slug, nil];
    
    moyas = nil;
    [MMMoyaActivity fetchAsyncWithParams:[NSDictionary dictionaryWithObjects:values forKeys:keys] async:^(NSArray *allRemote, NSError *error){
        [self showMoyas:allRemote];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = RGB(167, 191, 46);
    self.labelTag.text = [NSString stringWithFormat:@"タグ：%@",_moyatag.name];
}

- (void)showMoyas:(NSArray *)_moyas{
    moyas = _moyas;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (moyas == nil){
        return 1;
    }else{
        return [moyas count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MMMoyaActivityCell";
    if (!moyas){
        MMLoadingCell *cell = [[MMLoadingCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMLoadingCell"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = @"ローディング中・・・";
        cell.textLabel.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    MMMoyaActivity *activity = [moyas objectAtIndex:indexPath.row];
    MMMoyaActivityCell *acell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!acell){
        acell = [[MMMoyaActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    acell.name.text = activity.user_name;
    acell.message.text = activity.message;
    acell.image.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:activity.picture_url ]] ];
    acell.time.text = [activity strTime];
    
    return acell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.footerView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footerView;
}


- (IBAction)pressClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setFooterView:nil];
    [self setLabelTag:nil];
    [super viewDidUnload];
}
@end
