package Number::Phone::Country;

use strict;

# *_codes are global so we can mock in some tests
use vars qw($VERSION %idd_codes %prefix_codes);
$VERSION = 1.6002;
my $use_uk = 0;

sub import {
    shift;
    my $export = 1;
    foreach my $param (@_) {
        if(lc($param) eq 'noexport') { $export = 0; }
         elsif(lc($param) eq 'uk') { $use_uk = 1; }
    }
    if($export) {
        my $callpkg = caller(1);
        no strict 'refs';
        *{"$callpkg\::phone2country"} = \&{__PACKAGE__."\::phone2country"};
    }
}

%idd_codes = (
    # 1     => 'NANP',

    # 2* checked against wtng.info 2011-07-08
    20      => 'EG', 212     => 'MA',
    2125288 => 'EH', # \ from http://en.wikipedia.org/wiki/List_of_country_calling_codes#At_a_glance
    2125289 => 'EH', # /
    213     => 'DZ', 216     => 'TN',
    218     => 'LY', 220     => 'GM', 221     => 'SN', 222     => 'MR',
    223     => 'ML',
    224     => 'GN',
    225     => 'CI', 226     => 'BF', 227     => 'NE', 228     => 'TG',
    229     => 'BJ', 230     => 'MU', 231     => 'LR', 232     => 'SL',
    233     => 'GH', 234     => 'NG', 235     => 'TD', 236     => 'CF',
    237     => 'CM', 238     => 'CV',
    239     => 'ST', 240     => 'GQ', 241     => 'GA',
    242     => 'CG', 243     => 'CD', 244     => 'AO', 245     => 'GW',
    246     => 'IO', 247     => 'AC', 248     => 'SC', 249     => 'SD',
    250     => 'RW', 251     => 'ET', 252     => 'SO', 253     => 'DJ',
    254     => 'KE', 255     => 'TZ', 256     => 'UG', 257     => 'BI',
    258     => 'MZ', 260     => 'ZM', 261     => 'MG',
    262269  => 'YT', # Mayotte fixed lines
    262639  => 'YT', # Mayotte GSM
    262     => 'RE', # Assume that Reunion is everything else in +262
    263     => 'ZW',
    264     => 'NA', 265     => 'MW', 266     => 'LS', 267     => 'BW',
    268     => 'SZ',
    269     => 'KM',
    27      => 'ZA', 290     => 'SH',
    291     => 'ER',
    297     => 'AW', 298     => 'FO', 299     => 'GL',
    
    # 3* checked against wtng.info 2011-07-08
    30      => 'GR', 31      => 'NL', 32      => 'BE', 33      => 'FR',
    34      => 'ES', 350     => 'GI', 351     => 'PT',
    352     => 'LU', 353     => 'IE', 35348   => 'GB', 354     => 'IS',
    355     => 'AL', 356     => 'MT', 357     => 'CY', 358     => 'FI',
    359     => 'BG', 36      => 'HU', 370     => 'LT', 371     => 'LV',
    372     => 'EE', 373     => 'MD', 374     => 'AM', 375     => 'BY',
    376     => 'AD', 377     => 'MC',
    37744   => 'KOS', # from http://en.wikipedia.org/wiki/List_of_country_calling_codes#At_a_glance
    37745   => 'KOS',
    38128   => 'KOS',
    38129   => 'KOS',
    38138   => 'KOS',
    38139   => 'KOS',
    38643   => 'KOS',
    38649   => 'KOS',
    378     => 'SM', 379     => 'VA',
    380     => 'UA', 381     => 'RS',
    382     => 'ME', 385     => 'HR',
    386     => 'SI',
    387     => 'BA',
    389     => 'MK', 39      => 'IT', 3966982 => 'VA',

    # 4* checked against wtng.info 2011-07-08
    40      => 'RO', 41      => 'CH', 420     => 'CZ', 421     => 'SK',
    423     => 'LI',
    43      => 'AT', 44      => 'GB',
    45      => 'DK', 46      => 'SE',
    47      => 'NO', 48      => 'PL', 49      => 'DE',
    
    # 5* checked against wtng.info 2011-07-08
    500     => 'FK',
    501     => 'BZ', 502     => 'GT', 503     => 'SV', 504     => 'HN',
    505     => 'NI', 506     => 'CR', 507     => 'PA',
    508     => 'PM', 509     => 'HT',
    51      => 'PE', 52      => 'MX', 53      => 'CU', 54      => 'AR',
    55      => 'BR', 56      => 'CL', 57      => 'CO', 58      => 'VE',
    590     => 'GP', 591     => 'BO', 592     => 'GY', 593     => 'EC',
    594     => 'GF', 595     => 'PY', 596     => 'MQ', 597     => 'SR',
    598     => 'UY',
    599     => 'BQ',
    5995    => 'SX', # will move to +1 721 in Sep 2011
    5999    => 'CW',
    
    # 6* checked against wtng.info 2011-07-08
    60      => 'MY',
    61      => 'AU',
    6189162 => 'CC', # Cocos (Keeling) Islands
    6189164 => 'CX', # Christmas Island
    62      => 'ID', 63      => 'PH',
    64      => 'NZ', 65      => 'SG', 66      => 'TH', 670     => 'TL',
    67210   => 'AQ', # Davis station    \
    67211   => 'AQ', # Mawson           | Australian Antarctic bases
    67212   => 'AQ', # Casey            |
    67213   => 'AQ', # Macquarie Island /
    6723    => 'NF', # Norfolk Island
    673     => 'BN', 674     => 'NR', 675     => 'PG', 676     => 'TO',
    677     => 'SB', 678     => 'VU', 679     => 'FJ', 680     => 'PW',
    681     => 'WF', 682     => 'CK',
    683     => 'NU', 685     => 'WS', 686     => 'KI', 687     => 'NC',
    688     => 'TV',
    689     => 'PF', 690     => 'TK', 691     => 'FM', 692     => 'MH',
    
    # 7* from http://en.wikipedia.org/wiki/Telephone_numbers_in_Kazakhstan
    # checked 2011-07-08
    76      => 'KZ',
    77      => 'KZ',
    7       => 'RU',
    
    # 8* checked against wtng.info 2011-07-08
    81      => 'JP', 82      => 'KR', 84      => 'VN', 850     => 'KP',
    852     => 'HK', 853     => 'MO', 855     => 'KH', 856     => 'LA',
    86      => 'CN',
    880     => 'BD',
    886     => 'TW',
    
    # 9* checked against wtng.info 2011-07-08
    90      => 'TR', 91      => 'IN', 92      => 'PK', 93      => 'AF',
    94      => 'LK', 95      => 'MM', 960     => 'MV', 961     => 'LB',
    962     => 'JO', 963     => 'SY', 964     => 'IQ', 965     => 'KW',
    966     => 'SA', 967     => 'YE', 968     => 'OM', 970     => 'PS',
    971     => 'AE',
    972     => 'IL', 973     => 'BH', 974     => 'QA', 975     => 'BT',
    976     => 'MN', 977     => 'NP',
    98      => 'IR',
    992     => 'TJ',
    993     => 'TM', 994     => 'AZ', 995     => 'GE',
    996     => 'KG', 998     => 'UZ',

    # these checked against wtng.info 2011-07-08
    800     => 'InternationalFreephone',
    808     => 'SharedCostServices',
    870     => 'Inmarsat',
    871     => 'Inmarsat',
    872     => 'Inmarsat',
    873     => 'Inmarsat',
    874     => 'Inmarsat',
    878     => 'UniversalPersonalTelecoms',
    8816    => 'Iridium',    # \ Sat-phones
    8817    => 'Iridium',    # |
    8818    => 'Globalstar', # |
    8819    => 'Globalstar', # /
    882     => 'InternationalNetworks',
    888     => 'TelecomsForDisasterRelief',
    # 979 is used for testing when we fail to load a module when we
    # know what "country" it is
    979     => 'InternationalPremiumRate',
    991     => 'ITPCS',
    # 999 deliberately NYI for testing; proposed to be like 888.
);

