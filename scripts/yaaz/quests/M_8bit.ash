import "util/main.ash";

boolean M_8bit()
{
  if (have($item[digital key]))
    return false;

  if (quest_status("questL13Final") > 3)
    return false;

  if (!have($item[continuum transfunctioner]))
    return false;

  if (dangerous($monster[blooper]))
  {
    log("Skipping the " + wrap($location[8-bit realm]) + " until it's safer.");
    return false;
  }

  while(!have($item[digital key]))
  {
    if (creatable_amount($item[digital key]) > 0)
    {
      log("Making a " + wrap($item[digital key]) + ".");
      create(1, $item[digital key]);
      continue;
    }
    maximize("items", $item[continuum transfunctioner]);
    if (!time_combat($monster[blooper], $location[8-bit realm]))
    {
      boolean b = yz_adventure($location[8-bit realm]);
      if (!b)
        break;
    }
  }
  return true;
}

void main()
{
  M_8bit();
}
