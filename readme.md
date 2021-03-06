# Yaaz (Yet Another Ascension Zcript)

This ascension script for Kingdom of Loathing is intended to be a bit friendlier
than other scripts, translating to being a bit more verbose about what it's
doing. It also isn't intended to be specifically for speed ascensions (though
it tries to be efficient) and has the option in several places to complete
side quests along the way.

Please, please, please reach out to me if you find bugs/problems/improvements!
I'm `Degrassi` in KoL.

## Installation

First, install it by running this command in KoLmafia's graphical CLI:

```
svn checkout https://github.com/mapledyne/yaaz/branches/Release/
```

To update the script itself, run this command in the graphical CLI:

```
svn update
```

## Purpose

This script (yaaz) was built as an experiment to build a new automated ascension script, but built with a few different goals than prior scripts.

Accordingly, if these goals don't fit what you're interested in, this will be a poor choice of a script on your part.

#### Goals:


* More clear output (quickly see what's being done and progress towards goals)

* Ability to run automation on individual quests or goals

* Work at any level of skill and IotM ownership

* Automatically send gifts and nice things to people


## Usage

The primary commands can be run right from the graphical CLI.

**Note:** As a first time user, try out `yaaz-progres` and `yaaz-trophy` to get
a feel for things before running `yaaz`. Those don't consume any turns or
resources so they have less risk to try out.

### yaaz-progress

Print out a detailed progress sheet of things you can do and how far you're
along with various quests.

### yaaz-trophy

Print out a list of trophies you don't have along with your progress towards
them. In addition to trophies will track trophy-like progress for other
completionist sorts of goals. This includes royalty, recipes you may not have
made yet, food/booze you haven't consumed, monsters with missing factoids in
Manuel, etc.

### yaaz-manuel

If you have a Monster Manuel, this script will try to give you some ideas on
what you might do to help complete your Manuel.

### yaaz

This command is the core of yaaz and will attempt to run you through a full
ascension. See options, below, to customize how the script works.

**Note:** Yaaz tries to make some choices in combats when it can help with quests
(things like olfaction and some combat items that are good in some circumstances).
From there, though, it reverts to your custom combat script settings in KoLMafia.
If you want yaaz to fight differently, make the changes in your CCS settings in
KoLMafia.

### yaaz-end

Run this command once yaaz completes and it'll use up everything it thinks it
can before rollover. This command won't make you overdrink, but will otherwise
try to prep you for end-of-day, including pvp, any one-a-day things you haven't
done, and get the best outfit for rollover.

Generally speaking, if you want to do other things during the day, you'd want
to do them before running this script.

### yaaz-begin

This command runs any "start of day" tasks that should be done early in a day
but has little cost (once a day things with a greater cost are attempted later
as appropriate resources are available). It's analogous to KolMafia's breakfast
system in many respects. This never needs to be run directly (the main yaaz
script runs this itself) but if you want to kick a day off, then do some manual
tasks first, this is an easy option.


### Other scripts

If you browse the script directory from the 'Scripts' menu, the majority of
scripts there can each be run individually as well. Run 'yz_prep' and it'll
do it's bit of cleanup for you, for instance.

This is most useful in the 'quests' directory where you can, instead of using
yaaz to attempt the whole ascension, have yaaz automate individual quests. Run
L06_Q_friar.ash and the Friar's quest will be done but nothing else. Quest
files have breakpoints in them, so manually running a quest file may have
to be done multiple times to get it to complete a quest.

Note that files that begin with 'yaaz-' are primarily meant to be run this way. Scripts starting with 'yz_' can be run, but are designed to primarily be run from the 'yaaz-' scripts, so you may get sub-optimal performance.


## Options

Lots of options available for Yaaz:

To change any of these flags, set the variable in the gCLI like so: `set yz_100familiar=mosquito`.

If you want to see what a flag is set to, use something like: `prefref yz_100familiar`. If nothing comes back, the script will use the default.

## Primary options
These options will change the various behaviors of how yaaz works.

| Option                 | Default | Notes |
| ---------------------- | ------- | ----- |
|  yz_100familiar        |           | Familiar to use for 100% run, versus trying to find the right familiar for a given task.  |
| yz_war_side            | `fratboy` | Fight Island War as fratboy or hippy. (fratboy generally recommended) |
|  yz_do_heart           |           | Do heart-y thing like using up your Smile of Mr. Accessory. Set to false to not be a heart while playing.  |
| yz_aggressive_optimize | `false`   | If true, skip all side actions that aren't solely about ascending (ex: Evoke Eldritch Horror, Portscan, Lights Out quest, etc) |
| yz_pvp                 | `true`    | 'false': don't PvP and don't talk about it. 'true': do PvP if the hippy stone is broken (will warn if it's not). 'always': Break the stone if it's not, then do PvP. |

## Secondary options
Usually you shouldn't need to change these, but if you're interested in some deeper tweaking, you can.

| Option                  | Default | Notes |
| ----------------------- | ------- | ----- |
| yz_no_pulls             | `false`  | If true, don't make any pulls when in Softcore. |
| yz_no_clovers           | `false`   | If true, don't use any clovers. |
| yz_pool_skill           | `*`       | If true, try to raise pool skill via the semi-rare. Defaults to true if you aren't already maxed and if yz_aggressive_optimize is false, otherwise it defaults to false. |
| yz_use_stash            | `false`   | If true, will put some items in the clan stash when it seems appropriate. Items moved are in the `yz_clan.txt` data file. |
| yz_no_heart             |         | A comma-separated list of people to never do heart-things to. Good for ignoring bots and such. |
| yz_do_jerk              | `true`    | If false things like warm milk, bricks, and toilet paper won't be used at people when doing 'heart' things." |
| yz_adventure_floor      |  `10`     |   Adventures left to start consuming food/booze |
| yz_do_collectors        | `true`    | Give things to certain well-known collectors, particularly devs of KoLMafia. Set to false to not give to these collectors. |
| yz_use_avatar_potions   | `true`    | Use avatar potions when you have them to stay constantly dressed up. |
| yz_log_level            |         | Set to 'info' or 'debug' to have more detailed messaging. |
| yz_no_dispose           | `false`   | If true, the script will be blocked from disposing of any item (selling, pulverizing, clan stash, etc. You'll need to do all inventory management manually. |
| yz_always_daily_dungeon | `false`   | After picking up the hero keys, if true it'll still get the daily dungeon rewards each day. |
| yz_use_stash            | `false`   | Dispose of some items in the clan stash instead of auto-selling. |
| yz_abort_on_no_tasks    | `false`   | If true, when there are no obvious quests to do, abort. If false, instead try spending some time leveling up. |
| yz_war_nuns             | `false`   | Complete the nuns sidequest in the island war. |
| yz_war_junkyard         | `true`    | Complete the junkyard sidequest in the island war. |
| yz_war_orchard          | `true`    | Complete the orchard sidequest in the island war. |
| yz_war_arena            | `true`    | Complete the arena sidequest in the island war. |
| yz_war_lighthouse       | `true`    | Complete the lighthouse (Sonofa beach) sidequest in the island war. |
| yz_max_wads             | `50`      | Max wads to have in inventory before stopping pulverizing anything. |
| yz_pvp_protection       | `true`    | If true, move things over pvp_min_value in value to your closet, if they're at risk of being pvp stolen. |
| yz_pvp_min_value           | `1000`    | Anything selling for more than this in the mall should be closetted at the end of the day, if yz_pvp_protection is set to true. |



## Action flags
You can add some additional actions from the script with these options. Most of these will add additional turns to your run, but if you're wanting to do some additional things besides simply ascending, you can ask the script to.

| Option          | Default | Notes |
| --------------- | ------- | ----- |
| yz_do_bounty    | `false`   | `never` (never take a bounty, or act on any), `false` (take bounties when easy, but don't spend any extra turns to complete them), `true` (complete active bounties, but don't take additional ones), `aggressive` (complete all available bounties), `aftercore` ('false' if in-run, 'aggressive' if in aftercore) |
| yz_do_nemesis   | `false`   | `true`, `false`, `aftercore`, `weapon`, or `aftercore-weapon`. `weapon` will stop at getting the legendary epic weapon, and `aftercore` will only work the quest during aftercore.


## Item of the Month flags

This will set how a few IotM and similar items are acted upon:

| Option          | Default | Notes |
| --------------- | ------- | ----- |
| yz_shower_temp                       | `mainstat`  | Use this temp when taking VIP showers. Can use a stat (or 'mainstat') or the actual temp ('hot', etc) |
| yz_max_daily_sausage                 | `5`         | Max sausages to grind each day. |
| yz_max_sausage_units                 | `5000`      | Grind auto-sellable things up to this many sausage units instead of simply selling them. |
| yz_manuel_location_count             | `5`         | For use with `yaaz-manuel`, how many locations/monsters to display. |
| yz_royal_tea_threshold               | `0`         | If > 0, will buy a cuppa royal tea each day if the price is below this threshold. Used to help gradually build up your royalty, if interested. |
| yz_stuffing_max                      | `1`         | Max turkey stuffing to throw in the battlefield. |
| yz_fortune_clannies                  |             | Comma separated list of clanmates to use with the Fortune Teller. (will try this list in order, based on who is online) |
| yz_manuel_always_show_progress       | `false`     | If false, when displaying progress of Monster Manuel factoids omit any locations where you already have 100%. |
| yz_daycare_recuits                   | `1`         | Number of times to recruit toddlers at the Boxing Daycare |
| yz_do_batfellow                      | `false`     | Once per day, try to do a batfellow special edition comic, if you have one. (requires Cheesecookie's Batfellow script) |
| yz_far_future                        | `true`      | If true, go to the future with your time-spinner and try to replicate something (requires Ezandora's Far Future script) |
| yz_do_lovetunnel                     | `true`      | If true, and if you have the LOVE Tunnel, will try to get things and fight folks. Set to `false` if you're trying to get the password. |
| yz_do_newyou                         | `aftercore` | Do the New You quest (Sharpen your Saw). (set to `true`, `false`, or `aftercore`) |
| yz_do_gingerbread                    | `aftercore` | Do the Gingerbread City.  (set to `true`, `false`, or `aftercore`) |
| yz_far_future                        | `true`      | Use the Time Spinner to go into the far future  (set to `true` or `false`) |
| yz_do_ltt                            | `false`     | Automate the LT&T telegram. (set to `true`, `false`, or `aftercore`). Note: This script aborts when you're at the LT&T boss since automating those fights hasn't been solved yet. Do that manually. |
| yz_partyfair                         | `aftercore` | Automate the Neverending Party. Set to aftercore and the script will still adventure here for the free adventures, but will decline the quest. (set to `true`, `false`, or `aftercore`) |
| yz_partyhard                         | `true`      | Do the hard mode quest in the Neverending Party when possible. |
| yz_do_spacegate                      | `false`     | Automate the Spacegate adventures. (set to `true`, `false`, or `aftercore`) |
| yz_upgrade_doctorbag                 | `aftercore` | Upgrade the Lil' Doctor Bag. (set to `true`, `false`, or `aftercore`) |
| yz_max_doctorbag_upgrades            | `1`         | Number of times yaaz will attempt to upgrade the Lil' Doctor Bag each day. |
| yz_max_doctorbag_upgrades_aftercore  |             | Defaults to `max_doctorbag_upgrades`, but will use this number if different when in aftercore. |

