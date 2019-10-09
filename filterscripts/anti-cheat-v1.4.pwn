/*

       @                     @@      @@    @@  @@ @@             @@@@@@@  @@                                     @@    @@            @@     @@@         @@
      @@@               @@           @@    @@     @@             @@                   @@                                @@          @@     @@@@         @@
     @   @    @@@@@@@ @@@@@@ @@      @@    @@  @@ @@   @@@@@     @@@@     @@  @@@@@ @@@@@@  @@@@@   @@@@@@@@@@@  @@      @@        @@     @@ @@         @@
    @@   @@   @@   @@   @@   @@      @@@@@@@@  @@ @@  @@   @@       @@@@  @@  @@      @@   @@   @@  @@   @@  @@  @@       @@      @@         @@         @@   @@
   @@@@@@@@   @@   @@   @@   @@      @@    @@  @@ @@  @@@@@@@          @@ @@  @@@@    @@   @@@@@@@  @@   @@  @@  @@        @@    @@          @@  @@@@@@ @@@@@@@@@@
  @        @  @@   @@   @@   @@      @@    @@  @@ @@  @@               @@ @@     @@   @@   @@       @@   @@  @@  @@         @@  @@           @@  @@@@@@      @@
 @          @ @@   @@   @@   @@      @@    @@  @@ @@  @@@@@@      @@@@@@  @@  @@@@@   @@   @@@@@@   @@   @@  @@  @@          @@@             @@  @@@@@@      @@


 Anti Hile Sistemi v1.4 Yapýmcý:

 Anti Cheat System v1.4 Credits:

 - Max_Andolini
 - Furkan1103 ( Bug Çözümlemelerinde, Dini ve MySQL'da Yardýmcý Oldu. )

 Anti Hile Sistemi v1.4 Yapým Süresi:

 Anti Cheat System v1.4 Finished Time:

 Baþlangýç/Start:        -     Bitiþ/Finish:

 23 Þubat/February 2014  -     8 Mart/March 2014

 Sistemler/Systems:      -     Sahipleri/Owners:

 Anti Crasher            -     Forum-Samp.com
 Anti Con                -     Gtaturk.com
 Anti Ping               -     Max_Andolini
 Anti Silah              -     Forum-Samp.com
 Anti Jetpack            -     Forum-Samp.com
 Anti Bot                -     Gtaturk.com
 Anti Drive By           -     Forum-Samp.com
 Anti Money              -     Forum-Samp.com
 Anti God                -     Gtaturk.com
 Anti God Car            -     Gtaturk.com
 Anti Spawn-Kill         -     Gtaturk.com
 Anti Spam               -     Gtaturk.com
 Anti Fall               -     Gtaturk.com
 Anti C Bug              -     Forum-Samp.com
 Anti Fake-Kill          -     Gtaturk.com
 Anti Rcon               -     Forum-Samp.com
 Anti Airbreak           -     Forum-Samp.com
 Anti Ýp                 -     Gtaturk.com
 Anti Skin               -     Gtaturk.com
 Anti Afk                -     Gtaturk.com
 Anti Fly                -     Forum-Samp.com
 Anti Sobeit             -     Gtaturk.com
 Anti Moto               -     Gtaturk.com
 Anti Teleport Vehicle   -     Forum-Samp.com
 Anti Command Spammer    -     Forum-Samp.de
 Anti Connection Spammer -     Gtaturk.com
 Anti Server F*cker      -     Forum-Samp.com
 Anti Dialog             -     Forum-Samp.com
 Anti Speed              -     Forum-Samp.com
 Anti Bunny Hop          -     Forum-Samp.com
 Anti Color Spammer      -     CaLderoN_
*/

//Includeler - Includes
#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <foreach>
#include <a_http>
#include <streamer>
#include <dini>
#include <GPDID>

//Pragmalar - Pragmas
#pragma dynamic 140000
#pragma tabsize 0

//Genel Ayarlar - General Settings
#define LANGUAGE               1        // Türkçe/English - 0/Türkçe - 1/English

#define COMMANDS               0        // Zcmd/Dcmd/Strcmp - 0/Zcmd - 1/Dcmd - 2/Strcmp

#define NORMAL_KAYIT           true     // Ban Ve Kick Bilgilerinin Scriptfiles'a Kayýt Olmayý Saðlar.  Açýk/True - Kapalý/False
#define MYSQL_KAYIT            false    // Ban Ve Kick Bilgilerinin Mysql'ye Kayýt Olmayý Saðlar.       Açýk/True - Kapalý/False

//Not: Ýki Define'de Açýk/True Yada Kapalý/False Olmamalýdýr.

#if MYSQL_KAYIT == true
#define MYSQL_TABLE       	   "Kick_Log"  // Mysql Tablo Bilgilerini Deðiþtirmeyiniz.
#define MYSQL_TABLE2           "Ban_Log"   // Mysql Tablo Bilgilerini Deðiþtirmeyiniz.
#endif

#define VERSIYON               "1.4"    // Anti Hile Sistemi Versiyonu

#define SENDCLIENTMESSAGETOALL false    // Kick,Ban Yazýlarýný Yazý Olarak Gösterir.       Açýk/True - Kapalý/False
#define TEXTDRAW               true     // Kick,Ban Yazýlarýný Textdraw Olarak Gösterir.   Açýk/True - Kapalý/False

//Not: Ýki Define'de Açýk/True Yada Kapalý/False Olmamalýdýr.

//Ýþlemler
#define ISLEM_CRASHER          1        // Anti Crasher              1-Ban  2-Kick
#define ISLEM_CON              1    	// Anti Con                  1-Ban  2-Kick
#define ISLEM_PING             2    	// Anti Ping                 1-Ban  2-Kick
#define ISLEM_SILAH            3    	// Anti Silah                1-Ban  2-Kick  3-Silahý Siler
#define ISLEM_JETPACK          3    	// Anti Jetpack              1-Ban  2-Kick  3-Jetpack'i Siler
#define ISLEM_GOD              2    	// Anti God                  1-Ban  2-Kick
#define ISLEM_GOD_CAR          2    	// Anti God Car              1-Ban  2-Kick
#define ISLEM_C_BUG            2    	// Anti C Bug                1-Ban  2-Kick
#define ISLEM_FAKE_KILL        2    	// Anti Fake Kill            1-Ban  2-Kick
#define ISLEM_RCON             2    	// Anti Rcon                 1-Ban  2-Kick
#define ISLEM_AIRBREAK         1    	// Anti Airbreak             1-Ban  2-Kick
#define ISLEM_IP               1    	// Anti Ip                   1-Ban  2-Kick
#define ISLEM_SKIN             3    	// Anti Skin                 1-Ban  2-Kick  3-Skin'i Sýfýrlar
#define ISLEM_FLY              1    	// Anti Fly                  1-Ban  2-Kick
#define ISLEM_SOBEIT           1    	// Anti Sobeit               1-Ban  2-Kick
#define ISLEM_MOTO             2    	// Anti Motor Bug            1-Ban  2-Kick
#define ISLEM_CONNECT          1    	// Anti Connection Spammer   1-Ban  2-Kick
#define ISLEM_SPEED            1    	// Anti Speed                1-Ban  2-Kick
#define ISLEM_COLOR_SPAMMER    2    	// Anti Color Spammer        1-Ban  2-Kick

//Diðer Ýþlemler
#define MAX_PING               400   	// Anti Ping Maksimum Ping Deðeri - Maximum Ping Value
#define MAX_SPEED_VEHICLE      380.0    // Anti Airbreak Araç Hýzý - Speed Vehicle Max(380=default)

#define BANLA                  (0)
#define KICKLE                 (1)

//Defineler - Defines
#define FILTERSCRIPT
#define C_BUG_TIME 5
#define Driver 0
#define Passanger 2

#if COMMANDS == 1
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#endif

#define Player3DText(%1,%2,%3,%4,%5,%6,%7) 		CreateDynamic3DTextLabel(%1, %2, %5, %6, %7, %3, %4, INVALID_VEHICLE_ID, 0, -1, -1, -1, %3)
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.6)

