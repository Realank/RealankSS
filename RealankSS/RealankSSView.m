//
//  RealankSSView.m
//  RealankSS
//
//  Created by Realank on 2017/1/12.
//  Copyright © 2017年 Realank. All rights reserved.
//

#import "RealankSSView.h"

#define MaxHeight 130
@interface RealankSSView()
@property (nonatomic, assign) NSSize availableSize;
@property (nonatomic, strong) NSTextField* clockText;
@property (nonatomic, strong) NSTextField* signiture;
@end
@implementation RealankSSView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/5.0];
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    }
    return self;
}

- (void)setAvailableSize:(NSSize)availableSize{
    double vUnit = availableSize.height / 3.0;
    double hUnit = availableSize.width / 4.0;
    double unit = vUnit > hUnit ? hUnit : vUnit;
    _availableSize.height = unit * 3 > MaxHeight ? MaxHeight : unit * 3;
    _availableSize.width = unit * 4;
    CGRect availableRect;
    availableRect.origin = NSMakePoint((availableSize.width-_availableSize.width)/2, (availableSize.height-_availableSize.height)/2);
    availableRect.size = _availableSize;
    _clockText.frame = availableRect;
    
}

- (void)updateTime{
    @synchronized (self) {
        if (!_clockText) {
            _clockText = [[NSTextField alloc] init];
            _clockText.alignment = NSTextAlignmentCenter;
            _clockText.drawsBackground = YES;
            _clockText.bordered = NO;
            _clockText.backgroundColor = [NSColor blackColor];
            _clockText.textColor = [NSColor lightGrayColor];
            _clockText.font = [NSFont fontWithName:@"Hiragino Sans" size:130];
            self.availableSize = self.frame.size;
            [self addSubview:_clockText];
            _signiture = [[NSTextField alloc] initWithFrame:NSMakeRect(self.frame.size.width - 200, 0, 200, 60)];
            _signiture.bordered = NO;
            _signiture.backgroundColor = [NSColor blackColor];
            _signiture.textColor = [NSColor lightGrayColor];
            _signiture.stringValue = @"Realank";
            _signiture.font = [NSFont fontWithName:@"Hiragino Sans" size:40];
            [self addSubview:_signiture];
            
        }
        
        NSDate* currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *comps = [calendar components:unitFlags fromDate:currentDate];
        NSInteger second = comps.second;
//        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//        if (second%2) {
//            [dateFormatter setDateFormat:@"HH : mm"];
//        }else{
//            [dateFormatter setDateFormat:@"HH   mm"];
//        }
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH : mm"];
        NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];
        _clockText.stringValue = dateString;
//        _signiture.alphaValue = labs(second%30-15) / 30.0 + 0.5;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSColor *backgroundColor = [NSColor colorWithRed:arc4random()%255/255.0 green:arc4random()%25/255.0 blue:arc4random()%25/255.0 alpha:1];
//            self.layer.backgroundColor = backgroundColor.CGColor;
//            [self setNeedsDisplay:YES];
//        });
    }
    
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
//    self.availableSize = rect.size;
    
}

- (void)animateOneFrame
{
    [self updateTime];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
