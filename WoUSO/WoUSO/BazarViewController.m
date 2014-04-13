//
//  BazarViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "BazarViewController.h"

@interface BazarViewController ()

@end

@implementation BazarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.helper = [[ApiHelper alloc] init];
    [self getBazaar];
}

- (void)getBazaar
{
    self.tableContent = [[self.helper getAvailableSpells] objectForKey:@"spells"];
}

-(void)getSummary
{
    NSDictionary * inventory = [self.helper getInventorySpells];
    self.tableContent = [inventory objectForKey:@"spells_available"];
    self.spellsCast = [inventory objectForKey:@"spells_cast"];
    self.spellsOnMe = [inventory objectForKey:@"spells_onme"];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:(YES)];
}

-(void)showBazaar
{
    [self.button1_selected setHidden:(false)];
    [self.button2_selected setHidden:(true)];
    [self getBazaar];
    [self.tableView reloadData];
}

-(void)showSummary
{
    [self.button1_selected setHidden:(true)];
    [self.button2_selected setHidden:(false)];
    [self getSummary];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.button1_selected.isHidden == false)
        return 1;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableContent.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (self.button1_selected)
        return 0;
    else
        return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellType;
    if (self.button1_selected.isHidden == false)
        cellType = @"BazaarCell";
    else
        cellType = @"BazaarSummary";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    if (self.button1_selected.isHidden == false)
    {
        NSString * title = [[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"title"];
        NSString * dueDays = [[[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"due_days"] stringValue];
        NSString * price = [[[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"price"] stringValue];
        NSString * imgURL = [[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"image_url"];
        imgURL = [NSString stringWithFormat:@"https://wouso.cs.pub.ro/next%@", imgURL];
        UIImage * img = [self.helper getImageForURL:imgURL];
        UIImageView * spellImageView = (UIImageView*)[cell viewWithTag:1];
        UILabel * spellNameLabel = (UILabel *)[cell viewWithTag:2];
        UILabel * goldLabel = (UILabel *)[cell viewWithTag:4];
        UILabel * dueLabel = (UILabel *)[cell viewWithTag:3];
        spellImageView.image = img;
        spellNameLabel.text = title;
        goldLabel.text = price;
        dueLabel.text = dueDays;
    }
    else
    {
        NSString * title;
        NSString * dueDays;
        NSString * amount;
        NSString * imgUrl;
        UIImage * img;
        UILabel * buyButtonText = (UILabel *)[cell viewWithTag:6];
        UIImageView * buyButtonBg = (UIImageView *)[cell viewWithTag:7];
        UIImageView * goldImageView = (UIImageView * )[cell viewWithTag:5];
        [buyButtonText setHidden:YES];
        [buyButtonBg setHidden:YES];
        [goldImageView setHidden:YES];
        UIImageView * spellImageView = (UIImageView*)[cell viewWithTag:1];
        UILabel * spellNameLabel = (UILabel *)[cell viewWithTag:2];
        UILabel * goldLabel = (UILabel *)[cell viewWithTag:3];
        UILabel * dueLabel = (UILabel *)[cell viewWithTag:4];
        switch (indexPath.section) {
            case 0:
                title = [[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"spell_title"];
                dueDays = [[[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"due_days"] stringValue];
                amount = [[[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"amount"] stringValue];
                imgUrl = [[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"image_url"];
                imgUrl = [NSString stringWithFormat:@"http://wouso.cs.pub.ro/next%@", imgUrl];
                img = [self.helper getImageForURL:imgUrl];
                spellNameLabel.text = title;
                goldLabel.text = amount;
                dueLabel.text = dueDays;
                spellImageView.image = img;
                break;
            case 1:
                
                break;
            case 2:
                break;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.button1_selected.isHidden == false)
    {
        NSString * spellId = [[[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"id"] stringValue];
        BOOL reply = [self.helper buySpell:spellId];
        NSString * spellName = [[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"title"];
        NSString *mesaj;
        if (reply == true)
        {
            mesaj = [NSString stringWithFormat:@"Ai cumparat %@",spellName];
        }
        else
        {
            mesaj = [NSString stringWithFormat:@"Nu se poate cumpara %@", spellName];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Bazaar" message: mesaj
                                                       delegate: nil
                                                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
