//
//  ZKRevealingTableViewCell.m
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

#import "ZKRevealingTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ZKRevealingTableViewCell ()

@property (nonatomic,strong) UIPanGestureRecognizer   *_panGesture;
@property (nonatomic,strong) UITapGestureRecognizer   *doubleTap;

@property (nonatomic, assign) CGFloat _initialTouchPositionX;
@property (nonatomic, assign) CGFloat _initialHorizontalCenter;
@property (nonatomic, assign) ZKRevealingTableViewCellDirection _lastDirection;
@property (nonatomic, assign) ZKRevealingTableViewCellDirection _currentDirection;

- (void)_slideInContentViewFromDirection:(ZKRevealingTableViewCellDirection)direction offsetMultiplier:(CGFloat)multiplier;
- (void)_slideOutContentViewInDirection:(ZKRevealingTableViewCellDirection)direction;

- (void)_pan:(UIPanGestureRecognizer *)panGesture;

- (void)_setRevealing:(BOOL)revealing;

- (CGFloat)_originalCenter;
- (CGFloat)_bounceMultiplier;

- (BOOL)_shouldDragLeft;
- (BOOL)_shouldDragRight;
- (BOOL)_shouldReveal;
- (BOOL)_shouldEditReveal;
- (BOOL)_shouldDelReveal;

@end

@implementation ZKRevealingTableViewCell

#pragma mark - Private Properties

@synthesize _panGesture;
@synthesize doubleTap;

@synthesize _initialTouchPositionX;
@synthesize _initialHorizontalCenter;
@synthesize _lastDirection;
@synthesize _currentDirection;

#pragma mark - Public Properties

@dynamic revealing;
@synthesize direction    = _direction;
@synthesize delegate     = _delegate;
@synthesize shouldBounce = _shouldBounce;
@synthesize backView     = _backView;
@synthesize backDelView     = _backDelView;
@synthesize backDelButton = _backDelButton;
@synthesize editView;


@synthesize realPriceLabel;
@synthesize quantityLabel;
@synthesize sizeLabel;
@synthesize unitLabel;
@synthesize priceLabel;
@synthesize indicatorImg;
@synthesize ribbinImg;
@synthesize backViewOut;

#define limitLeftOut 70

#pragma mark - Lifecycle

-(UIButton *)getDelButton :(NSString *)title X:(double)_x Y:(double)_y width:(double)_width hight:(double)_hight tag:(NSInteger)tag{
    
    UIButton *button    = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(_x, _y, _width, _hight)];
        
    button.titleLabel.font              = [UIFont fontWithName:@"Futura-CondensedMedium" size:35]; 
         
    button.titleLabel.lineBreakMode     = UILineBreakModeTailTruncation;
    button.contentVerticalAlignment     = UIControlContentVerticalAlignmentCenter;
    button.contentHorizontalAlignment   = UIControlContentHorizontalAlignmentCenter;
    
    [button setTitleColor:[self UIColorWithRGBStartRed:255 Green:3 Blue:3] forState:UIControlStateNormal];    
    
    [button setTitle: title forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, 2.0);
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];    
    button.tag = tag;
    return button;
}

-(UIColor *)UIColorWithRGBStartRed:(float)_red Green:(float)_green Blue:(float)_blue{
    return  [UIColor colorWithRed:_red/255.f
                    green:_green/255.f
                     blue:_blue/255.f    
                    alpha:1];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.direction = ZKRevealingTableViewCellDirectionBoth;
		self.shouldBounce = YES;
		
		self._panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_pan:)];
		self._panGesture.delegate = self;
		
		[self addGestureRecognizer:self._panGesture];
		
