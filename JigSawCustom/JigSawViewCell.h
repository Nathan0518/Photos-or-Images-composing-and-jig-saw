//
//  MyScrollView.h
//  JipSawViewDemo
//
//  Created by Nathan.Ou on 4/25/13.
//  Copyright (c) 2013 Genesislive. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ScrollImageView.h"

@interface JigSawViewCell : UIScrollView
{
    CGSize originImageSize;
    CGSize currentFrame;
    //UIImageView *imageView;
}
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *selfImage;
@property (nonatomic, retain) NSString *cellID;
@property (nonatomic, assign) BOOL isNewCell;

-(void)resetScrollView;



@end
