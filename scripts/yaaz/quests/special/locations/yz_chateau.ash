import "util/base/yz_print.ash";
import "util/base/yz_util.ash";
import "util/base/yz_inventory.ash";
import "util/base/yz_monsters.ash";
import "util/base/yz_maximize.ash";

import 'special/locations/yz_terminal.ash';

void chateau_progress()
{

}

void chateau_cleanup()
{

}

boolean can_chateau()
{
  return prop_bool("chateauAvailable") && be_good($item[Chateau Mantegna room key]);
}

boolean can_chateau_fight()
{
  if (prop_bool("_chateauMonsterFought"))
    return false;
  return true;
}

monster chateau_monster()
{
  return to_monster(get_property("chateauMonster"));
}

boolean chateau()
{
  if (!can_chateau())
  {
    return false;
  }

  if (!prop_bool("_chateauDeskHarvested"))
  {
    log("Collecting items from the " + wrap("Chateau Mantegna", COLOR_LOCATION) + " desk.");
    int desk = 0;
    if (get_chateau() contains $item[swiss piggy bank])
    {
      desk = 1;
    } else if (get_chateau() contains $item[continental juice bar])
    {
      desk = 2;
    } else if (get_chateau() contains $item[fancy stationery set])
    {
      desk = 3;
    }
    if (desk > 0)
    {
      visit_url("place.php?whichplace=chateau&action=chateau_desk" + desk);
    }
    return true;
  }

  if (chateau_monster() == $monster[writing desk]
      && !have($item[ghost of a necklace]))
  {
    if (can_chateau_fight() && expected_damage($monster[writing desk]) < (my_hp() / 2))
    {
      log("Looks like we can fight a " + wrap($monster[writing desk]) +" now, so going to do that.");
      if (can_terminal())
      {
        if (digitize_remaining() > 0)
        {
          if (!educated('digitize.edu'))
          {
            terminal_educate('digitize.edu');
          }
        }
      }
      maximize();
      string temp = visit_url('place.php?whichplace=chateau&action=chateau_painting');
      run_combat('yz_consult');
      return true;
    }
  }
  return false;

}

void main()
{
  log("Doing default actions with the " + wrap("Chateau Mantegna", COLOR_LOCATION) + ".");
  while(chateau());
}