// TAO Add
        self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        self.doubleTap.delegate = self;
        [self.contentView addGestureRecognizer:self.doubleTap];
        
        UIView *editViewInit         = [[UIView alloc] initWithFrame:self.contentView.frame];
		editViewInit.backgroundColor = [UIColor whiteColor];
		self.editView                = editViewInit;
        [self.editView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_cell"]]];
// TAO Add End
        
		self.contentView.backgroundColor = [UIColor whiteColor];
		
		UIView *backgroundView         = [[UIView alloc] initWithFrame:self.contentView.frame];
		backgroundView.backgroundColor = [UIColor whiteColor];
		self.backView                  = backgroundView;
                
		UIView *backgroundDelView         = [[UIView alloc] initWithFrame:self.contentView.frame];
		backgroundDelView.backgroundColor = [self UIColorWithRGBStartRed:233 Green:230 Blue:230];

		self.backDelView                  = backgroundDelView;
        
        self.indicatorImg = [self getImageX:5 Y:6 width:9 hight:30];
        self.ribbinImg = [self getImageX:140 Y:0 width:10 hight:25];
        
        self.realPriceLabel = [self getLableX:16 Y:5 width:75 hight:35];
        
        self.quantityLabel = [self getLableX:90 Y:5 width:60 hight:35];
        self.sizeLabel = [self getLableX:150 Y:5 width:60 hight:35];
        self.unitLabel = [self getLableX:210 Y:5 width:60 hight:35];
        self.priceLabel = [self getLableX:270 Y:5 width:50 hight:35];
        
        [self.contentView addSubview:self.indicatorImg];

        [self.contentView addSubview:self.realPriceLabel];
        [self.contentView addSubview:self.quantityLabel];
        [self.contentView addSubview:self.sizeLabel];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.ribbinImg];
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_cell"]]];
        
        
        self.backDelButton = [self getDelButton:@"del" X:270 Y:5 width:50 hight:35 tag:5];
        [self.backDelView addSubview:self.backDelButton];
                
        [self.realPriceLabel setAdjustsFontSizeToFitWidth:YES];
        [self.quantityLabel setAdjustsFontSizeToFitWidth:YES];
        [self.sizeLabel setAdjustsFontSizeToFitWidth:YES];
        [self.unitLabel setAdjustsFontSizeToFitWidth:YES];
        [self.priceLabel setAdjustsFontSizeToFitWidth:YES];
        
    }
        
    return self;
}

-(void)setImageOrder:(orderImage) order{    

    switch (order) {
        case orderOne:{
            [self.indicatorImg setImage:[UIImage imageNamed:@"order_one"]];
            [self.ribbinImg setImage:[UIImage imageNamed:@"ribbon"]];
        }            
            break;
        case orderTwo:{
            [self.indicatorImg setImage:[UIImage imageNamed:@"order_two"]];
            [self.ribbinImg setImage:nil];
        }            
            break;
        case orderThree:{
            [self.indicatorImg setImage:[UIImage imageNamed:@"order_three"]];
            [self.ribbinImg setImage:nil];
        }            
            break;
        case orderFour:{
            [self.indicatorImg setImage:[UIImage imageNamed:@"order_four"]];
            [self.ribbinImg setImage:nil];
        }
            break;
            
        default:
            break;
    }
    
}

-(UIImageView *)getImageX:(CGFloat)_x Y:(CGFloat)_y width:(CGFloat)_width hight:(CGFloat)_hight{    
    
    UIImageView *result = [[UIImageView alloc] initWithFrame:CGRectMake(_x, _y, _width, _hight)];
//    [result setImage:[UIImage imageNamed:_imageName]];    
    return result;    
}

-(UILabel *)getLableX:(CGFloat)_x Y:(CGFloat)_y width:(CGFloat)_width hight:(CGFloat)_hight{
   
    UILabel *result = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, _width, _hight)];
    result.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
    result.textAlignment = UITextAlignmentCenter;
    return result;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
    [self addSubview:self.backDelView];
    self.backDelView.frame = self.contentView.frame;
    
	[self addSubview:self.contentView];	

    [self addSubview:self.backView];
    
    [self addSubview:self.editView];
    self.editView.frame = self.contentView.frame;
    self.editView.center = CGPointMake(-self._originalCenter, self.editView.center.y);

    
    self.backView.frame = self.contentView.frame;
    
    if(self.backViewOut != NO){
        CGFloat x = -self._originalCenter;
        self.backView.center = CGPointMake(x, self.backView.center.y);
    }
}

#pragma mark - Accessors
#import <objc/runtime.h>

static char BOOLRevealing;

- (BOOL)isRevealing
{
	return [(NSNumber *)objc_getAssociatedObject(self, &BOOLRevealing) boolValue];
}

- (void)setRevealing:(BOOL)revealing
{
	// Don't change the value if its already that value.
	// Reveal unless the delegate says no
	if (revealing == self.revealing || 
		(revealing && self._shouldReveal))
		return;
	
	[self _setRevealing:revealing];
	
	if (self.isRevealing)
		[self _slideOutContentViewInDirection:(self.isRevealing) ? self._currentDirection : self._lastDirection];
	else
		[self _slideInContentViewFromDirection:(self.isRevealing) ? self._currentDirection : self._lastDirection offsetMultiplier:self._bounceMultiplier];
}


- (void)_setRevealing:(BOOL)revealing
{
	[self willChangeValueForKey:@"isRevealing"];
	objc_setAssociatedObject(self, &BOOLRevealing, [NSNumber numberWithBool:revealing], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"isRevealing"];
	
	if (self.isRevealing && [self.delegate respondsToSelector:@selector(cellDidReveal:)])
		[self.delegate cellDidReveal:self];
}

