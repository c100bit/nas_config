import 'package:telnet/telnet.dart';

abstract class TelnetProcessor {
  late TelnetClient client;

  void updateClient(TelnetClient client) => this.client = client;
  void run(TLMsg msg);
}
