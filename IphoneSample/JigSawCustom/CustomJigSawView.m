//
//  WeixinJigSawView.m
//  memori
//
//  Created by Nathan.Ou on 4/27/13.
//  Copyright (c) 2013 Xtremeprog.com. All rights reserved.
//

#import "CustomJigSawView.h"
#import "JigSawViewCell.h"
#import <QuartzCore/QuartzCore.h>


#define kAnimation 1

@interface CustomJigSawView(){
    NSMutableArray *checkNumArray;
    NSInteger viewCellsNum;
}
@end

@implementation CustomJigSawView

-(id)initWithFrame:(CGRect)frame andJigSawViewType:(JigSawViewType)_JSViewType
{
    self = [super init];
    if (self) {
        self.frame = frame;
        jsViewForType = _JSViewType;
        self.backgroundColor = [UIColor whiteColor];
        [self  initAllMutableArrays];
        
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

-(void)initAllMutableArrays
{
    checkNumArray = [[NSMutableArray alloc] init];
    _viewCellsArray = [[NSMutableArray alloc] init];
    _viewsRectArray = [[NSMutableArray alloc] init];
}

-(void)JigSawViewInitialize
{
    [self resetViewsRectArray];
    [self initScrollViews];
    //[self addSubViewToView];
    [self changePositionOfViewsWithDuration:0.5];
}

-(void)resetRandScrollView
{
    [self resetViewsRectArray];
    [self initScrollViews];
    
}

-(void)resetViewsRectArray
{
    [self.viewsRectArray removeAllObjects];
    [self setJigSawCellsArray];
}

#pragma mark - init all JigSawView Cells into viewCellsArray 
-(void)initScrollViews
{
    if ([checkNumArray count] != 0) {
        [checkNumArray removeAllObjects];
    }
    //[checkNumArray removeAllObjects];
    int viewCellsArrayallObjectNum = [self.viewCellsArray count];
    
    if ([self.viewCellsArray count] != 0 && viewCellsArrayallObjectNum > [self.viewsRectArray count]) {
        
        for (int i = viewCellsArrayallObjectNum; i > [self.viewsRectArray count] ; i--) {
            
            JigSawViewCell *_jigSawVieCell = (JigSawViewCell*)[self.viewCellsArray objectAtIndex:i-1];
            _jigSawVieCell.imageView.image = nil;
            [_jigSawVieCell removeFromSuperview];
            [self.viewCellsArray removeObjectAtIndex:i-1];
        }
        
    }
    
    if ([self.viewCellsArray count]!=0&& viewCellsArrayallObjectNum < [self.viewsRectArray count]) {
        for (int i = viewCellsArrayallObjectNum; i<[self.viewsRectArray count]; i++) {
            JigSawViewCell *_JSViewCell = [[JigSawViewCell alloc] init];
            _JSViewCell.isNewCell = YES;
            _JSViewCell.delegate = self;
            _JSViewCell.imageView.tag = kCellImageViewTag;
            [self addSubview:_JSViewCell];
            [self.viewCellsArray addObject:_JSViewCell];
            [_JSViewCell release];

        }
    }

    if([self.viewCellsArray count] != [self.viewsRectArray count]){
        
        if ([self.viewCellsArray count] != 0) {
            for (id a_ScrollView in self.viewCellsArray) {
                
                JigSawViewCell *_jigSawVieCell = (JigSawViewCell*)a_ScrollView;
                _jigSawVieCell.imageView.image = nil;
                [_jigSawVieCell removeFromSuperview];                
            }
        }
        
        [self.viewCellsArray removeAllObjects];
        for (int i = 0; i<[self.viewsRectArray count]; i++) {
            JigSawViewCell *_JSViewCell = [[JigSawViewCell alloc] init];
            _JSViewCell.isNewCell = YES;
            _JSViewCell.delegate = self;
            _JSViewCell.imageView.tag = kCellImageViewTag;
            [self addSubview:_JSViewCell];
            [self.viewCellsArray addObject:_JSViewCell];
            [_JSViewCell release];
        }
    }else {
        return;
    }

}

#pragma mark - random a different Num In An Array
-(NSInteger)randomADifferentNumInAnArray:(NSMutableArray*)tempArray
{
    if (tempArray.count == 1) {
        NSNumber *num = (NSNumber*)[tempArray objectAtIndex:0];
        int wantedInt = num.intValue;
        [tempArray removeAllObjects];
        return wantedInt;
    }else{
        int randomInt = arc4random()%[tempArray count];
        
        NSNumber *num = (NSNumber*)[tempArray objectAtIndex:randomInt];
        int wantedInt = num.intValue;
        [tempArray removeObjectAtIndex:randomInt];
        return wantedInt;
    }
}

#pragma mark - change Jig Saw View Cells' Positions/frames
-(void)changePositionOfViewsWithDuration:(CGFloat)_duration
{
    [checkNumArray removeAllObjects];
//    NSInteger _allPicsNum = [self.viewsRectArray count];
   
    for (int i = 0; i<[self.viewCellsArray count]; i++) {
        NSNumber *tempNum = [NSNumber numberWithInt:i];
        [checkNumArray addObject:tempNum];
    }
    
#ifdef kAnimation
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:_duration];
#endif
    for (id a_ScrollView in self.viewCellsArray) {

        
        int randomPic = [self randomADifferentNumInAnArray:checkNumArray];
        
        
        JigSawViewCell *_scrollView = (JigSawViewCell*)a_ScrollView;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:_scrollView cache:NO];
        _scrollView.frame = [[self.viewsRectArray objectAtIndex:randomPic] CGRectValue];
        
    }
#ifdef kAnimation
    [UIView commitAnimations];
#endif
}