- (BOOL)_shouldReveal
{
	// Conditions are checked in order
	return (![self.delegate respondsToSelector:@selector(cellShouldReveal:)] || [self.delegate cellShouldReveal:self]);
}

- (BOOL)_shouldEditReveal
{
	// Conditions are checked in order
	return (![self.delegate respondsToSelector:@selector(cellEditShouldReveal:)] || [self.delegate cellEditShouldReveal:self]);
}

#pragma mark - Handing Touch
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    
    if (self._shouldEditReveal == YES){
        if ([self.delegate respondsToSelector:@selector(cellBeforeReverse:)])
            [self.delegate cellBeforeReverse:self];
        
        [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGFloat x = self._originalCenter;
                         self.editView.center = CGPointMake(x, self.editView.center.y);
                     }
                     completion:^(BOOL finished){
                         
                         if ([self.delegate respondsToSelector:@selector(cellDidReverse:)])
                             [self.delegate cellDidReverse:self];
                         
                     }];
    }
    
}

- (void)_pan:(UIPanGestureRecognizer *)recognizer
{
	
//    if(self._shouldDelReveal == YES){
    
	CGPoint translation           = [recognizer translationInView:self];
	CGPoint currentTouchPoint     = [recognizer locationInView:self];
	CGPoint velocity              = [recognizer velocityInView:self];
	
	CGFloat originalCenter        = self._originalCenter;
	CGFloat currentTouchPositionX = currentTouchPoint.x;
	CGFloat panAmount             = self._initialTouchPositionX - currentTouchPositionX;
	CGFloat newCenterPosition     = self._initialHorizontalCenter - panAmount;
	CGFloat centerX               = self.contentView.center.x;

	if (recognizer.state == UIGestureRecognizerStateBegan) {
		
		// Set a baseline for the panning
		self._initialTouchPositionX = currentTouchPositionX;
		self._initialHorizontalCenter = self.contentView.center.x;
		
		if ([self.delegate respondsToSelector:@selector(cellDidBeginPan:)])
			[self.delegate cellDidBeginPan:self];
				
	} else if (recognizer.state == UIGestureRecognizerStateChanged) {
		
		// If the pan amount is negative, then the last direction is left, and vice versa.
		if (newCenterPosition - centerX < 0)
			self._lastDirection = ZKRevealingTableViewCellDirectionLeft;
		else
			self._lastDirection = ZKRevealingTableViewCellDirectionRight;
		
		// Don't let you drag past a certain point depending on direction
		if ((newCenterPosition < originalCenter && !self._shouldDragLeft) || (newCenterPosition > originalCenter && !self._shouldDragRight))
			newCenterPosition = originalCenter;
		
		// Let's not go waaay out of bounds
		if (newCenterPosition > self.bounds.size.width + originalCenter)
            newCenterPosition = self.bounds.size.width + originalCenter;
//        if (newCenterPosition > originalCenter )
//			newCenterPosition = originalCenter;      
        
        else if (newCenterPosition < originalCenter - limitLeftOut  )
                newCenterPosition = originalCenter - limitLeftOut;
        
//		else if (newCenterPosition < -originalCenter)
//			newCenterPosition = -originalCenter;
		        
        
		CGPoint center = self.contentView.center;
		center.x = newCenterPosition;
		
		self.contentView.layer.position = center;
		
        
	} else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
				
		// Swiping left, velocity is below 0.
		// Swiping right, it is above 0
		// If the velocity is above the width in points per second at any point in the pan, push it to the acceptable side
		// Otherwise, if we are 60 points in, push to the other side
		// If we are < 60 points in, bounce back
		
#define kMinimumVelocity self.contentView.frame.size.width
#define kMinimumPan      20.0
		
		CGFloat velocityX = velocity.x;
		
		BOOL push = (velocityX < -kMinimumVelocity);
		push |= (velocityX > kMinimumVelocity);
		push |= ((self._lastDirection == ZKRevealingTableViewCellDirectionLeft && translation.x < -kMinimumPan) || (self._lastDirection == ZKRevealingTableViewCellDirectionRight && translation.x > kMinimumPan));
		push &= self._shouldReveal;
		push &= ((self._lastDirection == ZKRevealingTableViewCellDirectionRight && self._shouldDragRight) || (self._lastDirection == ZKRevealingTableViewCellDirectionLeft && self._shouldDragLeft)); 
		
		if (velocityX > 0 && self._lastDirection == ZKRevealingTableViewCellDirectionLeft)
			push = NO;
		
		else if (velocityX < 0 && self._lastDirection == ZKRevealingTableViewCellDirectionRight)
			push = NO;
		
		if (push && !self.isRevealing) {
			
			[self _slideOutContentViewInDirection:self._lastDirection];
			[self _setRevealing:YES];
			
			self._currentDirection = self._lastDirection;
			
		} else if (self.isRevealing && translation.x != 0) {
			CGFloat multiplier = self._bounceMultiplier;
			if (!self.isRevealing)
				multiplier *= -1.0;
				
			[self _slideInContentViewFromDirection:self._currentDirection offsetMultiplier:multiplier];
			[self _setRevealing:NO];
			
		} else if (translation.x != 0) {
			// Figure out which side we've dragged on.
			ZKRevealingTableViewCellDirection finalDir = ZKRevealingTableViewCellDirectionRight;
			if (translation.x < 0)
				finalDir = ZKRevealingTableViewCellDirectionLeft;
		
			[self _slideInContentViewFromDirection:finalDir offsetMultiplier:-1.0 * self._bounceMultiplier];
			[self _setRevealing:NO];
		}
        
	}
