//
//  MJPPokemon.h
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJPPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *sprite;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSArray<NSString *> *abilities;

-(instancetype)initWithName:(NSString *)name sprite:(NSURL *)sprite identifier:(NSString *)identifier abilities:(NSArray *)abilities;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
