# Setup

## Normal users process
1. To run this code you will need a version of Ruby  more recent than 3.
2. To run the program you need to execute texttest_fixture.rb, like: ruby app/texttest_fixture.rb
3. When you run the file this generate a simulation of 4 days, and modify the item's quality accoding with the rules.


## Developer process
- If you want to test the methods of the program then you will need to install some gems that you cand find in the file 'Gemfile' just run the command 'bundle install' and the gem will automatically be installed

### TDD
#### spec/gilded_rose_spec.rb make a test for six relevant method
- normal_item: used to apply the rules of a "normal" item
- upgrade_quality: used to increase quality in 1
- backstage_quality: used to apply the rules of a "backstage" item
- aged_brie_queality: used to apply the rules of a "aged brie" item
- conjured_item?: used to apply the rules of a "conjured" item
- update_quality: used to apply the rules of all available items

### Team Members
- Co-authored-by: Frcomparan <frcomparan@gmail.com>
- Co-authored-by: EliasUR <eliasrodriguez2002@hotmail.com>
- Co-authored-by: femm34 <femm34@users.noreply.github>