# Prefix Codes hash
# ISO code maps to 3 element array containing:
# - Country prefix
# - IDD prefix (for dialling from this country prefix to another)
# - NDD prefix (for dialling from one area of this country to another)
%prefix_codes = (
    'AD' => ['376',   '00',  undef], # Andorra
    'AE' => ['971',   '00',    '0'], # United Arab Emirates
    'AF' => [ '93',   '00',    '0'], # Afghanistan
    'AG' => [  '1',  '011',    '1'], # Antigua and Barbuda
    'AI' => [  '1',  '011',    '1'], # Anguilla
    'AL' => ['355',   '00',    '0'], # Albania
    'AM' => ['374',   '00',    '8'], # Armenia
    'BQ' => ['599',   '00',    '0'], # Bonaire, Saint Eustatius and Saba (ex-Netherland Antilles)
    'AO' => ['244',   '00',    '0'], # Angola
    'AQ' => ['672',  undef,  undef], # Antarctica
    'AR' => [ '54',   '00',    '0'], # Argentina
    'AS' => [  '1',  '011',    '1'], # American Samoa
    'AT' => [ '43',   '00',    '0'], # Austria
    'AU' => [ '61',   '00',  undef], # Australia
    'AW' => ['297',   '00',  undef], # Aruba
    'AZ' => ['994',   '00',    '8'], # Azerbaijan
    'BA' => ['387',   '00',    '0'], # Bosnia and Herzegovina
    'BB' => [  '1',  '011',    '1'], # Barbados
    'BD' => ['880',   '00',    '0'], # Bangladesh
    'BE' => [ '32',   '00',    '0'], # Belgium
    'BF' => ['226',   '00',  undef], # Burkina Faso
    'BG' => ['359',   '00',    '0'], # Bulgaria
    'BH' => ['973',   '00',  undef], # Bahrain
    'BI' => ['257',   '00',  undef], # Burundi
    'BJ' => ['229',   '00',  undef], # Benin
    'BM' => [  '1',  '011',    '1'], # Bermuda
    'BN' => ['673',   '00',    '0'], # Brunei Darussalam
    'BO' => ['591',   '00',    '0'], # Bolivia
    'BR' => [ '55',   '00',    '0'], # Brazil
    'BS' => [  '1',  '011',    '1'], # Bahamas
    'BT' => ['975',   '00',  undef], # Bhutan
    'BV' => [ '47',   '00',  undef], # Bouvet Island - Norway
    'BW' => ['267',   '00',  undef], # Botswana
    'BY' => ['375',  '810',    '8'], # Belarus (IDD really 8**10)
    'BZ' => ['501',   '00',    '0'], # Belize
    'CA' => [  '1',  '011',    '1'], # Canada
    'CC' => [ '61', '0011',    '0'], # Cocos (Keeling) Islands
    'CD' => ['243',   '00',  undef], # Congo (Dem. Rep. of / Zaire)
    'CF' => ['236',   '00',  undef], # Central African Republic
    'CG' => ['242',   '00',  undef], # Congo
    'CH' => [ '41',   '00',    '0'], # Switzerland
    'CI' => ['225',   '00',    '0'], # Cote D'Ivoire
    'CK' => ['682',   '00',   '00'], # Cook Islands
    'CL' => [ '56',   '00',    '0'], # Chile
    'CM' => ['237',   '00',  undef], # Cameroon
    'CN' => [ '86',   '00',    '0'], # China
    'CO' => [ '57',  '009',   '09'], # Colombia
    'CR' => ['506',   '00',  undef], # Costa Rica
    'CU' => [ '53',  '119',    '0'], # Cuba
    'CV' => ['238',    '0',  undef], # Cape Verde Islands
    'CX' => [ '61', '0011',    '0'], # Christmas Island
    'CY' => ['357',   '00',  undef], # Cyprus
    'CZ' => ['420',   '00',  undef], # Czech Republic
    'DE' => [ '49',   '00',    '0'], # Germany
    'DJ' => ['253',   '00',  undef], # Djibouti
    'DK' => [ '45',   '00',  undef], # Denmark
    'DM' => [  '1',  '011',      1], # Dominica
    'DO' => [  '1',  '011',      1], # Dominican Republic
    'DZ' => ['213',   '00',    '7'], # Algeria
    'EC' => ['593',   '00',    '0'], # Ecuador
    'EE' => ['372',   '00',  undef], # Estonia
    'EG' => [ '20',   '00',    '0'], # Egypt
    'EH' => ['212',   '00',    '0'], # Western Sahara
    'ER' => ['291',   '00',    '0'], # Eritrea
    'ES' => [ '34',   '00',  undef], # Spain
    'ET' => ['251',   '00',    '0'], # Ethiopia
    'FI' => ['358',   '00',    '0'], # Finland
    'FJ' => ['679',   '00',  undef], # Fiji
    'FK' => ['500',   '00',  undef], # Falkland Islands (Malvinas)
    'FM' => ['691',  '011',    '1'], # Micronesia, Federated States of
    'FO' => ['298',   '00',  undef], # Faroe Islands
    'FR' => [ '33',   '00',  undef], # France
    'GA' => ['241',   '00',  undef], # Gabonese Republic
    'GB' => [ '44',   '00',    '0'], # United Kingdom
    'GD' => [  '1',  '011',    '4'], # Grenada
    'GE' => ['995',  '810',    '8'], # Georgia
    'GF' => ['594',   '00',  undef], # French Guiana
    'GH' => ['233',   '00',  undef], # Ghana
    'GI' => ['350',   '00',  undef], # Gibraltar
    'GL' => ['299',   '00',  undef], # Greenland
    'GM' => ['220',   '00',  undef], # Gambia
    'GN' => ['224',   '00',    '0'], # Guinea
    'GP' => ['590',   '00',  undef], # Guadeloupe
    'GQ' => ['240',   '00',  undef], # Equatorial Guinea
    'GR' => [ '30',   '00',  undef], # Greece
    'GS' => ['995',  '810',    '8'], # South Georgia and the South Sandwich Islands (IDD really 8**10)
    'GT' => ['502',   '00',  undef], # Guatemala
    'GU' => [  '1',  '011',    '1'], # Guam
    'GW' => ['245',   '00',  undef], # Guinea-Bissau
    'GY' => ['592',  '001',    '0'], # Guyana
    'HK' => ['852',  '001',  undef], # Hong Kong
    'HM' => ['692',   '00',    '0'], # Heard Island & McDonald Islands
    'HN' => ['504',   '00',    '0'], # Honduras
    'HR' => ['385',   '00',    '0'], # Croatia
    'HT' => ['509',   '00',    '0'], # Haiti
    'HU' => [ '36',   '00',   '06'], # Hungary
    'ID' => [ '62',  '001',    '0'], # Indonesia
    'IE' => ['353',   '00',    '0'], # Ireland
    'IL' => ['972',   '00',    '0'], # Israel
    'IN' => [ '91',   '00',    '0'], # India
    'IO' => ['246',   '00',  undef], # British Indian Ocean Territory
    'IQ' => ['964',   '00',    '0'], # Iraq
    'IR' => [ '98',   '00',    '0'], # Iran, Islamic Republic of
    'IS' => ['354',   '00',    '0'], # Iceland
    'IT' => [ '39',   '00',  undef], # Italy
    'JM' => [  '1',  '011',    '1'], # Jamaica
    'JO' => ['962',   '00',    '0'], # Jordan
    'JP' => [ '81',  '001',    '0'], # Japan
    'KE' => ['254',  '000',    '0'], # Kenya
    'KG' => ['996',   '00',    '0'], # Kyrgyzstan
    'KH' => ['855',  '001',    '0'], # Cambodia
    'KI' => ['686',   '00',    '0'], # Kiribati
    'KM' => ['269',   '00',  undef], # Comoros
    'KN' => [  '1',  '011',    '1'], # Saint Kitts and Nevis
    'KP' => ['850',   '00',    '0'], # Korea, Democratic People's Republic of
    'KR' => [ '82',  '001',    '0'], # Korea (South)
    'KW' => ['965',   '00',    '0'], # Kuwait
    'KY' => [  '1',  '011',    '1'], # Cayman Islands
    'KZ' => [  '7',  '810',    '8'], # Kazakhstan (IDD really 8[pause]10)
    'LA' => ['856',   '00',    '0'], # Laos
    'LB' => ['961',   '00',    '0'], # Lebanon
    'LC' => [  '1',  '011',    '1'], # Saint Lucia
    'LI' => ['423',   '00',  undef], # Liechtenstein
    'LK' => [ '94',   '00',    '0'], # Sri Lanka
    'LR' => ['231',   '00',   '22'], # Liberia
    'LS' => ['266',   '00',    '0'], # Lesotho
    'LT' => ['370',   '00',    '8'], # Lithuania
    'LU' => ['352',   '00',  undef], # Luxembourg
    'LV' => ['371',   '00',    '8'], # Latvia
    'LY' => ['218',   '00',    '0'], # Libyan Arab Jamahiriya
    'MA' => ['212',   '00',  undef], # Morocco
    'MC' => ['377',   '00',    '0'], # Monaco
    'MD' => ['373',   '00',    '0'], # Moldova, Republic of
    'ME' => ['382',   '99',    '0'], # Montenegro
    'MG' => ['261',   '00',    '0'], # Madagascar
    'MH' => ['692',  '011',    '1'], # Marshall Islands
    'MK' => ['389',   '00',    '0'], # Macedonia, the Former Yugoslav Republic of
    'ML' => ['223',   '00',    '0'], # Mali
    'MM' => [ '95',   '00',  undef], # Myanmar
    'MN' => ['976',  '001',    '0'], # Mongolia
    'MO' => ['853',   '00',    '0'], # Macao
    'MP' => [  '1',  '011',    '1'], # Northern Mariana Islands
    'MQ' => ['596',   '00',    '0'], # Martinique
    'MR' => ['222',   '00',    '0'], # Mauritania
    'MS' => [  '1',  '011',    '1'], # Montserrat
    'MT' => ['356',   '00',   '21'], # Malta
    'MU' => ['230',   '00',    '0'], # Mauritius
    'MV' => ['960',   '00',    '0'], # Maldives
    'MW' => ['265',   '00',  undef], # Malawi
    'MX' => [ '52',   '00',   '01'], # Mexico
    'MY' => [ '60',   '00',    '0'], # Malaysia
    'MZ' => ['258',   '00',    '0'], # Mozambique
    'NA' => ['264',   '00',    '0'], # Namibia
    'NC' => ['687',   '00',    '0'], # New Caledonia
    'NE' => ['227',   '00',    '0'], # Niger
    'NF' => ['672',   '00',  undef], # Norfolk Island
    'NG' => ['234',  '009',    '0'], # Nigeria
    'NI' => ['505',   '00',    '0'], # Nicaragua
    'NL' => [ '31',   '00',    '0'], # Netherlands
    'NO' => [ '47',   '00',  undef], # Norway
    'NP' => ['977',   '00',    '0'], # Nepal
    'NR' => ['674',   '00',    '0'], # Nauru
    'NU' => ['683',   '00',    '0'], # Niue
    'NZ' => [ '64',   '00',    '0'], # New Zealand
    'OM' => ['968',   '00',    '0'], # Oman
    'PA' => ['507',   '00',    '0'], # Panama
    'PE' => [ '51',   '00',    '0'], # Peru
    'PF' => ['689',   '00',  undef], # French Polynesia
    'PG' => ['675',   '05',  undef], # Papua New Guinea
    'PH' => [ '63',   '00',    '0'], # Philippines
    'PK' => [ '92',   '00',    '0'], # Pakistan
    'PL' => [ '48',   '00',    '0'], # Poland
    'PM' => ['508',   '00',    '0'], # Saint Pierre and Miquelon
    'PN' => ['872', undef,   undef], # Pitcairn
    'PR' => [  '1',  '011',    '1'], # Puerto Rico
    'PS' => ['970',   '00',    '0'], # Palestinian Territory, Occupied
    'PT' => ['351',   '00',  undef], # Portugal
    'PW' => ['680',  '011',  undef], # Palau
    'PY' => ['595',  '002',    '0'], # Paraguay
    'QA' => ['974',   '00',    '0'], # Qatar
    'RE' => ['262',   '00',    '0'], # Reunion
    'RO' => [ '40',   '00',    '0'], # Romania
    'RS' => ['381',   '99',    '0'], # Serbia
    'RU' => [  '7',  '810',    '8'], # Russia 8**10 NOTE: may change to 00, 0
    'RW' => ['250',   '00',    '0'], # Rwanda
    'SA' => ['966',   '00',    '0'], # Saudi Arabia
    'SB' => ['677',   '00',  undef], # Solomon Islands
    'SC' => ['248',   '00',    '0'], # Seychelles
    'SD' => ['249',   '00',    '0'], # Sudan
    'SE' => [ '46',   '00',    '0'], # Sweden
    'SG' => [ '65',  '001',  undef], # Singapore
    'SH' => ['290',   '00',  undef], # Saint Helena
    'SI' => ['386',   '00',    '0'], # Slovenia
    'SJ' => ['378',   '00',    '0'], # Svalbard and Jan Mayen
    'SK' => ['421',   '00',    '0'], # Slovakia
    'SL' => ['232',   '00',    '0'], # Sierra Leone
    'SM' => ['378',   '00',    '0'], # San Marino
    'SN' => ['221',   '00',    '0'], # Senegal
    'SO' => ['252',   '00',  undef], # Somalia
    'SR' => ['597',   '00',  undef], # Suriname
    'ST' => ['239',   '00',    '0'], # Sao Tome and Principe
    'SV' => ['503',   '00',  undef], # El Salvador
    'SY' => ['963',   '00',    '0'], # Syria
    'SZ' => ['268',   '00',  undef], # Swaziland
    'TC' => [  '1',  '011',    '1'], # Turks and Caicos Islands
    'TD' => ['235',   '15',  undef], # Chad
    'TF' => ['596',   '00',    '0'], # French Southern Territories
    'TG' => ['228',   '00',  undef], # Togo
    'TH' => [ '66',  '001',    '0'], # Thailand
    'TJ' => ['992',  '810',    '8'], # Tajikistan (IDD really 8**10)
    'TK' => ['690',   '00',  undef], # Tokelau
    'TL' => ['670',   '00',  undef], # Timor-Leste
    'TM' => ['993',  '810',    '8'], # Turkmenistan (IDD really 8**10)
    'TN' => ['216',   '00',    '0'], # Tunisia
    'TO' => ['676',   '00',  undef], # Tonga Islands
    'TR' => [ '90',   '00',    '0'], # Turkey
    'TT' => [  '1',  '011',    '1'], # Trinidad and Tobago
    'TV' => ['688',   '00',  undef], # Tuvalu
    'TW' => ['886',  '002',  undef], # Taiwan, Province of China
    'TZ' => ['255',  '000',    '0'], # Tanzania, United Republic of
    'UA' => ['380',  '810',    '8'], # Ukraine (IDD really 8**10)
    'UG' => ['256',  '000',    '0'], # Uganda
    'US' => [  '1',  '011',    '1'], # United States
    'UY' => ['598',   '00',    '0'], # Uruguay
    'UZ' => ['998',  '810',    '8'], # Uzbekistan (IDD really 8**10)
    'VA' => ['379',   '00',  undef], # Holy See (Vatican City State)
    'VC' => [  '1',  '011',    '1'], # Saint Vincent and the Grenadines
    'VE' => [ '58',   '00',    '0'], # Venezuela
    'VG' => [  '1',  '011',    '1'], # Virgin Islands, British
    'VI' => [  '1',  '011',    '1'], # Virgin Islands, U.S.
    'VN' => [ '84',   '00',    '0'], # Viet Nam
    'VU' => ['678',   '00',  undef], # Vanuatu
    'WF' => ['681',   '19',  undef], # Wallis and Futuna Islands
    'WS' => ['685',    '0',    '0'], # Samoa (Western)
    'YE' => ['967',   '00',    '0'], # Yemen
    'YT' => ['262',   '00',  undef], # Mayotte
    'ZA' => [ '27',   '09',    '0'], # South Africa
    'ZM' => ['260',   '00',    '0'], # Zambia
    'ZW' => ['263',  '110',    '0'], # Zimbabwe
);
$prefix_codes{UK} = $prefix_codes{GB};

