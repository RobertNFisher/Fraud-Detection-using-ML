IMPORT STD;

/* CHECK 01_DATA_IMPORT_JOB.ECL TO MAKE SURE THAT YOU ECL WATCH INFORMATION IS INPUT CORRECTLY TO GET THE FILES TO SPRAY TO YOUR LANDING ZONE */

EXPORT Files := MODULE
				EXPORT file_scope := '~cap';
        EXPORT project_scope := 'transactions';
        EXPORT in_files_scope := 'in';
        EXPORT out_files_scope := 'out';
				EXPORT final_files_scope := 'results';

//Location of raw file on the landing zone -- to run a new file THE LANDING ZONE PATH IS THE ONLY THING YOU NEED TO CHANGE 
        EXPORT transactions_lz_file_path := '/var/lib/HPCCSystems/mydropzone/Removed_Features.csv';

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
					STRING dist1;
					STRING dist2;
					STRING P_emaildomain;
					STRING R_emaildomain;
					STRING C3;
					STRING C9;
					STRING C13;
					STRING D2;
					STRING D3;
					STRING D4;
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
					STRING V5;
					STRING V7;
					STRING V8;
					STRING V12;
					STRING V14;
					STRING V19;
					STRING V24;
					STRING V25;
					STRING V27;
					STRING V28;
					STRING V36;
					STRING V38;
					STRING V44;
					STRING V46;
					STRING V47;
					STRING V54;
					STRING V55;
					STRING V56;
					STRING V61;
					STRING V67;
					STRING V75;
					STRING V77;
					STRING V78;
					STRING V83;
					STRING V86;
					STRING V88;
					STRING V89;
					STRING V107;
					STRING V108;
					STRING V109;
					STRING V110;
					STRING V112;
					STRING V113;
					STRING V114;
					STRING V115;
					STRING V116;
					STRING V118;
					STRING V119;
					STRING V121;
					STRING V122;
					STRING V124;
					STRING V130;
					STRING V138;
					STRING V140;
					STRING V142;
					STRING V144;
					STRING V146;
					STRING V169;
					STRING V173;
					STRING V174;
					STRING V184;
					STRING V185;
					STRING V188;
					STRING V194;
					STRING V200;
					STRING V206;
					STRING V209;
					STRING V210;
					STRING V220;
					STRING V223;
					STRING V239;
					STRING V240;
					STRING V250;
					STRING V258;
					STRING V260;
					STRING V262;
					STRING V269;
					STRING V270;
					STRING V281;
					STRING V282;
					STRING V283;
					STRING V284;
					STRING V286;
					STRING V289;
					STRING V290;
					STRING V300;
					STRING V305;
					STRING V311;
					STRING V313;
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
					REAL4 associated_addr3;
					REAL4 associated_addr9;
					REAL4 associated_addr13;
					
			//D1-D15: timedelta, such as days between previous transaction, etc.
					REAL4 time_delta2;
					REAL4 time_delta3;
					REAL4 time_delta4;
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
					
					REAL4 V1;
					REAL4 V2;
					REAL4 V5;
					REAL4 V7;
					REAL4 V8;
					REAL4 V12;
					REAL4 V14;
					REAL4 V19;
					REAL4 V24;
					REAL4 V25;
					REAL4 V27;
					REAL4 V28;
					REAL4 V36;
					REAL4 V38;
					REAL4 V44;
					REAL4 V46;
					REAL4 V47;
					REAL4 V54;
					REAL4 V55;
					REAL4 V56;
					REAL4 V61;
					REAL4 V67;
					REAL4 V75;
					REAL4 V77;
					REAL4 V78;
					REAL4 V83;
					REAL4 V86;
					REAL4 V88;
					REAL4 V89;
					REAL4 V107;
					REAL4 V108;
					REAL4 V109;
					REAL4 V110;
					REAL4 V112;
					REAL4 V113;
					REAL4 V114;
					REAL4 V115;
					REAL4 V116;
					REAL4 V118;
					REAL4 V119;
					REAL4 V121;
					REAL4 V122;
					REAL4 V124;
					UNSIGNED DECIMAL15 V130;
					REAL4 V138;
					REAL4 V140;
					REAL4 V142;
					REAL4 V144;
					REAL4 V146;
					REAL4 V169;
					REAL4 V173;
					REAL4 V174;
					REAL4 V184;
					REAL4 V185;
					REAL4 V188;
					REAL4 V194;
					REAL4 V200;
					UNSIGNED DECIMAL15 V206;
					UNSIGNED DECIMAL15 V209;
					UNSIGNED DECIMAL15 V210;
					REAL4 V220;
					REAL4 V223;
					REAL4 V239;
					REAL4 V240;
					REAL4 V250;
					REAL4 V258;
					REAL4 V260;
					REAL4 V262;
					UNSIGNED DECIMAL9 V269;
					UNSIGNED DECIMAL15 V270;
					REAL4 V281;
					REAL4 V282;
					REAL4 V283;
					REAL4 V284;
					REAL4 V286;
					REAL4 V289;
					REAL4 V290;
					REAL4 V300;
					REAL4 V305;
					UNSIGNED DECIMAL15 V311;
					UNSIGNED DECIMAL15 V313;
			END;

        EXPORT transactions_clean_ds := DATASET(transactions_clean_file_path, transactions_clean_layout, THOR);
	
				
 //ENRICHED RECORD LAYOUT, PATH, AND DATASET		
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
					REAL4 associated_addr3;
					REAL4 associated_addr9;
					REAL4 associated_addr13;
					
			//D1-D15: timedelta, such as days between previous transaction, etc.
					REAL4 time_delta2;
					REAL4 time_delta3;
					REAL4 time_delta4;
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
					
					REAL4 V1;
					REAL4 V2;
					REAL4 V5;
					REAL4 V7;
					REAL4 V8;
					REAL4 V12;
					REAL4 V14;
					REAL4 V19;
					REAL4 V24;
					REAL4 V25;
					REAL4 V27;
					REAL4 V28;
					REAL4 V36;
					REAL4 V38;
					REAL4 V44;
					REAL4 V46;
					REAL4 V47;
					REAL4 V54;
					REAL4 V55;
					REAL4 V56;
					REAL4 V61;
					REAL4 V67;
					REAL4 V75;
					REAL4 V77;
					REAL4 V78;
					REAL4 V83;
					REAL4 V86;
					REAL4 V88;
					REAL4 V89;
					REAL4 V107;
					REAL4 V108;
					REAL4 V109;
					REAL4 V110;
					REAL4 V112;
					REAL4 V113;
					REAL4 V114;
					REAL4 V115;
					REAL4 V116;
					REAL4 V118;
					REAL4 V119;
					REAL4 V121;
					REAL4 V122;
					REAL4 V124;
					UNSIGNED DECIMAL15 V130;
					REAL4 V138;
					REAL4 V140;
					REAL4 V142;
					REAL4 V144;
					REAL4 V146;
					REAL4 V169;
					REAL4 V173;
					REAL4 V174;
					REAL4 V184;
					REAL4 V185;
					REAL4 V188;
					REAL4 V194;
					REAL4 V200;
					UNSIGNED DECIMAL15 V206;
					UNSIGNED DECIMAL15 V209;
					UNSIGNED DECIMAL15 V210;
					REAL4 V220;
					REAL4 V223;
					REAL4 V239;
					REAL4 V240;
					REAL4 V250;
					REAL4 V258;
					REAL4 V260;
					REAL4 V262;
					UNSIGNED DECIMAL9 V269;
					UNSIGNED DECIMAL15 V270;
					REAL4 V281;
					REAL4 V282;
					REAL4 V283;
					REAL4 V284;
					REAL4 V286;
					REAL4 V289;
					REAL4 V290;
					REAL4 V300;
					REAL4 V305;
					UNSIGNED DECIMAL15 V311;
					UNSIGNED DECIMAL15 V313;
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
				
				EXPORT transactions_enriched_ds := DATASET(transactions_enriched_file_path, transactions_enriched_layout, THOR);
			
