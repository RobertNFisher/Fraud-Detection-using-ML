IMPORT STD;

/* CHECK 01_DATA_IMPORT_JOB.ECL TO MAKE SURE THAT YOU ECL WATCH INFORMATION IS INPUT CORRECTLY TO GET THE FILES TO SPRAY TO YOUR LANDING ZONE */

EXPORT Files := MODULE
				EXPORT file_scope := '~cap';
        EXPORT project_scope := 'transactions';
        EXPORT in_files_scope := 'in';
        EXPORT out_files_scope := 'out';
				EXPORT final_files_scope := 'results';

//Location of raw file on the landing zone -- to run a new file THE LANDING ZONE PATH IS THE ONLY THING YOU NEED TO CHANGE 
        EXPORT transactions_lz_file_path := '/var/lib/HPCCSystems/mydropzone/train_transaction.csv';

				EXPORT transactions := transactions_lz_file_path[33..(LENGTH(transactions_lz_file_path) - 4)];


//Raw file layout and dataset after it is imported into Thor
        EXPORT transactions_raw_file_path := file_scope + '::' + project_scope + '::' + in_files_scope + '::' + transactions + '.csv';
											 
											 
				EXPORT transactions_raw_layout := RECORD
					STRING TransactionID;
					STRING isFraud;
					STRING TransactionDT;
					STRING TransactionAmt;
					STRING ProductCD;
					STRING card1;
					STRING card2;
					STRING card3;
					STRING card4;
					STRING card5;
					STRING card6;
					STRING addr1;
					STRING addr2;
					STRING dist1;
					STRING dist2;
					STRING P_emaildomain;
					STRING R_emaildomain;
					STRING C1;
					STRING C2;
					STRING C3;
					STRING C4;
					STRING C5;
					STRING C6;
					STRING C7;
					STRING C8;
					STRING C9;
					STRING C10;
					STRING C11;
					STRING C12;
					STRING C13;
					STRING C14;
					STRING D1;
					STRING D2;
					STRING D3;
					STRING D4;
					STRING D5;
					STRING D6;
					STRING D7;
					STRING D8;
					STRING D9;
					STRING D10;
					STRING D11;
					STRING D12;
					STRING D13;
					STRING D14;
					STRING D15;
					STRING M1;
					STRING M2;
					STRING M3;
					STRING M4;
					STRING M5;
					STRING M6;
					STRING M7;
					STRING M8;
					STRING M9;
					STRING V1;
					STRING V2;
					STRING V3;
					STRING V4;
					STRING V5;
					STRING V6;
					STRING V7;
					STRING V8;
					STRING V9;
					STRING V10;
					STRING V11;
					STRING V12;
					STRING V13;
					STRING V14;
					STRING V15;
					STRING V16;
					STRING V17;
					STRING V18;
					STRING V19;
					STRING V20;
					STRING V21;
					STRING V22;
					STRING V23;
					STRING V24;
					STRING V25;
					STRING V26;
					STRING V27;
					STRING V28;
					STRING V29;
					STRING V30;
					STRING V31;
					STRING V32;
					STRING V33;
					STRING V34;
					STRING V35;
					STRING V36;
					STRING V37;
					STRING V38;
					STRING V39;
					STRING V40;
					STRING V41;
					STRING V42;
					STRING V43;
					STRING V44;
					STRING V45;
					STRING V46;
					STRING V47;
					STRING V48;
					STRING V49;
					STRING V50;
					STRING V51;
					STRING V52;
					STRING V53;
					STRING V54;
					STRING V55;
					STRING V56;
					STRING V57;
					STRING V58;
					STRING V59;
					STRING V60;
					STRING V61;
					STRING V62;
					STRING V63;
					STRING V64;
					STRING V65;
					STRING V66;
					STRING V67;
					STRING V68;
					STRING V69;
					STRING V70;
					STRING V71;
					STRING V72;
					STRING V73;
					STRING V74;
					STRING V75;
					STRING V76;
					STRING V77;
					STRING V78;
					STRING V79;
					STRING V80;
					STRING V81;
					STRING V82;
					STRING V83;
					STRING V84;
					STRING V85;
					STRING V86;
					STRING V87;
					STRING V88;
					STRING V89;
					STRING V90;
					STRING V91;
					STRING V92;
					STRING V93;
					STRING V94;
					STRING V95;
					STRING V96;
					STRING V97;
					STRING V98;
					STRING V99;
					STRING V100;
					STRING V101;
					STRING V102;
					STRING V103;
					STRING V104;
					STRING V105;
					STRING V106;
					STRING V107;
					STRING V108;
					STRING V109;
					STRING V110;
					STRING V111;
					STRING V112;
					STRING V113;
					STRING V114;
					STRING V115;
					STRING V116;
					STRING V117;
					STRING V118;
					STRING V119;
					STRING V120;
					STRING V121;
					STRING V122;
					STRING V123;
					STRING V124;
					STRING V125;
					STRING V126;
					STRING V127;
					STRING V128;
					STRING V129;
					STRING V130;
					STRING V131;
					STRING V132;
					STRING V133;
					STRING V134;
					STRING V135;
					STRING V136;
					STRING V137;
					STRING V138;
					STRING V139;
					STRING V140;
					STRING V141;
					STRING V142;
					STRING V143;
					STRING V144;
					STRING V145;
					STRING V146;
					STRING V147;
					STRING V148;
					STRING V149;
					STRING V150;
					STRING V151;
					STRING V152;
					STRING V153;
					STRING V154;
					STRING V155;
					STRING V156;
					STRING V157;
					STRING V158;
					STRING V159;
					STRING V160;
					STRING V161;
					STRING V162;
					STRING V163;
					STRING V164;
					STRING V165;
					STRING V166;
					STRING V167;
					STRING V168;
					STRING V169;
					STRING V170;
					STRING V171;
					STRING V172;
					STRING V173;
					STRING V174;
					STRING V175;
					STRING V176;
					STRING V177;
					STRING V178;
					STRING V179;
					STRING V180;
					STRING V181;
					STRING V182;
					STRING V183;
					STRING V184;
					STRING V185;
					STRING V186;
					STRING V187;
					STRING V188;
					STRING V189;
					STRING V190;
					STRING V191;
					STRING V192;
					STRING V193;
					STRING V194;
					STRING V195;
					STRING V196;
					STRING V197;
					STRING V198;
					STRING V199;
					STRING V200;
					STRING V201;
					STRING V202;
					STRING V203;
					STRING V204;
					STRING V205;
					STRING V206;
					STRING V207;
					STRING V208;
					STRING V209;
					STRING V210;
					STRING V211;
					STRING V212;
					STRING V213;
					STRING V214;
					STRING V215;
					STRING V216;
					STRING V217;
					STRING V218;
					STRING V219;
					STRING V220;
					STRING V221;
					STRING V222;
					STRING V223;
					STRING V224;
					STRING V225;
					STRING V226;
					STRING V227;
					STRING V228;
					STRING V229;
					STRING V230;
					STRING V231;
					STRING V232;
					STRING V233;
					STRING V234;
					STRING V235;
					STRING V236;
					STRING V237;
					STRING V238;
					STRING V239;
					STRING V240;
					STRING V241;
					STRING V242;
					STRING V243;
					STRING V244;
					STRING V245;
					STRING V246;
					STRING V247;
					STRING V248;
					STRING V249;
					STRING V250;
					STRING V251;
					STRING V252;
					STRING V253;
					STRING V254;
					STRING V255;
					STRING V256;
					STRING V257;
					STRING V258;
					STRING V259;
					STRING V260;
					STRING V261;
					STRING V262;
					STRING V263;
					STRING V264;
					STRING V265;
					STRING V266;
					STRING V267;
					STRING V268;
					STRING V269;
					STRING V270;
					STRING V271;
					STRING V272;
					STRING V273;
					STRING V274;
					STRING V275;
					STRING V276;
					STRING V277;
					STRING V278;
					STRING V279;
					STRING V280;
					STRING V281;
					STRING V282;
					STRING V283;
					STRING V284;
					STRING V285;
					STRING V286;
					STRING V287;
					STRING V288;
					STRING V289;
					STRING V290;
					STRING V291;
					STRING V292;
					STRING V293;
					STRING V294;
					STRING V295;
					STRING V296;
					STRING V297;
					STRING V298;
					STRING V299;
					STRING V300;
					STRING V301;
					STRING V302;
					STRING V303;
					STRING V304;
					STRING V305;
					STRING V306;
					STRING V307;
					STRING V308;
					STRING V309;
					STRING V310;
					STRING V311;
					STRING V312;
					STRING V313;
					STRING V314;
					STRING V315;
					STRING V316;
					STRING V317;
					STRING V318;
					STRING V319;
					STRING V320;
					STRING V321;
					STRING V322;
					STRING V323;
					STRING V324;
					STRING V325;
					STRING V326;
					STRING V327;
					STRING V328;
					STRING V329;
					STRING V330;
					STRING V331;
					STRING V332;
					STRING V333;
					STRING V334;
					STRING V335;
					STRING V336;
					STRING V337;
					STRING V338;
					STRING V339;
				END;
				
				
        EXPORT transactions_raw_ds := DATASET(transactions_raw_file_path, transactions_raw_layout, CSV(HEADING(1)));

