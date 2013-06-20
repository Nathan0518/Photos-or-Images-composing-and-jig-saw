//
//  MyScrollView.m
//  JipSawViewDemo
//
//  Created by Nathan.Ou on 4/25/13.
//  Copyright (c) 2013 Genesislive. All rights reserved.
//

#import "JigSawViewCell.h"

#define kCanBeDoubleTouched 1

@interface JigSawViewCell() {
    
    BOOL isScaled;
}

@end


@implementation JigSawViewCell

//@synthesize imageView;

-(id)init
{
    self= [super init];
    if (self) {
       
        //self.cellID = [[NSString alloc] init];
        isScaled = NO;
        self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        [self setMaximumZoomScale:4.0];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)resetScrollView
{
    
    

    [self scrollRectToVisible:CGRectMake(self.contentSize.width/2-self.frame.size.width/2, self.contentSize.height/2-self.frame.size.height/2, self.frame.size.width, self.frame.size.height) animated:NO];
}

-(void)setFrame:(CGRect)frame
{
    //self.frame = frame;
    [super setFrame:frame];
   
    //Get the minScale
    CGFloat minScaleX = frame.size.width / (self.imageView.frame.size.width/self.zoomScale);
    CGFloat minScaleY = frame.size.height/(self.imageView.frame.size.height/self.zoomScale);
    
    self.minimumZoomScale = (minScaleX>minScaleY?minScaleX:minScaleY);
    
    self.zoomScale = self.minimumZoomScale;
    
    
}

-(void)setSelfImage:(UIImage *)selfImage
{
    [self.imageView setAlpha:0.f];
    [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.x, selfImage.size.width*self.zoomScale, selfImage.size.height*self.zoomScale)];
    self.imageView.image = selfImage;
    originImageSize = self.imageView.frame.size;
    self.contentSize = CGSizeMake(selfImage.size.width*self.zoomScale, selfImage.size.height*self.zoomScale);
    [self resetScrollView];
   
    //Get the minScale 
    CGFloat minScaleX = self.frame.size.width / selfImage.size.width;
    CGFloat minScaleY = self.frame.size.height/selfImage.size.height;
    
    self.minimumZoomScale = (minScaleX>minScaleY?minScaleX:minScaleY);
    
    self.zoomScale = self.minimumZoomScale;
    
    [UIView animateWithDuration:1 animations:^{
        
        [self.imageView setAlpha:1.f];
    }];

    
}


-(void)setZoomToMinScale
{
    [self setZoomScale:self.minimumZoomScale];
}



-(void)dealloc
{
    [self.cellID release];
    [_imageView release];
    [super dealloc];
}


#pragma mark - Double click to scale the pics into original size
#ifdef kCanBeDoubleTouched

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //NSLog(@"touch");
    
    if([[touches anyObject] tapCount] == 2){
        
        DLog(@"Double touch");
        CGPoint point = [[touches anyObject] locationInView:self];
        
        if(isScaled == YES){
            
            [self zoomToPointInRootView:point atScale:self.minimumZoomScale];
            
            isScaled = NO;
            
        }else{
            
            [self zoomToPointInRootView:point atScale:0.6];
            isScaled = YES;
        }
    }
}



- (void)zoomToPointInRootView:(CGPoint)center atScale:(float)scale {
    
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x    = center.x*(scale/self.zoomScale) - (self.frame.size.width  / 2.0);
    zoomRect.origin.y    = center.y*(scale/self.zoomScale) -(self.frame.size.height / 2.0);
    [self zoomToRect:zoomRect animated:YES];
    
}

#endif

@end
