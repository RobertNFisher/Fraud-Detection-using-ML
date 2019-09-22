﻿IMPORT STD;

/* CHECK 01_DATA_IMPORT_JOB.ECL TO MAKE SURE THAT YOU ECL WATCH INFORMATION IS INPUT CORRECTLY TO GET THE FILES TO SPRAY TO YOUR LANDING ZONE */

EXPORT Files := MODULE
				EXPORT file_scope := '~cap';
        EXPORT project_scope := 'transactions_identity';
        EXPORT in_files_scope := 'in';
        EXPORT out_files_scope := 'out';
				EXPORT final_files_scope := 'results';

//Location of raw file on the landing zone -- to run a new file THE LANDING ZONE PATH IS THE ONLY THING YOU NEED TO CHANGE 
        EXPORT identity_lz_file_path := '/var/lib/HPCCSystems/mydropzone/train_identity.csv';

				EXPORT identity := identity_lz_file_path[33..(LENGTH(identity_lz_file_path) - 4)];


//Raw file layout and dataset after it is imported into Thor
        EXPORT identity_raw_file_path := file_scope + '::' + project_scope + '::' + in_files_scope + '::' + identity + '.csv';
											 
											 
				EXPORT identity_raw_layout := RECORD
					STRING TransactionID;
					STRING id_01;
					STRING id_02;
					STRING id_03;
					STRING id_04;
					STRING id_05;
					STRING id_06;
					STRING id_07;
					STRING id_08;
					STRING id_09;
					STRING id_10;
					STRING id_11;
					STRING id_12;
					STRING id_13;
					STRING id_14;
					STRING id_15;
					STRING id_16;
					STRING id_17;
					STRING id_18;
					STRING id_19;
					STRING id_20;
					STRING id_21;
					STRING id_22;
					STRING id_23;
					STRING id_24;
					STRING id_25;
					STRING id_26;
					STRING id_27;
					STRING id_28;
					STRING id_29;
					STRING id_30;
					STRING id_31;
					STRING id_32;
					STRING id_33;
					STRING id_34;
					STRING id_35;
					STRING id_36;
					STRING id_37;
					STRING id_38;
					STRING DeviceType;
					STRING DeviceInfo;
				END;
				
				
        EXPORT identity_raw_ds := DATASET(identity_raw_file_path, identity_raw_layout, CSV(HEADING(1)));

//EXPORT Data Profile report on the Raw File. Use the report output to understand your data and validate the assumptions you would have made.
        EXPORT identity_data_patterns_raw_file_path := file_scope + '::' + project_scope + '::' + out_files_scope +  '::' + identity + '_raw_data_patterns.thor';
				
 //Cleaned file layout and dataset. The cleaned file is created after cleaning the raw file.
        EXPORT identity_clean_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + identity + '_clean.thor';
        
        EXPORT identity_clean_layout := RECORD
					UNSIGNED4 TransactionID;
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

        EXPORT identity_clean_ds := DATASET(identity_clean_file_path, identity_clean_layout, THOR);   

// PARSED RECORD LAYOUT, PATH, AND DATASET		
			//	EXPORT identity_parsed_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + identity + '_parsed_results.thor';
				//EXPORT identity_parsed_layout := RECORD
//						STRING8 identity_id;    						//base36 identity ID
//						STRING9 post_ID;				  					//FORMERLY 'NAME'
//						STRING title;												//full title text
	//					STRING100 cross_phrase;							//full pattern match found
	//					STRING30 cross_identity_phrase;		//whole phrase relating to crossposted identity
	//					STRING24 cross_identity_name;			//just the name of the crossposted identity (no 'r') -- CONVERTED TO LOWERCASE
	//					STRING8 cross_identity_ID;				  //base36_ID of cross-posted identity 
	//			END;
				
	//			EXPORT identity_parsed_ds := DATASET(identity_parsed_file_path, identity_parsed_layout, THOR);
				
 //ENRICHED RECORD LAYOUT, PATH, AND DATASET		-- here the cross-posted sub is confirmed to exist and the base36_ID of that sub is substituted for the name
	//			EXPORT identity_enriched_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::' + identity + '_enriched_results.thor';
	//			EXPORT identity_enriched_layout := RECORD
	//					STRING8 identity_id;    						//base36 identity ID
	//					STRING9 post_ID;				  					//FORMERLY 'NAME'
	//					STRING title;										//full title text
	//					STRING100 cross_phrase;							//full pattern match found
	//					STRING30 cross_identity_phrase;		//whole phrase relating to crossposted identity
	//					STRING24 cross_identity_name;			//just the name of the crossposted identity (no 'r') 
	//					STRING8 cross_identity_ID;				  //base36_ID of cross-posted identity 
	//			END;
				
	//			EXPORT identity_enriched_ds := DATASET(identity_enriched_file_path, identity_enriched_layout, THOR);
				
				
//identity DIRECTORY RECORD LAYOUT AND DATASET	
		//		EXPORT identity_directory_layout := RECORD
		//			  UNSIGNED4 base10_id;
	//					STRING8 base36_id;
					//	STRING24 identity_name;
				//		UNSIGNED4 subscribers;
			//	END;
				
				//EXPORT identity_directory := DATASET('~cr::identity_directory::out::identity_directory_clean.thor', identity_directory_layout, THOR);
				
//MASTER OUTPUT RECORD LAYOUT AND DATASET	
				//this file contains a list of the top 2500 subs and their base36_IDs (if found in directory)
			//	EXPORT MASTER_FILE_PATH := '~cr::identitys_directory::out::MASTER_OUTPUT.thor';
			
		//		EXPORT identitys_master_output_layout := RECORD
		//				STRING8  to_base36_id;					  
		//				STRING24 to_identity_name;
	//			END;			

				//EXPORT MASTER_FILE := DATASET(MASTER_FILE_PATH, identitys_master_output_layout, THOR);
				
			//	EXPORT CHILD_FILE_PATH := file_scope + '::' + project_scope + '::' + final_files_scope + '::' + identity + '_master_results.thor';
			
 END;