sub phone2country {
    my ($phone) = @_;
    return (phone2country_and_idd($phone))[0];
}

sub phone2country_and_idd {
    my ($phone) = @_;
    $phone =~ s/[^\+?\d+]//g;
    $phone = '+1'.$phone unless(substr($phone, 0, 1) =~ /[1+]/);
    $phone =~ s/\D//g;

    # deal with NANP insanity

    if($phone =~ m!^1(\d{3})\d{7}$!) {

        # see http://www.cnac.ca/co_codes/co_code_status_map.htm
	# checked 2011-07-08
        if($1 =~ m!^(
	    204|
	    226|
	    249|
	    250|
	    289|
	    306|
	    343|
	    365|
	    403|
	    416|
	    418|
	    431|
	    438|
	    450|
	    506|
	    514|
	    519|
	    579|
	    581|
	    587|
	    604|
	    613|
	    647|
	    705|
	    709|
	    778|
	    780|
	    807|
	    819|
	    867|
	    873|
	    902|
	    905
        )$!x) {
            return ('CA', 1);
        }
        # see http://www.nanpa.com/number_resource_info/area_code_maps.html
        elsif($1 =~ m!^(
          205|251|256|334|659|938|
          907|250|
          480|520|602|623|928|
          327|479|501|870|
          209|213|310|323|341|369|408|415|424|442|510|530|559|562|619|626|627|628|650|657|661|669|707|714|747|760|764|805|818|831|858|909|916|925|935|949|951|
          303|719|720|970|
          203|475|860|959|
          302|
          202|
          239|305|321|352|386|407|561|689|727|754|772|786|813|850|863|904|941|954|
          229|404|470|478|678|706|762|770|912|
          808|
          208|
          217|224|309|312|331|447|464|618|630|708|730|773|779|815|847|872|
          219|260|317|574|765|812|
          319|515|563|641|712|
          316|620|785|913|
          270|364|502|606|859|
          225|318|337|504|985|
          207|
          227|240|301|410|443|667|
          339|351|413|508|617|774|781|857|978|
          231|248|269|313|517|586|616|679|734|810|906|947|989|
          218|320|507|612|651|763|952|
          228|601|662|769|
          314|417|557|573|636|660|816|975|
          406|
          308|402|531|
          702|775|
          603|
          201|551|609|732|848|856|862|908|973|
          505|575|
          212|315|347|516|518|585|607|631|646|716|718|845|914|917|929|
          252|336|704|828|910|919|980|984|
          701|
          216|234|283|330|380|419|440|513|567|614|740|937|
          405|539|580|918|
          458|503|541|971|
          215|267|272|412|445|484|570|582|610|717|724|814|835|878|
          401|
          803|843|864|
          605|
          423|615|731|865|901|931|
          210|214|254|281|325|361|409|430|432|469|512|682|713|737|806|817|830|832|903|915|936|940|956|972|979|
          385|435|801|
          802|
          276|434|540|571|703|757|804|
          206|253|360|425|509|564|
          304|681|
          262|274|414|534|608|715|920|
          307
        )$!x) {
            return ('US', 1);
        }

        # see http://wtng.info/wtng-cod.html#WZ1
	# checked 2011-07-08
        elsif($1 eq '242') { return ('BS', 1); }
        elsif($1 eq '246') { return ('BB', 1); }
        elsif($1 eq '264') { return ('AI', 1); }
        elsif($1 eq '268') { return ('AG', 1); }
        elsif($1 eq '284') { return ('VG', 1); }
        elsif($1 eq '340') { return ('VI', 1); }
        elsif($1 eq '345') { return ('KY', 1); }
        elsif($1 eq '441') { return ('BM', 1); }
        elsif($1 eq '473') { return ('GD', 1); }
        elsif($1 eq '649') { return ('TC', 1); }
        elsif($1 eq '664') { return ('MS', 1); }
        elsif($1 eq '670') { return ('MP', 1); }
        elsif($1 eq '671') { return ('GU', 1); }
        elsif($1 eq '684') { return ('AS', 1); }
        elsif($1 eq '758') { return ('LC', 1); }
        elsif($1 eq '767') { return ('DM', 1); }
        elsif($1 eq '784') { return ('VC', 1); }
        elsif($1 eq '787') { return ('PR', 1); }
        elsif($1 eq '809') { return ('DO', 1); }
        elsif($1 eq '829') { return ('DO', 1); } # overlay
        elsif($1 eq '849') { return ('DO', 1); } # overlay
        elsif($1 eq '868') { return ('TT', 1); }
        elsif($1 eq '869') { return ('KN', 1); }
        elsif($1 eq '876') { return ('JM', 1); }
        elsif($1 eq '939') { return ('PR', 1); } # overlay

        else { return ('NANP', 1); }
    }

    else {
        my @retards = map { substr($phone, 0, $_) } reverse 1..length($phone);
        foreach my $idd (@retards) {
            if(exists $idd_codes{$idd}) {
                my $country = $idd_codes{$idd};
                if($country eq 'GB' && $use_uk) { $country = 'UK'; }
                return ($country, $idd);
            }
        }
    }
    return;
}

