import "util/print.ash";
import "util/inventory.ash";
import "util/effects.ash";
import "util/familiars.ash";

void do_maximize(string target, string outfit, item it);
void maximize(string target, string outfit, item it, familiar fam);
void maximize(string target, item it);
void maximize(string target, string outfit, familiar fam);
void maximize(string target, string outfit);
void maximize(string target);
void maximize();
void max_effects(string target);

void do_maximize(string target, string outfit, item it)
{
  string max = target;
  if (outfit != "")
  {
    if (max != "")
    {
      max = max + ", ";
    }
    max = max + "outfit " + outfit;
  }

  if (it != $item[none])
  {
    if (max != "")
    {
      max = max + ", ";
    }
    max = max + "+equip " + it;
  }

  maximize(max, false);
}

string default_maximize_string()
{
  string def = "mainstat, 0.4 hp  +effective, mp regen";
  if (my_buffedstat($stat[muscle]) > my_buffedstat($stat[moxie]))
  {
    def += ", +shield";
  }
  return def;
}

void maximize(string target, string outfit, item it, familiar fam)
{
  if (fam != $familiar[none])
    equip_familiar(fam);
  else
    choose_familiar(target);

  switch(target)
  {
    case "":
      do_maximize(default_maximize_string(), outfit, it);
      break;
    case "items":
    case "init":
    case "ml":
      do_maximize(target, outfit, it);
      break;
    case "noncombat":
      do_maximize("-combat", outfit, it);
      break;
    case "rollover":
      do_maximize("adv, pvp fights", outfit, it);
      break;
    default:
      warning("Tried to maximize '" + target+ "', but I don't understand that.");
  }
  max_effects(target);
}

void maximize(string target, item it)
{
  maximize(target, "", it, $familiar[none]);
}

void maximize(string target, string outfit, familiar fam)
{
  maximize(target, outfit, $item[none], fam);
}

void maximize(string target, familiar fam)
{
  maximize(target, "", fam);
}

void maximize(string target, string outfit)
{
  maximize(target, outfit, $familiar[none]);
}

void maximize(string target)
{
  maximize(target, "");
}

void maximize()
{
  maximize("");
}

void max_effects(string target)
{
  switch(target)
  {
    case "items":
      get_accordion();
      effect_maintain($effect[eye of the seal]);
      effect_maintain($effect[ermine eyes]);
      effect_maintain($effect[Fat Leon's Phat Loot Lyric]);
      effect_maintain($effect[ocelot eyes]);
      effect_maintain($effect[peeled eyeballs]);
      effect_maintain($effect[singer's faithful ocelot]);
      break;
    case "init":
      effect_maintain($effect[Sepia Tan]);
      effect_maintain($effect[Song of Slowness]);
      effect_maintain($effect[Springy Fusilli]);
      effect_maintain($effect[Ticking Clock]);
      effect_maintain($effect[Walberg\'s Dim Bulb]);
      break;
    case "noncombat":
      effect_maintain($effect[Fresh Scent]);
      effect_maintain($effect[Smooth Movements]);
      effect_maintain($effect[The Sonata of Sneakiness]);
      break;
    case "ml":
      effect_maintain($effect[Drescher's Annoying Noise]);
      effect_maintain($effect[pride of the puffin]);
      effect_maintain($effect[tortious]);
      effect_maintain($effect[eau d'enmity]);
      break;
    case "":
    case "rollover":
      break;
    default:
      warning("Tried to maximize effects for '" + target+ "', but I don't understand that.");
  }

}
