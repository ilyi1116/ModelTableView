//
//  YXKVOCheckmarkCell.m
//  YandexMaps
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXKVOCheckmarkCellInfo.h"


@implementation YXKVOCheckmarkCellInfo

@synthesize key = _key;
@synthesize object = _object;

- (void)dealloc {
    [_object removeObserver:self forKeyPath:_key];
    
	self.key = nil;
	self.object = nil;
	
	[super dealloc];
}

+ (id)cellWithTitle:(NSString *)title
              image:(UIImage  *)image
      observeObject:(id)object 
             forKey:(NSString *)key {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                   image:image
                           observeObject:object
                                  forKey:key];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						image:(UIImage *)image
                observeObject:(id)object 
                       forKey:(NSString *)key {
	YXKVOCheckmarkCellInfo * cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.title = title;
	cell.image = image;
	cell.selectionStyle = YXCellInfoSelectionStyleNone;
	cell.object = object;
	cell.key = key;
	cell.delegate = cell;
	cell.initialValueGetter = @selector(initialValue:);
	cell.changeHandler = @selector(checkmarkCell:changedValue:);
    
    [object addObserver:cell forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
	
	return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title
                        image:(UIImage *)image
                        group:(YXCheckmarkCellGroupInfo *)group
                     selected:(BOOL)selected {
    @throw @"YXKVOCheckmarkCellInfo does not support cellWithReuseIdentifier:title:image:group:selected: method";
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                        image:(UIImage *)image 
                 withDelegate:(id)delegate 
           initialValueGetter:(SEL)initialValueGetter 
                changeHandler:(SEL)changeHandler {
    @throw @"YXKVOCheckmarkCellInfo does not support cellWithReuseIdentifier:title:image:withDelegate:initialValueGetter:changeHandler: method";
}

+ (id)cellWithTitle:(NSString *)title 
              image:(UIImage *)image 
              group:(YXCheckmarkCellGroupInfo *)group 
           selected:(BOOL)selected {
    @throw @"YXKVOCheckmarkCellInfo does not support cellWithTitle:image:group:selected: method";
}

- (NSNumber *)initialValue:(YXCheckmarkCellInfo *)cell {
	return [_object valueForKey:_key];
}

- (void)checkmarkCell:(YXCheckmarkCellInfo *)cellInfo changedValue:(NSNumber *)value {
	[_object setValue:value forKey:_key];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [self object]) {
        [self updateCellAppearenceAnimated:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BOOL currentValue = [[_object valueForKey:_key] boolValue];
    BOOL newValue = !currentValue;
    [_object setValue:[NSNumber numberWithBool:newValue] forKey:_key];
}

@end