sub country_code {
    my $country = uc shift;

    my $data = $prefix_codes{$country} or return;

    return $$data[0];
}

sub idd_code {
    my $country = uc shift;

    my $data = $prefix_codes{$country} or return;

    return $$data[1];
}

sub ndd_code {
    my $country = uc shift;

    my $data = $prefix_codes{$country} or return;

    return $$data[2];
}

1;

=head1 NAME

Number::Phone::Country - Lookup country of phone number

=head1 SYNOPSIS

  use Number::Phone::Country;

  #returns 'CA' for Canada
  my $iso_country_code = phone2country("1 (604) 111-1111");

or

  use Number::Phone::Country qw(noexport uk);

  my $iso_country_code = Number::Phone::Country::phone2country(...);

or

  my ($iso_country_code, $idd) = Number::Phone::Country::phone2country_and_idd(...);

=head1 DESCRIPTION

This module looks up up the country based on a telephone number.
It uses the International Direct Dialing (IDD) prefix, and
lookups North American numbers using the Area Code, in accordance
with the North America Numbering Plan (NANP).  It can also, given a
country, tell you the country code, and the prefixes you need to dial
when in that country to call outside your local area or to call another
country.

Note that by default, phone2country is exported into your namespace.  This
is deprecated and may be removed in a future version.  You can turn that
off by passing the 'noexport' constant when you use the module.

