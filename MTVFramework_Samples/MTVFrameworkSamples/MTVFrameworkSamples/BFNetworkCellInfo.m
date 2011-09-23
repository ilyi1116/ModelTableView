//
//  BFNetworkCellInfo.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BFNetworkCellInfo.h"
#import "BFNetworkTableViewCell.h"

@implementation BFNetworkCellInfo

@synthesize networkTableViewCell = _networkTableViewCell;
@synthesize connecting = _connecting;
@synthesize connected = _connected;
@synthesize secure = _secure;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title target:(id)delegate action:(SEL)action disclosureAction:(SEL)disclosureAction {
    BFNetworkCellInfo *cellInfo = [[self alloc] initWithReuseIdentifier:@"networkTableViewCellID"];
    [cellInfo setTitle:title];
    [cellInfo setTarget:delegate];
    [cellInfo setAction:action];
    [cellInfo setDisclosureAction:disclosureAction];

    return [cellInfo autorelease];
}

- (void)dealloc {
    [_networkTableViewCell release];
    
    [super dealloc];
}

- (UITableViewCell *)tableViewCell {
    [[NSBundle mainBundle] loadNibNamed:@"BFNetworkTableViewCell" owner:self options:nil];
    UITableViewCell *loadedCell = [[_networkTableViewCell retain] autorelease];
    [self setNetworkTableViewCell:nil];
    return loadedCell;
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    // hidding default label since we use custom
    [[reusableCell textLabel] setHidden:YES];
    
    BFNetworkTableViewCell *cell = (BFNetworkTableViewCell *)reusableCell;
    
    [cell setSecure:_secure];
    [cell setChecked:_connected];
    [cell setInProgress:_connecting];
    [[cell networkNameLabel] setText:[self title]];
}

- (void)applyStyleForCell:(UITableViewCell *)aCell {	
	[super applyStyleForCell:aCell];
	
	BFNetworkTableViewCell *cell = (BFNetworkTableViewCell *)aCell;
	
	if (_connected) {
        [[cell networkNameLabel] setTextColor:[UIColor colorWithRed:76.0/255.0 green:86.0/255.0 blue:106.0/255.0 alpha:1.0]];
    }
    else {
        [[cell networkNameLabel] setTextColor:self.styleInfo.cellDefaultTextColor];
    }
	[[cell networkNameLabel] setFont:self.styleInfo.cellDefaultTextFont];
	[[cell networkNameLabel] setTextColor:self.styleInfo.cellDefaultTextColor];
	[[cell networkNameLabel] setHighlightedTextColor:self.styleInfo.cellDefaultTextColorHighlighted];
}

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    [self configureCell:tableViewCell];
    return NO;
}

- (void)setConnected:(BOOL)connected {
    _connected = connected;
    _connecting = NO;
    [self updateCellAppearenceAnimated:NO];
}

- (void)setConnecting:(BOOL)connecting {
    _connecting = connecting;
    [self updateCellAppearenceAnimated:NO];
}

- (void)setSecure:(BOOL)secure {
    _secure = secure;
    [self updateCellAppearenceAnimated:NO];
}

@end
