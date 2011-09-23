//
//  MYCustomCellView.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "MYCustomCellView.h"


@implementation MYCustomCellView
@synthesize centerLabel = _centerLabel;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_centerLabel release];
    [super dealloc];
}

- (IBAction)addNewCellToTop:(id)sender {
    [[self delegate] customCellViewWantsToAddCellToTop:self];
}

- (IBAction)addNewCellToBottom:(id)sender {
    [[self delegate] customCellViewWantsToAddCellToBottom:self];
}

- (IBAction)deleteToLeft:(id)sender {
    [[self delegate] customCellView:self wantsToDeleteWithAnimation:UITableViewRowAnimationLeft];
}

- (IBAction)deleteToRight:(id)sender {
    [[self delegate] customCellView:self wantsToDeleteWithAnimation:UITableViewRowAnimationRight];
}

- (IBAction)deleteFadeOut:(id)sender {
    [[self delegate] customCellView:self wantsToDeleteWithAnimation:UITableViewRowAnimationFade];
}
@end
