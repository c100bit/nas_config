import 'package:telnet/telnet.dart';

abstract class TelnetProcessor {
  final ITelnetClient client;
  TelnetProcessor(this.client);

  void run(TLMsg msg);
}
