//
//  WeixinJigSawView.h
//  memori
//
//  Created by Nathan.Ou on 4/27/13.
//  Copyright (c) 2013 Xtremeprog.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JigSawViewCell.h"

#define kCellImageViewTag 2004
//@class JigSawViewCell;

typedef enum{
    JSPicsType1 = 1,
    JSPicsType2 = 2,
    JSPicsType3 = 3,
    JSPicsType4 = 4,
    JSPicsType5 = 5,
    JSPicsType6 = 6,
    JSPicsType7 = 7,
    JSPicsType8 = 8,
    JSPicsType9 = 9,
    JSPicsType10 = 10,
    JSPicsType11 = 11,
    JSPicsType12 = 12
}JigSawViewType;

@interface CustomJigSawView : UIView<UIScrollViewDelegate>
{
    JigSawViewType jsViewForType;
}
@property (nonatomic, retain) NSMutableArray *viewCellsArray;
@property (nonatomic, retain) NSMutableArray *viewsRectArray;
@property (nonatomic, assign) NSInteger sortedPhotoNums;
@property (nonatomic, assign) JigSawViewType jsViewType;
@property (nonatomic, assign) NSInteger JigSawViewTypeNum;

-(id)initWithFrame:(CGRect)frame andJigSawViewType:(JigSawViewType)_JSViewType;
-(void)changePositionWithAnimation;
-(JigSawViewCell*)cellWithID:(NSString*)cellID;
-(JigSawViewType)getJigSaaViewType;

@end
