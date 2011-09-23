//
//  YXDisclosureButtonCellInfo.m
//  YandexFoundation
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

NSString *const YXDisclosureButtonCellInfoDefaultReuseIdentidier = @"YXDisclosureButtonCellInfoDefaultReuseIdentidier";

#import "YXDisclosureButtonCellInfo.h"
#import "YXDisclosureCellInfo.h"

@implementation YXDisclosureButtonCellInfo

@synthesize disclosureAction = _disclosureAction;

+ (NSString *)defaultReuseIdentifier {
    return YXDisclosureButtonCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithTitle:(NSString *)title 
             target:(id)target 
             action:(SEL)action
   disclosureAction:(SEL)disclosureAction {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                  target:target
                                  action:action
                        disclosureAction:disclosureAction];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                       target:(id)delegate 
                       action:(SEL)action
             disclosureAction:(SEL)disclosureAction {
    YXDisclosureButtonCellInfo *cellInfo = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    [cellInfo setTitle:title];
    [cellInfo setTarget:delegate];
    [cellInfo setAction:action];
    [cellInfo setDisclosureAction:disclosureAction];
    
    return [cellInfo autorelease];
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
													reuseIdentifier:self.reuseIdentifier] autorelease];	
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

- (void)tableView:(UITableView *)tableView cellAccessoryButtonTapped:(UITableViewCell *)cell aIndexPath:(NSIndexPath *)indexPath {
    [_target performSelector:_disclosureAction withObject:self];
}

@end
