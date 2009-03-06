      *************************************************************************
      * 
      * Source File Name: SQL1252A
      * 
      * (C) COPYRIGHT International Business Machines Corp. 1996,1997
      * All Rights Reserved
      * Licensed Materials - Property of IBM
      * 
      * US Government Users Restricted Rights - Use, duplication or
      * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
      * 
      * Function = Include File defining:
      *               Collating Sequence
      *                 Source: CODE PAGE 1252 (Windows Latin/1)
      *                 Target: CCSID 500 (EBCDIC International)
      * 
      * Operating System: Darwin
      * 
      **************************************************************************
       01 SQLE-1252-500.
          05 WEIGHT-00 PIC X VALUE X"00".
          05 WEIGHT-01 PIC X VALUE X"01".
          05 WEIGHT-02 PIC X VALUE X"02".
          05 WEIGHT-03 PIC X VALUE X"03".
          05 WEIGHT-04 PIC X VALUE X"37".
          05 WEIGHT-05 PIC X VALUE X"2D".
          05 WEIGHT-06 PIC X VALUE X"2E".
          05 WEIGHT-07 PIC X VALUE X"2F".
          05 WEIGHT-08 PIC X VALUE X"16".
          05 WEIGHT-09 PIC X VALUE X"05".
          05 WEIGHT-0A PIC X VALUE X"25".
          05 WEIGHT-0B PIC X VALUE X"0B".
          05 WEIGHT-0C PIC X VALUE X"0C".
          05 WEIGHT-0D PIC X VALUE X"0D".
          05 WEIGHT-0E PIC X VALUE X"0E".
          05 WEIGHT-0F PIC X VALUE X"0F".
          05 WEIGHT-10 PIC X VALUE X"10".
          05 WEIGHT-11 PIC X VALUE X"11".
          05 WEIGHT-12 PIC X VALUE X"12".
          05 WEIGHT-13 PIC X VALUE X"13".
          05 WEIGHT-14 PIC X VALUE X"3C".
          05 WEIGHT-15 PIC X VALUE X"3D".
          05 WEIGHT-16 PIC X VALUE X"32".
          05 WEIGHT-17 PIC X VALUE X"26".
          05 WEIGHT-18 PIC X VALUE X"18".
          05 WEIGHT-19 PIC X VALUE X"19".
          05 WEIGHT-1A PIC X VALUE X"3F".
          05 WEIGHT-1B PIC X VALUE X"27".
          05 WEIGHT-1C PIC X VALUE X"1C".
          05 WEIGHT-1D PIC X VALUE X"1D".
          05 WEIGHT-1E PIC X VALUE X"1E".
          05 WEIGHT-1F PIC X VALUE X"1F".
          05 WEIGHT-20 PIC X VALUE X"40".
          05 WEIGHT-21 PIC X VALUE X"4F".
          05 WEIGHT-22 PIC X VALUE X"7F".
          05 WEIGHT-23 PIC X VALUE X"7B".
          05 WEIGHT-24 PIC X VALUE X"5B".
          05 WEIGHT-25 PIC X VALUE X"6C".
          05 WEIGHT-26 PIC X VALUE X"50".
          05 WEIGHT-27 PIC X VALUE X"7D".
          05 WEIGHT-28 PIC X VALUE X"4D".
          05 WEIGHT-29 PIC X VALUE X"5D".
          05 WEIGHT-2A PIC X VALUE X"5C".
          05 WEIGHT-2B PIC X VALUE X"4E".
          05 WEIGHT-2C PIC X VALUE X"6B".
          05 WEIGHT-2D PIC X VALUE X"60".
          05 WEIGHT-2E PIC X VALUE X"4B".
          05 WEIGHT-2F PIC X VALUE X"61".
          05 WEIGHT-30 PIC X VALUE X"F0".
          05 WEIGHT-31 PIC X VALUE X"F1".
          05 WEIGHT-32 PIC X VALUE X"F2".
          05 WEIGHT-33 PIC X VALUE X"F3".
          05 WEIGHT-34 PIC X VALUE X"F4".
          05 WEIGHT-35 PIC X VALUE X"F5".
          05 WEIGHT-36 PIC X VALUE X"F6".
          05 WEIGHT-37 PIC X VALUE X"F7".
          05 WEIGHT-38 PIC X VALUE X"F8".
          05 WEIGHT-39 PIC X VALUE X"F9".
          05 WEIGHT-3A PIC X VALUE X"7A".
          05 WEIGHT-3B PIC X VALUE X"5E".
          05 WEIGHT-3C PIC X VALUE X"4C".
          05 WEIGHT-3D PIC X VALUE X"7E".
          05 WEIGHT-3E PIC X VALUE X"6E".
          05 WEIGHT-3F PIC X VALUE X"6F".
          05 WEIGHT-40 PIC X VALUE X"7C".
          05 WEIGHT-41 PIC X VALUE X"C1".
          05 WEIGHT-42 PIC X VALUE X"C2".
          05 WEIGHT-43 PIC X VALUE X"C3".
          05 WEIGHT-44 PIC X VALUE X"C4".
          05 WEIGHT-45 PIC X VALUE X"C5".
          05 WEIGHT-46 PIC X VALUE X"C6".
          05 WEIGHT-47 PIC X VALUE X"C7".
          05 WEIGHT-48 PIC X VALUE X"C8".
          05 WEIGHT-49 PIC X VALUE X"C9".
          05 WEIGHT-4A PIC X VALUE X"D1".
          05 WEIGHT-4B PIC X VALUE X"D2".
          05 WEIGHT-4C PIC X VALUE X"D3".
          05 WEIGHT-4D PIC X VALUE X"D4".
          05 WEIGHT-4E PIC X VALUE X"D5".
          05 WEIGHT-4F PIC X VALUE X"D6".
          05 WEIGHT-50 PIC X VALUE X"D7".
          05 WEIGHT-51 PIC X VALUE X"D8".
          05 WEIGHT-52 PIC X VALUE X"D9".
          05 WEIGHT-53 PIC X VALUE X"E2".
          05 WEIGHT-54 PIC X VALUE X"E3".
          05 WEIGHT-55 PIC X VALUE X"E4".
          05 WEIGHT-56 PIC X VALUE X"E5".
          05 WEIGHT-57 PIC X VALUE X"E6".
          05 WEIGHT-58 PIC X VALUE X"E7".
          05 WEIGHT-59 PIC X VALUE X"E8".
          05 WEIGHT-5A PIC X VALUE X"E9".
          05 WEIGHT-5B PIC X VALUE X"4A".
          05 WEIGHT-5C PIC X VALUE X"E0".
          05 WEIGHT-5D PIC X VALUE X"5A".
          05 WEIGHT-5E PIC X VALUE X"5F".
          05 WEIGHT-5F PIC X VALUE X"6D".
          05 WEIGHT-60 PIC X VALUE X"79".
          05 WEIGHT-61 PIC X VALUE X"81".
          05 WEIGHT-62 PIC X VALUE X"82".
          05 WEIGHT-63 PIC X VALUE X"83".
          05 WEIGHT-64 PIC X VALUE X"84".
          05 WEIGHT-65 PIC X VALUE X"85".
          05 WEIGHT-66 PIC X VALUE X"86".
          05 WEIGHT-67 PIC X VALUE X"87".
          05 WEIGHT-68 PIC X VALUE X"88".
          05 WEIGHT-69 PIC X VALUE X"89".
          05 WEIGHT-6A PIC X VALUE X"91".
          05 WEIGHT-6B PIC X VALUE X"92".
          05 WEIGHT-6C PIC X VALUE X"93".
          05 WEIGHT-6D PIC X VALUE X"94".
          05 WEIGHT-6E PIC X VALUE X"95".
          05 WEIGHT-6F PIC X VALUE X"96".
          05 WEIGHT-70 PIC X VALUE X"97".
          05 WEIGHT-71 PIC X VALUE X"98".
          05 WEIGHT-72 PIC X VALUE X"99".
          05 WEIGHT-73 PIC X VALUE X"A2".
          05 WEIGHT-74 PIC X VALUE X"A3".
          05 WEIGHT-75 PIC X VALUE X"A4".
          05 WEIGHT-76 PIC X VALUE X"A5".
          05 WEIGHT-77 PIC X VALUE X"A6".
          05 WEIGHT-78 PIC X VALUE X"A7".
          05 WEIGHT-79 PIC X VALUE X"A8".
          05 WEIGHT-7A PIC X VALUE X"A9".
          05 WEIGHT-7B PIC X VALUE X"C0".
          05 WEIGHT-7C PIC X VALUE X"BB".
          05 WEIGHT-7D PIC X VALUE X"D0".
          05 WEIGHT-7E PIC X VALUE X"A1".
          05 WEIGHT-7F PIC X VALUE X"07".
          05 WEIGHT-80 PIC X VALUE X"20".
          05 WEIGHT-81 PIC X VALUE X"21".
          05 WEIGHT-82 PIC X VALUE X"22".
          05 WEIGHT-83 PIC X VALUE X"23".
          05 WEIGHT-84 PIC X VALUE X"24".
          05 WEIGHT-85 PIC X VALUE X"15".
          05 WEIGHT-86 PIC X VALUE X"06".
          05 WEIGHT-87 PIC X VALUE X"17".
          05 WEIGHT-88 PIC X VALUE X"28".
          05 WEIGHT-89 PIC X VALUE X"29".
          05 WEIGHT-8A PIC X VALUE X"2A".
          05 WEIGHT-8B PIC X VALUE X"2B".
          05 WEIGHT-8C PIC X VALUE X"2C".
          05 WEIGHT-8D PIC X VALUE X"09".
          05 WEIGHT-8E PIC X VALUE X"0A".
          05 WEIGHT-8F PIC X VALUE X"1B".
          05 WEIGHT-90 PIC X VALUE X"30".
          05 WEIGHT-91 PIC X VALUE X"31".
          05 WEIGHT-92 PIC X VALUE X"1A".
          05 WEIGHT-93 PIC X VALUE X"33".
          05 WEIGHT-94 PIC X VALUE X"34".
          05 WEIGHT-95 PIC X VALUE X"35".
          05 WEIGHT-96 PIC X VALUE X"36".
          05 WEIGHT-97 PIC X VALUE X"08".
          05 WEIGHT-98 PIC X VALUE X"38".
          05 WEIGHT-99 PIC X VALUE X"39".
          05 WEIGHT-9A PIC X VALUE X"3A".
          05 WEIGHT-9B PIC X VALUE X"3B".
          05 WEIGHT-9C PIC X VALUE X"04".
          05 WEIGHT-9D PIC X VALUE X"14".
          05 WEIGHT-9E PIC X VALUE X"3E".
          05 WEIGHT-9F PIC X VALUE X"FF".
          05 WEIGHT-A0 PIC X VALUE X"41".
          05 WEIGHT-A1 PIC X VALUE X"AA".
          05 WEIGHT-A2 PIC X VALUE X"B0".
          05 WEIGHT-A3 PIC X VALUE X"B1".
          05 WEIGHT-A4 PIC X VALUE X"9F".
          05 WEIGHT-A5 PIC X VALUE X"B2".
          05 WEIGHT-A6 PIC X VALUE X"6A".
          05 WEIGHT-A7 PIC X VALUE X"B5".
          05 WEIGHT-A8 PIC X VALUE X"BD".
          05 WEIGHT-A9 PIC X VALUE X"B4".
          05 WEIGHT-AA PIC X VALUE X"9A".
          05 WEIGHT-AB PIC X VALUE X"8A".
          05 WEIGHT-AC PIC X VALUE X"BA".
          05 WEIGHT-AD PIC X VALUE X"CA".
          05 WEIGHT-AE PIC X VALUE X"AF".
          05 WEIGHT-AF PIC X VALUE X"BC".
          05 WEIGHT-B0 PIC X VALUE X"90".
          05 WEIGHT-B1 PIC X VALUE X"8F".
          05 WEIGHT-B2 PIC X VALUE X"EA".
          05 WEIGHT-B3 PIC X VALUE X"FA".
          05 WEIGHT-B4 PIC X VALUE X"BE".
          05 WEIGHT-B5 PIC X VALUE X"A0".
          05 WEIGHT-B6 PIC X VALUE X"B6".
          05 WEIGHT-B7 PIC X VALUE X"B3".
          05 WEIGHT-B8 PIC X VALUE X"9D".
          05 WEIGHT-B9 PIC X VALUE X"DA".
          05 WEIGHT-BA PIC X VALUE X"9B".
          05 WEIGHT-BB PIC X VALUE X"8B".
          05 WEIGHT-BC PIC X VALUE X"B7".
          05 WEIGHT-BD PIC X VALUE X"B8".
          05 WEIGHT-BE PIC X VALUE X"B9".
          05 WEIGHT-BF PIC X VALUE X"AB".
          05 WEIGHT-C0 PIC X VALUE X"64".
          05 WEIGHT-C1 PIC X VALUE X"65".
          05 WEIGHT-C2 PIC X VALUE X"62".
          05 WEIGHT-C3 PIC X VALUE X"66".
          05 WEIGHT-C4 PIC X VALUE X"63".
          05 WEIGHT-C5 PIC X VALUE X"67".
          05 WEIGHT-C6 PIC X VALUE X"9E".
          05 WEIGHT-C7 PIC X VALUE X"68".
          05 WEIGHT-C8 PIC X VALUE X"74".
          05 WEIGHT-C9 PIC X VALUE X"71".
          05 WEIGHT-CA PIC X VALUE X"72".
          05 WEIGHT-CB PIC X VALUE X"73".
          05 WEIGHT-CC PIC X VALUE X"78".
          05 WEIGHT-CD PIC X VALUE X"75".
          05 WEIGHT-CE PIC X VALUE X"76".
          05 WEIGHT-CF PIC X VALUE X"77".
          05 WEIGHT-D0 PIC X VALUE X"AC".
          05 WEIGHT-D1 PIC X VALUE X"69".
          05 WEIGHT-D2 PIC X VALUE X"ED".
          05 WEIGHT-D3 PIC X VALUE X"EE".
          05 WEIGHT-D4 PIC X VALUE X"EB".
          05 WEIGHT-D5 PIC X VALUE X"EF".
          05 WEIGHT-D6 PIC X VALUE X"EC".
          05 WEIGHT-D7 PIC X VALUE X"BF".
          05 WEIGHT-D8 PIC X VALUE X"80".
          05 WEIGHT-D9 PIC X VALUE X"FD".
          05 WEIGHT-DA PIC X VALUE X"FE".
          05 WEIGHT-DB PIC X VALUE X"FB".
          05 WEIGHT-DC PIC X VALUE X"FC".
          05 WEIGHT-DD PIC X VALUE X"AD".
          05 WEIGHT-DE PIC X VALUE X"AE".
          05 WEIGHT-DF PIC X VALUE X"59".
          05 WEIGHT-E0 PIC X VALUE X"44".
          05 WEIGHT-E1 PIC X VALUE X"45".
          05 WEIGHT-E2 PIC X VALUE X"42".
          05 WEIGHT-E3 PIC X VALUE X"46".
          05 WEIGHT-E4 PIC X VALUE X"43".
          05 WEIGHT-E5 PIC X VALUE X"47".
          05 WEIGHT-E6 PIC X VALUE X"9C".
          05 WEIGHT-E7 PIC X VALUE X"48".
          05 WEIGHT-E8 PIC X VALUE X"54".
          05 WEIGHT-E9 PIC X VALUE X"51".
          05 WEIGHT-EA PIC X VALUE X"52".
          05 WEIGHT-EB PIC X VALUE X"53".
          05 WEIGHT-EC PIC X VALUE X"58".
          05 WEIGHT-ED PIC X VALUE X"55".
          05 WEIGHT-EE PIC X VALUE X"56".
          05 WEIGHT-EF PIC X VALUE X"57".
          05 WEIGHT-F0 PIC X VALUE X"8C".
          05 WEIGHT-F1 PIC X VALUE X"49".
          05 WEIGHT-F2 PIC X VALUE X"CD".
          05 WEIGHT-F3 PIC X VALUE X"CE".
          05 WEIGHT-F4 PIC X VALUE X"CB".
          05 WEIGHT-F5 PIC X VALUE X"CF".
          05 WEIGHT-F6 PIC X VALUE X"CC".
          05 WEIGHT-F7 PIC X VALUE X"E1".
          05 WEIGHT-F8 PIC X VALUE X"70".
          05 WEIGHT-F9 PIC X VALUE X"DD".
          05 WEIGHT-FA PIC X VALUE X"DE".
          05 WEIGHT-FB PIC X VALUE X"DB".
          05 WEIGHT-FC PIC X VALUE X"DC".
          05 WEIGHT-FD PIC X VALUE X"8D".
          05 WEIGHT-FE PIC X VALUE X"8E".
          05 WEIGHT-FF PIC X VALUE X"DF".
