Photos-or-Images-composing-and-jig-saw
======================================
![Screenshot](https://raw.github.com/Nathan0518/Photos-or-Images-composing-and-jig-saw/master/iosP.png)

This is a tool for composing images or photos.

You can set styles by rewriting method -(void)setJigSawCellsArray in CustomJigSawView.

the images in the customJigSawView is able to zoom and scroll.

When changing the pics in customjigSawView, see as in Sample

-(void)updateJigSawView
{
    switch (kPicsInView ) {
        case 1:
            self.mainJigSawView.jsViewType = JSPicsType1;
            break;
        case 2:
            self.mainJigSawView.jsViewType = JSPicsType3;
            break;
        case 3:
            self.self.mainJigSawView.jsViewType = JSPicsType5;
            break;
        case 4:
            self.mainJigSawView.jsViewType = JSPicsType7;
            break;
        case 5:
            self.mainJigSawView.jsViewType = JSPicsType9;
            break;
        case 6:
            self.mainJigSawView.jsViewType = JSPicsType10;
            break;
        default:
            break;
    }
    for (int i = 0; i<kPicsInView; i++) {
        
        JigSawViewCell *jsCell = [self.mainJigSawView.viewCellsArray objectAtIndex:i];
        jsCell.selfImage = [UIImage imageNamed:[NSString stringWithFormat:@"imageP%d",i+1]];
        
    }
    [self.mainJigSawView changePositionWithAnimation];

}

By setting its type, u can set selfImage for each cell, and the image will be change automactically.

Also see the method [self.mainJigSawView changePositionWithAnimation], by using this method u can change the position
of each cell or event add and delete cell for in customJigSawView. For adding and deleting cell see method -(void)setJigSawCellsArray in CustomJigSawView.m .
