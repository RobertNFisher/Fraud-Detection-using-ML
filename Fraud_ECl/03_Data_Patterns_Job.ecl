IMPORT  Fraud_ECL;
IMPORT DataPatterns;

rawTransactionsData := Fraud_ECL.Files.transactions_raw_ds;
OUTPUT(rawTransactionsData, NAMED('rawTransactionsDataSample'));

rawTransactionsProfileResults := DataPatterns.Profile(rawTransactionsData, features := 'fill_rate,cardinality,best_ecl_types,lengths,patterns,modes');
OUTPUT(rawTransactionsProfileResults,,Fraud_ECL.Files.transactions_data_patterns_raw_file_path, OVERWRITE);