-(void)changePositionWithAnimation
{
    [self changePositionOfViewsWithDuration:0.5];
}

#pragma mark - when photos number change this method will be called to fit the Arrays
-(void)setSortedPhotoNums:(NSInteger)sortedPhotoNums
{
    _sortedPhotoNums = sortedPhotoNums;
    
    if (_sortedPhotoNums <= 6) {
        viewCellsNum = _sortedPhotoNums;
    }else if(_sortedPhotoNums <=8){
        viewCellsNum = 6;
    }else{
        viewCellsNum = 6;
    }
    
    switch (viewCellsNum) {
        case 1:
            jsViewForType = JSPicsType1;
            break;
        case 2:
            jsViewForType = JSPicsType2;
            break;
        case 3:
            jsViewForType = JSPicsType4;
            break;
        case 4:
            jsViewForType = JSPicsType6;
            break;
        case 5:
            jsViewForType = JSPicsType8;
            break;
        case 6:
            jsViewForType = JSPicsType10;
            break;
        case 9:
            jsViewForType = JSPicsType11;
            break;
        default:
            break;
    }

    
    [self JigSawViewInitialize];
}

-(void)resetScrollViewsNum
{
    int viewCellsArrayallObjectNum = [self.viewCellsArray count];
    
    if ([self.viewCellsArray count] != 0 && viewCellsArrayallObjectNum > [self.viewsRectArray count]) {
        
        for (int i = viewCellsArrayallObjectNum-1; i > [self.viewsRectArray count] ; i--) {
            
            JigSawViewCell *_jigSawVieCell = (JigSawViewCell*)[self.viewCellsArray objectAtIndex:i];
            [_jigSawVieCell removeFromSuperview];
            [self.viewCellsArray removeObjectAtIndex:i];
        }
        
    }
    
    if ([self.viewCellsArray count]!=0&& viewCellsArrayallObjectNum < [self.viewsRectArray count]) {
        for (int i = viewCellsArrayallObjectNum; i<[self.viewsRectArray count]; i++) {
            JigSawViewCell *_JSViewCell = [[JigSawViewCell alloc] init];
            _JSViewCell.delegate = self;
            _JSViewCell.imageView.tag = kCellImageViewTag;
            [self addSubview:_JSViewCell];
            [self.viewCellsArray addObject:_JSViewCell];
            [_JSViewCell release];
            
        }
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(JigSawViewType)getJigSaaViewType
{
    return _jsViewType;
}

-(void)setJsViewType:(JigSawViewType)jsViewType
{
    jsViewForType = jsViewType;
    
    [self resetViewsRectArray];
    [self initScrollViews];
    [self changePositionWithAnimation];
}

-(void)dealloc
{
    
    [_viewsRectArray release];
    [_viewCellsArray release];
    [checkNumArray release];
    [super dealloc];
}

#pragma mark - init Rects for all JigSawView Cells as different Type
-(void)setJigSawCellsArray
{
  
    CGFloat Hight = self.frame.size.height;
    CGFloat Width = self.frame.size.width;
    
    //Type 1
    if (jsViewForType == JSPicsType3) {
        CGRect rect1 = CGRectMake(2, 2, (self.frame.size.width-6)*(0.65), (self.frame.size.height-4));
        CGRect rect2 = CGRectMake(4+(self.frame.size.width-6)*(0.65), 2, (self.frame.size.width-6)*(0.35), (self.frame.size.height-4));
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        self.JigSawViewTypeNum = 3;
    }
    
    //type 2
    if (jsViewForType == JSPicsType10) {
        CGRect rect1 = CGRectMake(2, 2, (Width-6)/2, (Hight-8)*0.45);
        CGRect rect2 = CGRectMake(4+(Width-6)/2, 2,  (Width-6)/2, ((Hight-8)*0.55)/2);
        CGRect rect3 = CGRectMake(4+(Width-6)/2, 4+((Hight-8)*0.55)/2, (Width-6)/2, ((Hight-8)*0.55)/2);
        
        CGRect rect4 = CGRectMake(2, 4+(Hight-8)*0.45,  (Width-6)/2, ((Hight-8)*0.55)/2);
        CGRect rect5 = CGRectMake(2, 6+(Hight-8)*0.45+((Hight-8)*0.55)/2,  (Width-6)/2, ((Hight-8)*0.55)/2);
        CGRect rect6 = CGRectMake(4+(Width-6)/2, 6+(Hight-8)*0.55, (Width-6)/2, (Hight-8)*0.45);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        NSValue *aValue5 = [NSValue valueWithCGRect:rect5];
        NSValue *aValue6 = [NSValue valueWithCGRect:rect6];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        [self.viewsRectArray addObject:aValue5];
        [self.viewsRectArray addObject:aValue6];
        self.JigSawViewTypeNum = 10;
        
    }
    
    //Type 3
    if (jsViewForType == JSPicsType2) {
        CGRect rect1 = CGRectMake(2, 2, (self.frame.size.width-4), (self.frame.size.height-6)/2);
        CGRect rect2 = CGRectMake(2, 4+(self.frame.size.height-6)/2, (self.frame.size.width-2), (self.frame.size.height-6)/2);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
       self.JigSawViewTypeNum = 2;
        
    }
    
    //type 4
    if (jsViewForType == JSPicsType1) {
        CGRect rect1 = CGRectMake(2, 2, (self.frame.size.width-4), (self.frame.size.height-4));
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        
        [self.viewsRectArray addObject:aValue1];
        self.JigSawViewTypeNum = 1;
        
    }

    //type 5
    if (jsViewForType == JSPicsType5) {
        CGRect rect1 = CGRectMake(2, 2,(Width-4) ,(Hight-6)*0.65);
        CGRect rect2 = CGRectMake(2, 4+(Hight-6)*0.65,(Width-6)*0.35 , ((Hight-6)*0.35));
        CGRect rect3 = CGRectMake(4+(Width-6)*0.35, 4+(Hight-6)*0.65,(Width-6)*0.65 , ((Hight-6)*0.35));
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        self.JigSawViewTypeNum = 5;
    }
   
    //type 6
    if (jsViewForType == JSPicsType9) {
       
        CGRect rect1 = CGRectMake(2, 2, (Width-6)*0.67, (Hight-8)/4);
        CGRect rect2 = CGRectMake(4+(Width-6)*0.67, 2,  (Width-6)*0.33, (Hight-8)/4);
        CGRect rect3 = CGRectMake(2, 4+(Hight-8)/4, (Width-4), (Hight-8)/2);
        
        CGRect rect4 = CGRectMake(2, 6+(Hight-8)*0.75,  (Width-6)*0.33, (Hight-8)/4);
        CGRect rect5 = CGRectMake(4+(Width-6)*0.33, 6+(Hight-8)/4+(Hight-8)/2,  (Width-6)*0.67, (Hight-8)/4);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        NSValue *aValue5 = [NSValue valueWithCGRect:rect5];

        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        [self.viewsRectArray addObject:aValue5];
        self.JigSawViewTypeNum = 9;

    }
    
        
   //type 7
    if (jsViewForType == JSPicsType4) {
        
        CGRect rect1 = CGRectMake(2, 2,(Width-8)/3 , (Hight-4));
        CGRect rect2 = CGRectMake(4+(Width-8)/3, 2,(Width-8)/3 , (Hight-4));
        CGRect rect3 = CGRectMake(6+2*(Width-8)/3, 2,(Width-8)/3 , (Hight-4));
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        self.JigSawViewTypeNum = 4;
    }
    //type8
    if (jsViewForType == JSPicsType8) {
        CGRect rect1 = CGRectMake(2, 2, (Width-6)/2, (Hight-6)/2);
        CGRect rect2 = CGRectMake(4+(Width-6)/2,2, (Width-6)/2, (Hight-6)/2);
        CGRect rect3 = CGRectMake(2, 4+(Hight-6)/2,(Width-8)/3, (Hight-6)/2);
        CGRect rect4 = CGRectMake(4+(Width-8)/3, 4+(Hight-6)/2, (Width-8)/3, (Hight-6)/2);
        CGRect rect5 = CGRectMake(6+((Width-8)/3)*2, 4+(Hight-6)/2, (Width-8)/3, (Hight-6)/2);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        NSValue *aValue5 = [NSValue valueWithCGRect:rect5];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        [self.viewsRectArray addObject:aValue5];
        self.JigSawViewTypeNum = 8;
    }
        
    //type 9
    if (jsViewForType == JSPicsType7) {
        CGRect rect1 = CGRectMake(2, 2,(Width-6)*0.75 ,(Hight-6)*0.75);
        CGRect rect2 = CGRectMake(4+(Width-6)*0.75,2 ,(Width-6)*0.25 , (Hight-6)*0.75);
        CGRect rect3 = CGRectMake(2, 4+(Hight-6)*0.75,(Width-6)*0.75, (Hight-6)*0.25);
        CGRect rect4 = CGRectMake(4+(Width-6)*0.75, 4+(Hight-6)*0.75,(Width-6)*0.25, (Hight-6)*0.25);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        self.JigSawViewTypeNum = 7;
    }
    
    //type 11
    if (jsViewForType == JSPicsType6) {
        
        CGRect rect1 = CGRectMake(2, 2, (self.frame.size.width-6)/2, (self.frame.size.height-6)/2);
        CGRect rect2 = CGRectMake((self.frame.size.width-6)/2+4, 2, (self.frame.size.width-6)/2, (self.frame.size.height-6)/2);
        CGRect rect3 = CGRectMake(2, 4+(self.frame.size.height-6)/2, (self.frame.size.width-6)/2, (self.frame.size.height-6)/2);
        CGRect rect4 = CGRectMake((self.frame.size.width-6)/2+4, 4+(self.frame.size.height-6)/2, (self.frame.size.width-6)/2, (self.frame.size.height-6)/2);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        self.JigSawViewTypeNum = 6;
    }
    
    //type 10
    if (jsViewForType == JSPicsType12) {
        
        CGRect rect1 = CGRectMake(2, 2, (Width-8)/3, (Hight-8)/3);
        CGRect rect2 = CGRectMake(4+(Width-8)/3, 2,  (Width-8)/3, (Hight-8)/3);
        CGRect rect3 = CGRectMake(6+2*(Width-8)/3, 2, (Width-8)/3, (Hight-8)/3);
        
        CGRect rect4 = CGRectMake(2, 4+(Width-8)/3,  (Width-8)/3, (Hight-8)/3);
        CGRect rect5 = CGRectMake(4+(Width-8)/3, 4+(Width-8)/3,  (Width-8)/3, (Hight-8)/3);
        CGRect rect6 = CGRectMake(6+2*(Width-8)/3, 4+(Width-8)/3,  (Width-8)/3, (Hight-8)/3);
        
        CGRect rect7 = CGRectMake(2, 6+2*(Width-8)/3,  (Width-8)/3, (Hight-8)/3);
        CGRect rect8 = CGRectMake(4+(Width-8)/3, 6+2*(Width-8)/3, (Width-8)/3, (Hight-8)/3);
        CGRect rect9 = CGRectMake(6+2*(Width-8)/3, 6+2*(Width-8)/3, (Width-8)/3, (Hight-8)/3);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        NSValue *aValue5 = [NSValue valueWithCGRect:rect5];
        NSValue *aValue6 = [NSValue valueWithCGRect:rect6];
        NSValue *aValue7 = [NSValue valueWithCGRect:rect7];
        NSValue *aValue8 = [NSValue valueWithCGRect:rect8];
        NSValue *aValue9 = [NSValue valueWithCGRect:rect9];

        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        [self.viewsRectArray addObject:aValue5];
        [self.viewsRectArray addObject:aValue6];
        [self.viewsRectArray addObject:aValue7];
        [self.viewsRectArray addObject:aValue8];
        [self.viewsRectArray addObject:aValue9];
        self.JigSawViewTypeNum = 12;
        
    }
   
    //type 12
    if (jsViewForType == JSPicsType11) {
        CGRect rect1 = CGRectMake(2, 2, (Width-8)/3, (Hight-6)/2);
        CGRect rect2 = CGRectMake(4+(Width-8)/3, 2,  (Width-8)/3, (Hight-6)/2);
        CGRect rect3 = CGRectMake(6+2*(Width-8)/3, 2,(Width-8)/3, (Hight-6)/2);
        
        CGRect rect4 = CGRectMake(2, 4+(Hight-6)/2,(Width-8)/3, (Hight-6)/2);
        CGRect rect5 = CGRectMake(4+(Width-8)/3, 4+(Hight-6)/2,(Width-8)/3, (Hight-6)/2);
        CGRect rect6 = CGRectMake(6+2*(Width-8)/3, 4+(Hight-6)/2,(Width-8)/3, (Hight-6)/2);
        
        NSValue *aValue1 = [NSValue valueWithCGRect:rect1];
        NSValue *aValue2 = [NSValue valueWithCGRect:rect2];
        NSValue *aValue3 = [NSValue valueWithCGRect:rect3];
        NSValue *aValue4 = [NSValue valueWithCGRect:rect4];
        NSValue *aValue5 = [NSValue valueWithCGRect:rect5];
        NSValue *aValue6 = [NSValue valueWithCGRect:rect6];
        
        [self.viewsRectArray addObject:aValue1];
        [self.viewsRectArray addObject:aValue2];
        [self.viewsRectArray addObject:aValue3];
        [self.viewsRectArray addObject:aValue4];
        [self.viewsRectArray addObject:aValue5];
        [self.viewsRectArray addObject:aValue6];
        self.JigSawViewTypeNum = 11;
    }
    
}

#pragma mark - check if there has the same cell in Jig Saw View Cells Array
-(JigSawViewCell*)cellWithID:(NSString*)cellID
{
    for (id a_cell in self.viewCellsArray) {
        JigSawViewCell *cell = (JigSawViewCell*)a_cell;
        if ([cell.cellID isEqualToString:cellID]) {
            return cell;
        }
    }
    return nil;
}

#pragma mark - ScrollView Delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    JigSawViewCell* _jigSawCell = (JigSawViewCell*)scrollView;
    return _jigSawCell.imageView;
}


@end
