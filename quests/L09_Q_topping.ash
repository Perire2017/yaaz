import "quests/L09_SQ_bridge.ash";
import "quests/L09_SQ_oilpeak.ash";

boolean L09_Q_topping()
{
  if (L09_SQ_bridge()) return true;
  if (L09_SQ_oilpeak()) return true;

  return false;
}

void main()
{
  L09_SQ_bridge();
}