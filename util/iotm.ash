
import "util/iotm/snojo.ash";
import "util/iotm/witchess.ash";
import "util/iotm/terminal.ash";
import "util/iotm/chateau.ash";
import "util/iotm/deck.ash";
import "util/iotm/floundry.ash";
import "util/iotm/bookshelf.ash";

void iotm()
{
  log("Doing default actions with various IotM things, if you have them.");
  //snojo();

  //witchess();

  chateau();

  terminal();

  deck();

  floundry();

  while(libram())
  {
    // cast a few of these
  }
}

void main()
{
  iotm();
}
