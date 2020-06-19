//
//  MJPPokemonTableViewController.h
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJPPokemon.h"

#import "MJPPokemonDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJPPokemonTableViewController : UITableViewController

@property (nonatomic) NSArray<MJPPokemon *> *allPokemon;

@end

NS_ASSUME_NONNULL_END