//Newler - News
new
 ANTI_CRASHER,           		// Anti Crasher
 ANTI_CON,    	       	    	// Anti Con
 ANTI_PING,              		// Anti Ping           
 ANTI_SILAH,             		// Anti Silah          
 ANTI_JETPACK,           		// Anti Jetpack        
 ANTI_DRIVEBY,       	   		// Anti Drive By       
 ANTI_MONEY,             		// Anti Money          
 ANTI_GOD,               		// Anti God            
 ANTI_GOD_CAR,           		// Anti God Car        
 ANTI_SPAWN_KILL,        		// Anti Spawn Kill     
 ANTI_SPAM,              		// Anti Spam           
 ANTI_FALL,              		// Anti Fall           
 ANTI_C_BUG,             		// Anti C Bug          
 ANTI_FAKE_KILL,         		// Anti Fake Kill      
 ANTI_RCON,              		// Anti Rcon           
 ANTI_AIRBREAK,          		// Anti Airbreak       
 ANTI_IP,                		// Anti Ip             
 ANTI_SKIN,              		// Anti Skin           
 ANTI_FLY,               		// Anti Fly            
 ANTI_SOBEIT,            		// Anti Sobeit         
 ANTI_MOTOR,                 	// Anti Motor Bug
 ANTI_TELEPORT_VEHICLE,      	// Anti Teleport Vehicle
 ANTI_COMMAND_SPAMMER,      	// Anti Command Spammer
 ANTI_CONNECTION_SPAMMER,    	// Anti Connection Spammer
 ANTI_SERVER_FUCKER,        	// Anti Server Fucker
 ANTI_DIALOG,              	    // Anti Dialog
 ANTI_SPEED,                 	// Anti Speed

 ANTI_COLOR_SPAMMER,            // Anti Color Spammer
 Act[MAX_PLAYERS],
 #if MYSQL_KAYIT == true
 SQLL,
 #endif
 EVT,
 timespawn[MAX_PLAYERS][2],
 reqSorgu[MAX_PLAYERS char],
 in_cBaglanti[MAX_PLAYERS char] = 0,
 BH[MAX_PLAYERS],
 oft[MAX_PLAYERS],
 InCar[MAX_PLAYERS],
 WhatCar[MAX_PLAYERS],
 P_CBUG_TICKS[MAX_PLAYERS],
 Text3D:Spawnkill[MAX_PLAYERS],
 antispawnkill[MAX_PLAYERS],
 timer[MAX_PLAYERS],
 savetp[MAX_PLAYERS],
 dives[MAX_PLAYERS],
 Text:olaylar[5],
 yazideger[5][128],
 Float:OldVehiclePos[2000][4],
 LastCar[500],
 PlayerWeapon[MAX_PLAYERS][13],
 PlayerAmmo[MAX_PLAYERS][13],
 var[MAX_PLAYERS] = {-1,...},
 warns[MAX_PLAYERS] = {0,...},
 bool:npc[MAX_PLAYERS] = {false,...},
 uyarilar[MAX_PLAYERS] = {0,...},
 MAKS_OYUNCU_= MAX_PLAYERS,
 ConnectionErrors[6][40]=
 {
 #if LANGUAGE == 0
 "Yanlis Site",
 "Soket Yok",
 "Baglanilamiyor",
 "Yazilamiyor",
 "Yazi Cok Buyuk",
 "Birkac Dakika Sonra Deneyin"
 #elseif LANGUAGE == 1
 "Wrong Site",
 "No Socket",
 "Unable To Connect",
 "Can't Write",
 "Very Large Font",
 "After A Few Minutes And Try Again"
 #endif
 },

 legalmods[48][22] = {
        {400, 1024,1021,1020,1019,1018,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {401, 1145,1144,1143,1142,1020,1019,1017,1013,1007,1006,1005,1004,1003,1001,0000,0000,0000,0000},
        {404, 1021,1020,1019,1017,1016,1013,1007,1002,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {405, 1023,1021,1020,1019,1018,1014,1001,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {410, 1024,1023,1021,1020,1019,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {415, 1023,1019,1018,1017,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {418, 1021,1020,1016,1006,1002,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {420, 1021,1019,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {421, 1023,1021,1020,1019,1018,1016,1014,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {422, 1021,1020,1019,1017,1013,1007,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {426, 1021,1019,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {436, 1022,1021,1020,1019,1017,1013,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {439, 1145,1144,1143,1142,1023,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {477, 1021,1020,1019,1018,1017,1007,1006,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {478, 1024,1022,1021,1020,1013,1012,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {489, 1024,1020,1019,1018,1016,1013,1006,1005,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {491, 1145,1144,1143,1142,1023,1021,1020,1019,1018,1017,1014,1007,1003,0000,0000,0000,0000,0000},
        {492, 1016,1006,1005,1004,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {496, 1143,1142,1023,1020,1019,1017,1011,1007,1006,1003,1002,1001,0000,0000,0000,0000,0000,0000},
        {500, 1024,1021,1020,1019,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {516, 1021,1020,1019,1018,1017,1016,1015,1007,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {517, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1016,1007,1003,1002,0000,0000,0000,0000,0000},
        {518, 1145,1144,1143,1142,1023,1020,1018,1017,1013,1007,1006,1005,1003,1001,0000,0000,0000,0000},
        {527, 1021,1020,1018,1017,1015,1014,1007,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {529, 1023,1020,1019,1018,1017,1012,1011,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000},
        {534, 1185,1180,1179,1178,1127,1126,1125,1124,1123,1122,1106,1101,1100,0000,0000,0000,0000,0000},
        {535, 1121,1120,1119,1118,1117,1116,1115,1114,1113,1110,1109,0000,0000,0000,0000,0000,0000,0000},
        {536, 1184,1183,1182,1181,1128,1108,1107,1105,1104,1103,0000,0000,0000,0000,0000,0000,0000,0000},
        {540, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1004,1001,0000,0000,0000,0000},
        {542, 1145,1144,1021,1020,1019,1018,1015,1014,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {546, 1145,1144,1143,1142,1024,1023,1019,1018,1017,1007,1006,1004,1002,1001,0000,0000,0000,0000},
        {547, 1143,1142,1021,1020,1019,1018,1016,1003,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {549, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1012,1011,1007,1003,1001,0000,0000,0000,0000},
        {550, 1145,1144,1143,1142,1023,1020,1019,1018,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000},
        {551, 1023,1021,1020,1019,1018,1016,1006,1005,1003,1002,0000,0000,0000,0000,0000,0000,0000,0000},
        {558, 1168,1167,1166,1165,1164,1163,1095,1094,1093,1092,1091,1090,1089,1088,0000,0000,0000,0000},
        {559, 1173,1162,1161,1160,1159,1158,1072,1071,1070,1069,1068,1067,1066,1065,0000,0000,0000,0000},
        {560, 1170,1169,1141,1140,1139,1138,1033,1032,1031,1030,1029,1028,1027,1026,0000,0000,0000,0000},
        {561, 1157,1156,1155,1154,1064,1063,1062,1061,1060,1059,1058,1057,1056,1055,1031,1030,1027,1026},
        {562, 1172,1171,1149,1148,1147,1146,1041,1040,1039,1038,1037,1036,1035,1034,0000,0000,0000,0000},
        {565, 1153,1152,1151,1150,1054,1053,1052,1051,1050,1049,1048,1047,1046,1045,0000,0000,0000,0000},
        {567, 1189,1188,1187,1186,1133,1132,1131,1130,1129,1102,0000,0000,0000,0000,0000,0000,0000,0000},
        {575, 1177,1176,1175,1174,1099,1044,1043,1042,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {576, 1193,1192,1191,1190,1137,1136,1135,1134,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {580, 1023,1020,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {589, 1145,1144,1024,1020,1018,1017,1016,1013,1007,1006,1005,1004,1000,0000,0000,0000,0000,0000},
        {600, 1022,1020,1018,1017,1013,1007,1006,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {603, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000}
 },

 Karaliste[37][0] = {
	{"nul"},
	{"nul."},
	{"nul,"},
	{"aux"},
	{"aux."},
	{"aux,"},
	{"con"},
	{"con."},
	{"Con."},
	{"CoN."},
	{"CoN,"},
	{"con,"},
	{"prn"},
	{"prn."},
	{"prn,"},
	{"prn,"},
	{"prn."},
	{"com0"},
	{"com1"},
	{"com2"},
	{"com3"},
	{"com4"},
	{"com5"},
	{"com6"},
	{"com7"},
	{"com8"},
	{"com9"},
	{"lpt0"},
	{"lpt1"},
	{"lpt2"},
	{"lpt3"},
	{"lpt4"},
	{"lpt5"},
	{"lpt6"},
	{"lpt7"},
	{"lpt8"},
	{"lpt9"}
 };

#include <money>

//Forwardlar - Forwards
forward PingKontrol(playerid);
forward BSS(playerid);
forward DBT(playerid);
forward remtp(playerid);
forward Checkhim(playerid);
forward HackCheck(playerid);
forward AutoKick(playerid);
forward AntiSpawnkill(playerid);
forward MyHttpResponse(index, response_code, data[]);
forward MyHttpResponses(index, response_code, data[]);
forward mesajsil(i);
forward globaltimer();
forward Slap(playerid);

stock Float:GetPlayerSpeedXY(playerid)
{
new Float:SpeedX, Float:SpeedY, Float:SpeedZ;
new Float:Speed;
if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid), SpeedX, SpeedY, SpeedZ);
else GetPlayerVelocity(playerid, SpeedX, SpeedY, SpeedZ);
Speed = floatsqroot(floatadd(floatpower(SpeedX, 2.0), floatpower(SpeedY, 2.0)));
return floatmul(Speed, 200.0);
}

public OnFilterScriptInit()
{
    #if LANGUAGE == 0
    printf("<======================================>");
	printf("<         Anti Hile Sistemi v%s       >",VERSIYON);
	printf("<                 Turkce               >");
	printf("<               Max_Andolini           >");
	printf("<            Basariyla Acildi          >");
    printf("<======================================>");
    #elseif LANGUAGE == 1
    printf("<======================================>");
	printf("<         Anti Cheat System v%s       >",VERSIYON);
	printf("<                English               >");
	printf("<               Max_Andolini           >");
	printf("<           Opened Successfully        >");
    printf("<======================================>");
	#endif
	#if MYSQL_KAYIT == true
	MySQLBaqlan();
	#endif
	if(ANTI_COMMAND_SPAMMER == 1) SetTimer("globaltimer",3000,1);
	UpdateConfig();
	HTTP(0, HTTP_GET, "maxandolini.com.nu/version.txt", "", "MyHttpResponse");
    for(new line; line<5; line++)
    {
    format(yazideger[line], 128, " ");
    }
    olaylar[0] = TextDrawCreate(271.000000,360.000000, yazideger[0]);//alltan 15
    olaylar[1] = TextDrawCreate(271.000000,371.000000, yazideger[1]);//alltan 14
    olaylar[2] = TextDrawCreate(271.000000,382.000000, yazideger[2]);//alltan 13
    olaylar[3] = TextDrawCreate(271.000000,392.000000, yazideger[3]);//alltan 12
    olaylar[4] = TextDrawCreate(271.000000,403.000000, yazideger[4]);//alltan 11
    for(new line; line<5; line++)
    {
    TextDrawLetterSize(olaylar[line], 0.199999,1.000000);
    TextDrawSetShadow(olaylar[line], 0);
    TextDrawAlignment(olaylar[line], 2);
    TextDrawFont(olaylar[line], 1);
    TextDrawShowForAll(olaylar[line]);
    }
    for(new line; line<5; line++)
    {
    TextDrawLetterSize(olaylar[line], 0.199999,1.000000);
    TextDrawSetShadow(olaylar[line], 0);
    TextDrawAlignment(olaylar[line], 2);
    TextDrawTextSize(olaylar[line], 640, 480);
    TextDrawBoxColor(olaylar[line], 0x000000FF);
    TextDrawFont(olaylar[line], 1);
    TextDrawSetOutline(olaylar[line], 1);
    TextDrawShowForAll(olaylar[line]);
    }
    SendRconCommand("reloadbans");
	return 1;
}

public OnFilterScriptExit()
{
    #if LANGUAGE == 0
    printf("<======================================>");
	printf("<         Anti Hile Sistemi v%s       >",VERSIYON);
	printf("<                 Turkce               >");
	printf("<               Max_Andolini           >");
	printf("<             Basariyla Kapandi        >");
    printf("<======================================>");
    #elseif LANGUAGE == 1
    printf("<======================================>");
	printf("<         Anti Cheat System v%s       >",VERSIYON);
	printf("<                English               >");
	printf("<               Max_Andolini           >");
	printf("<            Closed Successfully       >");
    printf("<======================================>");
	#endif
	for(new line; line<5; line++)
	{
	TextDrawDestroy(olaylar[line]);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(ANTI_CONNECTION_SPAMMER == 1)
	{
    if(in_cBaglanti{playerid} == 0){
    Girisbilgi(playerid);
	}
	else if(in_cBaglanti{playerid} == 1){
	#if ISLEM_CONNECT == 1
	   Banat("Connection Spammer Hilesi","Connection Spammer Hack");
	#elseif ISLEM_CONNECT == 2
	   Kickat("Connection Spammer Hilesi","Connection Spammer Hack");
	#endif
	}
	} else {
    Girisbilgi(playerid);
	}
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	in_cBaglanti{playerid} = 0;
	timespawn[playerid][1] = 0;
    if(ANTI_BOT == 1)
    {
	    MAKS_OYUNCU_= MaksID(playerid);
	    if(npc[playerid]) npc[playerid] = false;
	    if(var[playerid] != -1)
	    {
	        KillTimer(var[playerid]);
	        var[playerid] = -1;
	    }
	    uyarilar[playerid] = 0;
    }
    if(ANTI_SPAWN_KILL == 1) antispawnkill[playerid] = 0;
    return 1;
}

public OnPlayerSpawn(playerid)
{
	if(ANTI_SPAWN_KILL == 1)
    {
		antispawnkill[playerid] = 1;
		if(antispawnkill[playerid] == 1)
		{
		SetPlayerHealth(playerid, 100000.0);
		#if LANGUAGE == 0
	    SendClientMessage(playerid, 0xFF0000AA, "{C8C8C8}» {FFFFFF}Sizi {F63A00}' 10 ' {FFFFFF}Saniye Koruyan {F63A00}' Anti-Spawnkill ' {FFFFFF}Korumasý Devrede.");
	    SetPlayerChatBubble(playerid, "{C8C8C8}» {F63A00}' Anti-Spawnkill ' {FFFFFF}Korumasý Devredýþý.", 0xFF0000AA, 100.0, 10000);
	    #elseif LANGUAGE == 1
	    SendClientMessage(playerid, 0xFF0000AA, "{C8C8C8}» {FFFFFF}You For{F63A00}' 10 ' {FFFFFF}Seconds Protect{F63A00}' Anti-Spawnkill ' {FFFFFF}Activate.");
	    SetPlayerChatBubble(playerid, "{C8C8C8}» {F63A00}' Anti-Spawnkill ' {FFFFFF}Protect Disable.", 0xFF0000AA, 100.0, 10000);
	    #endif
	    Spawnkill[playerid] = Player3DText("«« Anti-Spawnkill »»",0x00F600F6,30.0,playerid,0,0,0.4);
	    SetTimerEx("AntiSpawnkill",10000,0,"i",playerid);
	    }
    }
    if(ANTI_SOBEIT == 1) SetTimerEx("HackCheck", 5 * 1000, 0, "i", playerid);
	for(new line; line<5; line++)
	{
	TextDrawShowForPlayer(playerid, olaylar[line]);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(ANTI_FAKE_KILL == 1)
    {
	    if(GetPVarInt(playerid,"AntiFakeKill")>GetTickCount()) {
		#if ISLEM_FAKE_KILL == 1
	       Banat("Fake Kill Hilesi","Fake Kill Hack");
		#elseif ISLEM_FAKE_KILL == 2
	       Kickat("Fake Kill Hilesi","Fake Kill Hack");
	 	#endif
		}
	    SetPVarInt(playerid,"AntiFakeKill",GetTickCount()+3000);
	}
    if(ANTI_MOTOR == 1)
    {
	    new vID,v;
	    v = GetPlayerVehicleID(killerid);

	    if(IsBike(v))
	    {
	    if(GetPlayerState(killerid) == PLAYER_STATE_PASSENGER)
	    {
	        new the_driver = -1;

		    foreach(Player, i)
		    {
	            vID = GetPlayerVehicleID(i);
	        if(playerid != i && vID == v && GetPlayerVehicleSeat(i) == 0){
	        the_driver = i;
	        break;
	        }
	    }
	    if(the_driver == -1)
	    {
		#if ISLEM_MOTO == 1
	       Banat("Motor Bug Hilesi","Moto Bug Hack");
		#elseif ISLEM_MOTO == 2
	       Kickat("Motor Bug Hilesi","Moto Bug Hack");
		#endif
	    return true;
	    }
	    }
	    }
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	InCar[playerid] = 0;
	if(ANTI_SERVER_FUCKER == 1) flooding(playerid);
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(ANTI_IP == 1)
    {
	    for(new i=0, j=0; i<2048; i++) if(text[i] >= '0' && text[i] <= '9') {
	    j++; if(j >= 0xF || j >= 10){
		#if ISLEM_IP == 1
	       Banat("Reklam","Advertisement");
		#elseif ISLEM_IP == 2
	       Kickat("Reklam","Advertisement");
		#endif
	    return 0; } }
    }
    if(ANTI_SPAM == 1)
    {
			if(!spamProtect(playerid, "Chat", 3)) {
	        #if LANGUAGE == 0
			return SendClientMessage(playerid, 0xFF0000FF, "{007FFF}(({C3C3C3} *** Anti Hile *** {FFFFFF}Tekrar chat edebilmek için 3 saniye bekleyin! {007FFF}))"), 0;
            #elseif LANGUAGE == 1
			return SendClientMessage(playerid, 0xFF0000FF, "{007FFF}(({C3C3C3} *** Anti Cheat *** {FFFFFF}Wait For 3 Seconds In Order To Chat Again! {007FFF}))"), 0;
			#endif
		}
	}
	return 1;
}

#if COMMANDS == 0
CMD:anticheat(playerid, params[]) return cmd_antihile(playerid, params);

CMD:antihile(playerid, params[])
{
	Anticheats(playerid);
	return 1;
}

CMD:anticheatcredits(playerid, params[]) return cmd_antihileyapimci(playerid, params);

CMD:antihileyapimci(playerid, params[])
{
	Anticheatcredits(playerid);
	return 1;
}

CMD:anticheatversion(playerid, params[]) return cmd_antihileversiyon(playerid, params);

CMD:antihileversiyon(playerid, params[])
{
	Anticheatversion(playerid);
	return 1;
}

CMD:anticheatautosettings(playerid, params[]) return cmd_antihileotoayar(playerid, params);

CMD:antihileotoayar(playerid, params[])
{
	new hileoto[256],idx;

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hileoto = strtok(params, idx);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hileoto))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihileotoayar (Ayarlar)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Ayarlar: (freeroam,roleplay,sifirla)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatautosettings (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Settings: (freeroam,roleplay,reset)");
 		#endif
		return 1;
    }
    else if(strcmp(hileoto, "freeroam", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 1;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 1;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 1;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 1;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 0;               		 // Anti Jetpack             Açýk/True - Kapalý/False
	 	ANTI_DRIVEBY = 1;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 1;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 1;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 1;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 1;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 1;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 1;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 1;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 1;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 1;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 1;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 1;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 1;                  		 // Anti Skin                Açýk/True - Kapalý/False
	 	ANTI_FLY = 1;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 1;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 1;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 1;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 1;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 1;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 1;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 1;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 1;                          // Anti Speed               Açýk/True - Kapalý/False
 	 	ANTI_COLOR_SPAMMER = 1;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",1);
	 	dini_IntSet(file,"Anti_Con",1);
	 	dini_IntSet(file,"Anti_Ping",1);
	 	dini_IntSet(file,"Anti_Silah",1);
	 	dini_IntSet(file,"Anti_Jetpack",0);

	 	dini_IntSet(file,"Anti_Driveby",1);
	 	dini_IntSet(file,"Anti_Money",1);
	 	dini_IntSet(file,"Anti_God",1);
	 	dini_IntSet(file,"Anti_God_Car",1);
	 	dini_IntSet(file,"Anti_Spawn_Kill",1);
	 	dini_IntSet(file,"Anti_Spam",1);
	 	dini_IntSet(file,"Anti_Fall",1);
	 	dini_IntSet(file,"Anti_C_Bug",1);
	 	dini_IntSet(file,"Anti_Fake_Kill",1);
	 	dini_IntSet(file,"Anti_Rcon",1);
	 	dini_IntSet(file,"Anti_Airbreak",1);
	 	dini_IntSet(file,"Anti_Ip",1);
	 	dini_IntSet(file,"Anti_Skin",1);

	 	dini_IntSet(file,"Anti_Fly",1);
	 	dini_IntSet(file,"Anti_Sobeit",1);
 	 	dini_IntSet(file,"Anti_Motor",1);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",1);
 	 	dini_IntSet(file,"Anti_Command_Spammer",1);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",1);
 	 	dini_IntSet(file,"Anti_Server_Fucker",1);
 	 	dini_IntSet(file,"Anti_Dialog",1);
 	 	dini_IntSet(file,"Anti_Speed",1);
 	 	dini_IntSet(file,"Anti_Color_Spammer",1);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Anti Freeroam Baþarýyla Aktif Edildi.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"Anti Freeroam Has Been Succesfully Activated.");
        #endif
    }
    else if(strcmp(hileoto, "roleplay", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 1;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 1;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 1;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 1;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 1;               		 // Anti Jetpack             Açýk/True - Kapalý/False
	 	ANTI_DRIVEBY = 1;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 1;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 1;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 1;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 0;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 0;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 1;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 1;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 1;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 1;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 1;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 1;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 1;                  		 // Anti Skin                Açýk/True - Kapalý/False
	 	ANTI_FLY = 1;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 1;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 1;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 1;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 0;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 1;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 1;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 1;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 1;                          // Anti Speed               Açýk/True - Kapalý/False
 	 	ANTI_COLOR_SPAMMER = 1;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",1);
	 	dini_IntSet(file,"Anti_Con",1);
	 	dini_IntSet(file,"Anti_Ping",1);
	 	dini_IntSet(file,"Anti_Silah",1);
	 	dini_IntSet(file,"Anti_Jetpack",1);

	 	dini_IntSet(file,"Anti_Driveby",1);
	 	dini_IntSet(file,"Anti_Money",1);
	 	dini_IntSet(file,"Anti_God",1);
	 	dini_IntSet(file,"Anti_God_Car",1);
	 	dini_IntSet(file,"Anti_Spawn_Kill",0);
	 	dini_IntSet(file,"Anti_Spam",0);
	 	dini_IntSet(file,"Anti_Fall",1);
	 	dini_IntSet(file,"Anti_C_Bug",1);
	 	dini_IntSet(file,"Anti_Fake_Kill",1);
	 	dini_IntSet(file,"Anti_Rcon",1);
	 	dini_IntSet(file,"Anti_Airbreak",1);
	 	dini_IntSet(file,"Anti_Ip",1);
	 	dini_IntSet(file,"Anti_Skin",1);
	 	dini_IntSet(file,"Anti_Fly",1);
	 	dini_IntSet(file,"Anti_Sobeit",1);
 	 	dini_IntSet(file,"Anti_Motor",1);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",1);
 	 	dini_IntSet(file,"Anti_Command_Spammer",0);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",1);
 	 	dini_IntSet(file,"Anti_Server_Fucker",1);
 	 	dini_IntSet(file,"Anti_Dialog",1);
 	 	dini_IntSet(file,"Anti_Speed",1);
 	 	dini_IntSet(file,"Anti_Color_Spammer",1);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Anti Roleplay Baþarýyla Aktif Edildi.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"Anti Roleplay Has Been Succesfully Activated.");
        #endif
    }
    else if(strcmp(hileoto, "sifirla", true) == 0 || strcmp(hileoto, "reset", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 0;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 0;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 0;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 0;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 0;               		 // Anti Jetpack             Açýk/True - Kapalý/False
	 	ANTI_DRIVEBY = 0;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 0;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 0;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 0;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 0;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 0;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 0;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 0;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 0;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 0;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 0;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 0;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 0;                  		 // Anti Skin                Açýk/True - Kapalý/False

	 	ANTI_FLY = 0;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 0;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 0;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 0;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 0;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 0;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 0;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 0;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 0;                          // Anti Speed               Açýk/True - Kapalý/False

 	 	ANTI_COLOR_SPAMMER = 0;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",0);
	 	dini_IntSet(file,"Anti_Con",0);
	 	dini_IntSet(file,"Anti_Ping",0);
	 	dini_IntSet(file,"Anti_Silah",0);
	 	dini_IntSet(file,"Anti_Jetpack",0);

	 	dini_IntSet(file,"Anti_Driveby",0);
	 	dini_IntSet(file,"Anti_Money",0);
	 	dini_IntSet(file,"Anti_God",0);
	 	dini_IntSet(file,"Anti_God_Car",0);
	 	dini_IntSet(file,"Anti_Spawn_Kill",0);
	 	dini_IntSet(file,"Anti_Spam",0);
	 	dini_IntSet(file,"Anti_Fall",0);
	 	dini_IntSet(file,"Anti_C_Bug",0);
	 	dini_IntSet(file,"Anti_Fake_Kill",0);
	 	dini_IntSet(file,"Anti_Rcon",0);
	 	dini_IntSet(file,"Anti_Airbreak",0);
	 	dini_IntSet(file,"Anti_Ip",0);
	 	dini_IntSet(file,"Anti_Skin",0);

	 	dini_IntSet(file,"Anti_Fly",0);
	 	dini_IntSet(file,"Anti_Sobeit",0);
 	 	dini_IntSet(file,"Anti_Motor",0);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",0);
 	 	dini_IntSet(file,"Anti_Command_Spammer",0);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",0);
 	 	dini_IntSet(file,"Anti_Server_Fucker",0);
 	 	dini_IntSet(file,"Anti_Dialog",0);
 	 	dini_IntSet(file,"Anti_Speed",0);

 	 	dini_IntSet(file,"Anti_Color_Spammer",0);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Tüm Ayarlar Baþarýyla Sýfýrlandý.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"All Settings Successfully Reset.");
        #endif
    }
    else
    {
 		SendClientMessage(playerid, 1, " ");
    }
	return 1;
}

CMD:anticheatstatus(playerid, params[]) return cmd_antihiledurum(playerid, params);

CMD:antihiledurum(playerid, params[])
{
	Anticheatstatus(playerid);
	return 1;
}

CMD:anticheatopen(playerid, params[]) return cmd_antihileac(playerid, params);

CMD:antihileac(playerid, params[])
{
	new hileac[256],idx;

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hileac = strtok(params, idx);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hileac))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihileac (Sistemler)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Sistemler");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,silah,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,rcon,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(airbreak,ip,skin,afk,fly,sobeit,motor,aracteleport,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatopen (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Systems");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,weapon,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(rcon,airbreak,ip,skin,afk,fly,sobeit,moto,teleportvehicle,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#endif
		return 1;
    }
    else if(strcmp(hileac, "crasher", true) == 0) Antiopen(playerid,1,"Anti_Crasher","Anti Crasher","Anti Crasher");
    else if(strcmp(hileac, "con", true) == 0) Antiopen(playerid,2,"Anti_Con","Anti Con","Anti Con");
    else if(strcmp(hileac, "ping", true) == 0) Antiopen(playerid,3,"Anti_Ping","Anti Ping","Anti Ping");
    else if(strcmp(hileac, "silah", true) == 0 || strcmp(hileac, "weapon", true) == 0) Antiopen(playerid,4,"Anti_Silah","Anti Silah","Anti Weapon");
    else if(strcmp(hileac, "jetpack", true) == 0) Antiopen(playerid,5,"Anti_Jetpack","Anti Jetpack","Anti Jetpack");
    else if(strcmp(hileac, "driveby", true) == 0) Antiopen(playerid,7,"Anti_Driveby","Anti Drive By","Anti Drive By");
    else if(strcmp(hileac, "money", true) == 0) Antiopen(playerid,8,"Anti_Money","Anti Money","Anti Money");
    else if(strcmp(hileac, "god", true) == 0) Antiopen(playerid,9,"Anti_God","Anti God","Anti God");
    else if(strcmp(hileac, "godcar", true) == 0) Antiopen(playerid,10,"Anti_God_Car","Anti God Car","Anti God Car");
    else if(strcmp(hileac, "spawnkill", true) == 0) Antiopen(playerid,11,"Anti_Spawn_Kill","Anti Spawn Kill","Anti Spawn Kill");
    else if(strcmp(hileac, "spam", true) == 0) Antiopen(playerid,12,"Anti_Spam","Anti Spam","Anti Spam");
    else if(strcmp(hileac, "fall", true) == 0) Antiopen(playerid,13,"Anti_Fall","Anti Fall","Anti Fall");
    else if(strcmp(hileac, "cbug", true) == 0) Antiopen(playerid,14,"Anti_C_Bug","Anti C Bug","Anti C Bug");
    else if(strcmp(hileac, "fakekill", true) == 0) Antiopen(playerid,15,"Anti_Fake_Kill","Anti Fake Kill","Anti Fake Kill");
    else if(strcmp(hileac, "rcon", true) == 0) Antiopen(playerid,16,"Anti_Rcon","Anti Rcon","Anti Rcon");
    else if(strcmp(hileac, "airbreak", true) == 0) Antiopen(playerid,17,"Anti_Airbreak","Anti Airbreak","Anti Airbreak");
    else if(strcmp(hileac, "ip", true) == 0) Antiopen(playerid,18,"Anti_Ip","Anti Ip","Anti Ip");
    else if(strcmp(hileac, "skin", true) == 0) Antiopen(playerid,19,"Anti_Skin","Anti Skin","Anti Skin");
    else if(strcmp(hileac, "fly", true) == 0) Antiopen(playerid,21,"Anti_Fly","Anti Fly","Anti Fly");
    else if(strcmp(hileac, "sobeit", true) == 0) Antiopen(playerid,22,"Anti_Sobeit","Anti Sobeit","Anti Sobeit");
    else if(strcmp(hileac, "motor", true) == 0 || strcmp(hileac, "moto", true) == 0) Antiopen(playerid,23,"Anti_Motor","Anti Motor Bug","Anti Moto Bug");
    else if(strcmp(hileac, "aracteleport", true) == 0 || strcmp(hileac, "teleportvehicle", true) == 0) Antiopen(playerid,24,"Anti_Teleport_Vehicle","Anti Araç Teleport","Anti Teleport Vehicle");
    else if(strcmp(hileac, "cmdspam", true) == 0) Antiopen(playerid,25,"Anti_Command_Spammer","Anti Command Spammer","Anti Command Spammer");
    else if(strcmp(hileac, "connectspam", true) == 0) Antiopen(playerid,26,"Anti_Connection_Spammer","Anti Connection Spammer","Anti Connection Spammer");
    else if(strcmp(hileac, "serverfuck", true) == 0) Antiopen(playerid,27,"Anti_Server_Fucker","Anti Server Fucker","Anti Server Fucker");
    else if(strcmp(hileac, "dialog", true) == 0) Antiopen(playerid,28,"Anti_Dialog","Anti Dialog","Anti Dialog");
    else if(strcmp(hileac, "speed", true) == 0) Antiopen(playerid,29,"Anti_Speed","Anti Speed","Anti Speed");
    else if(strcmp(hileac, "colorspam", true) == 0) Antiopen(playerid,31,"Anti_Color_Spammer","Anti Color Spammer","Anti Color Spammer");
    else SendClientMessage(playerid, 1, " ");
	return 1;
}

CMD:anticheatclose(playerid, params[]) return cmd_antihilekapat(playerid, params);

CMD:antihilekapat(playerid, params[])
{
	new hilekapat[256],idx;

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hilekapat = strtok(params, idx);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hilekapat))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihilekapat (Sistemler)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Sistemler");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,silah,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,rcon,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(airbreak,ip,skin,afk,fly,sobeit,motor,aracteleport,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatclose (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Systems");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,weapon,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(rcon,airbreak,ip,skin,afk,fly,sobeit,moto,teleportvehicle,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#endif
		return 1;
    }
    else if(strcmp(hilekapat, "crasher", true) == 0) Anticlose(playerid,1,"Anti_Crasher","Anti Crasher","Anti Crasher");
    else if(strcmp(hilekapat, "con", true) == 0) Anticlose(playerid,2,"Anti_Con","Anti Con","Anti Con");
    else if(strcmp(hilekapat, "ping", true) == 0) Anticlose(playerid,3,"Anti_Ping","Anti Ping","Anti Ping");
    else if(strcmp(hilekapat, "silah", true) == 0 || strcmp(hilekapat, "weapon", true) == 0) Anticlose(playerid,4,"Anti_Silah","Anti Silah","Anti Weapon");
    else if(strcmp(hilekapat, "jetpack", true) == 0) Anticlose(playerid,5,"Anti_Jetpack","Anti Jetpack","Anti Jetpack");
    else if(strcmp(hilekapat, "driveby", true) == 0) Anticlose(playerid,7,"Anti_Driveby","Anti Drive By","Anti Drive By");
    else if(strcmp(hilekapat, "money", true) == 0) Anticlose(playerid,8,"Anti_Money","Anti Money","Anti Money");
    else if(strcmp(hilekapat, "god", true) == 0) Anticlose(playerid,9,"Anti_God","Anti God","Anti God");
    else if(strcmp(hilekapat, "godcar", true) == 0) Anticlose(playerid,10,"Anti_God_Car","Anti God Car","Anti God Car");
    else if(strcmp(hilekapat, "spawnkill", true) == 0) Anticlose(playerid,11,"Anti_Spawn_Kill","Anti Spawn Kill","Anti Spawn Kill");
    else if(strcmp(hilekapat, "spam", true) == 0) Anticlose(playerid,12,"Anti_Spam","Anti Spam","Anti Spam");
    else if(strcmp(hilekapat, "fall", true) == 0) Anticlose(playerid,13,"Anti_Fall","Anti Fall","Anti Fall");
    else if(strcmp(hilekapat, "cbug", true) == 0) Anticlose(playerid,14,"Anti_C_Bug","Anti C Bug","Anti C Bug");
    else if(strcmp(hilekapat, "fakekill", true) == 0) Anticlose(playerid,15,"Anti_Fake_Kill","Anti Fake Kill","Anti Fake Kill");
    else if(strcmp(hilekapat, "rcon", true) == 0) Anticlose(playerid,16,"Anti_Rcon","Anti Rcon","Anti Rcon");
    else if(strcmp(hilekapat, "airbreak", true) == 0) Anticlose(playerid,17,"Anti_Airbreak","Anti Airbreak","Anti Airbreak");
    else if(strcmp(hilekapat, "ip", true) == 0) Anticlose(playerid,18,"Anti_Ip","Anti Ip","Anti Ip");
    else if(strcmp(hilekapat, "skin", true) == 0) Anticlose(playerid,19,"Anti_Skin","Anti Skin","Anti Skin");
    else if(strcmp(hilekapat, "fly", true) == 0) Anticlose(playerid,21,"Anti_Fly","Anti Fly","Anti Fly");
    else if(strcmp(hilekapat, "sobeit", true) == 0) Anticlose(playerid,22,"Anti_Sobeit","Anti Sobeit","Anti Sobeit");
    else if(strcmp(hilekapat, "motor", true) == 0 || strcmp(hilekapat, "moto", true) == 0) Anticlose(playerid,23,"Anti_Motor","Anti Motor Bug","Anti Moto Bug");
    else if(strcmp(hilekapat, "aracteleport", true) == 0 || strcmp(hilekapat, "teleportvehicle", true) == 0) Anticlose(playerid,24,"Anti_Teleport_Vehicle","Anti Araç Teleport","Anti Teleport Vehicle");
    else if(strcmp(hilekapat, "cmdspam", true) == 0) Anticlose(playerid,25,"Anti_Command_Spammer","Anti Command Spammer","Anti Command Spammer");
    else if(strcmp(hilekapat, "connectspam", true) == 0) Anticlose(playerid,26,"Anti_Connection_Spammer","Anti Connection Spammer","Anti Connection Spammer");
    else if(strcmp(hilekapat, "serverfuck", true) == 0) Anticlose(playerid,27,"Anti_Server_Fucker","Anti Server Fucker","Anti Server Fucker");
    else if(strcmp(hilekapat, "dialog", true) == 0) Anticlose(playerid,28,"Anti_Dialog","Anti Dialog","Anti Dialog");
    else if(strcmp(hilekapat, "speed", true) == 0) Anticlose(playerid,29,"Anti_Speed","Anti Speed","Anti Speed");
    else if(strcmp(hilekapat, "colorspam", true) == 0) Anticlose(playerid,31,"Anti_Color_Spammer","Anti Color Spammer","Anti Color Spammer");
    else SendClientMessage(playerid, 1, " ");
	return 1;
}
#elseif COMMANDS == 1
dcmd_anticheat(playerid, params[]) return dcmd_antihile(playerid, params);

dcmd_antihile(playerid, params[])
{
	Anticheats(playerid);
	return 1;
}

dcmd_anticheatcredits(playerid, params[]) return dcmd_antihileyapimci(playerid, params);

dcmd_antihileyapimci(playerid, params[])
{
    #pragma unused params
	Anticheatcredits(playerid);
	return 1;
}

dcmd_anticheatversion(playerid, params[]) return dcmd_antihileversiyon(playerid, params);

dcmd_antihileversiyon(playerid, params[])
{
    #pragma unused params
	Anticheatversion(playerid);
	return 1;
}

dcmd_anticheatautosettings(playerid, params[]) return dcmd_antihileotoayar(playerid, params);

dcmd_antihileotoayar(playerid, params[])
{
	new hileoto[256],idx;

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hileoto = strtok(params, idx);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hileoto))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihileotoayar (Ayarlar)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Ayarlar: (freeroam,roleplay,sifirla)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatautosettings (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Settings: (freeroam,roleplay,reset)");
 		#endif
		return 1;
    }
    else if(strcmp(hileoto, "freeroam", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 1;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 1;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 1;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 1;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 0;               		 // Anti Jetpack             Açýk/True - Kapalý/False
	 	ANTI_DRIVEBY = 1;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 1;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 1;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 1;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 1;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 1;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 1;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 1;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 1;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 1;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 1;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 1;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 1;                  		 // Anti Skin                Açýk/True - Kapalý/False
	 	ANTI_FLY = 1;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 1;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 1;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 1;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 1;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 1;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 1;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 1;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 1;                          // Anti Speed               Açýk/True - Kapalý/False
 	 	ANTI_COLOR_SPAMMER = 1;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",1);
	 	dini_IntSet(file,"Anti_Con",1);
	 	dini_IntSet(file,"Anti_Ping",1);
	 	dini_IntSet(file,"Anti_Silah",1);
	 	dini_IntSet(file,"Anti_Jetpack",0);

	 	dini_IntSet(file,"Anti_Driveby",1);
	 	dini_IntSet(file,"Anti_Money",1);
	 	dini_IntSet(file,"Anti_God",1);
	 	dini_IntSet(file,"Anti_God_Car",1);
	 	dini_IntSet(file,"Anti_Spawn_Kill",1);
	 	dini_IntSet(file,"Anti_Spam",1);
	 	dini_IntSet(file,"Anti_Fall",1);
	 	dini_IntSet(file,"Anti_C_Bug",1);
	 	dini_IntSet(file,"Anti_Fake_Kill",1);
	 	dini_IntSet(file,"Anti_Rcon",1);
	 	dini_IntSet(file,"Anti_Airbreak",1);
	 	dini_IntSet(file,"Anti_Ip",1);
	 	dini_IntSet(file,"Anti_Skin",1);

	 	dini_IntSet(file,"Anti_Fly",1);
	 	dini_IntSet(file,"Anti_Sobeit",1);
 	 	dini_IntSet(file,"Anti_Motor",1);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",1);
 	 	dini_IntSet(file,"Anti_Command_Spammer",1);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",1);
 	 	dini_IntSet(file,"Anti_Server_Fucker",1);
 	 	dini_IntSet(file,"Anti_Dialog",1);
 	 	dini_IntSet(file,"Anti_Speed",1);

 	 	dini_IntSet(file,"Anti_Color_Spammer",1);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Anti Freeroam Baþarýyla Aktif Edildi.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"Anti Freeroam Has Been Succesfully Activated.");
        #endif
    }
    else if(strcmp(hileoto, "roleplay", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 1;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 1;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 1;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 1;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 1;               		 // Anti Jetpack             Açýk/True - Kapalý/False

	 	ANTI_DRIVEBY = 1;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 1;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 1;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 1;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 0;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 0;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 1;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 1;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 1;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 1;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 1;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 1;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 1;                  		 // Anti Skin                Açýk/True - Kapalý/False

	 	ANTI_FLY = 1;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 1;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 1;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 1;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 0;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 1;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 1;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 1;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 1;                          // Anti Speed               Açýk/True - Kapalý/False

 	 	ANTI_COLOR_SPAMMER = 1;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",1);
	 	dini_IntSet(file,"Anti_Con",1);
	 	dini_IntSet(file,"Anti_Ping",1);
	 	dini_IntSet(file,"Anti_Silah",1);
	 	dini_IntSet(file,"Anti_Jetpack",1);

	 	dini_IntSet(file,"Anti_Driveby",1);
	 	dini_IntSet(file,"Anti_Money",1);
	 	dini_IntSet(file,"Anti_God",1);
	 	dini_IntSet(file,"Anti_God_Car",1);
	 	dini_IntSet(file,"Anti_Spawn_Kill",0);
	 	dini_IntSet(file,"Anti_Spam",0);
	 	dini_IntSet(file,"Anti_Fall",1);
	 	dini_IntSet(file,"Anti_C_Bug",1);
	 	dini_IntSet(file,"Anti_Fake_Kill",1);
	 	dini_IntSet(file,"Anti_Rcon",1);
	 	dini_IntSet(file,"Anti_Airbreak",1);
	 	dini_IntSet(file,"Anti_Ip",1);
	 	dini_IntSet(file,"Anti_Skin",1);

	 	dini_IntSet(file,"Anti_Fly",1);
	 	dini_IntSet(file,"Anti_Sobeit",1);
 	 	dini_IntSet(file,"Anti_Motor",1);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",1);
 	 	dini_IntSet(file,"Anti_Command_Spammer",0);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",1);
 	 	dini_IntSet(file,"Anti_Server_Fucker",1);
 	 	dini_IntSet(file,"Anti_Dialog",1);
 	 	dini_IntSet(file,"Anti_Speed",1);
 	 	dini_IntSet(file,"Anti_Bunny_Hop",1);
 	 	dini_IntSet(file,"Anti_Color_Spammer",1);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Anti Roleplay Baþarýyla Aktif Edildi.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"Anti Roleplay Has Been Succesfully Activated.");
        #endif
    }
    else if(strcmp(hileoto, "sifirla", true) == 0 || strcmp(hileoto, "reset", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 0;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 0;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 0;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 0;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 0;               		 // Anti Jetpack             Açýk/True - Kapalý/False
	 	ANTI_BOT = 0;                   		 // Anti Bot                 Açýk/True - Kapalý/False
	 	ANTI_DRIVEBY = 0;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 0;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 0;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 0;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 0;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 0;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 0;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 0;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 0;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 0;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 0;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 0;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 0;                  		 // Anti Skin                Açýk/True - Kapalý/False

	 	ANTI_FLY = 0;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 0;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 0;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 0;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 0;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 0;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 0;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 0;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 0;                          // Anti Speed               Açýk/True - Kapalý/False

 	 	ANTI_COLOR_SPAMMER = 0;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",0);
	 	dini_IntSet(file,"Anti_Con",0);
	 	dini_IntSet(file,"Anti_Ping",0);
	 	dini_IntSet(file,"Anti_Silah",0);
	 	dini_IntSet(file,"Anti_Jetpack",0);

	 	dini_IntSet(file,"Anti_Driveby",0);
	 	dini_IntSet(file,"Anti_Money",0);
	 	dini_IntSet(file,"Anti_God",0);
	 	dini_IntSet(file,"Anti_God_Car",0);
	 	dini_IntSet(file,"Anti_Spawn_Kill",0);
	 	dini_IntSet(file,"Anti_Spam",0);
	 	dini_IntSet(file,"Anti_Fall",0);
	 	dini_IntSet(file,"Anti_C_Bug",0);
	 	dini_IntSet(file,"Anti_Fake_Kill",0);
	 	dini_IntSet(file,"Anti_Rcon",0);
	 	dini_IntSet(file,"Anti_Airbreak",0);
	 	dini_IntSet(file,"Anti_Ip",0);
	 	dini_IntSet(file,"Anti_Skin",0);

	 	dini_IntSet(file,"Anti_Fly",0);
	 	dini_IntSet(file,"Anti_Sobeit",0);
 	 	dini_IntSet(file,"Anti_Motor",0);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",0);
 	 	dini_IntSet(file,"Anti_Command_Spammer",0);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",0);
 	 	dini_IntSet(file,"Anti_Server_Fucker",0);
 	 	dini_IntSet(file,"Anti_Dialog",0);
 	 	dini_IntSet(file,"Anti_Speed",0);

 	 	dini_IntSet(file,"Anti_Color_Spammer",0);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Tüm Ayarlar Baþarýyla Sýfýrlandý.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"All Settings Successfully Reset.");
        #endif
    }
    else
    {
 		SendClientMessage(playerid, 1, " ");
    }
	return 1;
}

dcmd_anticheatstatus(playerid, params[]) return dcmd_antihiledurum(playerid, params);

dcmd_antihiledurum(playerid, params[])
{
    #pragma unused params
	Anticheatstatus(playerid);
	return 1;
}

dcmd_anticheatopen(playerid, params[]) return dcmd_antihileac(playerid, params);

dcmd_antihileac(playerid, params[])
{
	new hileac[256],idx;

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hileac = strtok(params, idx);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hileac))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihileac (Sistemler)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Sistemler");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,silah,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,rcon,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(airbreak,ip,skin,afk,fly,sobeit,motor,aracteleport,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatopen (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Systems");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,weapon,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(rcon,airbreak,ip,skin,afk,fly,sobeit,moto,teleportvehicle,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#endif
		return 1;
    }
    else if(strcmp(hileac, "crasher", true) == 0) Antiopen(playerid,1,"Anti_Crasher","Anti Crasher","Anti Crasher");
    else if(strcmp(hileac, "con", true) == 0) Antiopen(playerid,2,"Anti_Con","Anti Con","Anti Con");
    else if(strcmp(hileac, "ping", true) == 0) Antiopen(playerid,3,"Anti_Ping","Anti Ping","Anti Ping");
    else if(strcmp(hileac, "silah", true) == 0 || strcmp(hileac, "weapon", true) == 0) Antiopen(playerid,4,"Anti_Silah","Anti Silah","Anti Weapon");
    else if(strcmp(hileac, "jetpack", true) == 0) Antiopen(playerid,5,"Anti_Jetpack","Anti Jetpack","Anti Jetpack");
    else if(strcmp(hileac, "bot", true) == 0) Antiopen(playerid,6,"Anti_Bot","Anti Bot","Anti Bot");
    else if(strcmp(hileac, "driveby", true) == 0) Antiopen(playerid,7,"Anti_Driveby","Anti Drive By","Anti Drive By");
    else if(strcmp(hileac, "money", true) == 0) Antiopen(playerid,8,"Anti_Money","Anti Money","Anti Money");
    else if(strcmp(hileac, "god", true) == 0) Antiopen(playerid,9,"Anti_God","Anti God","Anti God");
    else if(strcmp(hileac, "godcar", true) == 0) Antiopen(playerid,10,"Anti_God_Car","Anti God Car","Anti God Car");
    else if(strcmp(hileac, "spawnkill", true) == 0) Antiopen(playerid,11,"Anti_Spawn_Kill","Anti Spawn Kill","Anti Spawn Kill");
    else if(strcmp(hileac, "spam", true) == 0) Antiopen(playerid,12,"Anti_Spam","Anti Spam","Anti Spam");
    else if(strcmp(hileac, "fall", true) == 0) Antiopen(playerid,13,"Anti_Fall","Anti Fall","Anti Fall");
    else if(strcmp(hileac, "cbug", true) == 0) Antiopen(playerid,14,"Anti_C_Bug","Anti C Bug","Anti C Bug");
    else if(strcmp(hileac, "fakekill", true) == 0) Antiopen(playerid,15,"Anti_Fake_Kill","Anti Fake Kill","Anti Fake Kill");
    else if(strcmp(hileac, "rcon", true) == 0) Antiopen(playerid,16,"Anti_Rcon","Anti Rcon","Anti Rcon");
    else if(strcmp(hileac, "airbreak", true) == 0) Antiopen(playerid,17,"Anti_Airbreak","Anti Airbreak","Anti Airbreak");
    else if(strcmp(hileac, "ip", true) == 0) Antiopen(playerid,18,"Anti_Ip","Anti Ip","Anti Ip");
    else if(strcmp(hileac, "skin", true) == 0) Antiopen(playerid,19,"Anti_Skin","Anti Skin","Anti Skin");
    else if(strcmp(hileac, "fly", true) == 0) Antiopen(playerid,21,"Anti_Fly","Anti Fly","Anti Fly");
    else if(strcmp(hileac, "sobeit", true) == 0) Antiopen(playerid,22,"Anti_Sobeit","Anti Sobeit","Anti Sobeit");
    else if(strcmp(hileac, "motor", true) == 0 || strcmp(hileac, "moto", true) == 0) Antiopen(playerid,23,"Anti_Motor","Anti Motor Bug","Anti Moto Bug");
    else if(strcmp(hileac, "aracteleport", true) == 0 || strcmp(hileac, "teleportvehicle", true) == 0) Antiopen(playerid,24,"Anti_Teleport_Vehicle","Anti Araç Teleport","Anti Teleport Vehicle");
    else if(strcmp(hileac, "cmdspam", true) == 0) Antiopen(playerid,25,"Anti_Command_Spammer","Anti Command Spammer","Anti Command Spammer");
    else if(strcmp(hileac, "connectspam", true) == 0) Antiopen(playerid,26,"Anti_Connection_Spammer","Anti Connection Spammer","Anti Connection Spammer");
    else if(strcmp(hileac, "serverfuck", true) == 0) Antiopen(playerid,27,"Anti_Server_Fucker","Anti Server Fucker","Anti Server Fucker");
    else if(strcmp(hileac, "dialog", true) == 0) Antiopen(playerid,28,"Anti_Dialog","Anti Dialog","Anti Dialog");
    else if(strcmp(hileac, "speed", true) == 0) Antiopen(playerid,29,"Anti_Speed","Anti Speed","Anti Speed");;
    else if(strcmp(hileac, "colorspam", true) == 0) Antiopen(playerid,31,"Anti_Color_Spammer","Anti Color Spammer","Anti Color Spammer");
    else SendClientMessage(playerid, 1, " ");
	return 1;
}

dcmd_anticheatclose(playerid, params[]) return dcmd_antihilekapat(playerid, params);

dcmd_antihilekapat(playerid, params[])
{
	new hilekapat[256],idx;

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hilekapat = strtok(params, idx);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hilekapat))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihilekapat (Sistemler)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Sistemler");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,silah,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,rcon,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(airbreak,ip,skin,afk,fly,sobeit,motor,aracteleport,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatclose (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Systems");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,weapon,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(rcon,airbreak,ip,skin,afk,fly,sobeit,moto,teleportvehicle,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#endif
		return 1;
    }
    else if(strcmp(hilekapat, "crasher", true) == 0) Anticlose(playerid,1,"Anti_Crasher","Anti Crasher","Anti Crasher");
    else if(strcmp(hilekapat, "con", true) == 0) Anticlose(playerid,2,"Anti_Con","Anti Con","Anti Con");
    else if(strcmp(hilekapat, "ping", true) == 0) Anticlose(playerid,3,"Anti_Ping","Anti Ping","Anti Ping");
    else if(strcmp(hilekapat, "silah", true) == 0 || strcmp(hilekapat, "weapon", true) == 0) Anticlose(playerid,4,"Anti_Silah","Anti Silah","Anti Weapon");
    else if(strcmp(hilekapat, "jetpack", true) == 0) Anticlose(playerid,5,"Anti_Jetpack","Anti Jetpack","Anti Jetpack");
    else if(strcmp(hilekapat, "bot", true) == 0) Anticlose(playerid,6,"Anti_Bot","Anti Bot","Anti Bot");
    else if(strcmp(hilekapat, "driveby", true) == 0) Anticlose(playerid,7,"Anti_Driveby","Anti Drive By","Anti Drive By");
    else if(strcmp(hilekapat, "money", true) == 0) Anticlose(playerid,8,"Anti_Money","Anti Money","Anti Money");
    else if(strcmp(hilekapat, "god", true) == 0) Anticlose(playerid,9,"Anti_God","Anti God","Anti God");
    else if(strcmp(hilekapat, "godcar", true) == 0) Anticlose(playerid,10,"Anti_God_Car","Anti God Car","Anti God Car");
    else if(strcmp(hilekapat, "spawnkill", true) == 0) Anticlose(playerid,11,"Anti_Spawn_Kill","Anti Spawn Kill","Anti Spawn Kill");
    else if(strcmp(hilekapat, "spam", true) == 0) Anticlose(playerid,12,"Anti_Spam","Anti Spam","Anti Spam");
    else if(strcmp(hilekapat, "fall", true) == 0) Anticlose(playerid,13,"Anti_Fall","Anti Fall","Anti Fall");
    else if(strcmp(hilekapat, "cbug", true) == 0) Anticlose(playerid,14,"Anti_C_Bug","Anti C Bug","Anti C Bug");
    else if(strcmp(hilekapat, "fakekill", true) == 0) Anticlose(playerid,15,"Anti_Fake_Kill","Anti Fake Kill","Anti Fake Kill");
    else if(strcmp(hilekapat, "rcon", true) == 0) Anticlose(playerid,16,"Anti_Rcon","Anti Rcon","Anti Rcon");
    else if(strcmp(hilekapat, "airbreak", true) == 0) Anticlose(playerid,17,"Anti_Airbreak","Anti Airbreak","Anti Airbreak");
    else if(strcmp(hilekapat, "ip", true) == 0) Anticlose(playerid,18,"Anti_Ip","Anti Ip","Anti Ip");
    else if(strcmp(hilekapat, "skin", true) == 0) Anticlose(playerid,19,"Anti_Skin","Anti Skin","Anti Skin");
    else if(strcmp(hilekapat, "afk", true) == 0) Anticlose(playerid,20,"Anti_Afk","Anti Afk","Anti Afk");
    else if(strcmp(hilekapat, "fly", true) == 0) Anticlose(playerid,21,"Anti_Fly","Anti Fly","Anti Fly");
    else if(strcmp(hilekapat, "sobeit", true) == 0) Anticlose(playerid,22,"Anti_Sobeit","Anti Sobeit","Anti Sobeit");
    else if(strcmp(hilekapat, "motor", true) == 0 || strcmp(hilekapat, "moto", true) == 0) Anticlose(playerid,23,"Anti_Motor","Anti Motor Bug","Anti Moto Bug");
    else if(strcmp(hilekapat, "aracteleport", true) == 0 || strcmp(hilekapat, "teleportvehicle", true) == 0) Anticlose(playerid,24,"Anti_Teleport_Vehicle","Anti Araç Teleport","Anti Teleport Vehicle");
    else if(strcmp(hilekapat, "cmdspam", true) == 0) Anticlose(playerid,25,"Anti_Command_Spammer","Anti Command Spammer","Anti Command Spammer");
    else if(strcmp(hilekapat, "connectspam", true) == 0) Anticlose(playerid,26,"Anti_Connection_Spammer","Anti Connection Spammer","Anti Connection Spammer");
    else if(strcmp(hilekapat, "serverfuck", true) == 0) Anticlose(playerid,27,"Anti_Server_Fucker","Anti Server Fucker","Anti Server Fucker");
    else if(strcmp(hilekapat, "dialog", true) == 0) Anticlose(playerid,28,"Anti_Dialog","Anti Dialog","Anti Dialog");
    else if(strcmp(hilekapat, "speed", true) == 0) Anticlose(playerid,29,"Anti_Speed","Anti Speed","Anti Speed");
    else if(strcmp(hilekapat, "bunny", true) == 0) Anticlose(playerid,30,"Anti_Bunny_Hop","Anti Bunny Hop","Anti Bunny Hop");
    else if(strcmp(hilekapat, "colorspam", true) == 0) Anticlose(playerid,31,"Anti_Color_Spammer","Anti Color Spammer","Anti Color Spammer");
    else SendClientMessage(playerid, 1, " ");
	return 1;
}
#endif

public OnPlayerRequestClass(playerid, classid)
{
    if(ANTI_COLOR_SPAMMER == 1)
    {
	SetTimerEx("sorguSifirla", 5000, false, "i", playerid);
	if(reqSorgu{playerid} < 5)
	{
	reqSorgu{playerid} ++;
	}
	else {
	#if ISLEM_COLOR_SPAMMER == 1
		Banat("Color Spammer Hilesi","Color Spammer Hack");
	#elseif ISLEM_COLOR_SPAMMER == 2
		Kickat("Color Spammer Hilesi","Color Spammer Hack");
	#endif
	}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(ANTI_DRIVEBY == 1)
    {
	    if(newstate == PLAYER_STATE_DRIVER)
	    {
	        for (new i = 0; i<13; i++)
	        {
	                GetPlayerWeaponData(playerid, i, PlayerWeapon[playerid][i], PlayerAmmo[playerid][i]);
	        }
	        ResetPlayerWeapons(playerid);
	    }
	    if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	    {
	        for(new i=0;i<13;i++)
	        {
	                GivePlayerWeapon(playerid,PlayerWeapon[playerid][i],PlayerAmmo[playerid][i]);
	        }
	    }
	}
	
    if(ANTI_FALL == 1)
    {
		if(Act[playerid] == 1)
		{
			if(oldstate == PLAYER_STATE_DRIVER)
			{
				if(newstate == PLAYER_STATE_ONFOOT)
				{
					if(InCar[playerid] == 1)
					{
						PutPlayerInVehicle(playerid, WhatCar[playerid], Driver);
					}
				}
			}
			if(oldstate == PLAYER_STATE_PASSENGER)
			{
				if(newstate == PLAYER_STATE_ONFOOT)
				{
					if(InCar[playerid] == 1)
					{
						PutPlayerInVehicle(playerid, WhatCar[playerid], Passanger);
					}
				}
			}
			if(oldstate == PLAYER_STATE_ONFOOT)
			{
				if(newstate == PLAYER_STATE_DRIVER || PLAYER_STATE_PASSENGER)
				{
					InCar[playerid] = 1;
					WhatCar[playerid] = GetPlayerVehicleID(playerid);
				}
			}
		}
	}
    if(ANTI_TELEPORT_VEHICLE == 1)
    {
        if(newstate == PLAYER_STATE_DRIVER)
        {
                LastCar[playerid]=GetPlayerVehicleID(playerid);
        }
        else if(oldstate == PLAYER_STATE_DRIVER)
        {
                new lastveh = LastCar[playerid];
                GetVehiclePos(lastveh,OldVehiclePos[lastveh][0],OldVehiclePos[lastveh][1],OldVehiclePos[lastveh][2]);
                GetVehicleZAngle(lastveh,OldVehiclePos[lastveh][3]);
        }
    }
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(ANTI_C_BUG == 1)
    {
	    if(newkeys  & KEY_FIRE && oldkeys & KEY_CROUCH &&  IsCbugWeapon(playerid))
	    {
	    P_CBUG_TICKS[playerid] ++;

	    if(P_CBUG_TICKS[playerid] > C_BUG_TIME)
	    {
	    P_CBUG_TICKS[playerid] = playerid;
	    new DerPlayer[MAX_PLAYER_NAME];
	    GetPlayerName(P_CBUG_TICKS[playerid],DerPlayer,sizeof(DerPlayer));
	    P_CBUG_TICKS[playerid] = 0;
		#if ISLEM_C_BUG == 1
	       Banat("C Bug Hilesi","C Bug Hack");
		#elseif ISLEM_C_BUG == 2
	       Kickat("C Bug Hilesi","C Bug Hack");
		#endif
	    }
	    }
    }
    if(ANTI_BUNNY_HOP == 1)
    {
    if ((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP))
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            SetTimer("Bunny_Hop", 3000, false);
            BH[playerid] += 1;
            if(BH[playerid] == 2) return Slap(playerid);
		}
	}
	}
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	for(new rsr; rsr<MAX_PLAYERS; rsr++)
	{
	    if(ANTI_RCON == 1)
	    {
		    if(!success)
		    {
		        printf("Anti Hile: Hatali Rcon Sifresi Girdi. IP: %s. Sifre: %s",ip, password);
		        new pla[16];
		        for(new i=0; i<MAX_PLAYERS; i++)
		        {
		            GetPlayerIp(i, pla, sizeof(pla));
		            if(!strcmp(ip, pla, true))
		            {
		                #if LANGUAGE == 0
		                SendClientMessage(i, 0xFF4500AA, "{007FFF}(({C3C3C3} *** Anti Hile *** {FFFFFF}Hatalý Rcon Giriþi! {007FFF}))");
		                #elseif LANGUAGE == 1
		                SendClientMessage(i, 0xFF4500AA, "{007FFF}(({C3C3C3} *** Anti Cheat *** {FFFFFF}Wrong Rcon Login! {007FFF}))");
		                #endif
		                #if ISLEM_RCON == 1
		                   Banat("Rcon Hilesi","Rcon Hack");
		                #elseif ISLEM_RCON == 2
		                   Kickat("Rcon Hilesi","Rcon Hack");
		                #endif
		            }
		        }
		    }
		}
	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
    if(ANTI_GOD == 1)
    {
		new Float:can;
		GetPlayerHealth(playerid,can);
	    if(can>=101 && !IsPlayerAdmin(playerid))
		{
	    if(ANTI_SPAWN_KILL == 1)
	    {
		if(antispawnkill[playerid] != 0) { return 0;}
		}
		#if ISLEM_GOD == 1
	       Banat("God Hilesi","God Hack");
		#elseif ISLEM_GOD == 2
	       Kickat("God Hilesi","God Hack");
		#endif
		}
	}
	
    if(ANTI_GOD_CAR == 1)
    {
		new araci,Float:acan;
		araci = GetPlayerVehicleID(playerid);
		GetVehicleHealth(araci, acan);
		if(acan >=1001 && !IsPlayerAdmin(playerid))
		{
		#if ISLEM_GOD_CAR == 1
	        Banat("God Car Hilesi","God Car Hack");
		#elseif ISLEM_GOD_CAR == 2
	        Kickat("God Car Hilesi","God Car Hack");
		#endif
		}
	}
	
    if(ANTI_SILAH == 1)
    {
		new weap = GetPlayerWeapon(playerid);
		if(weap == 36)
		{
		#if ISLEM_SILAH == 1
	        Banat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 2
	        Kickat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 3
	        ResetPlayerWeapons(playerid);
		#endif
		}
	    if(weap == 38)
		{
		#if ISLEM_SILAH == 1
	        Banat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 2
	        Kickat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 3
	        ResetPlayerWeapons(playerid);
		#endif
	 	}
		if(weap == 39)
	 	{
		#if ISLEM_SILAH == 1
	        Banat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 2
	        Kickat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 3
	        ResetPlayerWeapons(playerid);
		#endif
		}
		if(weap == 40)
		{
		#if ISLEM_SILAH == 1
	        Banat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 2
	        Kickat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 3
	        ResetPlayerWeapons(playerid);
		#endif
		}
		if(weap == 45)
	    {
		#if ISLEM_SILAH == 1
	        Banat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 2
	        Kickat("Silah Hilesi","Weapon Hack");
		#elseif ISLEM_SILAH == 3
	        ResetPlayerWeapons(playerid);
		#endif
		}
	}
	
    if(ANTI_JETPACK == 1)
    {
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	    {
		#if ISLEM_JETPACK == 1
	        Banat("Jetpack Hilesi","Jetpack Hack");
		#elseif ISLEM_JETPACK == 2
	        Kickat("Jetpack Hilesi","Jetpack Hack");
		#elseif ISLEM_JETPACK == 3
	        ResetPlayerWeapons(playerid);
		#endif
	    }
    }
    
    if(ANTI_SKIN == 1)
    {
		if(GetPlayerSkin(playerid) >= 300) {
		#if ISLEM_SKIN == 1
	        Banat("Skin Hilesi","Skin Hack");
		#elseif ISLEM_SKIN == 2
	        Kickat("Skin Hilesi","Skin Hack");
		#elseif ISLEM_SKIN == 3
	    	SetPlayerSkin(playerid, 0);
		#endif
		return 1;
		}
		if(GetPlayerSkin(playerid) < 0) {
		#if ISLEM_SKIN == 1
	        Banat("Skin Hilesi","Skin Hack");
		#elseif ISLEM_SKIN == 2
	        Kickat("Skin Hilesi","Skin Hack");
		#elseif ISLEM_SKIN == 3
	    	SetPlayerSkin(playerid, 0);
		#endif
		return 1;
		}
	}
	
    if(ANTI_FLY == 1)
    {
	    if(GetPlayerAnimationIndex(playerid))
		{
		new animlib[32];
		new animname[32];
		GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
		if(strcmp(animlib, "SWIM", true) == 0)
		{
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,X,Y,Z);
		if(Z >= 8.45)
		{
		if(!IsPlayerInRangeOfPoint(playerid,37.85,1964.0404,-1199.6774,17.4400))
		{
		dives[playerid] = 1;
		}
		}
		}
		GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
		if(strcmp(animname, "FALL_FALL", true) == 0)
		{
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,X,Y,Z);
		SetPVarFloat(playerid,"Float",Z);
		SetTimer("Checkhim",1200,false);
		}
		}
	    new index = GetPlayerAnimationIndex(playerid);
		if(index >= 958 && index <= 962)
	    {
	    if(GetPlayerWeapon(playerid) != 46)
	    {
		dives[playerid] = 1;
	    }
	    }
	    if(dives[playerid] == 1)
		{
		#if ISLEM_FLY == 1
	        Banat("Ucma Hilesi","Fly Hack");
		#elseif ISLEM_FLY == 2
	        Kickat("Ucma Hilesi","Fly Hack");
		#endif
	    }
    }
    
    if(ANTI_AIRBREAK == 1)
    {
    if((GetPlayerSurfingVehicleID(playerid)!=INVALID_VEHICLE_ID || GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (GetPlayerSpeedXY(playerid) > MAX_SPEED_VEHICLE)) {
	#if ISLEM_AIRBREAK == 1
		Banat("Airbreak Hilesi","Airbreak Hack");
	#elseif ISLEM_AIRBREAK == 2
		Kickat("Airbreak Hilesi","Airbreak Hack");
	#endif
    return 1;
    }
    }
    
    if(ANTI_SPEED == 1)
    {
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
    if(GetPlayerVehicleID(playerid) != 578 || GetPlayerVehicleID(playerid) != 520 || GetPlayerVehicleID(playerid) != 578)
    {
    if(GetVehicleSpeed(GetPlayerVehicleID(playerid), 0) > 250)
    {
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(playerid, x, y, z+5);
	#if ISLEM_SPEED == 1
		Banat("Hiz Hilesi","Speed Hack");
	#elseif ISLEM_SPEED == 2
		Kickat("Hiz Hilesi","Speed Hack");
	#endif
    return 1;
    }
    }
    }
    }
    
    if(AFK[playerid] > 3)
    {
    DeletePlayer3DTextLabel(playerid, PlayerText3D:labelafk[playerid]);
    Delete3DTextLabel(labelafk[playerid]);
    }
    AFK[playerid] = 0;
	return 1;
}

public PingKontrol(playerid)
{
    if(ANTI_PING == 1)
    {
		new str[50],str2[50];
	    if(GetPlayerPing(playerid) > MAX_PING){
		#if ISLEM_PING == 1
			format(str,sizeof(str),"%d/Mak.%d Yüksek Ping",GetPlayerPing(playerid),MAX_PING);
			format(str2,sizeof(str2),"%d/Max.%d High Ping",GetPlayerPing(playerid),MAX_PING);
			Banat(str,str2);
		#elseif ISLEM_PING == 2
			format(str,sizeof(str),"%d/Mak.%d Yüksek Ping",GetPlayerPing(playerid),MAX_PING);
			format(str2,sizeof(str2),"%d/Max.%d High Ping",GetPlayerPing(playerid),MAX_PING);
			Kickat(str,str2);
		#endif
		}
    }
    return 1;
}

#if MYSQL_KAYIT == true
stock MySQLBaqlan()
{
    SQLL = mysql_connect("localhost", "root", "Antihile", "");
    if(mysql_ping(SQLL) == 1)
    {
    	printf("Anti Hile: MySQL Servere Basariyla Baglandi! | ");
    }
    else
	{
	    printf("Anti Hile: MySQL Server'e Baglanamadi! | Kapaniyor...");
	    SendRconCommand("exit");
	}
    return 1;
}
#endif

stock KickLog(string[])
{
	#if MYSQL_KAYIT == true
	new Date[16], year, month, day;
	getdate(year, month, day);
	format(Date, sizeof(Date), "%d/%d/%d", day, month, year);
	new query[256];
	mysql_real_escape_string(string, string);
    format(query, sizeof(query), "UPDATE `"#MYSQL_TABLE"` SET `Status` = 2, `KickReason` = '%s', `KickDate` = '%s'", string, Date);

	if(mysql_ping(SQLL))
	{
		mysql_query(query, KICKLE, 0, SQLL);
	}
	#elseif NORMAL_KAYIT == true
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("Anti_Hile/kick.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
	#endif
	return 1;
}

stock BanLog(string[])
{
	#if MYSQL_KAYIT == true
	new Date[16], year, month, day;
	getdate(year, month, day);
	format(Date, sizeof(Date), "%d/%d/%d", day, month, year);
	new query[256];
	mysql_real_escape_string(string, string);
    format(query, sizeof(query), "UPDATE `"#MYSQL_TABLE2"` SET `Status` = 2, `BanReason` = '%s', `BanDate` = '%s'", string, Date);
	if(mysql_ping(SQLL))
	{
		mysql_query(query, BANLA, 0, SQLL);
	}
	#elseif NORMAL_KAYIT == true
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("Anti_Hile/ban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
	#endif
	return 1;
}

stock CountIP(ip[])
{
        new c = 0;
        for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !strcmp(GetIP(i),ip)) c++;
        return c;
}

public BSS(playerid)
{
        new i = GetPlayerPing(playerid);
        if(i <= 0 || i >= 50000)
        {
                if(warns[playerid] >= 1) BanAll(playerid);
                else warns[playerid]++, var[playerid] = SetTimerEx("BSS",1500,false,"i",playerid);
        }
        return 0;
}

stock GetIP(playerid)
{
        new ip[16];
        GetPlayerIp(playerid,ip,sizeof(ip));
        return ip;
}

stock BanAll(playerid)
{
        new ip[32];
        GetPlayerIp(playerid,ip,sizeof(ip));
        for(new i = 0, p = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !npc[i])
        {
                p = GetPlayerPing(i);
                if(i == playerid || !strcmp(ip,GetIP(i)) || p <= 0 || p >= 50000)
                {
                        BanEx(i,"Bot");
                        if(var[i] != -1)
                        {
                                KillTimer(var[i]);
                                var[i] = -1;
                        }
                }
        }
        format(ip,sizeof(ip),"banip %s",ip);
        return SendRconCommand(ip);
}

stock GetHighestID(exceptof = INVALID_PLAYER_ID)
{
        new h = 0;
        for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i != exceptof && i > h) h = i;
        return h;
}

stock iswheelmodel(modelid) {

    new wheelmodels[17] = {1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};

    for(new I = 0, b = sizeof(wheelmodels); I != b; ++I) {
        if (modelid == wheelmodels[I])
            return true;

    }

    return false;
}

stock IllegalCarNitroIde(carmodel) {

    new illegalvehs[29] = { 581, 523, 462, 521, 463, 522, 461, 448, 468, 586, 509, 481, 510, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 569, 537, 538, 570, 449 };

    for(new I = 0, b = sizeof(illegalvehs); I != b; ++I) {

        if (carmodel == illegalvehs[I])
            return true;

    }

    return false;
}

stock illegal_nos_vehicle(PlayerID) {

    new carid = GetPlayerVehicleID(PlayerID);
    new playercarmodel = GetVehicleModel(carid);

    return IllegalCarNitroIde(playercarmodel);

}

stock islegalcarmod(vehicleide, componentid) {

    new modok = false;
    if ( (iswheelmodel(componentid)) || (componentid == 1086) || (componentid == 1087) || ((componentid >= 1008) && (componentid <= 1010))) {

        new nosblocker = IllegalCarNitroIde(vehicleide);

        if (!nosblocker)
            modok = true;

    } else {

        for(new I = 0, b = sizeof(legalmods); I != b; ++I) {

            if (legalmods[I][0] == vehicleide) {

                for(new J = 1; J < 22; J++) {
                    if (legalmods[I][J] == componentid)
                        modok = true;
                }

            }

        }

    }

    return modok;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    if(ANTI_CRASHER == 1)
    {
	    new vehicleide = GetVehicleModel(vehicleid);
	    new modok = islegalcarmod(vehicleide, componentid);
	    new Name[24];

	    if (!modok) {
	        printf("[invalid_mod] %s %d %d %d %d %d", Name, playerid, vehicleid, vehicleide, componentid);
		#if ISLEM_CRASHER == 1
			Banat("Crash Hilesi","Crash Hack");
		#elseif ISLEM_CRASHER == 2
			Kickat("Crash Hilesi","Crash Hack");
		#endif
	    switch(componentid)
		{
		    case 1008..1010: if(IsPlayerInInvalidNosVehicle(playerid)) RemoveVehicleComponent(vehicleid, componentid);
		}
		if(!IsComponentidCompatible(GetVehicleModel(vehicleid), componentid)) RemoveVehicleComponent(vehicleid, componentid);
	    }
    }
    return 1;
}

stock YerelIP(ip[])
{
    new c = 0;
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !strcmp(IpH(i),ip)) c++;
    return c;
}

public DBT(playerid)
{
    new i = GetPlayerPing(playerid);
    if(i <= 0 || i >= 50000)
    {
    if(uyarilar[playerid] >= 1) YasakH(playerid);
    else uyarilar[playerid]++, var[playerid] = SetTimerEx("DBT",1500,false,"i",playerid);
    }
    return 0;
}

stock IpH(playerid)
{
    new ip[16];
    GetPlayerIp(playerid,ip,sizeof(ip));
    return ip;
}

stock YasakH(playerid)
{
    new ip[32];
    GetPlayerIp(playerid,ip,sizeof(ip));
    for(new i = 0, p = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !npc[i])
    {
        p = GetPlayerPing(i);
        if(i == playerid || !strcmp(ip,IpH(i)) || p <= 0 || p >= 50000)
        {
        #if ISLEM_BOT == 1
   	       Banat("Bot Hilesi","Bot Hack");
        #elseif ISLEM_BOT == 2
   	       Kickat("Bot Hilesi","Bot Hack");
        #endif
        if(var[i] != -1)
        {
        KillTimer(var[i]);
        var[i] = -1;
     }
   }
}
    format(ip,sizeof(ip),"IpBan %s",ip);
    return SendRconCommand(ip);
}

stock MaksID(exceptof = INVALID_PLAYER_ID)
{
    new h = 0;
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i != exceptof && i > h) h = i;
    return h;
}

stock SetPlayerPosition(pid,Float:X,Float:Y,Float:Z)
{
	savetp[pid] = 1;
	SetPlayerPos(pid,X,Y,Z);
	KillTimer(timer[pid]);
	timer[pid] = SetTimer("remtp",15000,false);
}

public remtp(playerid)
{
	savetp[playerid] = 0;
	return 1;
}

public Checkhim(playerid)
{
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	if(Z > GetPVarFloat(playerid,"Float"))
	{
	if(savetp[playerid] != 1)
	{
	dives[playerid] = 1;
	}
	}
	return 1;
}

public CheckAFK(playerid)
{
    for(new i = 0; i != MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;

        AFK[i] ++;
        if(AFK[i] == 3)
        {
           labelafk[playerid] = Create3DTextLabel("<< AFK >>",0xFFFF00AA,0.0, 0.0, 0.0, 40.0, 0,0);
           Attach3DTextLabelToPlayer(labelafk[playerid], playerid, 0.0, 0.0, 0.0);
           SetTimerEx("AutoKick", 300000, 0, "i", playerid);
        }
    }
}

public AutoKick(playerid)
{
	#if ISLEM_AFK == 1
       Banat("Afk","Afk");
	#elseif ISLEM_AFK == 2
       Kickat("Afk","Afk");
	#endif
	return 1;
}

public HackCheck(playerid)
{
	new Float:x, Float:y, Float:z, pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	GetPlayerCameraFrontVector(playerid, x, y, z);
	#pragma unused x
	#pragma unused y
	if(z < -0.8)
	{
	#if ISLEM_SOBEIT == 1
        Banat("Sobeit Hilesi","Sobeit Hack");
	#elseif ISLEM_SOBEIT == 2
        Kickat("Sobeit Hilesi","Sobeit Hack");
	#endif
	}
	else
	{
	    TogglePlayerControllable(playerid, 1);
	}
	return 1;
}

stock Textdrawyazi(playerid, const text[])
{
for(new line; line < 5; line++)
{
TextDrawShowForPlayer(playerid, olaylar[line]);
}
for(new line; line < 5; line++)
{
TextDrawHideForAll(olaylar[line]);
if(line < 4)
{
yazideger[line] = yazideger[line+1];
TextDrawSetString(olaylar[line], yazideger[line]);
}
}
format(yazideger[4], 128, "%s",text);
TextDrawSetString(olaylar[4], yazideger[4]);
for(new line; line < 5; line++)
{
TextDrawShowForAll(olaylar[line]);
}
KillTimer(EVT);
EVT = SetTimerEx("mesajsil", 3500, false,"i",0);
return 1;
}

public mesajsil(i)
{
format(yazideger[(i) < (5) ? i+1 : 0], 150, "");
TextDrawSetString(olaylar[4],"");
if(i != 5)EVT = SetTimerEx("mesajsil", 3500, false,"i",i+1);
}

stock spamProtect(playerid, const szSpam[], iTime) {
	static
		s_szPVar[32],
		s_iPVar
	;
	format(s_szPVar, sizeof(s_szPVar), "pv_iSpam_%s", szSpam);

	s_iPVar = GetPVarInt(playerid, s_szPVar);

	if((GetTickCount() - s_iPVar) < iTime * 1000) {
		return 0;
	} else {
		SetPVarInt(playerid, s_szPVar, GetTickCount());
	}
	return 1;
}

stock IsCbugWeapon(playerid)
{
	new weaponID  = GetPlayerWeapon(playerid);

	if(weaponID == 22 || weaponID ==  24 || weaponID == 25 || weaponID == 27)
	{
	return 1;
	}
	return 0;
}

stock IsPlayerInInvalidNosVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	#define MAX_INVALID_NOS_VEHICLES 52
	new InvalidNosVehicles[MAX_INVALID_NOS_VEHICLES] =
	{
		581,523,462,521,463,522,461,448,468,586,417,425,469,487,512,520,563,593,
		509,481,510,472,473,493,520,595,484,430,453,432,476,497,513,533,577,
		452,446,447,454,590,569,537,538,570,449,519,460,488,511,519,548,592
	};
 	if(IsPlayerInAnyVehicle(playerid))
  	{
   		for(new i = 0; i < MAX_INVALID_NOS_VEHICLES; i++)
     	{
      		if(GetVehicleModel(vehicleid) == InvalidNosVehicles[i]) return true;
       	}
   	}
   	return false;
}

stock IsComponentidCompatible(modelid, componentid)
{
    if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 ||
         componentid == 1077 || componentid == 1078 || componentid == 1079 || componentid == 1080 || componentid == 1081 ||
         componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
         componentid == 1097 || componentid == 1098 || componentid == 1087 || componentid == 1086)
         return true;

    switch (modelid)
    {
        case 400: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 401: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 114 || componentid == 1020 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 402: return (componentid == 1009 || componentid == 1009 || componentid == 1010);
        case 404: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 405: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1023 || componentid == 1000);
        case 409: return (componentid == 1009);
        case 410: return (componentid == 1019 || componentid == 1021 || componentid == 1020 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 411: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 412: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 415: return (componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 418: return (componentid == 1020 || componentid == 1021 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016);
        case 419: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 420: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1003);
        case 421: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1016 || componentid == 1000);
        case 422: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007);
        case 426: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003);
        case 429: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 436: return (componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 438: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 439: return (componentid == 1003 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1013);
        case 442: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 445: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 451: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 458: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 466: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 467: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 474: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 475: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 477: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 478: return (componentid == 1005 || componentid == 1004 || componentid == 1012 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 479: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 480: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 489: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016 || componentid == 1000);
        case 491: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 492: return (componentid == 1005 || componentid == 1004 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1016 || componentid == 1000);
        case 496: return (componentid == 1006 || componentid == 1017 || componentid == 1007 || componentid == 1011 || componentid == 1019 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1003 || componentid == 1002 || componentid == 1142 || componentid == 1143 || componentid == 1020);
        case 500: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 506: return (componentid == 1009);
        case 507: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 516: return (componentid == 1004 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1015 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 517: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 518: return (componentid == 1005 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 526: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 527: return (componentid == 1021 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1015 || componentid == 1017 || componentid == 1007);
        case 529: return (componentid == 1012 || componentid == 1011 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 533: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 534: return (componentid == 1126 || componentid == 1127 || componentid == 1179 || componentid == 1185 || componentid == 1100 || componentid == 1123 || componentid == 1125 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1180 || componentid == 1178 || componentid == 1101 || componentid == 1122 || componentid == 1124 || componentid == 1106);
        case 535: return (componentid == 1109 || componentid == 1110 || componentid == 1113 || componentid == 1114 || componentid == 1115 || componentid == 1116 || componentid == 1117 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1120 || componentid == 1118 || componentid == 1121 || componentid == 1119);
        case 536: return (componentid == 1104 || componentid == 1105 || componentid == 1182 || componentid == 1181 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1184 || componentid == 1183 || componentid == 1128 || componentid == 1103 || componentid == 1107 || componentid == 1108);
        case 540: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 541: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 542: return (componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1015);
        case 545: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 546: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 547: return (componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1016 || componentid == 1003 || componentid == 1000);
        case 549: return (componentid == 1012 || componentid == 1011 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 550: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003);
        case 551: return (componentid == 1005 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003);
        case 555: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 558: return (componentid == 1092 || componentid == 1089 || componentid == 1166 || componentid == 1165 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1168 || componentid == 1167 || componentid == 1088 || componentid == 1091 || componentid == 1164 || componentid == 1163 || componentid == 1094 || componentid == 1090 || componentid == 1095 || componentid == 1093);
        case 559: return (componentid == 1065 || componentid == 1066 || componentid == 1160 || componentid == 1173 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1159 || componentid == 1161 || componentid == 1162 || componentid == 1158 || componentid == 1067 || componentid == 1068 || componentid == 1071 || componentid == 1069 || componentid == 1072 || componentid == 1070 || componentid == 1009);
        case 560: return (componentid == 1028 || componentid == 1029 || componentid == 1169 || componentid == 1170 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1141 || componentid == 1140 || componentid == 1032 || componentid == 1033 || componentid == 1138 || componentid == 1139 || componentid == 1027 || componentid == 1026 || componentid == 1030 || componentid == 1031);
        case 561: return (componentid == 1064 || componentid == 1059 || componentid == 1155 || componentid == 1157 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1154 || componentid == 1156 || componentid == 1055 || componentid == 1061 || componentid == 1058 || componentid == 1060 || componentid == 1062 || componentid == 1056 || componentid == 1063 || componentid == 1057);
        case 562: return (componentid == 1034 || componentid == 1037 || componentid == 1171 || componentid == 1172 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1149 || componentid == 1148 || componentid == 1038 || componentid == 1035 || componentid == 1147 || componentid == 1146 || componentid == 1040 || componentid == 1036 || componentid == 1041 || componentid == 1039);
        case 565: return (componentid == 1046 || componentid == 1045 || componentid == 1153 || componentid == 1152 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1150 || componentid == 1151 || componentid == 1054 || componentid == 1053 || componentid == 1049 || componentid == 1050 || componentid == 1051 || componentid == 1047 || componentid == 1052 || componentid == 1048);
        case 566: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 567: return (componentid == 1129 || componentid == 1132 || componentid == 1189 || componentid == 1188 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1187 || componentid == 1186 || componentid == 1130 || componentid == 1131 || componentid == 1102 || componentid == 1133);
        case 575: return (componentid == 1044 || componentid == 1043 || componentid == 1174 || componentid == 1175 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1176 || componentid == 1177 || componentid == 1099 || componentid == 1042);
        case 576: return (componentid == 1136 || componentid == 1135 || componentid == 1191 || componentid == 1190 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1192 || componentid == 1193 || componentid == 1137 || componentid == 1134);
        case 579: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 580: return (componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 585: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 587: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 589: return (componentid == 1005 || componentid == 1004 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1024 || componentid == 1013 || componentid == 1006 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 600: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1022 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 602: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 603: return (componentid == 1144 || componentid == 1145 || componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
    }
    return false;
}

public AntiSpawnkill(playerid)
{
	if(ANTI_SPAWN_KILL == 1)
	{
	    DestroyDynamic3DTextLabel(Spawnkill[playerid]);
	    SetPlayerHealth(playerid, 100.0);
	    #if LANGUAGE == 0
	    SendClientMessage(playerid, 0xFF0000AA, "{C8C8C8}» {F63A00}' Anti-Spawnkill ' {FFFFFF}Korumasý Bitti.");
	    #elseif LANGUAGE == 1
	    SendClientMessage(playerid, 0xFF0000AA, "{C8C8C8}» {F63A00}' Anti-Spawnkill ' {FFFFFF}Protection Ended.");
	    #endif
	    antispawnkill[playerid] = 0;
    }
	return 1;
}

stock Float:GetDistanceBetweenPoints(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2)
{
        return floatsqroot(floatpower(floatabs(floatsub(x2,x)),2)+floatpower(floatabs(floatsub(y2,y)),2)+floatpower(floatabs(floatsub(z2,z)),2));
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat)
{
        new Float:vpos_x, Float:vpos_y, Float:vpos_z, Float:vpos_a;
        GetVehiclePos(vehicleid, vpos_x, vpos_y, vpos_z); GetVehicleZAngle(vehicleid,vpos_a);
        if(OldVehiclePos[vehicleid][0] != 0.0 && OldVehiclePos[vehicleid][1] != 0.0 && OldVehiclePos[vehicleid][2] != 0.0 && OldVehiclePos[vehicleid][3] != 0.0)
        {
                new Float:vehicledistance = GetDistanceBetweenPoints(vpos_x, vpos_y, vpos_z, OldVehiclePos[vehicleid][0], OldVehiclePos[vehicleid][1], OldVehiclePos[vehicleid][2]);
                if(vehicledistance > 15.0)
                {
                        SetVehiclePos(vehicleid, OldVehiclePos[vehicleid][0], OldVehiclePos[vehicleid][1], OldVehiclePos[vehicleid][2]);
                        SetVehicleZAngle(vehicleid,OldVehiclePos[vehicleid][3]);
                        return;
                }
        }
        OldVehiclePos[vehicleid][0]=vpos_x;
        OldVehiclePos[vehicleid][1]=vpos_y;
        OldVehiclePos[vehicleid][2]=vpos_z;
        OldVehiclePos[vehicleid][3]=vpos_a;
}

stock flooding(playerid){
    if(timespawn[playerid][0] + 100 > GetTickCount())
        timespawn[playerid][1] ++;
    else timespawn[playerid][1] = 0;
    if(timespawn[playerid][1] > 3) return Kick(playerid);
    timespawn[playerid][0] = GetTickCount();
    return 1;
}

public globaltimer() {
for(new i=0; i<MAX_PLAYERS; i++) {
if(IsPlayerConnected(i)) {
if(oft[i]>=1) { oft[i]--; }}}
}

stock Girisbilgi(playerid)
{
    new string[1024],string2[1024];
    #if LANGUAGE == 0
    format(string,sizeof(string),"{C3C3C3}*** {FFFFFF}Bu Server Anti Hile Sistemi v%s Tarafýndan Korunmaktadýr. {C3C3C3}***",VERSIYON);
    format(string2,sizeof(string2),"{C3C3C3}*** {FFFFFF}Anti Hile Sistemi v%s Hakkýnda Bilgi Almak Ýçin /antihile Yazabilirsiniz. {C3C3C3}***",VERSIYON);
    SendClientMessageToAll(0xFFFFFAA,string);
    SendClientMessageToAll(0xFFFFFAA,string2);
    #elseif LANGUAGE == 1
    format(string,sizeof(string),"{C3C3C3}*** {FFFFFF}This Server Is Protected By Anti Cheat System v%s. {C3C3C3}***",VERSIYON);
    format(string2,sizeof(string2),"{C3C3C3}*** {FFFFFF}For Information About Anti Cheat System v%s /anticheat You Can Write. {C3C3C3}***",VERSIYON);
    SendClientMessageToAll(0xFFFFFAA,string);
    SendClientMessageToAll(0xFFFFFAA,string2);
    #endif

	if(ANTI_CON == 1)
	{
	new oadi[MAX_PLAYER_NAME];
	GetPlayerName(playerid,oadi,sizeof(oadi));

	for(new i=0; i<sizeof(Karaliste); i++)
	{
		if(!strcmp(oadi,Karaliste[i][0],true))
		{
				#if ISLEM_CON == 1
					Banat("Con Hilesi","Con Hack");
				#elseif ISLEM_CON == 2
					Kickat("Con Hilesi","Con Hack");
				#endif
		}
	}
	}

	if(ANTI_BOT == 1)
	{
	    if(YerelIP(IpH(playerid)) >= 6) return YasakH(playerid), 0;
	    MAKS_OYUNCU_= playerid > MAKS_OYUNCU_? playerid : MaksID(),
	    npc[playerid] = bool:IsPlayerNPC(playerid),
	    var[playerid] = SetTimerEx("DBT",2500,false,"i",playerid),
	    uyarilar[playerid] = 0;
	}
	dives[playerid] = 0;
    Act[playerid] = 1;

	if(ANTI_SPAWN_KILL == 1) antispawnkill[playerid] = 1;
	return 1;
}

stock PlayerName(playerid)
{
    new string[24];
    GetPlayerName(playerid,string,24);
    return string;
}

stock IsBike(vehicleid)
{
	new vaZ = GetVehicleModel(vehicleid);
	switch(vaZ)
	{
	    case 581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586: return true;
	}
	return false;
}

stock MySQLOlusturulmusMu(Name[])
{
	new Query[100];
	format(Query, sizeof(Query), "SELECT * FROM Antihile WHERE name = '%s';", Name);
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows()) return 1;
	return 0;
}

stock MySQLolustur(playerid)
{
	new Query[ 1024 ];
	format(Query, sizeof(Query), "INSERT INTO `Antihile` (`Anti_Crasher`, `Anti_Con`, `Anti_Ping`, `Anti_Silah`, `Anti_Jetpack`, \
	`Anti_Bot`, `Anti_Driveby`, `Anti_Money`, `Anti_God`, `Anti_God_Car`, `Anti_Spawn_Kill`, `Anti_Spam`, `Anti_Fall`, `Anti_C_Bug`, \
	`Anti_Fake_Kill`, `Anti_Rcon`, `Anti_Airbreak`, `Anti_Ip`, `Anti_Skin`, `Anti_Afk`, `Anti_Fly`, `Anti_Sobeit`, `Anti_Motor`, \
	`Anti_Teleport_Vehicle`, `Anti_Command_Spammer`, `Anti_Connection_Spammer`, `Anti_Server_Fucker`, `Anti_Dialog`, `Anti_Speed`, \
	`Anti_Bunny_Hop``, `Anti_Color_Spammer`) \
	VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
	ANTI_CRASHER,
	ANTI_CON,
	ANTI_PING,
	ANTI_SILAH,
	ANTI_JETPACK,
	ANTI_BOT,
	ANTI_DRIVEBY,
	ANTI_MONEY,
	ANTI_GOD,
	ANTI_GOD_CAR,
	ANTI_SPAWN_KILL,
	ANTI_SPAM,
	ANTI_FALL,
	ANTI_C_BUG,
	ANTI_FAKE_KILL,
	ANTI_RCON,
	ANTI_AIRBREAK,
	ANTI_IP,
	ANTI_SKIN,
	ANTI_AFK,
	ANTI_FLY,
	ANTI_SOBEIT,
	ANTI_MOTOR,
    ANTI_TELEPORT_VEHICLE,
	ANTI_COMMAND_SPAMMER,
	ANTI_CONNECTION_SPAMMER,
	ANTI_SERVER_FUCKER,
	ANTI_DIALOG,
	ANTI_SPEED,
	ANTI_BUNNY_HOP,
	ANTI_COLOR_SPAMMER);
	mysql_query(Query);
}

stock MySQLguncelle()
{
	new Query[ 1024 ];
	format(Query, sizeof(Query), "UPDATE `Antihile` SET `Anti_Crasher` = '%s', `Anti_Con` = '%s', `Anti_Ping` = '%s', `Anti_Silah` = '%s', `Anti_Jetpack` = '%s', \
	`Anti_Bot` = '%s', `Anti_Driveby` = '%s', `Anti_Money` = '%s', `Anti_God` = '%s', `Anti_God_Car` = '%s')",
	ANTI_CRASHER,
	ANTI_CON,
	ANTI_PING,
	ANTI_SILAH,
	ANTI_JETPACK,
	ANTI_BOT,
	ANTI_DRIVEBY,
	ANTI_MONEY,
	ANTI_GOD,
	ANTI_GOD_CAR);
	mysql_query(Query);
}

stock MySQLguncelle2()
{
	new Query[ 1024 ];
	format(Query, sizeof(Query), "UPDATE `Antihile` SET `Anti_Spawn_Kill` = '%s', `Anti_Spam` = '%s', `Anti_Fall` = '%s', `Anti_C_Bug` = '%s', \
	`Anti_Fake_Kill` = '%s', `Anti_Rcon` = '%s', `Anti_Airbreak` = '%s', `Anti_Ip` = '%s', `Anti_Skin` = '%s', `Anti_Afk` = '%s', `Anti_Fly` = '%s', \
	`Anti_Sobeit` = '%s', `Anti_Motor` = '%s', 'Anti_Teleport_Vehicle` = '%s', 'Anti_Command_Spammer` = '%s', 'Anti_Connection_Spammer` = '%s', \
	`Anti_Server_Fucker` = '%s', 'Anti_Dialog` = '%s', 'Anti_Speed` = '%s', 'Anti_Bunny_Hop` = '%s', 'Anti_Color_Spammer` = '%s')",
	ANTI_SPAWN_KILL,
	ANTI_SPAM,
	ANTI_FALL,
	ANTI_C_BUG,
	ANTI_FAKE_KILL,
	ANTI_RCON,
	ANTI_AIRBREAK,
	ANTI_IP,
	ANTI_SKIN,
	ANTI_AFK,
	ANTI_FLY,
	ANTI_SOBEIT,
	ANTI_MOTOR
	ANTI_TELEPORT_VEHICLE,
	ANTI_COMMAND_SPAMMER,
	ANTI_CONNECTION_SPAMMER,
	ANTI_SERVER_FUCKER,
	ANTI_DIALOG,
	ANTI_SPEED,
	ANTI_BUNNY_HOP,
	ANTI_COLOR_SPAMMER);
	mysql_query(Query);
}

stock UpdateConfig()
{
    #if MYSQL_KAYIT == true
    if(!MySQLOlusturulmusMu(ANTI_CON)) MySQLolustur(); else MySQLguncelle(); MySQLguncelle2();
    #elseif NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    if(!dini_Exists(file)) AyarOlustur(); else AyarGuncelle();
    #endif
}

stock AyarOlustur()
{
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
	dini_Create(file);
	dini_Int(file,"Anti_Crasher");
	dini_Int(file,"Anti_Con");
	dini_Int(file,"Anti_Ping");
	dini_Int(file,"Anti_Silah");
	dini_Int(file,"Anti_Jetpack");
	dini_Int(file,"Anti_Bot");
	dini_Int(file,"Anti_Driveby");
	dini_Int(file,"Anti_Money");
	dini_Int(file,"Anti_God");
	dini_Int(file,"Anti_God_Car");
	dini_Int(file,"Anti_Spawn_Kill");
	dini_Int(file,"Anti_Spam");
	dini_Int(file,"Anti_Fall");
	dini_Int(file,"Anti_C_Bug");
	dini_Int(file,"Anti_Fake_Kill");
	dini_Int(file,"Anti_Rcon");
	dini_Int(file,"Anti_Airbreak");
	dini_Int(file,"Anti_Ip");
	dini_Int(file,"Anti_Skin");
	dini_Int(file,"Anti_Afk");
	dini_Int(file,"Anti_Fly");
	dini_Int(file,"Anti_Sobeit");
	dini_Int(file,"Anti_Motor");
	dini_Int(file,"Anti_Teleport_Vehicle");
	dini_Int(file,"Anti_Command_Spammer");
	dini_Int(file,"Anti_Connection_Spammer");
	dini_Int(file,"Anti_Server_Fucker");
	dini_Int(file,"Anti_Dialog");
	dini_Int(file,"Anti_Speed");
	dini_Int(file,"Anti_Bunny_Hop");
	dini_Int(file,"Anti_Color_Spammer");
	#if LANGUAGE == 0
    printf("<======================================>");
	printf("<          Ayarlar Olusturuldu         >");
    printf("<======================================>");
	#elseif LANGUAGE == 1
    printf("<======================================>");
	printf("<         Configuration Created        >");
    printf("<======================================>");
	#endif
	return 1;
}

stock AyarGuncelle()
{
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
	ANTI_CRASHER = dini_Int(file,"Anti_Crasher");
	ANTI_CON = dini_Int(file,"Anti_Con");
 	ANTI_PING = dini_Int(file,"Anti_Ping");
 	ANTI_SILAH = dini_Int(file,"Anti_Silah");
 	ANTI_JETPACK = dini_Int(file,"Anti_Jetpack");
 	ANTI_BOT = dini_Int(file,"Anti_Bot");
 	ANTI_DRIVEBY = dini_Int(file,"Anti_Driveby");
	ANTI_MONEY = dini_Int(file,"Anti_Money");
	ANTI_GOD = dini_Int(file,"Anti_God");
	ANTI_GOD_CAR = dini_Int(file,"Anti_God_Car");
	ANTI_SPAWN_KILL = dini_Int(file,"Anti_Spawn_Kill");
	ANTI_SPAM = dini_Int(file,"Anti_Spam");
	ANTI_FALL = dini_Int(file,"Anti_Fall");
 	ANTI_C_BUG = dini_Int(file,"Anti_C_Bug");
 	ANTI_FAKE_KILL = dini_Int(file,"Anti_Fake_Kill");
 	ANTI_RCON = dini_Int(file,"Anti_Rcon");
 	ANTI_AIRBREAK = dini_Int(file,"Anti_Airbreak");
	ANTI_IP = dini_Int(file,"Anti_Ip");
	ANTI_SKIN = dini_Int(file,"Anti_Skin");
	ANTI_AFK = dini_Int(file,"Anti_Afk");
	ANTI_FLY = dini_Int(file,"Anti_Fly");
	ANTI_SOBEIT = dini_Int(file,"Anti_Sobeit");
	ANTI_MOTOR = dini_Int(file,"Anti_Motor");
	ANTI_TELEPORT_VEHICLE = dini_Int(file,"Anti_Teleport_Vehicle");
	ANTI_COMMAND_SPAMMER = dini_Int(file,"Anti_Command_Spammer");
	ANTI_CONNECTION_SPAMMER = dini_Int(file,"Anti_Connection_Spammer");
	ANTI_SERVER_FUCKER = dini_Int(file,"Anti_Server_Fucker");
	ANTI_DIALOG = dini_Int(file,"Anti_Dialog");
	ANTI_SPEED = dini_Int(file,"Anti_Speed");
	ANTI_BUNNY_HOP = dini_Int(file,"Anti_Bunny_Hop");
	ANTI_COLOR_SPAMMER = dini_Int(file,"Anti_Color_Spammer");
	#if LANGUAGE == 0
    printf("<======================================>");
	printf("<           Ayarlar Yuklendi           >");
    printf("<======================================>");
	#elseif LANGUAGE == 1
    printf("<======================================>");
	printf("<         Configuration Loaded         >");
    printf("<======================================>");
	#endif
	return 1;
}

public MyHttpResponse(index, response_code, data[])
{
    printf("<======================================>");
    #if LANGUAGE == 0
    printf("<          Anti Hile Sistemi           >");
    printf("<          Versiyon Kontrol            >");
    #elseif LANGUAGE == 1
    printf("<          Anti Cheat System           >");
    printf("<           Version Control            >");
    #endif
    printf("<                                      >");

    #if LANGUAGE == 0
    printf("<         Kurulu Olan Surum            >");
    #elseif LANGUAGE == 1
    printf("<         Installed Version            >");
    #endif
    printf("<               %s                    >",VERSIYON);
    printf("<                                      >");
    #if LANGUAGE == 0
    printf("<             Son Surum                >");
    #elseif LANGUAGE == 1
    printf("<           Latest Release             >");
    #endif
    printf("<               %s                    >",data);

    if(response_code == 200)
    {
        if(!strcmp(data, VERSIYON, true))
        {
        #if LANGUAGE == 0
        printf("<       Anti Hile Sistemi Guncel       >");
        #elseif LANGUAGE == 1
        printf("<      Anti Cheat System Updated       >");
        #endif
        }else{
        #if LANGUAGE == 0
        printf("<        Anti Hile Sistemi Eski        >");
        printf("<                                      >");
        printf("<      www.github.com/MaxAndolini/     >");
        printf("<         Adresinden Son Surumu        >");
        printf("<      Son Surumu Indirin Ve Kurun     >");
        #elseif LANGUAGE == 1
        printf("<        Anti Cheat System Old         >");
        printf("<                                      >");
        printf("<        Download And Install          >");
        printf("<           The Latest From            >");
        printf("<      www.github.com/MaxAndolini/     >");
        #endif
        }
        }else{
        #if LANGUAGE == 0
        printf("<                HATA                  >");
		printf("<          Surum Kontrolu Icýn         >");
		printf("<          Siteye Ulasilamiyor         >");
        printf("<                                      >");
        printf("<              ACIKLAMA                >");
        #elseif LANGUAGE == 1
        printf("<               ERROR                  >");
		printf("<         Server Is Unavailable        >");
		printf("<          For Version Control         >");
		#endif
        printf("<                                      >");
        #if LANGUAGE == 0
        printf("<              ACIKLAMA                >");
        printf("<             %s                    >",ConnectionErrors[response_code]);
        #elseif LANGUAGE == 1
        printf("<             EXPLANATION              >");
        printf("<                %s                    >",ConnectionErrors[response_code]);
        #endif
        }

    printf("<                                      >");
    printf("<======================================>");
}

public MyHttpResponses(index, response_code, data[])
{
	new string[512];
    if(response_code == 200)
    {
        #if LANGUAGE == 0
        format(string, 512, "{FFFFFF}Kullandýðýnýz Sürüm\t{00FF40}%s\n{FFFFFF}Son Sürüm \t{00FF40}%s\n\n",VERSIYON,data);
        #elseif LANGUAGE == 1
        format(string, 512, "{FFFFFF}You Are Using Version\t{00FF40}%s\n{FFFFFF}Latest Release \t{00FF40}%s\n\n",VERSIYON,data);
        #endif
        if(!strcmp(data, VERSIYON, true))
        {
            #if LANGUAGE == 0
            format(string, 512, "%s{FFFFFF}Anti Hile Sistemi'niz Güncel.",string);
            #elseif LANGUAGE == 1
            format(string, 512, "%s{FFFFFF}Anti Cheat System Updated.",string);
            #endif
		}else{
            #if LANGUAGE == 0
            format(string, 512, "%s{FFFFFF}Anti Hile Sistemi'niz Güncel Deðil.\nhttps://github.com/MaxAndolini Adresinden Ýndirin Ve Kurun.",string);
            #elseif LANGUAGE == 1
            format(string, 512, "%s{FFFFFF}Anti Cheat System Old.\nDownload And Install The Latest From https://github.com/MaxAndolini.",string);
            #endif
		}
		
        #if LANGUAGE == 0
		ShowPlayerDialog(index, 9999, DIALOG_STYLE_MSGBOX, "{FFFFFF}Anti Hile Sistemi Versiyon Kontrol", string, "Kapat", "");
		#elseif LANGUAGE == 1
		ShowPlayerDialog(index, 9999, DIALOG_STYLE_MSGBOX, "{FFFFFF}Anti Cheat System version Control", string, "Kapat", "");
		#endif
        }else{
        #if LANGUAGE == 0
		format(string, 512, "{FF0000}Sürüm Kontrolü Ýçin Siteye Ulaþamadýk!\n\n{FF0000}%s",ConnectionErrors[response_code]);
		#elseif LANGUAGE == 1
		format(string, 512, "{FF0000}Fails To Version Control Server!\n\n{FF0000}%s",ConnectionErrors[response_code]);
		#endif

        #if LANGUAGE == 0
		ShowPlayerDialog(index, 9999, DIALOG_STYLE_MSGBOX, "{FFFFFF}Anti Hile Sistemi Versiyon Kontrol", string, "Kapat", "");
		#elseif LANGUAGE == 1
		ShowPlayerDialog(index, 9999, DIALOG_STYLE_MSGBOX, "{FFFFFF}Anti Cheat System Version Control", string, "Kapat", "");
		#endif
    }
}

forward Kickat(const turkce[],const english[]);
public Kickat(const turkce[],const english[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	new str[512],str3[120];
	#if SENDCLIENTMESSAGETOALL == true
    #if LANGUAGE == 0
	format(str,sizeof(str),"{007FFF}(({C3C3C3} *** Anti Hile *** {FFFFFF}%s isimli oyuncu sunucudan atýldý. ( %s ) {007FFF})){007FFF}"		,PlayerName(i),turkce);
	#elseif LANGUAGE == 1
	format(str,sizeof(str),"{007FFF}(({C3C3C3} *** Anti Cheat *** {FFFFFF}%s has been kicked from the server. ( %s ) {007FFF})){007FFF}"		,PlayerName(i),english);
	#endif
	#elseif TEXTDRAW == true
	#if LANGUAGE == 0
	format(str,sizeof(str),"~r~~h~~h~<Anti Hile> ~w~%s isimli oyuncu sunucudan atildi. ( %s )"		,PlayerName(i),turkce);
	#elseif LANGUAGE == 1
	format(str,sizeof(str),"~r~~h~~h~<Anti Cheat> ~w~%s has been kicked from the server. ( %s )"		,PlayerName(i),english);
	#endif
	#endif
	#if SENDCLIENTMESSAGETOALL == true
	SendClientMessageToAll(0xFF0000FF,str);
	#elseif TEXTDRAW == true
	Textdrawyazi(i, str);
	#endif
    #if LANGUAGE == 0
    format(str3,sizeof(str3),"Kick: %s >>> Sebep: ( %s )"		,PlayerName(i),turkce);
    #elseif LANGUAGE == 1
    format(str3,sizeof(str3),"Kick: %s >>> Reason: ( %s )"		,PlayerName(i),english);
    #endif
	KickLog(str3);
	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
	SetTimerEx("Kickle", 100, false, "d", i);
	}
}

forward Kickle(playerid);
public Kickle(playerid)
{
    return Kick(playerid);
}

forward Banat(const turkce[],const english[]);
public Banat(const turkce[],const english[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
    new str2[512],str3[150];
    #if SENDCLIENTMESSAGETOALL == true
    #if LANGUAGE == 0
    format(str2,sizeof(str2),"{007FFF}(({C3C3C3} *** Anti Hile *** {FFFFFF}%s isimli oyuncu sunucudan yasaklandý. ( %s ) {007FFF})){007FFF}"		,PlayerName(i),turkce);
    #elseif LANGUAGE == 1
    format(str2,sizeof(str2),"{007FFF}(({C3C3C3} *** Anti Cheat *** {FFFFFF}%s has been banned from the server. ( %s ) {007FFF})){007FFF}"		,PlayerName(i),english);
    #endif
	#elseif TEXTDRAW == true
    #if LANGUAGE == 0
    format(str2,sizeof(str2),"~r~~h~~h~<Anti Hile> ~w~%s isimli oyuncu sunucudan yasaklandi. ( %s )"		,PlayerName(i),turkce);
    #elseif LANGUAGE == 1
    format(str2,sizeof(str2),"~r~~h~~h~<Anti Cheat> ~w~%s has been banned from the server. ( %s )"		,PlayerName(i),english);
    #endif
	#endif
	#if SENDCLIENTMESSAGETOALL == true
	SendClientMessageToAll(0xFF0000FF,str2);
	#elseif TEXTDRAW == true
	Textdrawyazi(i, str2);
	#endif
    #if LANGUAGE == 0
    format(str3,sizeof(str3),"Ban: %s >>> Sebep: ( %s )"		,PlayerName(i),turkce);
    #elseif LANGUAGE == 1
    format(str3,sizeof(str3),"Ban: %s >>> Reason: ( %s )"		,PlayerName(i),english);
    #endif
	BanLog(str3);
	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
	SetTimerEx("Banla", 100, false, "d", i);
	}
}

forward Antiopen(playerid,deger,const dini[],const turkce2[], const english2[]);
public Antiopen(playerid,deger,const dini[],const turkce2[],const english2[])
{
	new turkcee2[144],englishh2[144],dinii[144];
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    format(turkcee2,sizeof(turkcee2),"%s",turkce2);
    format(englishh2,sizeof(englishh2),"%s",english2);
    format(dinii,sizeof(dinii),"%s",dini);
    if(deger == 1)  { if(ANTI_CRASHER == 1) {            Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_CRASHER == 0)            { ANTI_CRASHER = 1;             Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 2)  { if(ANTI_CON == 1) {                Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_CON == 0)                { ANTI_CON = 1;                 Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 3)  { if(ANTI_PING == 1) {               Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_PING == 0)               { ANTI_PING = 1;                Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 4)  { if(ANTI_SILAH == 1) {              Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SILAH == 0)              { ANTI_SILAH = 1;               Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 5)  { if(ANTI_JETPACK == 1) {            Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_JETPACK == 0)            { ANTI_JETPACK = 1;             Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 6)  { if(ANTI_BOT == 1) {                Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_BOT == 0)                { ANTI_BOT = 1;                 Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 7)  { if(ANTI_DRIVEBY == 1) {            Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_DRIVEBY == 0)            { ANTI_DRIVEBY = 1;             Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 8)  { if(ANTI_MONEY == 1) {              Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_MONEY == 0)              { ANTI_MONEY = 1;               Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 9)  { if(ANTI_GOD == 1) {                Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_GOD == 0)                { ANTI_GOD = 1;                 Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 10) { if(ANTI_GOD_CAR == 1) {            Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_GOD_CAR == 0)            { ANTI_GOD_CAR = 1;             Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 11) { if(ANTI_SPAWN_KILL == 1) {         Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SPAWN_KILL == 0)         { ANTI_SPAWN_KILL = 1;          Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 12) { if(ANTI_SPAM == 1) {               Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SPAM == 0)               { ANTI_SPAM = 1;                Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 13) { if(ANTI_FALL == 1) {               Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_FALL == 0)               { ANTI_FALL = 1;                Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 14) { if(ANTI_C_BUG == 1) {              Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_C_BUG == 0)              { ANTI_C_BUG = 1;               Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 15) { if(ANTI_FAKE_KILL == 1) {          Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_FAKE_KILL == 0)          { ANTI_FAKE_KILL = 1;           Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 16) { if(ANTI_RCON == 1) {               Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_RCON == 0)               { ANTI_RCON = 1;                Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 17) { if(ANTI_AIRBREAK == 1) {           Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_AIRBREAK == 0)           { ANTI_AIRBREAK = 1;            Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 18) { if(ANTI_IP == 1) {                 Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_IP == 0)                 { ANTI_IP = 1;                  Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 19) { if(ANTI_SKIN == 1) {               Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SKIN == 0)               { ANTI_SKIN = 1;                Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 20) { if(ANTI_AFK == 1) {                Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_AFK == 0)                { ANTI_AFK = 1;                 Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 21) { if(ANTI_FLY == 1) {                Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_FLY == 0)                { ANTI_FLY = 1;                 Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 22) { if(ANTI_SOBEIT == 1) {             Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SOBEIT == 0)             { ANTI_SOBEIT = 1;              Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 23) { if(ANTI_MOTOR == 1) {              Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_MOTOR == 0)              { ANTI_MOTOR = 1;               Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 24) { if(ANTI_TELEPORT_VEHICLE == 1) {   Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_TELEPORT_VEHICLE == 0)   { ANTI_TELEPORT_VEHICLE = 1;    Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 25) { if(ANTI_COMMAND_SPAMMER == 1) {    Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_COMMAND_SPAMMER == 0)    { ANTI_COMMAND_SPAMMER = 1;     Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 26) { if(ANTI_CONNECTION_SPAMMER == 1) { Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_CONNECTION_SPAMMER == 0) { ANTI_CONNECTION_SPAMMER = 1;  Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 27) { if(ANTI_SERVER_FUCKER == 1) {      Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SERVER_FUCKER == 0)      { ANTI_SERVER_FUCKER = 1;       Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 28) { if(ANTI_DIALOG == 1) {             Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_DIALOG == 0)             { ANTI_DIALOG = 1;              Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 29) { if(ANTI_SPEED == 1) {              Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_SPEED == 0)              { ANTI_SPEED = 1;               Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 30) { if(ANTI_BUNNY_HOP == 1) {          Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_BUNNY_HOP == 0)          { ANTI_BUNNY_HOP = 1;           Antioactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 31) { if(ANTI_COLOR_SPAMMER == 1) {      Antiohata(playerid,turkcee2,englishh2); }else if(ANTI_COLOR_SPAMMER == 0)      { ANTI_COLOR_SPAMMER = 1;       Antioactive(playerid,dinii,turkcee2,englishh2); } }
    return 1;
}

forward Antiohata(playerid,const turkcee2[], const englishh2[]);
public Antiohata(playerid,const turkcee2[], const englishh2[])
{
    new string[144];
    #if LANGUAGE == 0
	format(string, sizeof(string), "%s Zaten Aktif.",turkcee2);
    Hatatr(playerid,string);
    #elseif LANGUAGE == 1
	format(string, sizeof(string), "%s Already Active.",englishh2);
    Hataen(playerid,string);
    #endif
}

forward Antioactive(playerid,const dinii[],const turkcee2[], const englishh2[]);
public Antioactive(playerid,const dinii[],const turkcee2[], const englishh2[])
{
    new file[256],str[100],string2[144];
    #if MYSQL_KAYIT == true
    MySQLguncelle(),MySQLguncelle2();
    #elseif NORMAL_KAYIT == true
    format(str,sizeof(str),"%s",dinii);
    format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    dini_IntSet(file,str,1);
    #endif
    #if LANGUAGE == 0
	format(string2, sizeof(string2), "%s Baþarýyla Aktif Edildi.", turkcee2);
    Bilgitr(playerid,string2);
    #elseif LANGUAGE == 1
	format(string2, sizeof(string2), "%s Has Been Succesfully Activated.", englishh2);
    Bilgien(playerid,string2);
    #endif
}

forward Anticlose(playerid,deger,const dini[],const turkce2[], const english2[]);
public Anticlose(playerid,deger,const dini[],const turkce2[],const english2[])
{
	new turkcee2[144],englishh2[144],dinii[144];
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    format(turkcee2,sizeof(turkcee2),"%s",turkce2);
    format(englishh2,sizeof(englishh2),"%s",english2);
    format(dinii,sizeof(dinii),"%s",dini);
    if(deger == 0)  { if(ANTI_CRASHER == 0) {            Antichata(playerid,turkcee2,englishh2); }else if(ANTI_CRASHER == 1)            { ANTI_CRASHER = 0;             Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 2)  { if(ANTI_CON == 0) {                Antichata(playerid,turkcee2,englishh2); }else if(ANTI_CON == 1)                { ANTI_CON = 0;                 Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 3)  { if(ANTI_PING == 0) {               Antichata(playerid,turkcee2,englishh2); }else if(ANTI_PING == 1)               { ANTI_PING = 0;                Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 4)  { if(ANTI_SILAH == 0) {              Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SILAH == 1)              { ANTI_SILAH = 0;               Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 5)  { if(ANTI_JETPACK == 0) {            Antichata(playerid,turkcee2,englishh2); }else if(ANTI_JETPACK == 1)            { ANTI_JETPACK = 0;             Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 6)  { if(ANTI_BOT == 0) {                Antichata(playerid,turkcee2,englishh2); }else if(ANTI_BOT == 1)                { ANTI_BOT = 0;                 Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 7)  { if(ANTI_DRIVEBY == 0) {            Antichata(playerid,turkcee2,englishh2); }else if(ANTI_DRIVEBY == 1)            { ANTI_DRIVEBY = 0;             Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 8)  { if(ANTI_MONEY == 0) {              Antichata(playerid,turkcee2,englishh2); }else if(ANTI_MONEY == 1)              { ANTI_MONEY = 0;               Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 9)  { if(ANTI_GOD == 0) {                Antichata(playerid,turkcee2,englishh2); }else if(ANTI_GOD == 1)                { ANTI_GOD = 0;                 Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 00) { if(ANTI_GOD_CAR == 0) {            Antichata(playerid,turkcee2,englishh2); }else if(ANTI_GOD_CAR == 1)            { ANTI_GOD_CAR = 0;             Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 01) { if(ANTI_SPAWN_KILL == 0) {         Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SPAWN_KILL == 1)         { ANTI_SPAWN_KILL = 0;          Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 02) { if(ANTI_SPAM == 0) {               Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SPAM == 1)               { ANTI_SPAM = 0;                Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 03) { if(ANTI_FALL == 0) {               Antichata(playerid,turkcee2,englishh2); }else if(ANTI_FALL == 1)               { ANTI_FALL = 0;                Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 04) { if(ANTI_C_BUG == 0) {              Antichata(playerid,turkcee2,englishh2); }else if(ANTI_C_BUG == 1)              { ANTI_C_BUG = 0;               Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 05) { if(ANTI_FAKE_KILL == 0) {          Antichata(playerid,turkcee2,englishh2); }else if(ANTI_FAKE_KILL == 1)          { ANTI_FAKE_KILL = 0;           Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 06) { if(ANTI_RCON == 0) {               Antichata(playerid,turkcee2,englishh2); }else if(ANTI_RCON == 1)               { ANTI_RCON = 0;                Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 07) { if(ANTI_AIRBREAK == 0) {           Antichata(playerid,turkcee2,englishh2); }else if(ANTI_AIRBREAK == 1)           { ANTI_AIRBREAK = 0;            Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 08) { if(ANTI_IP == 0) {                 Antichata(playerid,turkcee2,englishh2); }else if(ANTI_IP == 1)                 { ANTI_IP = 0;                  Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 09) { if(ANTI_SKIN == 0) {               Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SKIN == 1)               { ANTI_SKIN = 0;                Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 20) { if(ANTI_AFK == 0) {                Antichata(playerid,turkcee2,englishh2); }else if(ANTI_AFK == 1)                { ANTI_AFK = 0;                 Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 21) { if(ANTI_FLY == 0) {                Antichata(playerid,turkcee2,englishh2); }else if(ANTI_FLY == 1)                { ANTI_FLY = 0;                 Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 22) { if(ANTI_SOBEIT == 0) {             Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SOBEIT == 1)             { ANTI_SOBEIT = 0;              Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 23) { if(ANTI_MOTOR == 0) {              Antichata(playerid,turkcee2,englishh2); }else if(ANTI_MOTOR == 1)              { ANTI_MOTOR = 0;               Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 24) { if(ANTI_TELEPORT_VEHICLE == 0) {   Antichata(playerid,turkcee2,englishh2); }else if(ANTI_TELEPORT_VEHICLE == 1)   { ANTI_TELEPORT_VEHICLE = 0;    Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 25) { if(ANTI_COMMAND_SPAMMER == 0) {    Antichata(playerid,turkcee2,englishh2); }else if(ANTI_COMMAND_SPAMMER == 1)    { ANTI_COMMAND_SPAMMER = 0;     Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 26) { if(ANTI_CONNECTION_SPAMMER == 0) { Antichata(playerid,turkcee2,englishh2); }else if(ANTI_CONNECTION_SPAMMER == 1) { ANTI_CONNECTION_SPAMMER = 0;  Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 27) { if(ANTI_SERVER_FUCKER == 0) {      Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SERVER_FUCKER == 1)      { ANTI_SERVER_FUCKER = 0;       Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 28) { if(ANTI_DIALOG == 0) {             Antichata(playerid,turkcee2,englishh2); }else if(ANTI_DIALOG == 1)             { ANTI_DIALOG = 0;              Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 29) { if(ANTI_SPEED == 0) {              Antichata(playerid,turkcee2,englishh2); }else if(ANTI_SPEED == 1)              { ANTI_SPEED = 0;               Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 30) { if(ANTI_BUNNY_HOP == 0) {          Antichata(playerid,turkcee2,englishh2); }else if(ANTI_BUNNY_HOP == 1)          { ANTI_BUNNY_HOP = 0;           Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    if(deger == 31) { if(ANTI_COLOR_SPAMMER == 0) {      Antichata(playerid,turkcee2,englishh2); }else if(ANTI_COLOR_SPAMMER == 1)      { ANTI_COLOR_SPAMMER = 0;       Anticinactive(playerid,dinii,turkcee2,englishh2); } }
    return 1;
}

forward Antichata(playerid,const turkcee2[], const englishh2[]);
public Antichata(playerid,const turkcee2[], const englishh2[])
{
    new string[144];
    #if LANGUAGE == 0
	format(string, sizeof(string), "%s Zaten Ýnaktif.",turkcee2);
    Hatatr(playerid,string);
    #elseif LANGUAGE == 1
	format(string, sizeof(string), "%s Already Inactive.",englishh2);
    Hataen(playerid,string);
    #endif
}

forward Anticinactive(playerid,const dinii[],const turkcee2[], const englishh2[]);
public Anticinactive(playerid,const dinii[],const turkcee2[], const englishh2[])
{
    new file[256],str[100],string2[144];
    #if MYSQL_KAYIT == true
    MySQLguncelle(); MySQLguncelle2();
    #elseif NORMAL_KAYIT == true
    format(str,sizeof(str),"%s",dinii);
    format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    dini_IntSet(file,str,0);
    #endif
    #if LANGUAGE == 0
	format(string2, sizeof(string2), "%s Baþarýyla Ýnaktif Edildi.", turkcee2);
    Bilgitr(playerid,string2);
    #elseif LANGUAGE == 1
	format(string2, sizeof(string2), "%s Has Been Succesfully Inactivated", englishh2);
    Bilgien(playerid,string2);
    #endif
}

stock Anticheats(playerid)
{
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    #if LANGUAGE == 0
    new Dialog[1024] = "{FFFFFF}Anti Hile Sistemi v1.4\n";
	strcat(Dialog, "{F63A00}Sistemler:\n\n");
	strcat(Dialog, "{FFFFFF}Anti Crasher - Anti Con - Anti Ping - Anti Silah\n");
	strcat(Dialog, "{FFFFFF}Anti Jetpack - Anti Bot - Anti Drive By - Anti Money\n");
	strcat(Dialog, "{FFFFFF}Anti God - Anti God Car - Anti Spawn-Kill - Anti Spam\n");
	strcat(Dialog, "{FFFFFF}Anti Fall - Anti C Bug - Anti Fake-Kill - Anti Rcon\n");
	strcat(Dialog, "{FFFFFF}Anti Airbreak - Anti Ýp - Anti Skin - Anti Afk\n");
	strcat(Dialog, "{FFFFFF}Anti Fly - Anti Sobeit - Anti Motor Bug - Anti Araç Teleport\n");
	strcat(Dialog, "{FFFFFF}Anti Command Spammer - Anti Connection Spammer - Anti Server F*cker\n");
	strcat(Dialog, "{FFFFFF}Anti Dialog - Anti Speed - Anti Bunny Hop\n");
	strcat(Dialog, "{F63A00}Komutlar:\n\n");
	strcat(Dialog, "{FFFFFF}/antihileac(Rcon) - /antihilekapat(Rcon) - /antihileotoayar(Rcon) - /antihileversiyon(Rcon)\n");
	strcat(Dialog, "{FFFFFF}/antihiledurum - /antihileyapimci");
    ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,"{FFFFFF}Anti Hile Sistemi v1.4",Dialog,"Tamam","");
    #elseif LANGUAGE == 1
    new Dialog[1024] = "{FFFFFF}Anti Cheat System v1.4\n";
	strcat(Dialog, "{F63A00}Systems:\n\n");
	strcat(Dialog, "{FFFFFF}Anti Crasher - Anti Con - Anti Ping - Anti Weapon\n");
	strcat(Dialog, "{FFFFFF}Anti Jetpack - Anti Bot - Anti Drive By - Anti Money\n");
	strcat(Dialog, "{FFFFFF}Anti God - Anti God Car - Anti Spawn-Kill - Anti Spam\n");
	strcat(Dialog, "{FFFFFF}Anti Fall - Anti C Bug - Anti Fake-Kill - Anti Rcon\n");
	strcat(Dialog, "{FFFFFF}Anti Airbreak - Anti Ýp - Anti Skin - Anti Afk\n");
	strcat(Dialog, "{FFFFFF}Anti Fly - Anti Sobeit - Anti Moto Bug - Anti Teleport Vehicle\n");
	strcat(Dialog, "{FFFFFF}Anti Command Spammer - Anti Connection Spammer - Anti Server F*cker\n");
	strcat(Dialog, "{FFFFFF}Anti Dialog - Anti Speed - Anti Bunny Hop\n");
	strcat(Dialog, "{F63A00}Commands:\n\n");
	strcat(Dialog, "{FFFFFF}/anticheatopen(Rcon) - /anticheatclose(Rcon) - /anticheatautosettings(Rcon) - /anticheatversion(Rcon)\n");
	strcat(Dialog, "{FFFFFF}/anticheatstatus - /anticheatcredits");
    ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,"{FFFFFF}Anti Cheat System v1.4",Dialog,"Okay","");
    #endif
}

stock Anticheatcredits(playerid)
{
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    #if LANGUAGE == 0
    new Dialog2[1024] = "{FFFFFF}Anti Hile Sistemi v1.4\n";
	strcat(Dialog2, "{F63A00}Yapýmcý:\n\n");
	strcat(Dialog2, "{FFFFFF}Max_Andolini\n");
	strcat(Dialog2, "{FFFFFF}Yardýmlarýndan Dolayý Furkan1103'a Teþekkür Ederim.");
    ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,"{FFFFFF}Anti Hile Sistemi v1.4",Dialog2,"Tamam","");
    #elseif LANGUAGE == 1
	new Dialog2[1024] = "{FFFFFF}Anti Cheat System v1.4\n";
	strcat(Dialog2, "{F63A00}Credits:\n\n");
	strcat(Dialog2, "{FFFFFF}Max_Andolini\n");
	strcat(Dialog2, "{FFFFFF}Furkan1103 for helping us to thank");
    ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,"{FFFFFF}Anti Cheat System v1.4",Dialog2,"Okay","");
    #endif
}

stock Anticheatversion(playerid)
{
    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    return HTTP(playerid, HTTP_GET, "maxandolini.com.nu/version.txt", "", "MyHttpResponses");
}

stock Anticheatstatus(playerid)
{
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	#if LANGUAGE == 0
    new Dialog3[5024] = "{FFFFFF}Anti Hile Sistemi v1.4\n";
	strcat(Dialog3, "{F63A00}Ayarlar:\n\n");
	if(ANTI_CRASHER == 0)           strcat(Dialog3, "{FFFFFF}Anti Crasher:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Crasher:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_CON == 0)               strcat(Dialog3, "{FFFFFF}Anti Con:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Con:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_PING == 0)              strcat(Dialog3, "{FFFFFF}Anti Ping:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Ping:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_SILAH == 0)             strcat(Dialog3, "{FFFFFF}Anti Silah:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Silah:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_JETPACK == 0)           strcat(Dialog3, "{FFFFFF}Anti Jetpack:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Jetpack:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_BOT == 0)               strcat(Dialog3, "{FFFFFF}Anti Bot:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Bot:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_DRIVEBY == 0)           strcat(Dialog3, "{FFFFFF}Anti Drive By:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Driveby:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_MONEY == 0)             strcat(Dialog3, "{FFFFFF}Anti Para:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Para:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_GOD == 0)               strcat(Dialog3, "{FFFFFF}Anti God:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti God:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_GOD_CAR == 0)           strcat(Dialog3, "{FFFFFF}Anti God Araç:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti God Araç:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_SPAWN_KILL == 0)        strcat(Dialog3, "{FFFFFF}Anti Spawn Kill:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Spawn Kill:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_SPAM == 0)              strcat(Dialog3, "{FFFFFF}Anti Spam:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Spam:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_FALL == 0)              strcat(Dialog3, "{FFFFFF}Anti Fall:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Fall:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_C_BUG == 0)             strcat(Dialog3, "{FFFFFF}Anti C Bug:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti C Bug:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_FAKE_KILL == 0)         strcat(Dialog3, "{FFFFFF}Anti Fake Kill:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Fake Kill:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_RCON == 0)              strcat(Dialog3, "{FFFFFF}Anti Rcon:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Rcon:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_AIRBREAK == 0)          strcat(Dialog3, "{FFFFFF}Anti Airbreak:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Airbreak:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_IP == 0)                strcat(Dialog3, "{FFFFFF}Anti Ip:\t\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Ip:\t\t\t                  {00FF40}Aktif.\n");
	if(ANTI_SKIN == 0)              strcat(Dialog3, "{FFFFFF}Anti Skin:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Skin:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_AFK == 0)               strcat(Dialog3, "{FFFFFF}Anti Afk:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Afk:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_FLY == 0)               strcat(Dialog3, "{FFFFFF}Anti Fly:\t\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Fly:\t\t\t                  {00FF40}Aktif.\n");
	if(ANTI_SOBEIT == 0)            strcat(Dialog3, "{FFFFFF}Anti Sobeit:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Sobeit:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_MOTOR == 0)             strcat(Dialog3, "{FFFFFF}Anti Motor Bug:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Motor Bug:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_TELEPORT_VEHICLE == 0)  strcat(Dialog3, "{FFFFFF}Anti Araç Teleport:\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Araç Teleport:\t                  {00FF40}Aktif.\n");
	if(ANTI_COMMAND_SPAMMER == 0)   strcat(Dialog3, "{FFFFFF}Anti Command Spammer:\t     {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Command Spammer:\t     {00FF40}Aktif.\n");
	if(ANTI_CONNECTION_SPAMMER == 0)strcat(Dialog3, "{FFFFFF}Anti Connection Spammer:\t     {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Connection Spammer:\t     {00FF40}Aktif.\n");
	if(ANTI_SERVER_FUCKER == 0)     strcat(Dialog3, "{FFFFFF}Anti Server Fucker:\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Server Fucker:\t                  {00FF40}Aktif.\n");
	if(ANTI_DIALOG == 0)            strcat(Dialog3, "{FFFFFF}Anti Dialog:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Dialog:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_SPEED == 0)             strcat(Dialog3, "{FFFFFF}Anti Speed:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Speed:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_BUNNY_HOP == 0)         strcat(Dialog3, "{FFFFFF}Anti Bunny Hop:\t\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Bunny Hop:\t\t                  {00FF40}Aktif.\n");
	if(ANTI_COLOR_SPAMMER == 0)     strcat(Dialog3, "{FFFFFF}Anti Color Spammer:\t                  {F63A00}Inaktif.\n"); else strcat(Dialog3, "{FFFFFF}Anti Color Spammer:\t                  {00FF40}Aktif.\n");
	ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,"{FFFFFF}Anti Hile Sistemi v1.4",Dialog3,"Tamam","");
	#elseif LANGUAGE == 1
	new Dialog3[5024] = "{FFFFFF}Anti Cheat System v1.4\n";
	strcat(Dialog3, "{F63A00}Configuration:\n\n");
	if(ANTI_CRASHER == 0)           strcat(Dialog3, "{FFFFFF}Anti Crasher:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Crasher:\t\t                  {00FF40}Active.\n");
	if(ANTI_CON == 0)               strcat(Dialog3, "{FFFFFF}Anti Con:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Con:\t\t                  {00FF40}Active.\n");
	if(ANTI_PING == 0)              strcat(Dialog3, "{FFFFFF}Anti Ping:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Ping:\t\t                  {00FF40}Active.\n");
	if(ANTI_SILAH == 0)             strcat(Dialog3, "{FFFFFF}Anti Weapon:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Weapon:\t\t                  {00FF40}Active.\n");
	if(ANTI_JETPACK == 0)           strcat(Dialog3, "{FFFFFF}Anti Jetpack:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Jetpack:\t\t                  {00FF40}Active.\n");
	if(ANTI_BOT == 0)               strcat(Dialog3, "{FFFFFF}Anti Bot:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Bot:\t\t                  {00FF40}Active.\n");
	if(ANTI_DRIVEBY == 0)           strcat(Dialog3, "{FFFFFF}Anti Drive By:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Driveby:\t\t                  {00FF40}Active.\n");
	if(ANTI_MONEY == 0)             strcat(Dialog3, "{FFFFFF}Anti Money:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Money:\t\t                  {00FF40}Active.\n");
	if(ANTI_GOD == 0)               strcat(Dialog3, "{FFFFFF}Anti God:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti God:\t\t                  {00FF40}Active.\n");
	if(ANTI_GOD == 0)               strcat(Dialog3, "{FFFFFF}Anti God Car:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti God Car:\t\t                  {00FF40}Active.\n");
	if(ANTI_SPAWN_KILL == 0)        strcat(Dialog3, "{FFFFFF}Anti Spawn Kill:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Spawn Kill:\t\t                  {00FF40}Active.\n");
	if(ANTI_SPAM == 0)              strcat(Dialog3, "{FFFFFF}Anti Spam:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Spam:\t\t                  {00FF40}Active.\n");
	if(ANTI_FALL == 0)              strcat(Dialog3, "{FFFFFF}Anti Fall:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Fall:\t\t                  {00FF40}Active.\n");
	if(ANTI_C_BUG == 0)             strcat(Dialog3, "{FFFFFF}Anti C Bug:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti C Bug:\t\t                  {00FF40}Active.\n");
	if(ANTI_FAKE_KILL == 0)         strcat(Dialog3, "{FFFFFF}Anti Fake Kill:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Fake Kill:\t\t                  {00FF40}Active.\n");
	if(ANTI_RCON == 0)              strcat(Dialog3, "{FFFFFF}Anti Rcon:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Rcon:\t\t                  {00FF40}Active.\n");
	if(ANTI_AIRBREAK == 0)          strcat(Dialog3, "{FFFFFF}Anti Airbreak:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Airbreak:\t\t                  {00FF40}Active.\n");
	if(ANTI_IP == 0)                strcat(Dialog3, "{FFFFFF}Anti Ip:\t\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Ip:\t\t\t                  {00FF40}Active.\n");
	if(ANTI_SKIN == 0)              strcat(Dialog3, "{FFFFFF}Anti Skin:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Skin:\t\t                  {00FF40}Active.\n");
	if(ANTI_AFK == 0)               strcat(Dialog3, "{FFFFFF}Anti Afk:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Afk:\t\t                  {00FF40}Active.\n");
	if(ANTI_FLY == 0)               strcat(Dialog3, "{FFFFFF}Anti Fly:\t\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Fly:\t\t\t                  {00FF40}Active.\n");
	if(ANTI_SOBEIT == 0)            strcat(Dialog3, "{FFFFFF}Anti Sobeit:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Sobeit:\t\t                  {00FF40}Active.\n");
	if(ANTI_MOTOR == 0)             strcat(Dialog3, "{FFFFFF}Anti Moto Bug:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Motor Bug:\t\t                  {00FF40}Active.\n");
	if(ANTI_TELEPORT_VEHICLE == 0)  strcat(Dialog3, "{FFFFFF}Anti Teleport Vehicle:\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Teleport Vehicle:\t                  {00FF40}Active.\n");
	if(ANTI_COMMAND_SPAMMER == 0)   strcat(Dialog3, "{FFFFFF}Anti Command Spammer:\t     {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Command Spammer:\t     {00FF40}Active.\n");
	if(ANTI_CONNECTION_SPAMMER == 0)strcat(Dialog3, "{FFFFFF}Anti Connection Spammer:\t     {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Connection Spammer:\t     {00FF40}Active.\n");
	if(ANTI_SERVER_FUCKER == 0)     strcat(Dialog3, "{FFFFFF}Anti Server Fucker:\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Server Fucker:\t                  {00FF40}Active.\n");
	if(ANTI_DIALOG == 0)            strcat(Dialog3, "{FFFFFF}Anti Dialog:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Dialog:\t\t                  {00FF40}Active.\n");
	if(ANTI_SPEED == 0)             strcat(Dialog3, "{FFFFFF}Anti Speed:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Speed:\t\t                  {00FF40}Active.\n");
	if(ANTI_BUNNY_HOP == 0)         strcat(Dialog3, "{FFFFFF}Anti Bunny Hop:\t\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Bunny Hop:\t\t                  {00FF40}Active.\n");
	if(ANTI_COLOR_SPAMMER == 0)     strcat(Dialog3, "{FFFFFF}Anti Color Spammer:\t                  {F63A00}Inactive.\n"); else strcat(Dialog3, "{FFFFFF}Anti Color Spammer:\t                  {00FF40}Active.\n");
	ShowPlayerDialog(playerid,1000,DIALOG_STYLE_MSGBOX,"{FFFFFF}Anti Cheat System v1.4",Dialog3,"Okay","");
	#endif
}

forward Banla(playerid);
public Banla(playerid)
{
    return Ban(playerid);
}

stock Hatatr(playerid,const hata[])
{
	new string[256];
	format(string,sizeof(string),"{FF0000}Hata: {FFFFFF}%s",hata);
	return SendClientMessage(playerid,-1,string);
}

stock Hataen(playerid,const error[])
{
	new string[256];
	format(string,sizeof(string),"{FF0000}Error: {FFFFFF}%s",error);
	return SendClientMessage(playerid,-1,string);
}

stock Bilgitr(playerid,const bilgi[])
{
	new string[256];
	format(string,sizeof(string),"{00FF40}Bilgi: {FFFFFF}%s",bilgi);
	return SendClientMessage(playerid,-1,string);
}

stock Bilgien(playerid,const information[])
{
	new string[256];
	format(string,sizeof(string),"{00FF40}Information: {FFFFFF}%s",information);
	return SendClientMessage(playerid,-1,string);
}

stock Kullatr(playerid,const kullanim[])
{
	new string[256];
	format(string,sizeof(string),"{00FF40}Kullaným: {FFFFFF}%s",kullanim);
	return SendClientMessage(playerid,-1,string);
}

stock Kullaen(playerid,const usage[])
{
	new string[256];
	format(string,sizeof(string),"{00FF40}Usage: {FFFFFF}%s",usage);
	return SendClientMessage(playerid,-1,string);
}

stock GetVehicleSpeed(vehicleid, get3d)
{
	new Float:x, Float:y, Float:z;
	GetVehicleVelocity(vehicleid, x, y, z);
	return SpeedCheck(x, y, z, 100.0, get3d);
}

forward sorguSifirla(playerid);
public sorguSifirla(playerid)
{
	reqSorgu{playerid} = 0;
	return 1;
}

public Slap(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetPlayerPos(playerid, X, Y, Z+5);
	BH[playerid] = 0;
	#if LANGUAGE == 0
	Hatatr(playerid,"Bunny-Hopping bu sunucuda yasaktýr.");
	#elseif LANGUAGE == 1
	Hataen(playerid,"Bunny-Hopping is prohibited in this server.");
	#endif
	return 1;
}

public Bunny_Hop(playerid)
{
	BH[playerid] = 0;
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(ANTI_SERVER_FUCKER == 1) flooding(playerid);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(ANTI_COMMAND_SPAMMER == 1)
	{
	if(oft[playerid]<3) {
	oft[playerid]++;
	}
	}
	if(ANTI_DIALOG == 1)
	{
    new ID = GetPlayerDialogID(playerid);
    if(ID != -1) 
    {
        #if LANGUAGE == 0
        Hatatr(playerid,"Böyle bir diyalog bulunmamaktadýr.");
        #elseif LANGUAGE == 1
        Hataen(playerid,"There is no such a dialogue.");
        #endif
        return 0;
    }
    }
    #if COMMANDS == 1
    dcmd(anticheat, 9, cmdtext);
    dcmd(antihile, 8, cmdtext);
    dcmd(anticheatcredits, 16, cmdtext);
    dcmd(antihileyapimci, 15, cmdtext);
    dcmd(anticheatversion, 16, cmdtext);
    dcmd(antihileversiyon, 16, cmdtext);
    dcmd(anticheatautosettings, 21, cmdtext);
    dcmd(antihileotoayar, 15, cmdtext);
    dcmd(anticheatstatus, 15, cmdtext);
    dcmd(antihiledurum, 13, cmdtext);
    dcmd(anticheatopen, 13, cmdtext);
    dcmd(antihileac, 10, cmdtext);
    dcmd(anticheatclose, 14, cmdtext);
    dcmd(antihilekapat, 13, cmdtext);
    #elseif COMMANDS == 2
	new index, cmd[20];
	cmd = strtok(cmdtext, index);

if (strcmp(cmd, "/anticheat", true) == 0 || strcmp(cmd, "/antihile", true) == 0)
{
	Anticheats(playerid);
    return 1;
}

if (strcmp(cmd, "/anticheatcredits", true) == 0 || strcmp(cmd, "/antihileyapimci", true) == 0)
{
	Anticheatcredits(playerid);
	return 1;
}

if (strcmp(cmd, "/anticheatversion", true) == 0 || strcmp(cmd, "/antihileversiyon", true) == 0)
{
	Anticheatversion(playerid);
	return 1;
}

if (strcmp(cmd, "/anticheatautosettings", true) == 0 || strcmp(cmd, "/antihileotoayar", true) == 0)
{
	new hileoto[256];

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hileoto = strtok(cmdtext, index);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hileoto))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihileotoayar (Ayarlar)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Ayarlar: (freeroam,roleplay,sifirla)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatautosettings (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Settings: (freeroam,roleplay,reset)");
 		#endif
		return 1;
    }
    else if(strcmp(hileoto, "freeroam", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 1;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 1;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 1;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 1;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 0;               		 // Anti Jetpack             Açýk/True - Kapalý/False

	 	ANTI_DRIVEBY = 1;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 1;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 1;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 1;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 1;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 1;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 1;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 1;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 1;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 1;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 1;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 1;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 1;                  		 // Anti Skin                Açýk/True - Kapalý/False

	 	ANTI_FLY = 1;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 1;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 1;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 1;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 1;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 1;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 1;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 1;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 1;                          // Anti Speed               Açýk/True - Kapalý/False

 	 	ANTI_COLOR_SPAMMER = 1;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",1);
	 	dini_IntSet(file,"Anti_Con",1);
	 	dini_IntSet(file,"Anti_Ping",1);
	 	dini_IntSet(file,"Anti_Silah",1);
	 	dini_IntSet(file,"Anti_Jetpack",0);
	 	dini_IntSet(file,"Anti_Driveby",1);
	 	dini_IntSet(file,"Anti_Money",1);
	 	dini_IntSet(file,"Anti_God",1);
	 	dini_IntSet(file,"Anti_God_Car",1);
	 	dini_IntSet(file,"Anti_Spawn_Kill",1);
	 	dini_IntSet(file,"Anti_Spam",1);
	 	dini_IntSet(file,"Anti_Fall",1);
	 	dini_IntSet(file,"Anti_C_Bug",1);
	 	dini_IntSet(file,"Anti_Fake_Kill",1);
	 	dini_IntSet(file,"Anti_Rcon",1);
	 	dini_IntSet(file,"Anti_Airbreak",1);
	 	dini_IntSet(file,"Anti_Ip",1);
	 	dini_IntSet(file,"Anti_Skin",1);

	 	dini_IntSet(file,"Anti_Fly",1);
	 	dini_IntSet(file,"Anti_Sobeit",1);
 	 	dini_IntSet(file,"Anti_Motor",1);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",1);
 	 	dini_IntSet(file,"Anti_Command_Spammer",1);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",1);
 	 	dini_IntSet(file,"Anti_Server_Fucker",1);
 	 	dini_IntSet(file,"Anti_Dialog",1);
 	 	dini_IntSet(file,"Anti_Speed",1);

 	 	dini_IntSet(file,"Anti_Color_Spammer",1);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Anti Freeroam Baþarýyla Aktif Edildi.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"Anti Freeroam Has Been Succesfully Activated.");
        #endif
    }
    else if(strcmp(hileoto, "roleplay", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 1;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 1;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 1;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 1;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 1;               		 // Anti Jetpack             Açýk/True - Kapalý/False

	 	ANTI_DRIVEBY = 1;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 1;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 1;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 1;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 0;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 0;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 1;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 1;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 1;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 1;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 1;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 1;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 1;                  		 // Anti Skin                Açýk/True - Kapalý/False

	 	ANTI_FLY = 1;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 1;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 1;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 1;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 0;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 1;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 1;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 1;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 1;                          // Anti Speed               Açýk/True - Kapalý/False

 	 	ANTI_COLOR_SPAMMER = 1;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",1);
	 	dini_IntSet(file,"Anti_Con",1);
	 	dini_IntSet(file,"Anti_Ping",1);
	 	dini_IntSet(file,"Anti_Silah",1);
	 	dini_IntSet(file,"Anti_Jetpack",1);
	 	dini_IntSet(file,"Anti_Driveby",1);
	 	dini_IntSet(file,"Anti_Money",1);
	 	dini_IntSet(file,"Anti_God",1);
	 	dini_IntSet(file,"Anti_God_Car",1);
	 	dini_IntSet(file,"Anti_Spawn_Kill",0);
	 	dini_IntSet(file,"Anti_Spam",0);
	 	dini_IntSet(file,"Anti_Fall",1);
	 	dini_IntSet(file,"Anti_C_Bug",1);
	 	dini_IntSet(file,"Anti_Fake_Kill",1);
	 	dini_IntSet(file,"Anti_Rcon",1);
	 	dini_IntSet(file,"Anti_Airbreak",1);
	 	dini_IntSet(file,"Anti_Ip",1);
	 	dini_IntSet(file,"Anti_Skin",1);
	 	dini_IntSet(file,"Anti_Fly",1);
	 	dini_IntSet(file,"Anti_Sobeit",1);
 	 	dini_IntSet(file,"Anti_Motor",1);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",1);
 	 	dini_IntSet(file,"Anti_Command_Spammer",0);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",1);
 	 	dini_IntSet(file,"Anti_Server_Fucker",1);
 	 	dini_IntSet(file,"Anti_Dialog",1);
 	 	dini_IntSet(file,"Anti_Speed",1);
 	 	dini_IntSet(file,"Anti_Color_Spammer",1);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Anti Roleplay Baþarýyla Aktif Edildi.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"Anti Roleplay Has Been Succesfully Activated.");
        #endif
    }
    else if(strcmp(hileoto, "sifirla", true) == 0 || strcmp(hileoto, "reset", true) == 0)
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
	 	ANTI_CRASHER = 0;            		     // Anti Crasher             Açýk/True - Kapalý/False
	 	ANTI_CON = 0;    	       	    		 // Anti Con                 Açýk/True - Kapalý/False
	 	ANTI_PING = 0;                  		 // Anti Ping                Açýk/True - Kapalý/False
	 	ANTI_SILAH = 0;                 		 // Anti Silah               Açýk/True - Kapalý/False
	 	ANTI_JETPACK = 0;               		 // Anti Jetpack             Açýk/True - Kapalý/False
	 	ANTI_BOT = 0;                   		 // Anti Bot                 Açýk/True - Kapalý/False
	 	ANTI_DRIVEBY = 0;       	     		 // Anti Drive By            Açýk/True - Kapalý/False
	 	ANTI_MONEY = 0;                  		 // Anti Money               Açýk/True - Kapalý/False
	 	ANTI_GOD = 0;                   		 // Anti God                 Açýk/True - Kapalý/False
	 	ANTI_GOD_CAR = 0;               		 // Anti God Car             Açýk/True - Kapalý/False
	 	ANTI_SPAWN_KILL = 0;            		 // Anti Spawn Kill          Açýk/True - Kapalý/False
	 	ANTI_SPAM = 0;                  		 // Anti Spam                Açýk/True - Kapalý/False
	 	ANTI_FALL = 0;                  		 // Anti Fall                Açýk/True - Kapalý/False
	 	ANTI_C_BUG = 0;                 		 // Anti C Bug               Açýk/True - Kapalý/False
	 	ANTI_FAKE_KILL = 0;             		 // Anti Fake Kill           Açýk/True - Kapalý/False
	 	ANTI_RCON = 0;                  		 // Anti Rcon                Açýk/True - Kapalý/False
	 	ANTI_AIRBREAK = 0;              		 // Anti Airbreak            Açýk/True - Kapalý/False
	 	ANTI_IP = 0;                    		 // Anti Ip                  Açýk/True - Kapalý/False
	 	ANTI_SKIN = 0;                  		 // Anti Skin                Açýk/True - Kapalý/False
	 	ANTI_FLY = 0;                    		 // Anti Fly                 Açýk/True - Kapalý/False
	 	ANTI_SOBEIT = 0;                		 // Anti Sobeit              Açýk/True - Kapalý/False
	 	ANTI_MOTOR = 0;                  	     // Anti Motor Bug           Açýk/True - Kapalý/False
 	 	ANTI_TELEPORT_VEHICLE = 0;               // Anti Teleport Vehicle    Açýk/True - Kapalý/False
 	 	ANTI_COMMAND_SPAMMER = 0;                // Anti Command Spammer     Açýk/True - Kapalý/False
 	 	ANTI_CONNECTION_SPAMMER = 0;             // Anti Connection Spammer  Açýk/True - Kapalý/False
 	 	ANTI_SERVER_FUCKER = 0;                  // Anti Server Fucker       Açýk/True - Kapalý/False
 	 	ANTI_DIALOG = 0;                         // Anti Dialog              Açýk/True - Kapalý/False
 	 	ANTI_SPEED = 0;                          // Anti Speed               Açýk/True - Kapalý/False
 	 	ANTI_COLOR_SPAMMER = 0;                  // Anti Color Spammer       Açýk/True - Kapalý/False
	 	#if MYSQL_KAYIT == true
	 	MySQLguncelle(); MySQLguncelle2();
	 	#elseif NORMAL_KAYIT == true
	 	dini_IntSet(file,"Anti_Crasher",0);
	 	dini_IntSet(file,"Anti_Con",0);
	 	dini_IntSet(file,"Anti_Ping",0);
	 	dini_IntSet(file,"Anti_Silah",0);
	 	dini_IntSet(file,"Anti_Jetpack",0);
	 	dini_IntSet(file,"Anti_Driveby",0);
	 	dini_IntSet(file,"Anti_Money",0);
	 	dini_IntSet(file,"Anti_God",0);
	 	dini_IntSet(file,"Anti_God_Car",0);
	 	dini_IntSet(file,"Anti_Spawn_Kill",0);
	 	dini_IntSet(file,"Anti_Spam",0);
	 	dini_IntSet(file,"Anti_Fall",0);
	 	dini_IntSet(file,"Anti_C_Bug",0);
	 	dini_IntSet(file,"Anti_Fake_Kill",0);
	 	dini_IntSet(file,"Anti_Rcon",0);
	 	dini_IntSet(file,"Anti_Airbreak",0);
	 	dini_IntSet(file,"Anti_Ip",0);
	 	dini_IntSet(file,"Anti_Skin",0);
	 	dini_IntSet(file,"Anti_Fly",0);
	 	dini_IntSet(file,"Anti_Sobeit",0);
 	 	dini_IntSet(file,"Anti_Motor",0);
 	 	dini_IntSet(file,"Anti_Teleport_Vehicle",0);
 	 	dini_IntSet(file,"Anti_Command_Spammer",0);
 	 	dini_IntSet(file,"Anti_Connection_Spammer",0);
 	 	dini_IntSet(file,"Anti_Server_Fucker",0);
 	 	dini_IntSet(file,"Anti_Dialog",0);
 	 	dini_IntSet(file,"Anti_Speed",0);
 	 	dini_IntSet(file,"Anti_Color_Spammer",0);
 	 	#endif
        #if LANGUAGE == 0
 		Bilgitr(playerid,"Tüm Ayarlar Baþarýyla Sýfýrlandý.");
        #elseif LANGUAGE == 1
		Bilgien(playerid,"All Settings Successfully Reset.");
        #endif
    }
    else
    {
 		SendClientMessage(playerid, 1, " ");
    }
	return 1;
}

if (strcmp(cmd, "/anticheatstatus", true) == 0 || strcmp(cmd, "/antihiledurum", true) == 0)
{
	Anticheatstatus(playerid);
	return 1;
}

if (strcmp(cmd, "/anticheatopen", true) == 0 || strcmp(cmd, "/antihileac", true) == 0)
{
	new hileac[256];

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hileac = strtok(cmdtext, index);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hileac))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihileac (Sistemler)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Sistemler");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,silah,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,rcon,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(airbreak,ip,skin,afk,fly,sobeit,motor,aracteleport,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatopen (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Systems");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,weapon,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(rcon,airbreak,ip,skin,afk,fly,sobeit,moto,teleportvehicle,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#endif
		return 1;
    }
    else if(strcmp(hileac, "crasher", true) == 0) Antiopen(playerid,1,"Anti_Crasher","Anti Crasher","Anti Crasher");
    else if(strcmp(hileac, "con", true) == 0) Antiopen(playerid,2,"Anti_Con","Anti Con","Anti Con");
    else if(strcmp(hileac, "ping", true) == 0) Antiopen(playerid,3,"Anti_Ping","Anti Ping","Anti Ping");
    else if(strcmp(hileac, "silah", true) == 0 || strcmp(hileac, "weapon", true) == 0) Antiopen(playerid,4,"Anti_Silah","Anti Silah","Anti Weapon");
    else if(strcmp(hileac, "jetpack", true) == 0) Antiopen(playerid,5,"Anti_Jetpack","Anti Jetpack","Anti Jetpack");
    else if(strcmp(hileac, "bot", true) == 0) Antiopen(playerid,6,"Anti_Bot","Anti Bot","Anti Bot");
    else if(strcmp(hileac, "driveby", true) == 0) Antiopen(playerid,7,"Anti_Driveby","Anti Drive By","Anti Drive By");
    else if(strcmp(hileac, "money", true) == 0) Antiopen(playerid,8,"Anti_Money","Anti Money","Anti Money");
    else if(strcmp(hileac, "god", true) == 0) Antiopen(playerid,9,"Anti_God","Anti God","Anti God");
    else if(strcmp(hileac, "godcar", true) == 0) Antiopen(playerid,10,"Anti_God_Car","Anti God Car","Anti God Car");
    else if(strcmp(hileac, "spawnkill", true) == 0) Antiopen(playerid,11,"Anti_Spawn_Kill","Anti Spawn Kill","Anti Spawn Kill");
    else if(strcmp(hileac, "spam", true) == 0) Antiopen(playerid,12,"Anti_Spam","Anti Spam","Anti Spam");
    else if(strcmp(hileac, "fall", true) == 0) Antiopen(playerid,13,"Anti_Fall","Anti Fall","Anti Fall");
    else if(strcmp(hileac, "cbug", true) == 0) Antiopen(playerid,14,"Anti_C_Bug","Anti C Bug","Anti C Bug");
    else if(strcmp(hileac, "fakekill", true) == 0) Antiopen(playerid,15,"Anti_Fake_Kill","Anti Fake Kill","Anti Fake Kill");
    else if(strcmp(hileac, "rcon", true) == 0) Antiopen(playerid,16,"Anti_Rcon","Anti Rcon","Anti Rcon");
    else if(strcmp(hileac, "airbreak", true) == 0) Antiopen(playerid,17,"Anti_Airbreak","Anti Airbreak","Anti Airbreak");
    else if(strcmp(hileac, "ip", true) == 0) Antiopen(playerid,18,"Anti_Ip","Anti Ip","Anti Ip");
    else if(strcmp(hileac, "skin", true) == 0) Antiopen(playerid,19,"Anti_Skin","Anti Skin","Anti Skin");
    else if(strcmp(hileac, "afk", true) == 0) Antiopen(playerid,20,"Anti_Afk","Anti Afk","Anti Afk");
    else if(strcmp(hileac, "fly", true) == 0) Antiopen(playerid,21,"Anti_Fly","Anti Fly","Anti Fly");
    else if(strcmp(hileac, "sobeit", true) == 0) Antiopen(playerid,22,"Anti_Sobeit","Anti Sobeit","Anti Sobeit");
    else if(strcmp(hileac, "motor", true) == 0 || strcmp(hileac, "moto", true) == 0) Antiopen(playerid,23,"Anti_Motor","Anti Motor Bug","Anti Moto Bug");
    else if(strcmp(hileac, "aracteleport", true) == 0 || strcmp(hileac, "teleportvehicle", true) == 0) Antiopen(playerid,24,"Anti_Teleport_Vehicle","Anti Araç Teleport","Anti Teleport Vehicle");
    else if(strcmp(hileac, "cmdspam", true) == 0) Antiopen(playerid,25,"Anti_Command_Spammer","Anti Command Spammer","Anti Command Spammer");
    else if(strcmp(hileac, "connectspam", true) == 0) Antiopen(playerid,26,"Anti_Connection_Spammer","Anti Connection Spammer","Anti Connection Spammer");
    else if(strcmp(hileac, "serverfuck", true) == 0) Antiopen(playerid,27,"Anti_Server_Fucker","Anti Server Fucker","Anti Server Fucker");
    else if(strcmp(hileac, "dialog", true) == 0) Antiopen(playerid,28,"Anti_Dialog","Anti Dialog","Anti Dialog");
    else if(strcmp(hileac, "speed", true) == 0) Antiopen(playerid,29,"Anti_Speed","Anti Speed","Anti Speed");
    else if(strcmp(hileac, "bunny", true) == 0) Antiopen(playerid,30,"Anti_Bunny_Hop","Anti Bunny Hop","Anti Bunny Hop");
    else if(strcmp(hileac, "colorspam", true) == 0) Antiopen(playerid,31,"Anti_Color_Spammer","Anti Color Spammer","Anti Color Spammer");
    else SendClientMessage(playerid, 1, " ");
	return 1;
}

if (strcmp(cmd, "/anticheatclose", true) == 0 || strcmp(cmd, "/antihilekapat", true) == 0)
{
	new hilekapat[256];

    if(!IsPlayerAdmin(playerid)) {
    #if LANGUAGE == 0
    Hatatr(playerid,"Rcon Admin Deðilsiniz.");
    #elseif LANGUAGE == 1
    Hataen(playerid,"You Are Not Rcon Admin.");
    #endif
    return 1;
    }
    hilekapat = strtok(cmdtext, index);
    #if NORMAL_KAYIT == true
    new file[256]; format(file,sizeof(file),"Anti_Hile/Ayarlar.ini");
    #endif
    if(!strlen(hilekapat))
    {
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        #if LANGUAGE == 0
 		Kullatr(playerid,"/antihilekapat (Sistemler)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Sistemler");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,silah,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,rcon,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(airbreak,ip,skin,afk,fly,sobeit,motor,aracteleport,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#elseif LANGUAGE == 1
 		Kullaen(playerid,"/anticheatclose (Systems)");
 		SendClientMessage(playerid, -3, "{FFFFFF}Systems");
 		SendClientMessage(playerid, -3, "{FFFFFF}(crasher,con,ping,weapon,jetpack,bot,driveby,money,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(god,godcar,spawnkill,spam,fall,cbug,fakekill,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(rcon,airbreak,ip,skin,afk,fly,sobeit,moto,teleportvehicle,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(cmdspam,connectspam,serverfuck,dialog,speed,)");
 		SendClientMessage(playerid, -3, "{FFFFFF}(bunny,colorspam)");
 		#endif
		return 1;
    }
    else if(strcmp(hilekapat, "crasher", true) == 0) Anticlose(playerid,1,"Anti_Crasher","Anti Crasher","Anti Crasher");
    else if(strcmp(hilekapat, "con", true) == 0) Anticlose(playerid,2,"Anti_Con","Anti Con","Anti Con");
    else if(strcmp(hilekapat, "ping", true) == 0) Anticlose(playerid,3,"Anti_Ping","Anti Ping","Anti Ping");
    else if(strcmp(hilekapat, "silah", true) == 0 || strcmp(hilekapat, "weapon", true) == 0) Anticlose(playerid,4,"Anti_Silah","Anti Silah","Anti Weapon");
    else if(strcmp(hilekapat, "jetpack", true) == 0) Anticlose(playerid,5,"Anti_Jetpack","Anti Jetpack","Anti Jetpack");
    else if(strcmp(hilekapat, "bot", true) == 0) Anticlose(playerid,6,"Anti_Bot","Anti Bot","Anti Bot");
    else if(strcmp(hilekapat, "driveby", true) == 0) Anticlose(playerid,7,"Anti_Driveby","Anti Drive By","Anti Drive By");
    else if(strcmp(hilekapat, "money", true) == 0) Anticlose(playerid,8,"Anti_Money","Anti Money","Anti Money");
    else if(strcmp(hilekapat, "god", true) == 0) Anticlose(playerid,9,"Anti_God","Anti God","Anti God");
    else if(strcmp(hilekapat, "godcar", true) == 0) Anticlose(playerid,10,"Anti_God_Car","Anti God Car","Anti God Car");
    else if(strcmp(hilekapat, "spawnkill", true) == 0) Anticlose(playerid,11,"Anti_Spawn_Kill","Anti Spawn Kill","Anti Spawn Kill");
    else if(strcmp(hilekapat, "spam", true) == 0) Anticlose(playerid,12,"Anti_Spam","Anti Spam","Anti Spam");
    else if(strcmp(hilekapat, "fall", true) == 0) Anticlose(playerid,13,"Anti_Fall","Anti Fall","Anti Fall");
    else if(strcmp(hilekapat, "cbug", true) == 0) Anticlose(playerid,14,"Anti_C_Bug","Anti C Bug","Anti C Bug");
    else if(strcmp(hilekapat, "fakekill", true) == 0) Anticlose(playerid,15,"Anti_Fake_Kill","Anti Fake Kill","Anti Fake Kill");
    else if(strcmp(hilekapat, "rcon", true) == 0) Anticlose(playerid,16,"Anti_Rcon","Anti Rcon","Anti Rcon");
    else if(strcmp(hilekapat, "airbreak", true) == 0) Anticlose(playerid,17,"Anti_Airbreak","Anti Airbreak","Anti Airbreak");
    else if(strcmp(hilekapat, "ip", true) == 0) Anticlose(playerid,18,"Anti_Ip","Anti Ip","Anti Ip");
    else if(strcmp(hilekapat, "skin", true) == 0) Anticlose(playerid,19,"Anti_Skin","Anti Skin","Anti Skin");
    else if(strcmp(hilekapat, "afk", true) == 0) Anticlose(playerid,20,"Anti_Afk","Anti Afk","Anti Afk");
    else if(strcmp(hilekapat, "fly", true) == 0) Anticlose(playerid,21,"Anti_Fly","Anti Fly","Anti Fly");
    else if(strcmp(hilekapat, "sobeit", true) == 0) Anticlose(playerid,22,"Anti_Sobeit","Anti Sobeit","Anti Sobeit");
    else if(strcmp(hilekapat, "motor", true) == 0 || strcmp(hilekapat, "moto", true) == 0) Anticlose(playerid,23,"Anti_Motor","Anti Motor Bug","Anti Moto Bug");
    else if(strcmp(hilekapat, "aracteleport", true) == 0 || strcmp(hilekapat, "teleportvehicle", true) == 0) Anticlose(playerid,24,"Anti_Teleport_Vehicle","Anti Araç Teleport","Anti Teleport Vehicle");
    else if(strcmp(hilekapat, "cmdspam", true) == 0) Anticlose(playerid,25,"Anti_Command_Spammer","Anti Command Spammer","Anti Command Spammer");
    else if(strcmp(hilekapat, "connectspam", true) == 0) Anticlose(playerid,26,"Anti_Connection_Spammer","Anti Connection Spammer","Anti Connection Spammer");
    else if(strcmp(hilekapat, "serverfuck", true) == 0) Anticlose(playerid,27,"Anti_Server_Fucker","Anti Server Fucker","Anti Server Fucker");
    else if(strcmp(hilekapat, "dialog", true) == 0) Anticlose(playerid,28,"Anti_Dialog","Anti Dialog","Anti Dialog");
    else if(strcmp(hilekapat, "speed", true) == 0) Anticlose(playerid,29,"Anti_Speed","Anti Speed","Anti Speed");
    else if(strcmp(hilekapat, "bunny", true) == 0) Anticlose(playerid,30,"Anti_Bunny_Hop","Anti Bunny Hop","Anti Bunny Hop");
    else if(strcmp(hilekapat, "colorspam", true) == 0) Anticlose(playerid,31,"Anti_Color_Spammer","Anti Color Spammer","Anti Color Spammer");
    else SendClientMessage(playerid, 1, " ");
	return 1;
}
	#endif
	return 1;
}