//LOGISTIC REGRESSION RECORD LAYOUT, PATH, AND DATASET		-- ML MODEL
				EXPORT transactions_logreg_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + transactions + '_logistic_regression_results.thor';
				
				EXPORT transactions_logreg_layout := RECORD
					UNSIGNED4 TransactionID;		
					UNSIGNED1 isFraud;
					UNSIGNED4 TransactionDT;		
					REAL8 TransactionAmt;
					//STRING1 ProductCD;	
					UNSIGNED3 cInfo1;
					REAL4 cInfo2;
					REAL4 cInfo3;
					//STRING16 cInfo4;
					REAL4 cInfo5;
					//STRING15 cInfo6;
					REAL4 addr1;
					REAL4 dist1;
					REAL4 dist2;
					//STRING16 P_emaildomain;		
					//STRING16 R_emaildomain;
					REAL4 associated_addr3;
					REAL4 associated_addr9;
					REAL4 associated_addr13;		
					REAL4 time_delta2;
					REAL4 time_delta3;
					REAL4 time_delta4;
					REAL4 time_delta7;
					//STRING19 time_delta8;
					//STRING19 time_delta9;
					REAL4 time_delta10;
					REAL4 time_delta11;
					REAL4 time_delta12;
					REAL4 time_delta13;
					REAL4 time_delta14;
					REAL4 time_delta15;
					//STRING1 match1;
					//STRING1 match2;
					//STRING1 match3;
					//STRING2 match4;
					//STRING1 match5;
					//STRING1 match6;
					//STRING1 match7;
					//STRING1 match8;
					//STRING1 match9;
					REAL4 V1;
					REAL4 V2;
					REAL4 V5;
					REAL4 V7;
					REAL4 V8;
					REAL4 V12;
					REAL4 V14;
					REAL4 V19;
					REAL4 V24;
					REAL4 V25;
					REAL4 V27;
					REAL4 V28;
					REAL4 V36;
					REAL4 V38;
					REAL4 V44;
					REAL4 V46;
					REAL4 V47;
					REAL4 V54;
					REAL4 V55;
					REAL4 V56;
					REAL4 V61;
					REAL4 V67;
					REAL4 V75;
					REAL4 V77;
					REAL4 V78;
					REAL4 V83;
					REAL4 V86;
					REAL4 V88;
					REAL4 V89;
					REAL4 V107;
					REAL4 V108;
					REAL4 V109;
					REAL4 V110;
					REAL4 V112;
					REAL4 V113;
					REAL4 V114;
					REAL4 V115;
					REAL4 V116;
					REAL4 V118;
					REAL4 V119;
					REAL4 V121;
					REAL4 V122;
					REAL4 V124;
					UNSIGNED DECIMAL15 V130;
					REAL4 V138;
					REAL4 V140;
					REAL4 V142;
					REAL4 V144;
					REAL4 V146;
					REAL4 V169;
					REAL4 V173;
					REAL4 V174;
					REAL4 V184;
					REAL4 V185;
					REAL4 V188;
					REAL4 V194;
					REAL4 V200;
					UNSIGNED DECIMAL15 V206;
					UNSIGNED DECIMAL15 V209;
					UNSIGNED DECIMAL15 V210;
					REAL4 V220;
					REAL4 V223;
					REAL4 V239;
					REAL4 V240;
					REAL4 V250;
					REAL4 V258;
					REAL4 V260;
					REAL4 V262;
					UNSIGNED DECIMAL9 V269;
					UNSIGNED DECIMAL15 V270;
					REAL4 V281;
					REAL4 V282;
					REAL4 V283;
					REAL4 V284;
					REAL4 V286;
					REAL4 V289;
					REAL4 V290;
					REAL4 V300;
					REAL4 V305;
					UNSIGNED DECIMAL15 V311;
					UNSIGNED DECIMAL15 V313;
			END;
				
				EXPORT transactions_logreg_ds := DATASET(transactions_logreg_file_path, transactions_logreg_layout, THOR);
				