//    }
}

- (BOOL)_shouldDragLeft
{
	return (self.direction == ZKRevealingTableViewCellDirectionBoth || self.direction == ZKRevealingTableViewCellDirectionLeft);
}

- (BOOL)_shouldDragRight
{
	return (self.direction == ZKRevealingTableViewCellDirectionBoth || self.direction == ZKRevealingTableViewCellDirectionRight);
}

- (CGFloat)_originalCenter
{
	return ceil(self.bounds.size.width / 2);
}

- (CGFloat)_bounceMultiplier
{
	return self.shouldBounce ? MIN(ABS(self._originalCenter - self.contentView.center.x) / kMinimumPan, 1.0) : 0.0;
}

#pragma mark - Sliding
#define kBOUNCE_DISTANCE 20.0

- (void)_slideInContentViewFromDirection:(ZKRevealingTableViewCellDirection)direction offsetMultiplier:(CGFloat)multiplier
{
	CGFloat bounceDistance;
	
	if (self.contentView.center.x == self._originalCenter)
		return;
	
	switch (direction) {
		case ZKRevealingTableViewCellDirectionRight:
			bounceDistance = kBOUNCE_DISTANCE * multiplier;
			break;
		case ZKRevealingTableViewCellDirectionLeft:
			bounceDistance = -kBOUNCE_DISTANCE * multiplier;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	
	[UIView animateWithDuration:0.1
						  delay:0 
						options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction 
					 animations:^{ self.contentView.center = CGPointMake(self._originalCenter, self.contentView.center.y); } 
					 completion:^(BOOL f) {
						 						 
						 [UIView animateWithDuration:0.1 delay:0 
											 options:UIViewAnimationCurveLinear
										  animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, bounceDistance, 0); } 
										  completion:^(BOOL f) {                     
											  
												  [UIView animateWithDuration:0.1 delay:0 
																	  options:UIViewAnimationCurveLinear
																   animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, -bounceDistance, 0); } 
																   completion:NULL];
										  }
						  ]; 
					 }];
}

- (void)_slideOutContentViewInDirection:(ZKRevealingTableViewCellDirection)direction;
{
	CGFloat x;
	
	switch (direction) {
		case ZKRevealingTableViewCellDirectionLeft:
            x = limitLeftOut+20;
			break;
		case ZKRevealingTableViewCellDirectionRight:
			x = self.contentView.frame.size.width + self._originalCenter;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	
	[UIView animateWithDuration:0.1 
						  delay:0 
						options:UIViewAnimationOptionCurveEaseOut 
					 animations:^{ self.contentView.center = CGPointMake(x, self.contentView.center.y); } 
					 completion:NULL];
}

-(CGFloat)getOriginalCenter{
    return self._originalCenter;
}

-(void)setbackViewOut{
   CGFloat x = - self._originalCenter;
    self.backView.center = CGPointMake(x, self.backView.center.y);
}


-(void)setShiftContentView{
    self.contentView.center = CGPointMake(self.contentView.center.x+10, self.contentView.center.y);
}

-(void)cellDelRevealBack{
    [self _slideInContentViewFromDirection: YES ? self._currentDirection : self._lastDirection offsetMultiplier:self._bounceMultiplier];
    [self _setRevealing:NO];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer == self._panGesture) {
		UIScrollView *superview = (UIScrollView *)self.superview;
		CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:superview];
		
		// Make sure it is scrolling horizontally
		return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO && (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
	}
        
    if (gestureRecognizer == self.doubleTap) {
        return YES;
    }
    
	return NO;
}

//-(BOOL)_shouldDelReveal:(ZKRevealingTableViewCell *)cell{
//	return (![self.delegate respondsToSelector:@selector(cellDelShouldReveal:)] || [self.delegate cellDelShouldReveal:self]);    
//}

@end






