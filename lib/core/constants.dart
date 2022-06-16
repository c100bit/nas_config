import 'package:flutter/material.dart';
import 'package:nas_config/models/settings.dart';

const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const colorSchemeSeed = Color(0x006750A4);
const textColor = Color(0xFFadaeb5);
const focusColor = Color.fromARGB(255, 94, 98, 128);

const mainBtnColor = bgColor;
const mainBtnHoverColor = Color.fromARGB(255, 36, 39, 57);
const mainBtnTextColor = Color(0xffd0bcff);

const defaultPadding = 10.0;
const defaultMargin = 4.0;
const defaultRadius = 10.0;

const btnFontSize = 16.0;
const captionSize = 18.0;
const bodyTextSize = 15.0;

const timeoutSelectValues = [5, 10, 20, 30];
const threadsSelectValues = [5, 10, 20, 30];

const timeoutDefaultValue = 5;
const threadsDefaultValue = 5;
const protocolDefaultValue = SettingsProtocol.ssh;
const loginDefaultValue = '';
const passwordDefaultValue = '';
const deviceDefaultValue = DeviceType.miktorik;

const appModelKey = 'appModelKey';

const appMinWSize = 500.0;
const appMinHSize = 700.0;

const appDebug = true;

const dlinkWelcome = '#';
const dlinkCheckCmd = 'show switch';
const dlinkCheckStr = 'Device Type';
const dlinkKeyWords = ['dlink, d-link'];

const mikrotikWelcome = '>';
const mikrotikCheckCmd = '/system resource print';
const mikrotikCheckStr = 'mikrotik';
const mikrotikKeyWords = ['mikrotik'];

const mobileWidth = 870;

const logFilePath = 'result.log';
const logTimeFormat = 'yyyy-MM-dd H:mm:ss';