//EXPORT Data Profile report on the Raw File. Use the report output to understand your data and validate the assumptions you would have made.
        EXPORT transactions_data_patterns_raw_file_path := file_scope + '::' + project_scope + '::' + out_files_scope +  '::' + transactions + '_raw_data_patterns.thor';
				
  //Cleaned file layout and dataset. The cleaned file is created after cleaning the raw file.
       EXPORT transactions_clean_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + transactions + '_clean.thor';
        
        EXPORT transactions_clean_layout := RECORD
					UNSIGNED4 TransactionID;		//Tells with 1 or 0 if the transaction is fruadulent, 1 being true
					UNSIGNED1 isFraud;
					UNSIGNED4 TransactionDT;		//TransactionDT: timedelta from a given reference datetime (not an actual timestamp)
																					//“TransactionDT first value is 86400, which corresponds to the number of seconds in a day (60 * 60 * 24 = 86400) 
																					//so I think the unit is seconds. Using this, we know the data spans 6 months, as the maximum value is 15811131, 
																					//which would correspond to day 183.”
					REAL8 TransactionAmt;
					STRING1 ProductCD;					//ProductCD: product code, the product for each transaction
																					//“Product isn't necessary to be a real 'product' (like one item to be added to the shopping cart).
																					//It could be any kind of service.”
					UNSIGNED3 cInfo1;
					REAL4 cInfo2;
					REAL4 cInfo3;
					STRING16 cInfo4;
					REAL4 cInfo5;
					STRING15 cInfo6;
					REAL4 addr1;								//addr1 + " " + addr2 = entire card holders address.
					REAL4 addr2;
					REAL4 dist1;								//dist1+dist2 = distances between (not limited) 
																					//billing address, mailing address, zip code, IP address, phone area, etc.
																					// kept secret for privacy
					REAL4 dist2;
					STRING16 P_emaildomain;		//P_ purchaser R_ Recipient
					STRING16 R_emaildomain;
					//C1-C14: counting, such as how many addresses are found to be associated with the payment card, etc.
									//The actual meaning is masked.
									//“Can you please give more examples of counts in the variables C1-15? Would these be like counts of phone numbers, email addresses, names associated with the user? I can't think of 15.
									//Your guess is good, plus like device, ipaddr, billingaddr, etc. 
									//Also these are for both purchaser and recipient, which doubles the number.”
											//Maybe combine these?
					REAL4 associated_addr1;
					REAL4 associated_addr2;
					REAL4 associated_addr3;
					REAL4 associated_addr4;
					REAL4 associated_addr5;
					REAL4 associated_addr6;
					REAL4 associated_addr7;
					REAL4 associated_addr8;
					REAL4 associated_addr9;
					REAL4 associated_addr10;
					REAL4 associated_addr11;
					REAL4 associated_addr12;
					REAL4 associated_addr13;
					REAL4 associated_addr14;
		
			//D1-D15: timedelta, such as days between previous transaction, etc.
					REAL4 time_delta1;
					REAL4 time_delta2;
					REAL4 time_delta3;
					REAL4 time_delta4;
					REAL4 time_delta5;
					REAL4 time_delta6;
					REAL4 time_delta7;
					STRING19 time_delta8;
					STRING19 time_delta9;
					REAL4 time_delta10;
					REAL4 time_delta11;
					REAL4 time_delta12;
					REAL4 time_delta13;
					REAL4 time_delta14;
					REAL4 time_delta15;
					//M1-M9: match, such as names on card and address, etc.
							//Mx is attribute of matching check, e.g. is phone areacode matched with billing zipcode,
							//purchaser and recipient first/or last name match, etc.
					STRING1 match1;
					STRING1 match2;
					STRING1 match3;
					STRING2 match4;
					STRING1 match5;
					STRING1 match6;
					STRING1 match7;
					STRING1 match8;
					STRING1 match9;
			END;

        EXPORT transactions_clean_ds := DATASET(transactions_clean_file_path, transactions_clean_layout, THOR);
	
				
 //ENRICHED RECORD LAYOUT, PATH, AND DATASET		-- here the cross-posted sub is confirmed to exist and the base36_ID of that sub is substituted for the name
				EXPORT transactions_enriched_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + transactions + '_enriched_results.thor';
				
				EXPORT transactions_enriched_layout := RECORD
					UNSIGNED4 TransactionID;		//Tells with 1 or 0 if the transaction is fruadulent, 1 being true
					UNSIGNED1 isFraud;
					UNSIGNED4 TransactionDT;		//TransactionDT: timedelta from a given reference datetime (not an actual timestamp)
																					//“TransactionDT first value is 86400, which corresponds to the number of seconds in a day (60 * 60 * 24 = 86400) 
																					//so I think the unit is seconds. Using this, we know the data spans 6 months, as the maximum value is 15811131, 
																					//which would correspond to day 183.”
					REAL8 TransactionAmt;
					STRING1 ProductCD;					//ProductCD: product code, the product for each transaction
																					//“Product isn't necessary to be a real 'product' (like one item to be added to the shopping cart).
																					//It could be any kind of service.”
					UNSIGNED3 cInfo1;
					REAL4 cInfo2;
					REAL4 cInfo3;
					STRING16 cInfo4;
					REAL4 cInfo5;
					STRING15 cInfo6;
					REAL4 addr1;								//addr1 + " " + addr2 = entire card holders address.
					REAL4 addr2;
					REAL4 dist1;								//dist1+dist2 = distances between (not limited) 
																					//billing address, mailing address, zip code, IP address, phone area, etc.
																					// kept secret for privacy
					REAL4 dist2;
					STRING16 P_emaildomain;		//P_ purchaser R_ Recipient
					STRING16 R_emaildomain;
					//C1-C14: counting, such as how many addresses are found to be associated with the payment card, etc.
									//The actual meaning is masked.
									//“Can you please give more examples of counts in the variables C1-15? Would these be like counts of phone numbers, email addresses, names associated with the user? I can't think of 15.
									//Your guess is good, plus like device, ipaddr, billingaddr, etc. 
									//Also these are for both purchaser and recipient, which doubles the number.”
											//Maybe combine these?
					REAL4 associated_addr1;
					REAL4 associated_addr2;
					REAL4 associated_addr3;
					REAL4 associated_addr4;
					REAL4 associated_addr5;
					REAL4 associated_addr6;
					REAL4 associated_addr7;
					REAL4 associated_addr8;
					REAL4 associated_addr9;
					REAL4 associated_addr10;
					REAL4 associated_addr11;
					REAL4 associated_addr12;
					REAL4 associated_addr13;
					REAL4 associated_addr14;
		
			//D1-D15: timedelta, such as days between previous transaction, etc.
					REAL4 time_delta1;
					REAL4 time_delta2;
					REAL4 time_delta3;
					REAL4 time_delta4;
					REAL4 time_delta5;
					REAL4 time_delta6;
					REAL4 time_delta7;
					STRING19 time_delta8;
					STRING19 time_delta9;
					REAL4 time_delta10;
					REAL4 time_delta11;
					REAL4 time_delta12;
					REAL4 time_delta13;
					REAL4 time_delta14;
					REAL4 time_delta15;
					//M1-M9: match, such as names on card and address, etc.
							//Mx is attribute of matching check, e.g. is phone areacode matched with billing zipcode,
							//purchaser and recipient first/or last name match, etc.
					STRING1 match1;
					STRING1 match2;
					STRING1 match3;
					STRING2 match4;
					STRING1 match5;
					STRING1 match6;
					STRING1 match7;
					STRING1 match8;
					STRING1 match9;
					REAL4 id_01;
					REAL8 id_02;
					REAL4 id_03;
					REAL4 id_04;
					REAL4 id_05;
					REAL4 id_06;
					REAL4 id_07;
					REAL4 id_08;
					REAL4 id_09;
					REAL4 id_10;
					REAL4 id_11;
					REAL8 id_12;
					REAL4 id_13;
					REAL4 id_14;
					STRING7 id_15;
					STRING8 id_16;
					REAL4 id_17;
					REAL4 id_18;
					REAL4 id_19;
					REAL4 id_20;
					REAL4 id_21;
					REAL4 id_22;
					STRING20 id_23;
					REAL4 id_24;
					REAL4 id_25;
					REAL4 id_26;
					STRING8 id_27;
					STRING5 id_28;
					STRING8 id_29;
					STRING16 id_30;
					STRING30 id_31;
					REAL4 id_32;
					STRING9 id_33;
					STRING15 id_34;
					STRING1 id_35;
					STRING1 id_36;
					STRING1 id_37;
					STRING1 id_38;
					STRING7 DeviceType;
					STRING43 DeviceInfo;
			END;
				
	//			EXPORT transactions_enriched_ds := DATASET(transactions_enriched_file_path, transactions_enriched_layout, THOR);
				
				
//transactions DIRECTORY RECORD LAYOUT AND DATASET	
		//		EXPORT transactions_directory_layout := RECORD
		//			  UNSIGNED4 base10_id;
	//					STRING8 base36_id;
					//	STRING24 transactions_name;
				//		UNSIGNED4 subscribers;
			//	END;
				
				//EXPORT transactions_directory := DATASET('~cr::transactions_directory::out::transactions_directory_clean.thor', transactions_directory_layout, THOR);
				
//MASTER OUTPUT RECORD LAYOUT AND DATASET	
				//this file contains a list of the top 2500 subs and their base36_IDs (if found in directory)
			//	EXPORT MASTER_FILE_PATH := '~cr::transactionss_directory::out::MASTER_OUTPUT.thor';
			
		//		EXPORT transactionss_master_output_layout := RECORD
		//				STRING8  to_base36_id;					  
		//				STRING24 to_transactions_name;
	//			END;			

				//EXPORT MASTER_FILE := DATASET(MASTER_FILE_PATH, transactionss_master_output_layout, THOR);
				
			//	EXPORT CHILD_FILE_PATH := file_scope + '::' + project_scope + '::' + final_files_scope + '::' + transactions + '_master_results.thor';
			
 END;