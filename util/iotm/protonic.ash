import "util/base/monsters.ash";
import "util/base/locations.ash";

boolean ghost_hunting()
{
  // need better logic here to decide if we're going to hunt a ghost.
  if (my_hp() < 200)
    return false;
   if (get_property("questPAGhost") == STARTED || get_property("ghostLocation") != "")
    return true;
  return false;
}

location ghost_location()
{
  return to_location(get_property("ghostLocation"));
}

boolean protonic()
{
  if (!ghost_hunting())
    return false;

  location ghost_loc = ghost_location();
  if (!location_open(ghost_loc))
  {
    warning("Wanting to catch a ghost at " + wrap(ghost_loc) + " but I can't auto-unlock that yet.");
    wait(10);
    return false;
  }

  log("Who ya gonna call? No one. You're going to trap this ghost in " + wrap(ghost_loc) + " and keep it for yourself.");
  maximize("", $item[protonic accelerator pack]);
  adv1(ghost_loc, -1, "");
  return true;
}

void cross_streams(string player)
{
  if (i_a($item[protonic accelerator pack]) == 0)
    return;

  if (to_boolean(get_property("_streamsCrossed")))
    return;

  log("Crossing streams with " + wrap(player, COLOR_MONSTER) + ".");
  cli_execute("crossstreams " + player);
}

void cross_streams()
{
  string p = get_property("streamCrossDefaultTarget");
  cross_streams(p);
}

void main()
{
  protonic();
}
