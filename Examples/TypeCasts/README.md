#### TypeCasts

This folder contains two contracts a simpler version and an executable version of a Type Casts vulnerability:

SimpleTypeCasts.sol -> Simpler version

TypeCasts.sol -> Deployable and executable version

You can execute try to visualize this vulnerability by running script.py:

USAGE: python3 script.py

This script deploys 3 contracts (Game, CounterLibrary and FakeCounter), uses CounterLibrary to execute play() function two times and the third time it uses FakeCounter. As consequence, instead of returning 3, Game contract returns 2, because it used two different contracts to execute this function.