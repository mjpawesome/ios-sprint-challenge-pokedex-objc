//
//  MJPPokemon.m
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import "MJPPokemon.h"

@implementation MJPPokemon

- (instancetype)initWithName:(NSString *)name sprite:(NSURL *)sprite identifier:(NSNumber *)identifier abilities:(NSArray *)abilities {
    self = [super init];
    if (self) {
        _name = [name copy];
        _sprite = [sprite copy];
        _identifier = [identifier copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    // name
    NSString *name = dictionary[@"name"];

    // identifier
    NSString *identifier = dictionary[@"id"];

    // abilities
    NSMutableArray *abilities = [[NSMutableArray alloc] init];
    NSArray *abilitiesDictionary = dictionary[@"abilities"];
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [abilities addObject:ability];
    }

    // image
    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    NSURL *sprite = [NSURL URLWithString:spriteString];

    return [self initWithName:name sprite:sprite identifier:identifier abilities:abilities];
}



@end