//RANDOM TREES CLASSIFICATION RECORD LAYOUT, PATH, AND DATASET		-- ML MODEL
				EXPORT transactions_randforest_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + transactions + '_random_forest_results.thor';
				
				EXPORT transactions_randforest_layout := RECORD
					UNSIGNED4 TransactionID;		
					UNSIGNED1 isFraud;
					UNSIGNED4 TransactionDT;		
					REAL8 TransactionAmt;
					//STRING1 ProductCD;	
					UNSIGNED3 cInfo1;
					REAL4 cInfo2;
					REAL4 cInfo3;
					//STRING16 cInfo4;
					REAL4 cInfo5;
					//STRING15 cInfo6;
					REAL4 addr1;
					REAL4 dist1;
					REAL4 dist2;
					//STRING16 P_emaildomain;		
					//STRING16 R_emaildomain;
					REAL4 associated_addr3;
					REAL4 associated_addr9;
					REAL4 associated_addr13;		
					REAL4 time_delta2;
					REAL4 time_delta3;
					REAL4 time_delta4;
					REAL4 time_delta7;
					//STRING19 time_delta8;
					//STRING19 time_delta9;
					REAL4 time_delta10;
					REAL4 time_delta11;
					REAL4 time_delta12;
					REAL4 time_delta13;
					REAL4 time_delta14;
					REAL4 time_delta15;
					//STRING1 match1;
					//STRING1 match2;
					//STRING1 match3;
					//STRING2 match4;
					//STRING1 match5;
					//STRING1 match6;
					//STRING1 match7;
					//STRING1 match8;
					//STRING1 match9;
					REAL4 V1;
					REAL4 V2;
					REAL4 V5;
					REAL4 V7;
					REAL4 V8;
					REAL4 V12;
					REAL4 V14;
					REAL4 V19;
					REAL4 V24;
					REAL4 V25;
					REAL4 V27;
					REAL4 V28;
					REAL4 V36;
					REAL4 V38;
					REAL4 V44;
					REAL4 V46;
					REAL4 V47;
					REAL4 V54;
					REAL4 V55;
					REAL4 V56;
					REAL4 V61;
					REAL4 V67;
					REAL4 V75;
					REAL4 V77;
					REAL4 V78;
					REAL4 V83;
					REAL4 V86;
					REAL4 V88;
					REAL4 V89;
					REAL4 V107;
					REAL4 V108;
					REAL4 V109;
					REAL4 V110;
					REAL4 V112;
					REAL4 V113;
					REAL4 V114;
					REAL4 V115;
					REAL4 V116;
					REAL4 V118;
					REAL4 V119;
					REAL4 V121;
					REAL4 V122;
					REAL4 V124;
					UNSIGNED DECIMAL15 V130;
					REAL4 V138;
					REAL4 V140;
					REAL4 V142;
					REAL4 V144;
					REAL4 V146;
					REAL4 V169;
					REAL4 V173;
					REAL4 V174;
					REAL4 V184;
					REAL4 V185;
					REAL4 V188;
					REAL4 V194;
					REAL4 V200;
					UNSIGNED DECIMAL15 V206;
					UNSIGNED DECIMAL15 V209;
					UNSIGNED DECIMAL15 V210;
					REAL4 V220;
					REAL4 V223;
					REAL4 V239;
					REAL4 V240;
					REAL4 V250;
					REAL4 V258;
					REAL4 V260;
					REAL4 V262;
					UNSIGNED DECIMAL9 V269;
					UNSIGNED DECIMAL15 V270;
					REAL4 V281;
					REAL4 V282;
					REAL4 V283;
					REAL4 V284;
					REAL4 V286;
					REAL4 V289;
					REAL4 V290;
					REAL4 V300;
					REAL4 V305;
					UNSIGNED DECIMAL15 V311;
					UNSIGNED DECIMAL15 V313;
				END;
				
				EXPORT transactions_randforest_ds := DATASET(transactions_randforest_file_path, transactions_randforest_layout, THOR);
			
 END;