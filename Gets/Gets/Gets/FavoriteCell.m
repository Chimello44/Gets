//
//  FavoriteCell.m
//  Gets
//
//  Created by Ezequiel de Oliveira Lima on 03/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (void)awakeFromNib {
    // Initialization code
    [_imagePhotoPlace.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_imagePhotoPlace.layer setBorderWidth: 2.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
