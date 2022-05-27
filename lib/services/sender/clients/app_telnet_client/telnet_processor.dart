import 'package:telnet/telnet.dart';

abstract class TelnetProcessor {
  late final TelnetClient client;

  void addClient(TelnetClient client) => this.client = client;
  void run(TLMsg msg);
}
