//
//  LDTwoLevelTableView.m
//  TwoLevelMenu
//
//  Created by Lilac on 13-12-26.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDTwoLevelTableView.h"

@implementation LDTwoLevelTableView
@synthesize level0TableView;
@synthesize level1TableView;
@synthesize dataDicArray;
@synthesize level0Array;
@synthesize level1Array;
@synthesize dropdownBtn;
@synthesize delegate;
@synthesize isOpen;
@synthesize isTwoLevel;
@synthesize selected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    level0TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 160, 250) style:UITableViewStylePlain];
    level0TableView.delegate = self;
    level0TableView.dataSource = self;
    
    level1TableView = [[UITableView alloc]initWithFrame:CGRectMake(160, 0, 160, 250) style:UITableViewStylePlain];
    level1TableView.delegate = self;
    level1TableView.dataSource = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Filter" ofType:@"plist"];
    dataDicArray = [NSArray arrayWithContentsOfFile:path];
    level0Array = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i< dataDicArray.count; i++) {
        NSString *key = [[dataDicArray objectAtIndex:i] objectForKey:@"State"];
        [level0Array addObject:key];
    }
    level1Array = [[dataDicArray objectAtIndex:0] objectForKey:@"Cities"];
    
    dropdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropdownBtn setFrame:CGRectMake(0, 250, 320, 30)];
    [dropdownBtn setBackgroundImage:[UIImage imageNamed:@"dropdown_packup.png"] forState:UIControlStateNormal];
    [dropdownBtn setBackgroundImage:[UIImage imageNamed:@"dropdown_packup.png"] forState:UIControlStateHighlighted];
    
    [dropdownBtn addTarget:self action:@selector(dropdownBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dropdownBtn];
    
    UIPanGestureRecognizer *handleDragGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragMenu:)];
    handleDragGestureRecognizer.minimumNumberOfTouches = 1;
    handleDragGestureRecognizer.maximumNumberOfTouches = 1;
    [dropdownBtn addGestureRecognizer:handleDragGestureRecognizer];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:level0TableView];
    [self addSubview:level1TableView];
}

-(void)dropdownBtnPressed
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.center = CGPointMake(self.frame.size.width / 2, -self.frame.size.height / 2);
                     }
                     completion:NULL];
}

- (void)dragMenu:(UIPanGestureRecognizer *)sender
{
    if ([sender state] == UIGestureRecognizerStateChanged)
    {
        CGPoint gesturePosition = [sender translationInView:dropdownBtn];
        CGPoint newPosition = gesturePosition;
        
        newPosition.x = self.frame.size.width / 2;

        if (isOpen) {
            if (newPosition.y < dropdownBtn.frame.size.height)
            {
                newPosition.y += (self.frame.size.height + dropdownBtn.frame.size.height)/ 2;
                
                [self setCenter:newPosition];
            }
        }else{
            
        }

        [self setCenter:newPosition];

    }
    else if ([sender state] == UIGestureRecognizerStateEnded)
    {
        [self animatePullUp];
    }
}

-(void)animatePullUp
{
    [UIView animateWithDuration:0.3f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (isOpen) {
                             self.center = CGPointMake(self.frame.size.width / 2, -self.frame.size.height / 2);
                         }else{
                             self.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 30);
                         }
                         isOpen = !isOpen;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if ([tableView isEqual:self.level0TableView])
    {
        return level0Array.count;
    }else{
        return level1Array.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    if ([tableView isEqual:self.level0TableView]) {
        cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        cell.textLabel.text = [level0Array objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    }else if([tableView isEqual:self.level1TableView]){
        cell.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        cell.textLabel.text = [level1Array objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.level0TableView]) {
        
        if (isTwoLevel) {
            NSArray *cities = [[dataDicArray objectAtIndex:indexPath.row] objectForKey:@"Cities"];
            level1Array = [NSArray arrayWithArray:cities];
            [level1TableView reloadData];
            [self addSubview:level1TableView];
        }else{
            [self.delegate menuItemSelected:indexPath withFilterStyle:[level0Array objectAtIndex:indexPath.row]];
        }
    }else if([tableView isEqual:self.level1TableView]){
        [self.delegate menuItemSelected:indexPath withFilterStyle:[level1Array objectAtIndex:indexPath.row]];
    }
}



@end
