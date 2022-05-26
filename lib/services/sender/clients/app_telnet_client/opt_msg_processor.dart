import 'package:nas_config/services/sender/clients/app_telnet_client/telnet_processor.dart';
import 'package:telnet/telnet.dart';

class OptMsgProcessor extends TelnetProcessor {
  late final Map<TLOpt, List<TLMsg>> _willReplyMap;
  late final Map<TLOpt, List<TLMsg>> _doReplyMap;
  final _echoEnabled = true;

  OptMsgProcessor(super.client) {
    _initReplyMap();
  }

  void _initReplyMap() {
    _willReplyMap = <TLOpt, List<TLMsg>>{
      TLOpt.echo: [
        _echoEnabled
            ? TLOptMsg(TLCmd.doIt, TLOpt.echo) // [IAC DO ECHO]
            : TLOptMsg(TLCmd.doNot, TLOpt.echo)
      ], // [IAC DON'T ECHO]
      TLOpt.suppress: [
        TLOptMsg(TLCmd.doIt, TLOpt.suppress)
      ], // [IAC DO SUPPRESS_GO_AHEAD]
      TLOpt.logout: [],
    };
    _doReplyMap = <TLOpt, List<TLMsg>>{
      TLOpt.echo: [
        _echoEnabled
            ? TLOptMsg(TLCmd.will, TLOpt.echo) // [IAC WILL ECHO]
            : TLOptMsg(TLCmd.wont, TLOpt.echo)
      ], // [IAC WONT ECHO]
      TLOpt.logout: [],
      TLOpt.tmlType: [
        TLOptMsg(TLCmd.will, TLOpt.tmlType), // [IAC WILL TERMINAL_TYPE]
        TLSubMsg(TLOpt.tmlType, [
          0x00,
          0x41,
          0x4E,
          0x53,
          0x49
        ]), // [IAC SB TERMINAL_TYPE IS ANSI IAC SE]
      ],
      TLOpt.windowSize: [
        TLOptMsg(TLCmd.will, TLOpt.windowSize), // [IAC WILL WINDOW_SIZE]
        TLSubMsg(TLOpt.windowSize,
            [0x00, 0x5A, 0x00, 0x18]), // [IAC SB WINDOW_SIZE 90 24 IAC SE]
      ],
    };
  }

  @override
  void run(TLMsg msg) {
    final cmd = (msg as TLOptMsg).cmd; // Telnet Negotiation Command.
    final opt = (msg as TLOptMsg).opt; // Telnet Negotiation Option.

    if (cmd == TLCmd.wont) {
      // Write [IAC DO opt].
      _client?.write(TLOptMsg(TLCmd.doNot, opt));
    } else if (cmd == TLCmd.doNot) {
      // Write [IAC WON'T opt].
      _client?.write(TLOptMsg(TLCmd.wont, opt));
    } else if (cmd == TLCmd.will) {
      if (_willReplyMap.containsKey(opt)) {
        // Reply the option.
        for (var msg in _willReplyMap[opt]!) {
          _client?.write(msg);
        }
      } else {
        // Write [IAC DON'T opt].
        _client?.write(TLOptMsg(TLCmd.doNot, opt));
      }
    } else if (cmd == TLCmd.doIt) {
      // Reply the option.
      if (_doReplyMap.containsKey(opt)) {
        for (var msg in _doReplyMap[opt]!) {
          _client?.write(msg);
        }
      } else {
        // Write [IAC WON'T opt].
        _client?.write(TLOptMsg(TLCmd.wont, opt));
      }
    }
  }
}
