import "util/main.ash";

boolean one_orchard_effect(effect ef, item it)
{
  if (have_effect(ef) == 0 && item_amount(it) > 0)
  {
    use(1, it);
  }
  if (have_effect(ef) > 0)
    return true;
  else
    return false;
}

void check_orchard_effects()
{
  if (one_orchard_effect($effect[filthworm guard stench], $item[filthworm royal guard scent gland]))
    return;
  if (one_orchard_effect($effect[filthworm drone stench], $item[filthworm drone scent gland]))
    return;
  if (one_orchard_effect($effect[filthworm larva stench], $item[filthworm hatchling scent gland]))
    return;
}

location pick_orchard_location()
{

  if (have_effect($effect[filthworm guard stench]) > 0)
    return $location[The Filthworm Queen's Chamber];
  if (have_effect($effect[filthworm drone stench]) > 0)
    return $location[The royal guard Chamber];
  if (have_effect($effect[filthworm larva stench]) > 0)
    return $location[The feeding Chamber];

  return $location[the hatching chamber];
}

void do_orchard()
{

  if (get_property("sidequestOrchardCompleted") != "none")
  {
    log("Orchard quest already complete.");
    return;
  }

  if (get_property("hippiesDefeated") < 64)
  {
    warning("Orchard quest not available yet. Kill more hippies.");
    return;
  }

  log("Completing the orchard quest.");
  while (i_a($item[heart of the filthworm queen]) == 0)
  {
    check_orchard_effects();

    maximize("items");
    dg_adventure(pick_orchard_location());
  }
  outfit("frat warrior fatigues");
  log("Visiting the grocer to complete the quest.");
  visit_url("bigisland.php?place=orchard&action=stand&pwd=");

  log("Visiting the grocer once more to collect our reward.");
  visit_url("bigisland.php?place=orchard&action=stand&pwd=");
  log("Orchard complete.");
}

void main()
{
  do_orchard();
}