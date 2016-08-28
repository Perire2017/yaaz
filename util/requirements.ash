import "print.ash";
import "util/util.ash";
import "util/adventure.ash";

// future requirements that we may as well sort out as we go.

void make_if_needed(item it, string msg)
{
  if (i_a(it) == 0 && creatable_amount(it) > 0)
  {
    if (msg != "")
    {
      log("Making " + wrap(it) + " " + msg);
    }
    create(1, it);
  }
}

void make_if_needed(item it)
{
  make_if_needed(it, "");
}

void buy_if_needed(item it, string message)
{
  if (i_a(it) > 0)
  {
    return;
  }

  coinmaster coin = it.seller;
  if (coin == $coinmaster[none])
  {
    // a regular store item
    if (!is_npc_item(it))
    {
      warning("Trying to possibly by " + wrap(it) + " but that's not an NPC item...");
      return;
    }
    int price = npc_price(it);
    if (price == 0)
    {
      // We can't buy from that NPC shop right now.
      // Don't sweat it and assume we can buy it later.
      // (or don't sweat it since we'll never be able to, like the frilly skirt
      // on the wrong star sign)
      return;
    }
    if (price*10 > my_meat())
    {
      // we don't have the spare cash to comfortably buy this.
      return;
    }
    if (message != "")
    {
      log("Buying " + wrap(it) + " " + message);
    }
    buy(1, it);
  } else {
    if (is_accessible(coin))
    {
      int coins = coin.available_tokens;
      int price = sell_price(coin, it);
      if (price <= coins)
      {
        // we can reach the coinmaster, and have enough <coin> to buy it!
        if (message != "")
        {
          log("Buying " + wrap(it) + " " + message);
        }
        buy(coin, 1, it);
      }
    }
  }
}

void buy_if_needed(item it)
{
  buy_if_needed(it, "");
}

void keys()
{
  if (quest_status("questL13Final") > 3)
  {
    return;
  }
  // keys for the door.
  string msg = "for the perplexing door.";
  make_if_needed($item[skeleton key], msg);
  make_if_needed($item[digital key], msg);
  make_if_needed($item[richard's star key], msg);

  buy_if_needed($item[boris's key], msg);
  buy_if_needed($item[jarlsberg's key], msg);
  buy_if_needed($item[sneaky pete's key], msg);
}

void build_requirements()
{
  if (get_property("questL13Final") == "finished")
    return;

  buy_if_needed($item[frilly skirt], "so we can catburgle with the " + wrap($item[Orcish Frat House blueprints]) + ".");

  make_if_needed($item[unstable fulminate]);
  if (my_meat() > 5000)
  {
    make_if_needed($item[bitchin' meatcar], "to reach the desert.");
  }

  if (get_property("questL11Palindome") != "finished")
  {
    make_if_needed($item[wet stunt nut stew], "for Mr. Alarm");
  }

  if (get_property("questL13Final") != "unstarted" && i_a($item[wand of nagamar]) == 0 && can_adventure())
  {
    if (creatable_amount($item[wand of nagamar]) > 0)
    {
      create(1, $item[wand of nagamar]);
    } else if (item_amount($item[disassembled clover]) == 0)
    {
      warning("Note: you don't have the " + wrap($item[wand of nagamar]) + ", but are at the tower.");
    } else {
      log("Going to get the pieces of the " + wrap($item[wand of nagamar]) + ".");
      use(1, $item[disassembled clover]);

      string protect = get_property("cloverProtectActive");
      set_property("cloverProtectActive", false);
      dg_adventure($location[The Castle in the Clouds in the Sky (Basement)]);
			set_property("cloverProtectActive", protect);
      create(1, $item[wand of nagamar]);
    }
  }

  while (item_amount($item[Talisman o' Namsilat]) == 0 && item_amount($item[gaudy key]) > 0)
  {
    cli_execute("checkpoint");
    if (!have_equipped($item[pirate fledges]))
    {
      equip($item[pirate fledges]);
    }
    use(1, $item[gaudy key]);
    cli_execute("outfit checkpoint");
  }

  if (item_amount($item[unstable fulminate]) == 0 && creatable_amount($item[unstable fulminate]) > 0)
  {
    create(1, $item[unstable fulminate]);
  }

  if (have_cubeling_items() && !get_property("dailyDungeonDone").to_boolean() && quest_status("questL13Final") < 3 && can_adventure())
  {
    if (i_a($item[sneaky pete's key]) == 0 || i_a($item[boris's key]) == 0 || i_a($item[jarlsberg's key]) == 0)
    {
      maximize("", $item[ring of detect boring doors]);
      while (!get_property("dailyDungeonDone").to_boolean())
      {
        dg_adventure($location[the daily dungeon]);
      }
    }
  }

  keys();

  // Cobb Goblin cake
  if (creatable_amount($item[knob cake]) > 0 && get_property("questL05Goblin") != "finished")
  {
    create(1, $item[knob cake]);
  }

  if (creatable_amount($item[jar of oil]) > 0 && item_amount($item[jar of oil]) == 0 && !bit_flag(get_property("twinPeakProgress").to_int(), 2))
  {
    create(1, $item[jar of oil]);
  }

}

void main()
{
  build_requirements();
  log("Requirements check complete.");
}