Also be aware that the ISO code for the United Kingdom is GB, not UK.  If
you would prefer UK, pass the 'uk' constant.

I have put in number ranges for Kosovo, which does not yet have an ISO
country code.  I have used KOS, as that is used by the UN Development
Programme.  This may change in the future.

=head1 FUNCTIONS

The following functions are available:

=over 4

=item country_code($country)

Returns the international dialing prefix for this country - eg, for the UK
it returns 44, and for Canada it returns 1.

=item idd_code($country)

Returns the International Direct Dialing prefix for the given country.
This is the prefix needed to make a call B<from a country> to another
country.  This is followed by the country code for the country you are
calling.  For example, when calling another country from the US, you must
dial 011.

=item ndd_code($country)

Returns the National Direct Dialing prefix for the given country.  This is
the prefix used to make a call B<within a country> from one city to
another.  This prefix may not be necessary when calling another city in the
same vicinity.  This is followed by the city or area code for the place you
are calling.  For example, in the US, the NDD prefix is "1", so you must
dial 1 before the area code to place a long distance call within the
country.

=item phone2country($phone)

Returns the ISO country code (or KOS for Kosovo) for a phone number.
eg, for +441234567890 it returns 'GB' (or 'UK' if you've told it to).

=item phone2country_and_idd($phone)

Returns a list containing the ISO country code and IDD prefix for the given
phone number.  eg for +441234567890 it returns ('GB', 44).

=back

=head1 SEE ALSO

L<Parse::PhoneNumber>

=head1 BUGS

It has not been possible to maintain complete backwards compatibility with
the original 0.01 release.  To fix a
bug, while still retaining the ability to look up plain un-adorned NANP
numbers without the +1 prefix, all non-NANP numbers *must* have their
leading + sign.

Another incompatibility - it was previously assumed that any number not
assigned to some other country was in the US.  This was incorrect for (eg)
800 numbers.  These are now identified as being generic NANP numbers.

Will go out of date every time the NANP has one of its code splits/overlays.
So that's about once a month then.  I'll do my best to keep it up to date.

=head1 WARNING

The Yugoslavs keep changing their minds about what country they want to be
and what their ISO 3166 code and IDD prefix should be.  YU? CS? RS? ME?
God knows.  And then there's Kosovo ...

=head1 AUTHOR

now maintained by David Cantrell E<lt>david@cantrell.org.ukE<gt>

originally by TJ Mather, E<lt>tjmather@maxmind.comE<gt>

country/IDD/NDD contributions by Michael Schout, E<lt>mschout@gkg.netE<gt>

Thanks to Shraga Bor-Sood for the updates in version 1.4.

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by MaxMind LLC

Copyright 2004 - 2007 David Cantrell

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
