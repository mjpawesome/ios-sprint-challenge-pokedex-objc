//
//  MJPPokemonDetailViewController.h
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJPPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJPPokemonDetailViewController : UIViewController

@property (weak, nonatomic) MJPPokemon *pokemon;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *identificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

NS_ASSUME_NONNULL_END
