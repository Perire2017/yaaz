import "util/base/print.ash";
import "util/base/consume.ash";

item effect_to_item(effect ef)
{
  switch(ef)
  {
    case $effect[adorable lookout]:     return $item[giraffe-necked turtle];
    case $effect[baited hook]:          return $item[wriggling worm];
    case $effect[balls of ectoplasm]:   return $item[ectoplasmic orbs];
    case $effect[black tongue]:         return $item[black snowcone];
    case $effect[blue tongue]:          return $item[blue snowcone];
    case $effect[Eau de Tortue]:        return $item[turtle pheromones];
    case $effect[Eau d'enmity]:         return $item[perfume of prejudice];
    case $effect[ermine eyes]:          return $item[eyedrops of the ermine];
    case $effect[eye of the seal]:      return $item[seal eyeball];
    case $effect[fresh scent]:          return $item[deodorant];
    case $effect[green tongue]:         return $item[green snowcone];
    case $effect[high colognic]:        return $item[musk turtle];
    case $effect[hippy stench]:         return $item[reodorant];
    case $effect[lustful heart]:        return $item[love song of naughty innuendo];
    case $effect[ocelot eyes]:          return $item[eyedrops of the ocelot];
    case $effect[orange tongue]:        return $item[orange snowcone];
    case $effect[peeled eyeballs]:      return $item[knob goblin eyedrops];
    case $effect[purple tongue]:        return $item[purple snowcone];
    case $effect[red tongue]:           return $item[red snowcone];
    case $effect[Rushtacean\']:         return $item[armored prawn];
    case $effect[Sepia Tan]:            return $item[old bronzer];
    case $effect[Spiro Gyro]:           return $item[programmable turtle];
    case $effect[Ticking Clock]:        return $item[cheap wind-up clock];
    case $effect[tortious]:             return $item[mocking turtle];
    case $effect[withered heart]:       return $item[love song of disturbing obsession];
    default:                            return $item[none];
  }
}

skill effect_to_skill(effect ef)
{
  return to_skill(ef);
}

void effect_maintain(effect ef)
{
  if (have_effect(ef) > 0)
    return;

  item it = effect_to_item(ef);
  skill sk = effect_to_skill(ef);

  if (sk == $skill[none] && it == $item[none])
  {
    error("Trying to add an effect (" + wrap(ef) + ") and can't find an appropriate skill or item.");
    return;
  }

  if (sk != $skill[none])
  {
    if (have_skill(sk))
    {
      log("Adding effect " + wrap(ef) + " by casting " + wrap(sk) + ".");
      use_skill(1, sk);
      return;
    }
  }

  if (it != $item[none])
  {
    // buy one if we need it and can afford it:
    if (item_amount(it) == 0)
    {
      if (is_npc_item(it))
      {
        int price = npc_price(it);
        if (price > 0 && price < my_meat()*10)
        {
          log("Buying " + wrap(it) + " to maintain " + wrap(ef));
          buy(1, it);
        }
      }
    }

    if (item_amount(it) > 0)
    {
      log("Adding effect " + wrap(ef) + " by using " + wrap(it) + ".");
      use(1, it);
      return;
    }
  }
}

boolean uneffect(effect ef)
{
	if(have_effect(ef) == 0)
		return true;

	if(cli_execute("uneffect " + ef))
		return true;

	if(item_amount($item[Soft Green Echo Eyedrop Antidote]) > 0)
	{
    log("Removing the effect " + wrap(ef) + " with a " + wrap($item[Soft Green Echo Eyedrop Antidote]) + ".");
		visit_url("uneffect.php?pwd=&using=Yep.&whicheffect=" + to_int(ef));
		return true;
	}
	return false;
}

void cast_surplus_mp()
{
  if (my_mp() < (my_maxmp() * 0.8))
    return;

  log("Trying to cast out surplus MP. Can't easily test this until out of Nuclear Autumn.");
  wait(5);

  effect[int] effect_list;
  int count = 0;

  foreach ef in $effects[polka of plenty,
                         Fat Leon's Phat Loot Lyric,
                         elemental saucesphere,
                         astral shell,
                         snarl of the timberwolf,
                         ghostly shell,
                         Empathy,
                         ear winds,
                         Impeccable Coiffure]
  {
    if (have_skill(effect_to_skill(ef)))
    {
      effect_list[count] = ef;
      count += 1;
    }
  }

  sort effect_list by have_effect(value);

  foreach ef in effect_list
  {
    if(my_mp() < (my_maxmp() * 0.8))
      break;
    use_skill(1, to_skill(effect_list[ef]));
  }


}
