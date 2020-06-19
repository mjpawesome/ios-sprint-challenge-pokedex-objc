//
//  MJPPokemonTableViewController.m
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import "MJPPokemonTableViewController.h"
#import "MJPPokedex-Swift.h"

@interface MJPPokemonTableViewController ()

@end

@implementation MJPPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[MJPPokemonController sharedController]

     fetchAllPokemonWithCompletion:^(NSArray<MJPPokemon *> * allPokemon, NSError * error) {
        self.allPokemon = allPokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    MJPPokemon *pokemon = self.allPokemon[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}


 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"DetailSegue"]) {
         MJPPokemonDetailViewController *detailVC = segue.destinationViewController;
         NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
         MJPPokemon *pokemon = self.allPokemon[indexPath.row];
         detailVC.pokemon = pokemon;
         [[MJPPokemonController sharedController] fillInDetailsFor:pokemon];
     }
 }


@end
