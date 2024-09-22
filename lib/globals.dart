library app.globals;

import 'package:flutter/animation.dart';
import 'package:clipious/service.dart';
import 'package:clipious/utils/file_db.dart';
import 'package:clipious/utils/interfaces/db.dart';

import 'utils/models/country.dart';

// const BROADCAST_SERVER_CHANGED = 'server-changed';
// const BROADCAST_STOP_PLAYING = 'stop-playing';
// const BROADCAST_STOP_MINI_PLAYER = 'stop-mini-player';
// const BROADCAST_MOVE_MINI_PLAYER = 'move-mini-player';
// const NAVIGATOR_KEY = 1;
const youtubeHosts = [
  'youtube.com',
  'www.youtube.com',
  'm.youtube.com',
  'youtu.be'
];

const animationDuration = Duration(milliseconds: 250);
const animationCurve = Curves.easeInOutQuad;

Service service = Service();

const double innerHorizontalPadding = 16;

late IDbClient db;

final FileDB fileDb = FileDB();

List<Country> countryCodes = [
  Country('AD', 'Andorra'),
  Country('AE', 'United Arab Emirates'),
  Country('AF', 'Afghanistan'),
  Country('AG', 'Antigua and Barbuda'),
  Country('AI', 'Anguilla'),
  Country('AL', 'Albania'),
  Country('AM', 'Armenia'),
  Country('AO', 'Angola'),
  Country('AQ', 'Antarctica'),
  Country('AR', 'Argentina'),
  Country('AS', 'American Samoa'),
  Country('AT', 'Austria'),
  Country('AU', 'Australia'),
  Country('AW', 'Aruba'),
  Country('AX', 'Åland Islands'),
  Country('AZ', 'Azerbaijan'),
  Country('BA', 'Bosnia and Herzegovina'),
  Country('BB', 'Barbados'),
  Country('BD', 'Bangladesh'),
  Country('BE', 'Belgium'),
  Country('BF', 'Burkina Faso'),
  Country('BG', 'Bulgaria'),
  Country('BH', 'Bahrain'),
  Country('BI', 'Burundi'),
  Country('BJ', 'Benin'),
  Country('BL', 'Saint Barthélemy'),
  Country('BM', 'Bermuda'),
  Country('BN', 'Brunei Darussalam'),
  Country('BO', 'Bolivia (Plurinational State of)'),
  Country('BQ', 'Bonaire, Sint Eustatius and Saba'),
  Country('BR', 'Brazil'),
  Country('BS', 'Bahamas'),
  Country('BT', 'Bhutan'),
  Country('BV', 'Bouvet Island'),
  Country('BW', 'Botswana'),
  Country('BY', 'Belarus'),
  Country('BZ', 'Belize'),
  Country('CA', 'Canada'),
  Country('CC', 'Cocos (Keeling) Islands'),
  Country('CD', 'Congo, Democratic Republic of the'),
  Country('CF', 'Central African Republic'),
  Country('CG', 'Congo'),
  Country('CH', 'Switzerland'),
  Country('CI', 'Côte d\'Ivoire'),
  Country('CK', 'Cook Islands'),
  Country('CL', 'Chile'),
  Country('CM', 'Cameroon'),
  Country('CN', 'China'),
  Country('CO', 'Colombia'),
  Country('CR', 'Costa Rica'),
  Country('CU', 'Cuba'),
  Country('CV', 'Cabo Verde'),
  Country('CW', 'Curaçao'),
  Country('CX', 'Christmas Island'),
  Country('CY', 'Cyprus'),
  Country('CZ', 'Czechia'),
  Country('DE', 'Germany'),
  Country('DJ', 'Djibouti'),
  Country('DK', 'Denmark'),
  Country('DM', 'Dominica'),
  Country('DO', 'Dominican Republic'),
  Country('DZ', 'Algeria'),
  Country('EC', 'Ecuador'),
  Country('EE', 'Estonia'),
  Country('EG', 'Egypt'),
  Country('EH', 'Western Sahara'),
  Country('ER', 'Eritrea'),
  Country('ES', 'Spain'),
  Country('ET', 'Ethiopia'),
  Country('FI', 'Finland'),
  Country('FJ', 'Fiji'),
  Country('FK', 'Falkland Islands (Malvinas)'),
  Country('FM', 'Micronesia (Federated States of)'),
  Country('FO', 'Faroe Islands'),
  Country('FR', 'France'),
  Country('GA', 'Gabon'),
  Country('GB', 'United Kingdom of Great Britain and Northern Ireland'),
  Country('GD', 'Grenada'),
  Country('GE', 'Georgia'),
  Country('GF', 'French Guiana'),
  Country('GG', 'Guernsey'),
  Country('GH', 'Ghana'),
  Country('GI', 'Gibraltar'),
  Country('GL', 'Greenland'),
  Country('GM', 'Gambia'),
  Country('GN', 'Guinea'),
  Country('GP', 'Guadeloupe'),
  Country('GQ', 'Equatorial Guinea'),
  Country('GR', 'Greece'),
  Country('GS', 'South Georgia and the South Sandwich Islands'),
  Country('GT', 'Guatemala'),
  Country('GU', 'Guam'),
  Country('GW', 'Guinea-Bissau'),
  Country('GY', 'Guyana'),
  Country('HK', 'Hong Kong'),
  Country('HM', 'Heard Island and McDonald Islands'),
  Country('HN', 'Honduras'),
  Country('HR', 'Croatia'),
  Country('HT', 'Haiti'),
  Country('HU', 'Hungary'),
  Country('ID', 'Indonesia'),
  Country('IE', 'Ireland'),
  Country('IL', 'Israel'),
  Country('IM', 'Isle of Man'),
  Country('IN', 'India'),
  Country('IO', 'British Indian Ocean Territory'),
  Country('IQ', 'Iraq'),
  Country('IR', 'Iran (Islamic Republic of)'),
  Country('IS', 'Iceland'),
  Country('IT', 'Italy'),
  Country('JE', 'Jersey'),
  Country('JM', 'Jamaica'),
  Country('JO', 'Jordan'),
  Country('JP', 'Japan'),
  Country('KE', 'Kenya'),
  Country('KG', 'Kyrgyzstan'),
  Country('KH', 'Cambodia'),
  Country('KI', 'Kiribati'),
  Country('KM', 'Comoros'),
  Country('KN', 'Saint Kitts and Nevis'),
  Country('KP', 'Korea (Democratic People\'s Republic of)'),
  Country('KR', 'Korea, Republic of'),
  Country('KW', 'Kuwait'),
  Country('KY', 'Cayman Islands'),
  Country('KZ', 'Kazakhstan'),
  Country('LA', 'Lao People\'s Democratic Republic'),
  Country('LB', 'Lebanon'),
  Country('LC', 'Saint Lucia'),
  Country('LI', 'Liechtenstein'),
  Country('LK', 'Sri Lanka'),
  Country('LR', 'Liberia'),
  Country('LS', 'Lesotho'),
  Country('LT', 'Lithuania'),
  Country('LU', 'Luxembourg'),
  Country('LV', 'Latvia'),
  Country('LY', 'Libya'),
  Country('MA', 'Morocco'),
  Country('MC', 'Monaco'),
  Country('MD', 'Moldova, Republic of'),
  Country('ME', 'Montenegro'),
  Country('MF', 'Saint Martin (French part)'),
  Country('MG', 'Madagascar'),
  Country('MH', 'Marshall Islands'),
  Country('MK', 'North Macedonia'),
  Country('ML', 'Mali'),
  Country('MM', 'Myanmar'),
  Country('MN', 'Mongolia'),
  Country('MO', 'Macao'),
  Country('MP', 'Northern Mariana Islands'),
  Country('MQ', 'Martinique'),
  Country('MR', 'Mauritania'),
  Country('MS', 'Montserrat'),
  Country('MT', 'Malta'),
  Country('MU', 'Mauritius'),
  Country('MV', 'Maldives'),
  Country('MW', 'Malawi'),
  Country('MX', 'Mexico'),
  Country('MY', 'Malaysia'),
  Country('MZ', 'Mozambique'),
  Country('NA', 'Namibia'),
  Country('NC', 'New Caledonia'),
  Country('NE', 'Niger'),
  Country('NF', 'Norfolk Island'),
  Country('NG', 'Nigeria'),
  Country('NI', 'Nicaragua'),
  Country('NL', 'Netherlands'),
  Country('NO', 'Norway'),
  Country('NP', 'Nepal'),
  Country('NR', 'Nauru'),
  Country('NU', 'Niue'),
  Country('NZ', 'New Zealand'),
  Country('OM', 'Oman'),
  Country('PA', 'Panama'),
  Country('PE', 'Peru'),
  Country('PF', 'French Polynesia'),
  Country('PG', 'Papua New Guinea'),
  Country('PH', 'Philippines'),
  Country('PK', 'Pakistan'),
  Country('PL', 'Poland'),
  Country('PM', 'Saint Pierre and Miquelon'),
  Country('PN', 'Pitcairn'),
  Country('PR', 'Puerto Rico'),
  Country('PS', 'Palestine, State of'),
  Country('PT', 'Portugal'),
  Country('PW', 'Palau'),
  Country('PY', 'Paraguay'),
  Country('QA', 'Qatar'),
  Country('RE', 'Réunion'),
  Country('RO', 'Romania'),
  Country('RS', 'Serbia'),
  Country('RU', 'Russian Federation'),
  Country('RW', 'Rwanda'),
  Country('SA', 'Saudi Arabia'),
  Country('SB', 'Solomon Islands'),
  Country('SC', 'Seychelles'),
  Country('SD', 'Sudan'),
  Country('SE', 'Sweden'),
  Country('SG', 'Singapore'),
  Country('SH', 'Saint Helena, Ascension and Tristan da Cunha'),
  Country('SI', 'Slovenia'),
  Country('SJ', 'Svalbard and Jan Mayen'),
  Country('SK', 'Slovakia'),
  Country('SL', 'Sierra Leone'),
  Country('SM', 'San Marino'),
  Country('SN', 'Senegal'),
  Country('SO', 'Somalia'),
  Country('SR', 'Suriname'),
  Country('SS', 'South Sudan'),
  Country('ST', 'Sao Tome and Principe'),
  Country('SV', 'El Salvador'),
  Country('SX', 'Sint Maarten (Dutch part)'),
  Country('SY', 'Syrian Arab Republic'),
  Country('SZ', 'Eswatini'),
  Country('TC', 'Turks and Caicos Islands'),
  Country('TD', 'Chad'),
  Country('TF', 'French Southern Territories'),
  Country('TG', 'Togo'),
  Country('TH', 'Thailand'),
  Country('TJ', 'Tajikistan'),
  Country('TK', 'Tokelau'),
  Country('TL', 'Timor-Leste'),
  Country('TM', 'Turkmenistan'),
  Country('TN', 'Tunisia'),
  Country('TO', 'Tonga'),
  Country('TR', 'Türkiye'),
  Country('TT', 'Trinidad and Tobago'),
  Country('TV', 'Tuvalu'),
  Country('TW', 'Taiwan, Province of China'),
  Country('TZ', 'Tanzania, United Republic of'),
  Country('UA', 'Ukraine'),
  Country('UG', 'Uganda'),
  Country('UM', 'United States Minor Outlying Islands'),
  Country('US', 'United States of America'),
  Country('UY', 'Uruguay'),
  Country('UZ', 'Uzbekistan'),
  Country('VA', 'Holy See'),
  Country('VC', 'Saint Vincent and the Grenadines'),
  Country('VE', 'Venezuela (Bolivarian Republic of)'),
  Country('VG', 'Virgin Islands (British)'),
  Country('VI', 'Virgin Islands (U.S.)'),
  Country('VN', 'Viet Nam'),
  Country('VU', 'Vanuatu'),
  Country('WF', 'Wallis and Futuna'),
  Country('WS', 'Samoa'),
  Country('YE', 'Yemen'),
  Country('YT', 'Mayotte'),
  Country('ZA', 'South Africa'),
  Country('ZM', 'Zambia'),
  Country('ZW', 'Zimbabwe')
];
