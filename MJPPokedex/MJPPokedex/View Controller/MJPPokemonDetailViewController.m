//
//  MJPPokemonDetailViewController.m
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import "MJPPokemonDetailViewController.h"
#import "MJPPokedex-Swift.h"

// Your network controller must have an interface as specified below. Note that the fillInDetails method does not take a completion closure. Rather, it fills in additional details (identifier, abilities, sprite) by setting pokemon's properties directly.
// The detail view controller must use KVO to be notified when the network controller has finished filling in details for a Pokemon, triggering a UI update.

@interface MJPPokemonDetailViewController ()

@end

@implementation MJPPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];

    if (!self.pokemon.identifier) {
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    }
}

-(void) updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];

        self.identificationLabel.text = [NSString stringWithFormat:@"#%@", self.pokemon.identifier];

        NSString *abilities = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];

        self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilities];

        [self loadSprite];

    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}


-(void) loadSprite {
    
    NSURL *sprite = self.pokemon.sprite;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:sprite completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"Error getting sprite data %@", error);
            return;
        }
        UIImage *sprite = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self imageView] setImage:sprite];
        });
    }];

    [dataTask resume];
}




@end
