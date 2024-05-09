//
//  ZKRevealingTableViewCell.h
//  ZKRevealingTableViewCell
//
//  Created by Alex Zielenski on 4/29/12.
//  Copyright (c) 2012 Alex Zielenski.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense,  and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

@class ZKRevealingTableViewCell;

typedef enum {
	ZKRevealingTableViewCellDirectionRight = 0,
	ZKRevealingTableViewCellDirectionLeft,
	ZKRevealingTableViewCellDirectionBoth,
	ZKRevealingTableViewCellDirectionNone,
} ZKRevealingTableViewCellDirection;

typedef enum{
    orderOne = 0,
    orderTwo,
    orderThree,
    orderFour    
} orderImage;


@protocol ZKRevealingTableViewCellDelegate <NSObject>

@optional
- (BOOL)cellShouldReveal:(ZKRevealingTableViewCell *)cell;
- (void)cellDidBeginPan:(ZKRevealingTableViewCell *)cell;
- (void)cellDidReveal:(ZKRevealingTableViewCell *)cell;
- (void)cellDidReverse:(ZKRevealingTableViewCell *)cell;
- (void)cellBeforeReverse:(ZKRevealingTableViewCell *)cell;
-(BOOL)cellEditShouldReveal:(ZKRevealingTableViewCell *)cell;
//-(BOOL)cellDelShouldReveal:(ZKRevealingTableViewCell *)cell;

@end

@interface ZKRevealingTableViewCell : UITableViewCell{
    UILabel *realPriceLabel;
    UILabel *quantityLabel;
    UILabel *sizeLabel;
    UILabel *unitLabel;    
    UILabel *priceLabel;    
    UIImageView *indicatorImg;
    UIImageView *ribbinImg;
}



@property (nonatomic) IBOutlet UIView *backView;
@property (nonatomic) IBOutlet UIView *editView;

@property (nonatomic) IBOutlet UIView *backDelView;
@property (nonatomic) IBOutlet UIButton *backDelButton;



@property (nonatomic, assign, getter = isRevealing) BOOL revealing;
@property (nonatomic, weak) id <ZKRevealingTableViewCellDelegate> delegate;
@property (nonatomic, assign) ZKRevealingTableViewCellDirection direction;
@property (nonatomic, assign) BOOL shouldBounce;

// Add by Gearbizz
@property (nonatomic, strong) UILabel *realPriceLabel;
@property (nonatomic, strong) UILabel *quantityLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic,strong) UIImageView *indicatorImg;


@property (nonatomic,strong) UIImageView *ribbinImg;

@property (nonatomic, assign) BOOL backViewOut;

// Add by Gearbizz
-(void)setImageOrder:(orderImage) order;
-(void)setbackViewOut;
-(CGFloat)getOriginalCenter;
-(void)cellDelRevealBack;



@end






