import 'util/base/settings.ash';

void eldritchhorror()
{
  if (!have_skill($skill[evoke eldritch horror])) return;
  if (to_boolean(get_property("_eldritchHorrorEvoked"))) return;

  if (to_boolean(setting("aggressive_optimize", "false"))) return;

  int cost = mp_cost($skill[evoke eldritch horror]);

  if (cost < my_mp() * 1.5)
  {
    maximize();
    use_skill(1, $skill[evoke eldritch horror]);
  }
}

void main()
{
  eldritchhorror();
}