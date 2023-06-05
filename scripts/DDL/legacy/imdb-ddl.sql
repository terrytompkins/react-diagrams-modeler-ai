CREATE SCHEMA amdb_qa01;

CREATE TABLE `APPLICATION` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`NAME`               varchar(100)  NOT NULL    ,
	`API_KEY`            varchar(255)      ,
	`AUTHORIZATIONS`     varchar(255)      ,
	`STORE_LOGGING_DISABLED` tinyint      ,
	`SEARCH_LOGGING_DISABLED` tinyint      
 );

CREATE TABLE `APPLICATION_LEVEL_DAYS` ( 
	`APPLICATION_ID`     varchar(255)  NOT NULL    ,
	`IDEXX_LEVEL_ID`     int  NOT NULL    ,
	`DAYS`               int      
 );

CREATE INDEX `IDX_APPLICATION_LEVEL_DAYS_FK0` ON `APPLICATION_LEVEL_DAYS` ( `APPLICATION_ID` );

CREATE TABLE `ASSET_FILE_TYPE` ( 
	`ID`                 int  NOT NULL DEFAULT 0   PRIMARY KEY,
	`NAME`               varchar(100)  NOT NULL    
 );

CREATE TABLE `ASSUMED_ISSUER` ( 
	`SAP_ID`             varchar(100)  NOT NULL    PRIMARY KEY,
	`ASSUMED_ISSUER_VALUE` varchar(100)      ,
	`CREATED_DATE_TIME`  timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`LAST_UPDATED_DATE_TIME` datetime      
 );

CREATE TABLE `CLINIC` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`NAME`               varchar(100)  NOT NULL    
 );

CREATE TABLE `CLINIC_PROPERTY` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`CLINIC_ID`          varchar(255)  NOT NULL    ,
	`PROPERTY_NAME`      varchar(255)  NOT NULL    ,
	`PROPERTY_VALUE`     varchar(16000)      
 );

CREATE INDEX `IDX_CLINIC_PROPERTY_FK1` ON `CLINIC_PROPERTY` ( `CLINIC_ID` );

CREATE TABLE `CUSTOM_ATTRIBUTES_ARCHIVE` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   ,
	`IMAGE_ID`           varchar(255)  NOT NULL    ,
	`NAME`               varchar(512)      ,
	`VALUE`              varchar(10240)      
 );

CREATE TABLE `DATABASECHANGELOG` ( 
	`ID`                 varchar(255)  NOT NULL    ,
	`AUTHOR`             varchar(255)  NOT NULL    ,
	`FILENAME`           varchar(255)  NOT NULL    ,
	`DATEEXECUTED`       datetime  NOT NULL    ,
	`ORDEREXECUTED`      int  NOT NULL    ,
	`EXECTYPE`           varchar(10)  NOT NULL    ,
	`MD5SUM`             varchar(35)      ,
	`DESCRIPTION`        varchar(255)      ,
	`COMMENTS`           varchar(255)      ,
	`TAG`                varchar(255)      ,
	`LIQUIBASE`          varchar(20)      ,
	`CONTEXTS`           varchar(255)      ,
	`LABELS`             varchar(255)      ,
	`DEPLOYMENT_ID`      varchar(10)      
 );

CREATE TABLE `DATABASECHANGELOGLOCK` ( 
	`ID`                 int  NOT NULL    PRIMARY KEY,
	`LOCKED`             boolean  NOT NULL    ,
	`LOCKGRANTED`        datetime      ,
	`LOCKEDBY`           varchar(255)      
 );

CREATE TABLE `DICOM_APPLICATION_AE` ( 
	`CALLED_AE_TITLE`    varchar(100)  NOT NULL    PRIMARY KEY,
	`APPLICATION_ID`     varchar(255)  NOT NULL    ,
	`API_KEY`            varchar(100)  NOT NULL    ,
	`IDENTIFIED_BY_AE_TITLE_ONLY` boolean  NOT NULL    
 );

CREATE TABLE `DICOM_STORE_LOG` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`APPLICATION_ID`     varchar(255)      ,
	`CALLING_AE_TITLE`   varchar(100)  NOT NULL    ,
	`CALLED_AE_TITLE`    varchar(100)  NOT NULL    ,
	`IMAGE_ASSET_ID`     varchar(255)      ,
	`INSTITUTE_NAME`     varchar(100)      ,
	`SAP_ID`             varchar(255)      ,
	`IMAGE_STORED_TIMESTAMP` datetime      ,
	`IMAGE_RECEIVED_TIMESTAMP` datetime      
 );

CREATE INDEX `IDX_APPLICATION_ID` ON `DICOM_STORE_LOG` ( `APPLICATION_ID` );

CREATE INDEX `IDX_CALLED_AE_TITLE` ON `DICOM_STORE_LOG` ( `CALLED_AE_TITLE` );

CREATE INDEX `IDX_CALLING_AE_TITLE` ON `DICOM_STORE_LOG` ( `CALLING_AE_TITLE` );

CREATE INDEX `IDX_IMAGE_ASSET_ID` ON `DICOM_STORE_LOG` ( `IMAGE_ASSET_ID` );

CREATE INDEX `IDX_IMAGE_RECEIVED_TIMESTAMP` ON `DICOM_STORE_LOG` ( `IMAGE_RECEIVED_TIMESTAMP` );

CREATE INDEX `IDX_SAP_ID` ON `DICOM_STORE_LOG` ( `SAP_ID` );

CREATE TABLE `DICOM_TAG_IGNORE_PIXEL_DATA` ( 
	`TAG`                varchar(255)  NOT NULL    PRIMARY KEY,
	`VALUE`              varchar(255)      
 );

CREATE TABLE `DICOM_TAG_TEMPLATE` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`TAG`                varchar(255)      
 );

CREATE TABLE `DS_MAPPING_RULE` ( 
	`ID`                 varchar(64)  NOT NULL    PRIMARY KEY,
	`NAME`               varchar(64)  NOT NULL    ,
	`SAP_ID`             varchar(255)  NOT NULL    ,
	`CREATE_DATE`        timestamp      ,
	`UPDATE_TIMESTAMP`   timestamp      ,
	CONSTRAINT `DS_MAPPING_RULE_SAP_ID_uc` UNIQUE ( `SAP_ID`, `NAME` ) 
 );

CREATE INDEX `DS_MAPPING_RULE_SAP_ID_idx` ON `DS_MAPPING_RULE` ( `SAP_ID` );

CREATE TABLE `DS_MAPPING_RULE_ACTIONS` ( 
	`ID`                 varchar(64)  NOT NULL    PRIMARY KEY,
	`TAG_KEY`            varchar(64)  NOT NULL    ,
	`ACTION_TYPE`        varchar(64)  NOT NULL    ,
	`REPLACE_VALUE`      varchar(1024)      ,
	`DO_ACTION_IF_NULL`  boolean   DEFAULT false   ,
	`DS_MAPPING_RULE_ID` varchar(64)  NOT NULL    ,
	`CREATE_DATE`        timestamp      ,
	`UPDATE_TIMESTAMP`   timestamp      
 );

CREATE INDEX `FK_DS_MAPPING_RULE_ACTIONS_idx` ON `DS_MAPPING_RULE_ACTIONS` ( `DS_MAPPING_RULE_ID` );

CREATE TABLE `DS_MAPPING_RULE_TRIGGERS` ( 
	`ID`                 varchar(64)  NOT NULL    PRIMARY KEY,
	`TAG_KEY`            varchar(64)  NOT NULL    ,
	`TAG_VALUE`          varchar(1024)      ,
	`DS_MAPPING_RULE_ID` varchar(64)  NOT NULL    ,
	`CREATE_DATE`        timestamp      ,
	`UPDATE_TIMESTAMP`   timestamp      
 );

CREATE INDEX `FK_DS_MAPPING_RULE_TRIGGERS_idx` ON `DS_MAPPING_RULE_TRIGGERS` ( `DS_MAPPING_RULE_ID` );

CREATE TABLE `Dicom_IM_Plugin_Config` ( 
	`ID`                 int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	`CONFIG_NAME`        varchar(128)  NOT NULL    ,
	`CONFIG_VALUE`       varchar(256)  NOT NULL DEFAULT ''   ,
	`CONFIG_DESCRIPTION` varchar(256)      ,
	`CREATED_DATE`       timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`UPDATED_DATE`       timestamp      ,
	CONSTRAINT `CONFIG_NAME_UNIQUE` UNIQUE ( `CONFIG_NAME` ) 
 );

CREATE TABLE `GENDER` ( 
	`ID`                 varchar(100)  NOT NULL    PRIMARY KEY,
	`DESCRIPTION`        varchar(255)  NOT NULL    
 );

CREATE TABLE `IDX_AECONFIG` ( 
	`ID`                 int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	`AE_TITLE`           varchar(100)  NOT NULL    ,
	`INSTITUTE_NAME`     varchar(100)      ,
	`IDENTIFIED_BY_AE_TITLE_ONLY` boolean      ,
	`SAP_ID`             varchar(100)      ,
	`API_KEY`            varchar(100)      ,
	`ENABLED`            boolean  NOT NULL DEFAULT true   ,
	`LAST_ACCESSED_DATE_TIME` datetime      ,
	`CREATED_DATE_TIME`  timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`MODALITY_TYPE_CODE` varchar(100)      ,
	`LOCATION_TOKEN`     varchar(255)      ,
	`C_FIND_QUERY_SIZE_LIMIT` int   DEFAULT 0   ,
	`SUPPORT_QUERY_RETRIEVE` boolean  NOT NULL DEFAULT 0   ,
	`IP_ADDRESS`         varchar(50)      ,
	`RADIOLOGY_LOG_ACTIVE` boolean  NOT NULL DEFAULT 0   ,
	CONSTRAINT `UQ_AE_TITLE_INSTITUTE_NAME` UNIQUE ( `AE_TITLE`, `INSTITUTE_NAME` ) 
 );

CREATE INDEX `IDX_AECONFIG_LOCATION_TOKEN` ON `IDX_AECONFIG` ( `LOCATION_TOKEN` );

CREATE TABLE `IMAGE_ASSET_WP_LEGACY_UPLOAD` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`IMAGE_ASSET_ID`     varchar(255)  NOT NULL    ,
	`WP_LEGACY_UPLOAD_ID` varchar(255)  NOT NULL    ,
	CONSTRAINT `UQ_IMAGE_ASSET_WP_LEGACY_UPLOAD` UNIQUE ( `IMAGE_ASSET_ID`, `WP_LEGACY_UPLOAD_ID` ) 
 );

CREATE TABLE `IMPORTED_IMAGE` ( 
	`SAP_ID`             varchar(255)  NOT NULL    ,
	`STUDY_INSTANCE_UID` varchar(255)  NOT NULL    ,
	`CREATE_TIMESTAMP`   datetime      ,
	`IMPORT_TYPE`        varchar(15)      ,
	CONSTRAINT pk_imported_image PRIMARY KEY ( `SAP_ID`, `STUDY_INSTANCE_UID` )
 );

CREATE INDEX `IDX_IMPORTED_IMAGE_STUDY_ID_SAP_ID` ON `IMPORTED_IMAGE` ( `STUDY_INSTANCE_UID`, `SAP_ID` );

CREATE TABLE `LEGACY_UPLOAD_QUEUE` ( 
	`ID`                 int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	`CLINIC_ID`          int  NOT NULL    ,
	`ASSET_ID`           varchar(255)  NOT NULL    ,
	`FILE_NAME`          varchar(128)  NOT NULL    ,
	`STATUS`             varchar(64)      ,
	`STATUS_MESSAGE`     varchar(255)      ,
	`RETRY_COUNT`        int      
 );

CREATE TABLE `MESSAGING_SUBSCRIPTION` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`CALLBACK`           varchar(255)  NOT NULL    ,
	`EVENT`              varchar(16)  NOT NULL    ,
	`STARTDATE`          timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`ENDDATE`            timestamp  NOT NULL DEFAULT '0000-00-00 00:00:00'   ,
	`EXCEPTION_EMAIL`    varchar(128)  NOT NULL    ,
	`VERSION`            varchar(16)      ,
	`STATUS`             varchar(16)      ,
	`SECRET`             varchar(255)      ,
	`USER_NAME`          varchar(255)      ,
	`PASSWORD`           varchar(255)      
 );

CREATE TABLE `MESSAGING_SUBSCRIPTION_APPLICATIONS` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`MESSAGING_SUBSCRIPTION_ID` varchar(255)      ,
	`APPLICATION_ID`     varchar(255)      
 );

CREATE INDEX `APPLICATION_ID` ON `MESSAGING_SUBSCRIPTION_APPLICATIONS` ( `APPLICATION_ID` );

CREATE INDEX `MESSAGING_SUBSCRIPTION_ID` ON `MESSAGING_SUBSCRIPTION_APPLICATIONS` ( `MESSAGING_SUBSCRIPTION_ID` );

CREATE TABLE `MESSAGING_SUBSCRIPTION_BLACKLIST` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`MESSAGING_SUBSCRIPTION_ID` varchar(255)      ,
	`SAP_ID`             varchar(255)      
 );

CREATE INDEX `MESSAGING_SUBSCRIPTION_ID` ON `MESSAGING_SUBSCRIPTION_BLACKLIST` ( `MESSAGING_SUBSCRIPTION_ID` );

CREATE INDEX `SAP_ID` ON `MESSAGING_SUBSCRIPTION_BLACKLIST` ( `SAP_ID` );

CREATE TABLE `MESSAGING_SUBSCRIPTION_WHITELIST` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`MESSAGING_SUBSCRIPTION_ID` varchar(255)      ,
	`SAP_ID`             varchar(255)      
 );

CREATE INDEX `MESSAGING_SUBSCRIPTION_ID` ON `MESSAGING_SUBSCRIPTION_WHITELIST` ( `MESSAGING_SUBSCRIPTION_ID` );

CREATE INDEX `SAP_ID` ON `MESSAGING_SUBSCRIPTION_WHITELIST` ( `SAP_ID` );

CREATE TABLE `ML_DATASET` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`DATASET_NAME`       varchar(255)      ,
	`USER_ID`            varchar(255)      ,
	`NUMBER_OF_IMAGES`   int      ,
	`QUERY_JSON`         text      ,
	`FILE_PATH`          varchar(1024)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`CREATE_STATUS`      varchar(255)      
 );

CREATE INDEX `IDX_ML_DATASET_DATE_CREATED` ON `ML_DATASET` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_DATASET_DATE_UPDATED` ON `ML_DATASET` ( `DATE_UPDATED` );

CREATE TABLE `ML_DATASET_ITEM` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`DATASET_ID`         varchar(255)      ,
	`MEDIUM_JPG_URL`     varchar(1024)      ,
	`IMAGE_ASSET_ID`     varchar(255)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   
 );

CREATE INDEX `FK_ML_DATASET_ITEM_ML_DATASET` ON `ML_DATASET_ITEM` ( `DATASET_ID` );

CREATE INDEX `IDX_ML_DATASET_ITEM_DATE_CREATED` ON `ML_DATASET_ITEM` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_DATASET_ITEM_DATE_UPDATED` ON `ML_DATASET_ITEM` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_DATASET_ITEM_IMAGE_ASSET_ID` ON `ML_DATASET_ITEM` ( `IMAGE_ASSET_ID` );

CREATE TABLE `ML_DATASET_REVIEW` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`DATASET_ID`         varchar(255)      ,
	`USER_ID`            varchar(255)      ,
	`REVIEW_STATUS`      varchar(255)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`ML_TYPE`            varchar(255)      ,
	`ML_VERSION`         varchar(255)      ,
	CONSTRAINT `UQ_ML_DATASET_REVIEW_DATASET_VERSION_TYPE_USER` UNIQUE ( `DATASET_ID`, `ML_VERSION`, `ML_TYPE`, `USER_ID` ) 
 );

CREATE INDEX `IDX_ML_DATASET_REVIEW_DATE_CREATED` ON `ML_DATASET_REVIEW` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_DATASET_REVIEW_DATE_UPDATED` ON `ML_DATASET_REVIEW` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_DATASET_REVIEW_ML_TYPE` ON `ML_DATASET_REVIEW` ( `ML_TYPE` );

CREATE INDEX `IDX_ML_DATASET_REVIEW_ML_VERSION` ON `ML_DATASET_REVIEW` ( `ML_VERSION` );

CREATE INDEX `IDX_ML_DATASET_REVIEW_USER_ID` ON `ML_DATASET_REVIEW` ( `USER_ID` );

CREATE TABLE `ML_LABELSET` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`LABELSET_NAME`      varchar(255)      ,
	`ML_TYPE`            varchar(255)      ,
	`LABEL_JSON`         text      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   
 );

CREATE INDEX `IDX_ML_LABELSET_DATE_CREATED` ON `ML_LABELSET` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_LABELSET_DATE_UPDATED` ON `ML_LABELSET` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_LABELSET_ML_TYPE` ON `ML_LABELSET` ( `ML_TYPE` );

CREATE TABLE `ML_LABEL_JOB` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`USER_ID`            varchar(255)      ,
	`DATASET_ID`         varchar(255)      ,
	`LABELSET_ID`        varchar(255)      ,
	`JOB_TYPE`           varchar(255)      ,
	`JOB_NAME`           varchar(255)      ,
	`JOB_DESCRIPTION`    text      ,
	`JOB_STATUS`         varchar(255)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   
 );

CREATE INDEX `FK_ML_LABEL_JOB_ML_DATASET` ON `ML_LABEL_JOB` ( `DATASET_ID` );

CREATE INDEX `FK_ML_LABEL_JOB_ML_LABELSET` ON `ML_LABEL_JOB` ( `LABELSET_ID` );

CREATE INDEX `IDX_ML_LABEL_JOB_DATE_CREATED` ON `ML_LABEL_JOB` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_LABEL_JOB_DATE_UPDATED` ON `ML_LABEL_JOB` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_LABEL_JOB_JOB_STATUS` ON `ML_LABEL_JOB` ( `JOB_STATUS` );

CREATE INDEX `IDX_ML_LABEL_JOB_JOB_TYPE` ON `ML_LABEL_JOB` ( `JOB_TYPE` );

CREATE TABLE `ML_LABEL_JOB_ITEM` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`USER_ID`            varchar(255)      ,
	`JOB_ID`             varchar(255)      ,
	`DATASET_ITEM_ID`    varchar(255)      ,
	`ANNOTATION_DATA`    longtext      ,
	`ORIENTATION`        int      ,
	`CLASS_ID`           varchar(255)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   
 );

CREATE INDEX `FK_ML_LABEL_JOB_ITEM_ML_DATASET_ITEM` ON `ML_LABEL_JOB_ITEM` ( `DATASET_ITEM_ID` );

CREATE INDEX `FK_ML_LABEL_JOB_ITEM_ML_LABEL_JOB` ON `ML_LABEL_JOB_ITEM` ( `JOB_ID` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_DATE_CREATED` ON `ML_LABEL_JOB_ITEM` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_DATE_UPDATED` ON `ML_LABEL_JOB_ITEM` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_USER_ID` ON `ML_LABEL_JOB_ITEM` ( `USER_ID` );

CREATE TABLE `ML_LABEL_JOB_ITEM_REVIEW` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`USER_ID`            varchar(255)      ,
	`JOB_ID`             varchar(255)      ,
	`DATASET_ITEM_ID`    varchar(255)      ,
	`ANNOTATION_DATA`    longtext      ,
	`ORIENTATION`        int      ,
	`CLASS_ID`           varchar(255)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`ORIGINAL_USER_ID`   varchar(255)      
 );

CREATE INDEX `FK_ML_LABEL_JOB_ITEM_REVIEW_ML_DATASET_ITEM` ON `ML_LABEL_JOB_ITEM_REVIEW` ( `DATASET_ITEM_ID` );

CREATE INDEX `FK_ML_LABEL_JOB_ITEM_REVIEW_ML_LABEL_JOB` ON `ML_LABEL_JOB_ITEM_REVIEW` ( `JOB_ID` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_REVIEW_DATE_CREATED` ON `ML_LABEL_JOB_ITEM_REVIEW` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_REVIEW_DATE_UPDATED` ON `ML_LABEL_JOB_ITEM_REVIEW` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_REVIEW_ORIGINAL_USER_ID` ON `ML_LABEL_JOB_ITEM_REVIEW` ( `ORIGINAL_USER_ID` );

CREATE INDEX `IDX_ML_LABEL_JOB_ITEM_REVIEW_USER_ID` ON `ML_LABEL_JOB_ITEM_REVIEW` ( `USER_ID` );

CREATE TABLE `ML_MODEL_VERSIONS` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`MODEL_NAME`         varchar(255)      ,
	`MODEL_VERSION`      varchar(255)      ,
	`MODEL_TYPE`         varchar(255)      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`LABEL_JSON`         text      ,
	`MODEL_SERVICE_URL`  varchar(1024)      
 );

CREATE INDEX `IDX_ML_MODEL_VERSIONS_DATE_CREATED` ON `ML_MODEL_VERSIONS` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_MODEL_VERSIONS_DATE_UPDATED` ON `ML_MODEL_VERSIONS` ( `DATE_UPDATED` );

CREATE TABLE `ML_USER_CACHE` ( 
	`USER_ID`            varchar(255)  NOT NULL    PRIMARY KEY,
	`USER_CACHE`         longtext      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   
 );

CREATE INDEX `IDX_ML_USER_CACHE_DATE_CREATED` ON `ML_USER_CACHE` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_USER_CACHE_DATE_UPDATED` ON `ML_USER_CACHE` ( `DATE_UPDATED` );

CREATE TABLE `MODALITY` ( 
	`ID`                 varchar(100)  NOT NULL    PRIMARY KEY,
	`NAME`               varchar(10)  NOT NULL    ,
	`DESCRIPTION`        varchar(50)  NOT NULL    
 );

CREATE TABLE `MPPS_N_CREATE` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`MPPS_SOP_INSTANCE_UID` varchar(255)  NOT NULL    ,
	`PATIENT_ID`         varchar(255)  NOT NULL    ,
	`PERFORMED_STATION_AE_TITLE` varchar(255)      ,
	`PERFORMED_PROCEDURE_STEP_START_DATE` timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`PERFORMED_PROCEDURE_STEP_END_DATE` timestamp      ,
	`PERFORMED_STATION_NAME` varchar(255)      ,
	`PERFORMED_LOCATION` varchar(255)      ,
	`PERFORMED_PROCEDURE_STEP_STATUS` varchar(255)      ,
	`STUDY_INSTANCE_UID` varchar(255)      ,
	`SCHEDULED_PROCEDURE_STEP_ID` varchar(255)      ,
	`CREATE_TIMESTAMP`   timestamp      ,
	`UPDATE_TIMESTAMP`   timestamp      ,
	CONSTRAINT `SOP_INSTANCE_UID_AND_AE_TITLE` UNIQUE ( `MPPS_SOP_INSTANCE_UID`, `PERFORMED_STATION_AE_TITLE` ) 
 );

CREATE TABLE `MPPS_N_SET` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`MPPS_N_CREATE_ID`   varchar(255)  NOT NULL    ,
	`RETRIEVE_AE_TITLE`  varchar(255)      ,
	`REFERENCED_SOP_INSTANCE_UIDS` varchar(1000)      ,
	`SERIES_DESCRIPTION` varchar(1000)      ,
	`PERFORMING_PHYSICIAN_NAME` varchar(255)      ,
	`PROTOCOL_NAME`      varchar(255)      ,
	`OPERATORS_NAME`     varchar(255)      ,
	`SERIES_INSTANCE_UID` varchar(255)      ,
	`CREATE_TIMESTAMP`   timestamp   DEFAULT CURRENT_TIMESTAMP   ,
	`UPDATE_TIMESTAMP`   timestamp      
 );

CREATE TABLE `PATIENT` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`NAME`               varchar(100)  NOT NULL    ,
	`DOB`                date      ,
	`SPECIES`            varchar(500)      ,
	`BREED`              varchar(500)      ,
	`GENDER`             varchar(30)      ,
	`APPLICATION_PATIENT_ID` varchar(255)      ,
	`SAP_ID`             varchar(255)      ,
	`WEIGHT`             int   DEFAULT 0   ,
	`WEIGHT_UNIT`        varchar(16)      ,
	`EDHD_NUMBER`        varchar(255)      ,
	`ACTIVE_FLAG`        int   DEFAULT 0   ,
	`LAST_MOD_DATE`      timestamp   DEFAULT CURRENT_TIMESTAMP   ,
	`WEIGHT_DECIMAL_PART` float(12,0)   DEFAULT 0   ,
	`CREATED_BY_WP`      boolean  NOT NULL DEFAULT 0   
 );

CREATE INDEX `IDX_PATIENT_FK3` ON `PATIENT` ( `SAP_ID` );

CREATE INDEX `IDX_PATIENT_NAME` ON `PATIENT` ( `NAME` );

CREATE INDEX `PATIENT_INDEX` ON `PATIENT` ( `APPLICATION_PATIENT_ID` );

CREATE TABLE `PROPERTIES` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`PROP_VALUE`         varchar(1024)      
 );

CREATE TABLE `PROVIDER` ( 
	`ID`                 int  NOT NULL DEFAULT 0   PRIMARY KEY,
	`NAME`               varchar(100)  NOT NULL    ,
	`SECURITY_KEY`       varchar(255)      ,
	`USER_KEY`           varchar(255)      
 );

CREATE TABLE `PROVIDER_LEVEL` ( 
	`PROVIDER_ID`        int  NOT NULL DEFAULT 0   ,
	`PROVIDER_LEVEL`     varchar(25)  NOT NULL DEFAULT ''   ,
	`DESCRIPTION`        varchar(500)      ,
	CONSTRAINT pk_provider_level PRIMARY KEY ( `PROVIDER_ID`, `PROVIDER_LEVEL` )
 );

CREATE TABLE `REQUEST_DETAILS` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`STUDY_INSTANCE_UID` varchar(255)  NOT NULL    ,
	`PATIENT_ID`         varchar(255)      ,
	`API_KEY`            varchar(255)  NOT NULL    ,
	`SAP_ID`             varchar(255)      ,
	`MODALITY`           varchar(255)      ,
	`REQUEST_NOTES`      varchar(255)      ,
	`REQUESTING_DOCTOR`  varchar(255)      ,
	`ACCESSION_NUMBER`   varchar(255)      ,
	`STATUS`             varchar(255)  NOT NULL    ,
	`CREATE_TIMESTAMP`   timestamp   DEFAULT CURRENT_TIMESTAMP   ,
	`UPDATE_TIMESTAMP`   timestamp      ,
	`LOCATION_TOKEN`     varchar(255)      ,
	`RECONCILED_REQUEST` boolean  NOT NULL DEFAULT 0   
 );

CREATE INDEX `REQDET_FK_idx` ON `REQUEST_DETAILS` ( `PATIENT_ID` );

CREATE INDEX `REQUEST_DET_INDEX` ON `REQUEST_DETAILS` ( `PATIENT_ID`, `SAP_ID`, `MODALITY` );

CREATE INDEX `REQUEST_DETAILS_LOCATION_TOKEN` ON `REQUEST_DETAILS` ( `LOCATION_TOKEN` );

CREATE INDEX `REQUEST_DETAILS_SAP` ON `REQUEST_DETAILS` ( `SAP_ID` );

CREATE TABLE `REQUEST_DETAILS_LINK` ( 
	`REQUEST_DETAILS_ID` varchar(255)  NOT NULL    PRIMARY KEY,
	`REQUEST_TYPE`       varchar(255)      ,
	`REQUEST_JSON`       json      
 );

CREATE INDEX `REQUEST_DETAILS_LINK_REQUEST_TYPE` ON `REQUEST_DETAILS_LINK` ( `REQUEST_TYPE` );

CREATE TABLE `SHOT` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`NAME`               varchar(255)  NOT NULL    ,
	`CLASS_MAJOR`        varchar(50)      ,
	`CLASS_MINOR`        varchar(50)      ,
	`CLASS_MAJOR_DEFAULT` boolean   DEFAULT false   ,
	CONSTRAINT `NAME` UNIQUE ( `NAME` ) 
 );

CREATE TABLE `SHOT_CLASS_MAJOR` ( 
	`NAME`               varchar(50)  NOT NULL    PRIMARY KEY,
	`MATCH_REGEX`        varchar(255)  NOT NULL    
 );

CREATE TABLE `SHOT_CLASS_MINOR` ( 
	`NAME`               varchar(50)  NOT NULL    PRIMARY KEY,
	`MATCH_REGEX`        varchar(255)  NOT NULL    ,
	`SHOT_CLASS_MAJOR`   varchar(50)  NOT NULL    
 );

CREATE INDEX fk_shot_class_minor_shot_class_major ON `SHOT_CLASS_MINOR` ( `SHOT_CLASS_MAJOR` );

CREATE TABLE `SPECIES` ( 
	`ID`                 varchar(100)  NOT NULL    PRIMARY KEY,
	`SPECIES_NAME`       varchar(255)  NOT NULL    ,
	`NORMAL_IMAGE_SPECIES` tinyint   DEFAULT 0   
 );

CREATE TABLE `STUDY` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`STUDY_DATE`         datetime      ,
	`ACCESSION_NUMBER`   varchar(16)      ,
	`STUDY_TITLE`        varchar(500)      ,
	`DESCRIPTION`        varchar(10000)      ,
	`PATIENT_ID`         varchar(255)      ,
	`STUDY_INSTANCE_UID` varchar(255)  NOT NULL    ,
	`DOCTOR`             varchar(255)      ,
	`LAST_MOD_DATE`      timestamp   DEFAULT CURRENT_TIMESTAMP   
 );

CREATE INDEX `IDX_STUDY_FK3` ON `STUDY` ( `PATIENT_ID` );

CREATE INDEX `STUDY_INDEX` ON `STUDY` ( `STUDY_INSTANCE_UID` );

CREATE TABLE `USERS` ( 
	`USER_NAME`          varchar(100)  NOT NULL    PRIMARY KEY,
	`USER_ROLE`          varchar(20)  NOT NULL    ,
	`USER_PASSWORD`      varchar(100)  NOT NULL    ,
	`CREATED_DATE`       datetime      ,
	`DESCRIPTION`        varchar(200)      
 );

CREATE TABLE ae ( 
	pk                   bigint  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	aet                  varchar(250)      ,
	hostname             varchar(250)      ,
	port                 int  NOT NULL    ,
	cipher_suites        varchar(250)      ,
	pat_id_issuer        varchar(250)      ,
	acc_no_issuer        varchar(250)      ,
	user_id              varchar(250)      ,
	passwd               varchar(250)      ,
	fs_group_id          varchar(250)      ,
	ae_group             varchar(250)   DEFAULT '-'   ,
	ae_desc              varchar(250)      ,
	wado_url             varchar(250)      ,
	station_name         varchar(250)      ,
	institution          varchar(250)      ,
	department           varchar(250)      ,
	installed            boolean   DEFAULT 1   ,
	vendor_data          longblob      ,
	CONSTRAINT aet UNIQUE ( aet ) 
 );

CREATE INDEX ae_group ON ae ( ae_group );

CREATE INDEX hostname ON ae ( hostname );

CREATE TABLE dcm_im_mapping ( 
	`ID`                 int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	`DCM_TAG_ID`         int  NOT NULL    ,
	`IM_FIELD_NAME`      varchar(45)  NOT NULL    ,
	`Field_Format`       varchar(45)      ,
	`Enabled`            smallint UNSIGNED NOT NULL DEFAULT 1   ,
	`DEFAULT_VALUE`      varchar(256)      ,
	`DESCRIPTION`        varchar(256)      ,
	required             boolean   DEFAULT false   ,
	`IM_CHILD_FIELD_NAME` varchar(45)      
 );

CREATE TABLE dcm_im_mappings ( 
	`ID`                 int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	`DCM_TAG_ID`         int  NOT NULL    ,
	`IM_FIELD_NAME`      varchar(45)  NOT NULL    ,
	`Field_Format`       varchar(45)      ,
	`Enabled`            smallint UNSIGNED NOT NULL DEFAULT 1   ,
	`DEFAULT_VALUE`      varchar(256)      ,
	`DESCRIPTION`        varchar(256)      ,
	required             boolean   DEFAULT false   ,
	`IM_CHILD_FIELD_NAME` varchar(45)      
 );

CREATE TABLE idx_dicom_components ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	component_name       varchar(45)  NOT NULL    ,
	request_type         smallint UNSIGNED  DEFAULT 1   
 );

CREATE TABLE idx_failure_log ( 
	`ID`                 int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	`IP_ADDRESS`         varchar(20)  NOT NULL    ,
	`AETITLE`            varchar(100)  NOT NULL    ,
	`INSTITUTE_NAME`     varchar(100)  NOT NULL    ,
	`MANUFATURER`        varchar(100)      ,
	`MANUFACTURER_MODEL_NAME` varchar(100)      ,
	`MODALITY`           varchar(100)      ,
	`FAILED_DATE_TIME`   timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`PATIENT_NAME`       varchar(256)      ,
	`RESPONSIBLE_PERSON_NAME` varchar(256)      ,
	`CALLING_HOST_NAME`  varchar(256)      ,
	`ERROR_TYPE`         varchar(75)      ,
	`ERROR_MESSAGE`      varchar(150)      
 );

CREATE INDEX `IDX_FAILURE_LOG_FAILED_DATE_TIME` ON idx_failure_log ( `FAILED_DATE_TIME` );

CREATE TABLE idx_failure_log_archive ( 
	`ID`                 int  NOT NULL DEFAULT 0   ,
	`IP_ADDRESS`         varchar(20)  NOT NULL    ,
	`AETITLE`            varchar(100)  NOT NULL    ,
	`INSTITUTE_NAME`     varchar(100)  NOT NULL    ,
	`MANUFATURER`        varchar(100)      ,
	`MANUFACTURER_MODEL_NAME` varchar(100)      ,
	`MODALITY`           varchar(100)      ,
	`FAILED_DATE_TIME`   timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`PATIENT_NAME`       varchar(256)      ,
	`RESPONSIBLE_PERSON_NAME` varchar(256)      ,
	`CALLING_HOST_NAME`  varchar(256)      ,
	`ERROR_TYPE`         varchar(75)      ,
	`ERROR_MESSAGE`      varchar(150)      
 );

CREATE TABLE idx_invalid_ae ( 
	`AETITLE`            varchar(100)  NOT NULL    PRIMARY KEY
 );

CREATE TABLE idx_send_image_jobs ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	job_id               varchar(128)  NOT NULL    ,
	dest_ae_title        varchar(128)  NOT NULL    ,
	sending_ae_title     varchar(128)      ,
	dest_host_name       varchar(256)  NOT NULL    ,
	port                 int UNSIGNED NOT NULL    ,
	image_asset_id       varchar(256)  NOT NULL    ,
	retries_count        smallint UNSIGNED NOT NULL    ,
	created_date_time    timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	updated_date_time    timestamp  NOT NULL DEFAULT '0000-00-00 00:00:00'   ,
	file_path            varchar(256)      ,
	s3_image_url         varchar(512)      ,
	reason               varchar(1000)      ,
	status_code          varchar(20)  NOT NULL    ,
	schedule_timestamp   timestamp      
 );

CREATE INDEX `IDX_SEND_IMAGE_JOBS_JOB_ID` ON idx_send_image_jobs ( job_id );

CREATE INDEX `IDX_SEND_IMAGE_JOBS_STATUS_CODE` ON idx_send_image_jobs ( status_code );

CREATE TABLE idx_send_image_jobs_archive ( 
	id                   int UNSIGNED NOT NULL DEFAULT 0   ,
	job_id               varchar(128)  NOT NULL    ,
	dest_ae_title        varchar(128)  NOT NULL    ,
	sending_ae_title     varchar(128)      ,
	dest_host_name       varchar(256)  NOT NULL    ,
	port                 int UNSIGNED NOT NULL    ,
	image_asset_id       varchar(256)  NOT NULL    ,
	retries_count        smallint UNSIGNED NOT NULL    ,
	created_date_time    timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	updated_date_time    timestamp  NOT NULL DEFAULT '0000-00-00 00:00:00'   ,
	file_path            varchar(256)      ,
	s3_image_url         varchar(512)      ,
	reason               varchar(1000)      ,
	status_code          varchar(20)  NOT NULL    ,
	schedule_timestamp   timestamp      
 );

CREATE TABLE users ( 
	username             varchar(50)  NOT NULL    PRIMARY KEY,
	password             varchar(60)  NOT NULL    ,
	enabled              boolean  NOT NULL    
 );

CREATE TABLE `ASSET` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`FILE_TYPE`          varchar(100)      ,
	`PROVIDER_STORAGE_LEVEL` varchar(25)  NOT NULL    ,
	`IDEXX_STORAGE_LEVEL` int      ,
	`PROVIDER_ID`        int  NOT NULL    ,
	`NAME`               varchar(100)      ,
	`DATE_CAPTURED`      datetime      ,
	`DATE_UPLOADED`      datetime  NOT NULL    ,
	`DATE_LAST_VISITED`  datetime      ,
	`ASSET_SIZE`         bigint  NOT NULL    ,
	`CHECKSUM`           varchar(100)  NOT NULL    ,
	`LAST_UPDATE_DATE`   timestamp      ,
	`ORIGINAL_FILENAME`  varchar(100)  NOT NULL    ,
	`SAP_ID`             varchar(255)      ,
	`APPLICATION_ID`     varchar(100)      ,
	`LOCATION_TOKEN`     varchar(100)  NOT NULL    ,
	`LOCATION_PATH`      varchar(500)  NOT NULL    ,
	`CONTENT_TYPE`       varchar(100)      
 );

CREATE INDEX `IDX_ASSET_FK0` ON `ASSET` ( `PROVIDER_ID`, `PROVIDER_STORAGE_LEVEL` );

CREATE INDEX `IDX_ASSET_SAP_ID` ON `ASSET` ( `SAP_ID` );

CREATE TABLE `BREED` ( 
	`SPECIES_ID`         varchar(100)  NOT NULL    ,
	`BREED_ID`           varchar(100)  NOT NULL    ,
	`BREED_NAME`         varchar(255)  NOT NULL    ,
	CONSTRAINT `ux_BREED` UNIQUE ( `SPECIES_ID`, `BREED_ID`, `BREED_NAME` ) 
 );

CREATE TABLE `CLIENT` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`FIRST_NAME`         varchar(255)      ,
	`LAST_NAME`          varchar(255)  NOT NULL    ,
	`SAP_ID`             varchar(255)  NOT NULL    ,
	`EMAIL`              varchar(255)      ,
	`APPLICATION_CLIENT_ID` varchar(255)      ,
	CONSTRAINT `IDX_CLIENT_UNIQUE_KEY` UNIQUE ( `FIRST_NAME`, `LAST_NAME`, `APPLICATION_CLIENT_ID`, `SAP_ID` ) 
 );

CREATE INDEX `IDX_CLIENT_FIRST_NAME` ON `CLIENT` ( `FIRST_NAME` );

CREATE INDEX `IDX_CLIENT_LAST_NAME` ON `CLIENT` ( `LAST_NAME` );

CREATE INDEX `SAP_ID` ON `CLIENT` ( `SAP_ID` );

CREATE TABLE `CUSTOMER_SHOT` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`NAME`               varchar(255)  NOT NULL    ,
	`SHOT_ID`            varchar(255)  NOT NULL    ,
	CONSTRAINT `NAME` UNIQUE ( `NAME` ) 
 );

CREATE INDEX fk_customer_shot_shot ON `CUSTOMER_SHOT` ( `SHOT_ID` );

CREATE TABLE `DEFAULT_LEVEL` ( 
	`IDEXX_LEVEL`        int  NOT NULL DEFAULT 0   PRIMARY KEY,
	`PROVIDER_ID`        int  NOT NULL    ,
	`PROVIDER_LEVEL`     varchar(25)  NOT NULL    ,
	`LAST_UPDATED`       timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`DESCRIPTION`        varchar(500)      
 );

CREATE INDEX `IDX_DEFAULT_LEVEL_FK0` ON `DEFAULT_LEVEL` ( `PROVIDER_ID` );

CREATE TABLE `EXTERNAL_PATIENT_LINK` ( 
	`PATIENT_ID`         varchar(255)  NOT NULL    ,
	`ISSUER_OF_PATIENT_ID` varchar(255)  NOT NULL    ,
	`PIMS_PATIENT_ID`    varchar(255)  NOT NULL    ,
	CONSTRAINT pk_external_patient_link PRIMARY KEY ( `PATIENT_ID`, `ISSUER_OF_PATIENT_ID`, `PIMS_PATIENT_ID` )
 );

CREATE TABLE `IMAGE_ML` ( 
	`IMAGE_ASSET_ID`     varchar(255)  NOT NULL    ,
	`ML_VERSION`         varchar(255)  NOT NULL    ,
	`ANNOTATION_DATA`    longtext      ,
	`WINDOW_WIDTH`       int   DEFAULT 0   ,
	`WINDOW_CENTER`      int   DEFAULT 0   ,
	`INVERTED`           boolean   DEFAULT 0   ,
	`ORIENTATION`        int   DEFAULT 0   ,
	`CROP_X1`            float(12,0)   DEFAULT 0   ,
	`CROP_Y1`            float(12,0)   DEFAULT 0   ,
	`CROP_X2`            float(12,0)   DEFAULT 0   ,
	`CROP_Y2`            float(12,0)   DEFAULT 0   ,
	`CROP_X3`            float(12,0)   DEFAULT 0   ,
	`CROP_Y3`            float(12,0)   DEFAULT 0   ,
	`CROP_X4`            float(12,0)   DEFAULT 0   ,
	`CROP_Y4`            float(12,0)   DEFAULT 0   ,
	`CALIBRATED`         boolean   DEFAULT 0   ,
	`X_DPI`              float(12,0)   DEFAULT 96   ,
	`Y_DPI`              float(12,0)   DEFAULT 96   ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`ML_TYPE`            varchar(255)      ,
	`CLASS_ID`           varchar(255)      ,
	CONSTRAINT pk_image_ml PRIMARY KEY ( `IMAGE_ASSET_ID`, `ML_VERSION` )
 );

CREATE INDEX `IDX_IMAGE_ML_CLASS_ID` ON `IMAGE_ML` ( `CLASS_ID` );

CREATE INDEX `IDX_IMAGE_ML_DATE_CREATED` ON `IMAGE_ML` ( `DATE_CREATED` );

CREATE INDEX `IDX_IMAGE_ML_ML_TYPE` ON `IMAGE_ML` ( `ML_TYPE` );

CREATE INDEX `IDX_IMAGE_ML_ORIENTATION` ON `IMAGE_ML` ( `ORIENTATION` );

CREATE TABLE `IMAGE_UPDATE` ( 
	`IMAGE_ASSET_ID`     varchar(255)  NOT NULL    ,
	`CASE_ID`            varchar(255)  NOT NULL    ,
	`SAP_ID`             varchar(255)  NOT NULL    ,
	`USER_ID`            varchar(255)      ,
	`UPDATE_TYPE`        varchar(255)      ,
	`ANNOTATION_DATA`    longtext      ,
	`WINDOW_WIDTH`       int   DEFAULT 0   ,
	`WINDOW_CENTER`      int   DEFAULT 0   ,
	`INVERTED`           boolean   DEFAULT 0   ,
	`ORIENTATION`        int   DEFAULT 0   ,
	`CROP_X1`            float(12,0)   DEFAULT 0   ,
	`CROP_Y1`            float(12,0)   DEFAULT 0   ,
	`CROP_X2`            float(12,0)   DEFAULT 0   ,
	`CROP_Y2`            float(12,0)   DEFAULT 0   ,
	`CROP_X3`            float(12,0)   DEFAULT 0   ,
	`CROP_Y3`            float(12,0)   DEFAULT 0   ,
	`CROP_X4`            float(12,0)   DEFAULT 0   ,
	`CROP_Y4`            float(12,0)   DEFAULT 0   ,
	`CALIBRATED`         boolean   DEFAULT 0   ,
	`X_DPI`              float(12,0)   DEFAULT 96   ,
	`Y_DPI`              float(12,0)   DEFAULT 96   ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`CLASS_ID`           varchar(255)      ,
	CONSTRAINT pk_image_update PRIMARY KEY ( `IMAGE_ASSET_ID`, `CASE_ID`, `SAP_ID` )
 );

CREATE INDEX `IDX_IMAGE_UPDATE_CLASS_ID` ON `IMAGE_UPDATE` ( `CLASS_ID` );

CREATE INDEX `IDX_IMAGE_UPDATE_DATE_CREATED` ON `IMAGE_UPDATE` ( `DATE_CREATED` );

CREATE INDEX `IDX_IMAGE_UPDATE_DATE_UPDATED` ON `IMAGE_UPDATE` ( `DATE_UPDATED` );

CREATE INDEX `IDX_IMAGE_UPDATE_ORIENTATION` ON `IMAGE_UPDATE` ( `ORIENTATION` );

CREATE INDEX `IDX_IMAGE_UPDATE_UPDATE_TYPE` ON `IMAGE_UPDATE` ( `UPDATE_TYPE` );

CREATE TABLE `ML_PREDICTION_REVIEW` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`DATASET_ID`         varchar(255)      ,
	`USER_ID`            varchar(255)      ,
	`IMAGE_ASSET_ID`     varchar(255)      ,
	`ML_VERSION`         varchar(255)      ,
	`ML_TYPE`            varchar(255)      ,
	`ORIENTATION`        int      ,
	`ANNOTATION_DATA`    longtext      ,
	`DATE_CREATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`DATE_UPDATED`       datetime   DEFAULT CURRENT_TIMESTAMP(6)   ,
	`CLASS_ID`           varchar(255)      ,
	CONSTRAINT `ML_PREDICTION_REVIEW_UNIQUE` UNIQUE ( `DATASET_ID`, `USER_ID`, `IMAGE_ASSET_ID`, `ML_VERSION`, `ML_TYPE` ) 
 );

CREATE INDEX `FK_ML_PREDICTION_REVIEW_ASSET` ON `ML_PREDICTION_REVIEW` ( `IMAGE_ASSET_ID` );

CREATE INDEX `IDX_ML_PREDICTION_REVIEW_CLASS_ID` ON `ML_PREDICTION_REVIEW` ( `CLASS_ID` );

CREATE INDEX `IDX_ML_PREDICTION_REVIEW_DATASET_VERSION_TYPE_USER` ON `ML_PREDICTION_REVIEW` ( `DATASET_ID`, `ML_VERSION`, `ML_TYPE`, `USER_ID` );

CREATE INDEX `IDX_ML_PREDICTION_REVIEW_DATE_CREATED` ON `ML_PREDICTION_REVIEW` ( `DATE_CREATED` );

CREATE INDEX `IDX_ML_PREDICTION_REVIEW_DATE_UPDATED` ON `ML_PREDICTION_REVIEW` ( `DATE_UPDATED` );

CREATE INDEX `IDX_ML_PREDICTION_REVIEW_USER_ID` ON `ML_PREDICTION_REVIEW` ( `USER_ID` );

CREATE TABLE `NORMAL_ANIMAL_SIZE` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`SPECIES_ID`         varchar(255)      ,
	`NAME`               varchar(255)      ,
	`DESCRIPTION`        varchar(255)  NOT NULL    ,
	CONSTRAINT `ux_NORMAL_ANIMAL_SIZE` UNIQUE ( `SPECIES_ID`, `NAME` ) 
 );

CREATE TABLE `NORMAL_LIFE_STAGE` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`SPECIES_ID`         varchar(255)      ,
	`NAME`               varchar(255)      ,
	`AGE_RANGE`          varchar(11)      ,
	`DESCRIPTION`        varchar(255)  NOT NULL    ,
	CONSTRAINT `ux_NORMAL_LIFE_STAGE` UNIQUE ( `SPECIES_ID`, `NAME` ) 
 );

CREATE TABLE `NORMAL_SHOT` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`SPECIES_ID`         varchar(255)      ,
	`SHOT_ID`            varchar(255)  NOT NULL    ,
	`SERIES_TITLE`       varchar(255)      ,
	CONSTRAINT `ux_NORMAL_SHOT` UNIQUE ( `SPECIES_ID`, `SHOT_ID` ) 
 );

CREATE INDEX fk_normal_shot_shot ON `NORMAL_SHOT` ( `SHOT_ID` );

CREATE TABLE `OWNER` ( 
	`PATIENT_ID`         varchar(255)  NOT NULL    ,
	`CLIENT_ID`          varchar(255)  NOT NULL    ,
	`PRIMARY_OWNER`      boolean  NOT NULL DEFAULT true   ,
	CONSTRAINT pk_owner PRIMARY KEY ( `PATIENT_ID`, `CLIENT_ID` ),
	CONSTRAINT `IDX_OWNER_UNIQUE_KEY` UNIQUE ( `CLIENT_ID`, `PATIENT_ID` ) 
 );

CREATE TABLE `SERIES` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`STUDY_ID`           varchar(255)  NOT NULL    ,
	`TITLE`              varchar(100)      ,
	`COMMENTS`           varchar(10000)      ,
	`DICOM_MODALITY`     varchar(16)      ,
	`SERIES_INSTANCE_UID` varchar(255)  NOT NULL    ,
	`SERIES_DATE`        datetime      ,
	`LAST_MOD_DATE`      timestamp   DEFAULT CURRENT_TIMESTAMP   
 );

CREATE INDEX `IDX_SERIES_FK0` ON `SERIES` ( `STUDY_ID` );

CREATE INDEX `SERIES_INDEX` ON `SERIES` ( `SERIES_INSTANCE_UID` );

CREATE TABLE authorities ( 
	username             varchar(50)  NOT NULL    ,
	authority            varchar(50)  NOT NULL    
 );

CREATE INDEX ix_auth_username ON authorities ( username, authority );

CREATE TABLE dcm_component_field_mapping ( 
	dcm_mapping_id       int UNSIGNED NOT NULL    ,
	idx_component_id     int UNSIGNED NOT NULL    ,
	CONSTRAINT pk_dcm_component_field_mapping PRIMARY KEY ( dcm_mapping_id, idx_component_id )
 );

CREATE INDEX `FK_dcm_component_field_mapping_2` ON dcm_component_field_mapping ( idx_component_id );

CREATE TABLE dcm_component_im_mapping ( 
	dcm_mapping_id       int UNSIGNED NOT NULL    ,
	idx_component_id     int UNSIGNED NOT NULL    ,
	CONSTRAINT pk_dcm_component_im_mapping PRIMARY KEY ( dcm_mapping_id, idx_component_id )
 );

CREATE INDEX `FK_dcm_component_im_mapping_2` ON dcm_component_im_mapping ( idx_component_id );

CREATE TABLE `IMAGE` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`IMAGE_ASSET_ID`     varchar(255)      ,
	`SOP_INSTANCE_UID`   varchar(255)      ,
	`ANNOTATION_FILE_ASSET_ID` varchar(255)      ,
	`THUMBNAIL_ASSET_ID` varchar(255)      ,
	`SERIES_ID`          varchar(255)      ,
	`ACQUISITION_TIMESTAMP` datetime      ,
	`DATE_CAPTURED`      datetime      ,
	`DATE_UPLOADED`      timestamp      ,
	`DATE_LAST_VISITED`  timestamp      ,
	`XML`                varchar(10000)      ,
	`APPLICATION_ID`     varchar(255)      ,
	`IDEXX_MASTER_PATIENT_INDEX` varchar(255)      ,
	`FILE_TYPE`          varchar(100)      ,
	`REPROCESS_COUNT`    int      ,
	`PRE_SIGNED_THUMBNAIL_URL` varchar(1000)      ,
	`CURRENT_IDEXX_LEVEL` int      ,
	`DATE_LEVEL_CHANGED` timestamp      ,
	`STATUS_MESSAGE`     varchar(1000)      ,
	`ORIGINAL_FILENAME`  varchar(100)      ,
	`IMAGE_TITLE`        varchar(500)      ,
	`REVISION_NUMBER`    tinyint UNSIGNED NOT NULL DEFAULT 1   ,
	`DELETE_FLAG`        int  NOT NULL DEFAULT 0   ,
	`DELETE_STATUS_CHANGED_DATE` timestamp      ,
	`ANNOTATION_DATA`    longtext      ,
	`WINDOW_WIDTH`       int   DEFAULT 0   ,
	`WINDOW_CENTER`      int   DEFAULT 0   ,
	`ORIGINAL_WINDOW_WIDTH` int   DEFAULT 0   ,
	`ORIGINAL_WINDOW_CENTER` int   DEFAULT 0   ,
	`INVERTED`           boolean   DEFAULT false   ,
	`ORIGINAL_INVERTED`  boolean   DEFAULT false   ,
	`ORIENTATION`        int   DEFAULT 0   ,
	`CALIBRATED`         boolean   DEFAULT false   ,
	`X_DPI`              float(12,0)   DEFAULT 96   ,
	`Y_DPI`              float(12,0)   DEFAULT 96   ,
	`CROP_X1`            float(12,0)   DEFAULT 0   ,
	`CROP_Y1`            float(12,0)   DEFAULT 0   ,
	`CROP_X2`            float(12,0)   DEFAULT 0   ,
	`CROP_Y2`            float(12,0)   DEFAULT 0   ,
	`CROP_X3`            float(12,0)   DEFAULT 0   ,
	`CROP_Y3`            float(12,0)   DEFAULT 0   ,
	`CROP_X4`            float(12,0)   DEFAULT 0   ,
	`CROP_Y4`            float(12,0)   DEFAULT 0   ,
	`PRIVATE_FLAG`       boolean   DEFAULT false   ,
	`LAST_MOD_DATE`      timestamp   DEFAULT CURRENT_TIMESTAMP   ,
	`MEDIUM_JPEG_ASSET_ID` varchar(255)      ,
	`PRE_SIGNED_MEDIUM_JPEG_URL` varchar(1000)      ,
	`BODY_PART_EXAMINED` varchar(64)      ,
	`VIEW_POSITION`      varchar(64)      ,
	`INSTITUTION_NAME`   varchar(255)      ,
	`MANUFACTURER`       varchar(255)      ,
	`MANUFACTURER_MODEL` varchar(255)      ,
	`MODALITY`           varchar(20)      ,
	`PIXEL_REPRESENTATION` int   DEFAULT 0   ,
	`RESCALE_INTERCEPT`  float(12,0)   DEFAULT 0   ,
	`RESCALE_SLOPE`      float(12,0)   DEFAULT 1   ,
	`IMAGE_WIDTH`        int   DEFAULT 0   ,
	`IMAGE_HEIGHT`       int   DEFAULT 0   ,
	`PHOTOMETRIC_INTERPRETATION` varchar(64)      ,
	`HIGHBIT`            int   DEFAULT 0   ,
	`NUM_FRAMES`         int   DEFAULT 0   ,
	`INSTANCE_NUMBER`    int   DEFAULT 0   
 );

CREATE INDEX `IDX_IMAGE_APPLICATION_ID` ON `IMAGE` ( `APPLICATION_ID` );

CREATE INDEX `IDX_IMAGE_FK1` ON `IMAGE` ( `SERIES_ID` );

CREATE INDEX `IDX_IMAGE_REVISION_NUMBER` ON `IMAGE` ( `REVISION_NUMBER` );

CREATE INDEX `IDX_IMAGE_SOP_INSTANCE_UID` ON `IMAGE` ( `SOP_INSTANCE_UID` );

CREATE INDEX `IDX_IMAGE_THUMBNAIL_ASSET_ID` ON `IMAGE` ( `THUMBNAIL_ASSET_ID` );

CREATE INDEX `IMAGE_DATE_UPLOADED_INDEX` ON `IMAGE` ( `DATE_UPLOADED` );

CREATE INDEX `IMAGE_INDEX` ON `IMAGE` ( `IMAGE_ASSET_ID` );

CREATE INDEX `IMAGE_MEDIUM_JPEG_ASSET_ID_INDEX` ON `IMAGE` ( `MEDIUM_JPEG_ASSET_ID` );

CREATE TABLE `MESSAGING_STATUS` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`IMAGE_ASSET_ID`     varchar(255)  NOT NULL    ,
	`MESSAGING_SUBSCRIPTION_ID` varchar(255)      ,
	`STATUS`             varchar(255)      ,
	`CREATE_TIMESTAMP`   timestamp  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	`VERB`               varchar(255)      ,
	`STATUS_TEXT`        varchar(10240)      ,
	`HTTP_RESPONSE_CODE` varchar(100)      ,
	`RETRY_COUNT`        varchar(100)      
 );

CREATE INDEX `IMAGE_ASSET_ID` ON `MESSAGING_STATUS` ( `IMAGE_ASSET_ID` );

CREATE INDEX `MESSAGING_SUBSCRIPTION_ID` ON `MESSAGING_STATUS` ( `MESSAGING_SUBSCRIPTION_ID` );

CREATE TABLE `NORMAL_IMAGE` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`IMAGE_ID`           varchar(255)  NOT NULL    ,
	`SOURCE_IMAGE_ASSET_ID` varchar(255)      ,
	`SHOT_ID`            varchar(255)  NOT NULL    ,
	`SAP_ID`             varchar(255)  NOT NULL    ,
	`PRE_SIGNED_THUMBNAIL_URL` varchar(1000)      ,
	`PRE_SIGNED_MEDIUM_JPEG_URL` varchar(1000)      ,
	`ASSET_LARGE_ID`     varchar(255)  NOT NULL    ,
	`SPECIES_ID`         varchar(100)  NOT NULL    ,
	`BREED_ID`           varchar(100)      ,
	`ANIMAL_SIZE_ID`     varchar(100)      ,
	`LIFE_STAGE_ID`      varchar(255)      ,
	`VIEW_COUNT`         int  NOT NULL DEFAULT 0   ,
	`IMAGE_KEYWORD`      varchar(255)      ,
	`IMAGE_TITLE`        varchar(500)      ,
	`IMAGE_TYPE_NORMAL`  boolean  NOT NULL DEFAULT 1   ,
	`SHARED`             boolean   DEFAULT 0   ,
	`IDEXX_PROVIDED_REFERENCE_IMAGE` boolean   DEFAULT 0   ,
	`FILE_TYPE`          varchar(100)      ,
	`WINDOW_WIDTH`       int   DEFAULT 0   ,
	`WINDOW_CENTER`      int   DEFAULT 0   ,
	`ANNOTATION_DATA`    longtext      ,
	`INVERTED`           boolean   DEFAULT 0   ,
	`ORIENTATION`        int   DEFAULT 0   ,
	`CALIBRATED`         boolean   DEFAULT 0   ,
	`X_DPI`              float(12,0)   DEFAULT 96   ,
	`Y_DPI`              float(12,0)   DEFAULT 96   ,
	`CROP_X1`            float(12,0)   DEFAULT 0   ,
	`CROP_Y1`            float(12,0)   DEFAULT 0   ,
	`CROP_X2`            float(12,0)   DEFAULT 0   ,
	`CROP_Y2`            float(12,0)   DEFAULT 0   ,
	`CROP_X3`            float(12,0)   DEFAULT 0   ,
	`CROP_Y3`            float(12,0)   DEFAULT 0   ,
	`CROP_X4`            float(12,0)   DEFAULT 0   ,
	`CROP_Y4`            float(12,0)   DEFAULT 0   ,
	`BODY_PART_EXAMINED` varchar(64)      ,
	`VIEW_POSITION`      varchar(64)      ,
	`PIXEL_REPRESENTATION` int   DEFAULT 0   ,
	`RESCALE_INTERCEPT`  float(12,0)   DEFAULT 0   ,
	`RESCALE_SLOPE`      float(12,0)   DEFAULT 1   ,
	`IMAGE_WIDTH`        int   DEFAULT 0   ,
	`IMAGE_HEIGHT`       int   DEFAULT 0   ,
	`PHOTOMETRIC_INTERPRETATION` varchar(64)      ,
	`HIGHBIT`            int   DEFAULT 0   ,
	`NUM_FRAMES`         int   DEFAULT 0   ,
	`MANUFACTURER`       varchar(255)      ,
	`MANUFACTURER_MODEL` varchar(255)      ,
	`MODALITY`           varchar(20)      ,
	`INSTANCE_NUMBER`    int   DEFAULT 0   ,
	`CREATE_TIMESTAMP`   timestamp   DEFAULT CURRENT_TIMESTAMP   ,
	`UPDATE_TIMESTAMP`   timestamp   DEFAULT CURRENT_TIMESTAMP   ,
	CONSTRAINT `UQ_IMAGE_ID` UNIQUE ( `IMAGE_ID` ) 
 );

CREATE INDEX `FK_NORMAL_IMAGE_ANIMAL_SIZE` ON `NORMAL_IMAGE` ( `ANIMAL_SIZE_ID` );

CREATE INDEX `FK_NORMAL_IMAGE_ASSET_LARGE` ON `NORMAL_IMAGE` ( `ASSET_LARGE_ID` );

CREATE INDEX `FK_NORMAL_IMAGE_BREED_ID` ON `NORMAL_IMAGE` ( `SPECIES_ID`, `BREED_ID` );

CREATE INDEX `FK_NORMAL_IMAGE_LIFE_STAGE` ON `NORMAL_IMAGE` ( `LIFE_STAGE_ID` );

CREATE INDEX `FK_NORMAL_IMAGE_NORMAL_SHOT` ON `NORMAL_IMAGE` ( `SHOT_ID` );

CREATE INDEX idx_normal_image_source_image_asset_id ON `NORMAL_IMAGE` ( `SOURCE_IMAGE_ASSET_ID` );

CREATE TABLE `RADIOLOGY_LOG` ( 
	`ID`                 varchar(255)  NOT NULL    PRIMARY KEY,
	`SAP_ID`             varchar(255)  NOT NULL    ,
	`PATIENT_ID`         varchar(255)      ,
	`IMAGE_TIMESTAMP`    datetime      ,
	`APPLICATION_CLIENT_ID` varchar(255)      ,
	`CLIENT_LAST_NAME`   varchar(255)      ,
	`IMAGE_ID`           varchar(255)      ,
	`VIEW_POSITION`      varchar(64)      ,
	`MODALITY`           varchar(20)      ,
	`BODY_PART_THICKNESS` float(12,0)      ,
	`KVP`                float(12,0)      ,
	`EXPOSURE_TIME`      float(12,0)      ,
	`EXPOSURE_MA`        float(12,0)      ,
	`EXPOSURE_MAS`       float(12,0)      ,
	`USE_OF_GRID`        boolean  NOT NULL DEFAULT 0   ,
	`SEDATION_LEVEL`     varchar(255)      ,
	`VETERINARIAN`       varchar(255)      ,
	`OPERATOR_ID_1`      varchar(255)      ,
	`OPERATOR_ID_2`      varchar(255)      ,
	`OPERATOR_ID_3`      varchar(255)      ,
	`CREATE_TIMESTAMP`   datetime      ,
	`UPDATE_TIMESTAMP`   datetime      ,
	`APPLICATION_PATIENT_ID` varchar(255)      ,
	`PATIENT_NAME`       varchar(100)      ,
	`SPECIES`            varchar(500)      ,
	`BREED`              varchar(500)      
 );

CREATE INDEX `FK_RADIOLOGY_LOG_IMAGE` ON `RADIOLOGY_LOG` ( `IMAGE_ID` );

CREATE INDEX `FK_RADIOLOGY_LOG_PATIENT` ON `RADIOLOGY_LOG` ( `PATIENT_ID` );

CREATE INDEX `IDX_APPLICATION_CLIENT_ID` ON `RADIOLOGY_LOG` ( `APPLICATION_CLIENT_ID` );

CREATE INDEX `IDX_CLIENT_LAST_NAME` ON `RADIOLOGY_LOG` ( `CLIENT_LAST_NAME` );

CREATE INDEX `IDX_IMAGE_TIMESTAMP` ON `RADIOLOGY_LOG` ( `SAP_ID`, `IMAGE_TIMESTAMP` );

CREATE INDEX `IDX_SAP_ID` ON `RADIOLOGY_LOG` ( `SAP_ID` );

CREATE INDEX `IDX_APPLICATION_PATIENT_ID` ON `RADIOLOGY_LOG` ( `APPLICATION_PATIENT_ID` );

CREATE INDEX `IDX_PATIENT_NAME` ON `RADIOLOGY_LOG` ( `PATIENT_NAME` );

CREATE TABLE `CUSTOM_ATTRIBUTES` ( 
	`ID`                 varchar(255)  NOT NULL DEFAULT ''   PRIMARY KEY,
	`IMAGE_ID`           varchar(255)  NOT NULL    ,
	`NAME`               varchar(512)      ,
	`VALUE`              varchar(10240)      
 );

CREATE INDEX `IDX_CUSTOM_ATTRIBUTES_FK0` ON `CUSTOM_ATTRIBUTES` ( `IMAGE_ID` );

CREATE  PROCEDURE `deletePatient`()
DELETE FROM amdb_qa01.CUSTOM_ATTRIBUTES WHERE IMAGE_ID IN (SELECT ID FROM amdb_qa01.IMAGE WHERE SERIES_ID IN (SELECT ID FROM amdb_qa01.SERIES WHERE STUDY_ID IN (SELECT ID FROM amdb_qa01.STUDY WHERE PATIENT_ID= (SELECT ID FROM amdb_qa01.PATIENT WHERE NAME='autoPatient' and SAP_ID= 999575))));

CREATE  PROCEDURE `dowhile`()
BEGIN
DECLARE _rows INT DEFAULT 0;
  SET _rows = (SELECT count(*) FROM STUDY WHERE PATIENT_ID= (SELECT ID FROM amdb_qa01.PATIENT WHERE NAME='autoPatient' and SAP_ID= 999575)); 

  WHILE _rows > 0 DO
    SELECT * FROM SERIES WHERE STUDY_ID = (SELECT * FROM STUDY WHERE PATIENT_ID= (SELECT ID FROM amdb_qa01.PATIENT WHERE NAME='autoPatient' and SAP_ID= 999575)) limit _rows,_rows;
    SET _rows = _rows - 1;
  END WHILE;
END

CREATE VIEW amdb_qa01.BREED_VIEW AS select distinct `amdb_qa01`.`PATIENT`.`BREED` AS `BREED`,`amdb_qa01`.`PATIENT`.`SAP_ID` AS `SAP_ID`,`amdb_qa01`.`PATIENT`.`SPECIES` AS `SPECIES` from `amdb_qa01`.`PATIENT` order by `amdb_qa01`.`PATIENT`.`SAP_ID`,`amdb_qa01`.`PATIENT`.`SPECIES`,`amdb_qa01`.`PATIENT`.`BREED`;

CREATE VIEW amdb_qa01.DOCTOR_VIEW AS select distinct `amdb_qa01`.`STUDY`.`DOCTOR` AS `DOCTOR`,`amdb_qa01`.`PATIENT`.`SAP_ID` AS `SAP_ID` from (`amdb_qa01`.`PATIENT` join `amdb_qa01`.`STUDY`) where (`amdb_qa01`.`STUDY`.`PATIENT_ID` = `amdb_qa01`.`PATIENT`.`ID`) order by `amdb_qa01`.`PATIENT`.`SAP_ID`,`amdb_qa01`.`STUDY`.`DOCTOR`;

CREATE VIEW amdb_qa01.GENDER_VIEW AS select distinct `amdb_qa01`.`PATIENT`.`GENDER` AS `GENDER`,`amdb_qa01`.`PATIENT`.`SAP_ID` AS `SAP_ID` from `amdb_qa01`.`PATIENT` order by `amdb_qa01`.`PATIENT`.`SAP_ID`,`amdb_qa01`.`PATIENT`.`GENDER`;

CREATE VIEW amdb_qa01.MODALITY_VIEW AS select distinct `amdb_qa01`.`SERIES`.`DICOM_MODALITY` AS `DICOM_MODALITY`,`amdb_qa01`.`PATIENT`.`SAP_ID` AS `SAP_ID` from ((`amdb_qa01`.`PATIENT` join `amdb_qa01`.`STUDY`) join `amdb_qa01`.`SERIES`) where ((`amdb_qa01`.`STUDY`.`PATIENT_ID` = `amdb_qa01`.`PATIENT`.`ID`) and (`amdb_qa01`.`SERIES`.`STUDY_ID` = `amdb_qa01`.`STUDY`.`ID`)) order by `amdb_qa01`.`PATIENT`.`SAP_ID`,`amdb_qa01`.`SERIES`.`DICOM_MODALITY`;

CREATE VIEW amdb_qa01.SPECIES_VIEW AS select distinct `amdb_qa01`.`PATIENT`.`SPECIES` AS `SPECIES`,`amdb_qa01`.`PATIENT`.`SAP_ID` AS `SAP_ID` from `amdb_qa01`.`PATIENT` order by `amdb_qa01`.`PATIENT`.`SAP_ID`,`amdb_qa01`.`PATIENT`.`SPECIES`;

CREATE VIEW amdb_qa01.dicom_im_mapping_view AS select `DIMN`.`ID` AS `ID`,`DIMN`.`DCM_TAG_ID` AS `DCM_TAG_ID`,`DIMN`.`IM_FIELD_NAME` AS `IM_FIELD_NAME`,`DIMN`.`IM_CHILD_FIELD_NAME` AS `IM_CHILD_FIELD_NAME`,`DIMN`.`required` AS `required`,`IDC`.`component_name` AS `component_name`,`IDC`.`request_type` AS `request_type` from ((`amdb_qa01`.`dcm_im_mapping` `DIMN` join `amdb_qa01`.`dcm_component_im_mapping` `DCFM`) join `amdb_qa01`.`idx_dicom_components` `IDC`) where ((`IDC`.`id` = `DCFM`.`idx_component_id`) and (`DIMN`.`ID` = `DCFM`.`dcm_mapping_id`) and (`DIMN`.`Enabled` = 1));

CREATE VIEW amdb_qa01.dicomimmappings AS select `DIMN`.`ID` AS `ID`,`DIMN`.`DCM_TAG_ID` AS `DCM_TAG_ID`,`DIMN`.`IM_FIELD_NAME` AS `IM_FIELD_NAME`,`DIMN`.`IM_CHILD_FIELD_NAME` AS `IM_CHILD_FIELD_NAME`,`DIMN`.`required` AS `required`,`IDC`.`component_name` AS `component_name`,`IDC`.`request_type` AS `request_type` from ((`amdb_qa01`.`dcm_im_mappings` `DIMN` join `amdb_qa01`.`dcm_component_field_mapping` `DCFM`) join `amdb_qa01`.`idx_dicom_components` `IDC`) where ((`IDC`.`id` = `DCFM`.`idx_component_id`) and (`DIMN`.`ID` = `DCFM`.`dcm_mapping_id`) and (`DIMN`.`Enabled` = 1));

ALTER TABLE `APPLICATION_LEVEL_DAYS` ADD CONSTRAINT `IDX_APPLICATION_LEVEL_DAYS_FK0` FOREIGN KEY ( `APPLICATION_ID` ) REFERENCES `APPLICATION`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `ASSET` ADD CONSTRAINT `IDX_ASSET_FK0` FOREIGN KEY ( `PROVIDER_ID`, `PROVIDER_STORAGE_LEVEL` ) REFERENCES `PROVIDER_LEVEL`( `PROVIDER_ID`, `PROVIDER_LEVEL` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `BREED` ADD CONSTRAINT `BREED_ibfk_1` FOREIGN KEY ( `SPECIES_ID` ) REFERENCES `SPECIES`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `CLIENT` ADD CONSTRAINT `CLIENT_ibfk_1` FOREIGN KEY ( `SAP_ID` ) REFERENCES `CLINIC`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `CLINIC_PROPERTY` ADD CONSTRAINT `CLINIC_PROPERTY_FK1` FOREIGN KEY ( `CLINIC_ID` ) REFERENCES `CLINIC`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `CUSTOMER_SHOT` ADD CONSTRAINT fk_customer_shot_shot FOREIGN KEY ( `SHOT_ID` ) REFERENCES `SHOT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `CUSTOM_ATTRIBUTES` ADD CONSTRAINT `IDX_CUSTOM_ATTRIBUTES_FK0` FOREIGN KEY ( `IMAGE_ID` ) REFERENCES `IMAGE`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `DEFAULT_LEVEL` ADD CONSTRAINT `IDX_DEFAULT_LEVEL_FK0` FOREIGN KEY ( `PROVIDER_ID` ) REFERENCES `PROVIDER`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `DS_MAPPING_RULE_ACTIONS` ADD CONSTRAINT `FK_DS_MAPPING_RULE_ACTIONS` FOREIGN KEY ( `DS_MAPPING_RULE_ID` ) REFERENCES `DS_MAPPING_RULE`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `DS_MAPPING_RULE_TRIGGERS` ADD CONSTRAINT `FK_DS_MAPPING_RULE_TRIGGERS` FOREIGN KEY ( `DS_MAPPING_RULE_ID` ) REFERENCES `DS_MAPPING_RULE`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `EXTERNAL_PATIENT_LINK` ADD CONSTRAINT `EXTERNAL_PATIENT_LINK_ibfk_1` FOREIGN KEY ( `PATIENT_ID` ) REFERENCES `PATIENT`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `IMAGE` ADD CONSTRAINT `IDX_IMAGE_FK1` FOREIGN KEY ( `SERIES_ID` ) REFERENCES `SERIES`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `IMAGE_ML` ADD CONSTRAINT `FK_IMAGE_ML_ASSET` FOREIGN KEY ( `IMAGE_ASSET_ID` ) REFERENCES `ASSET`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `IMAGE_UPDATE` ADD CONSTRAINT `FK_IMAGE_UPDATE_ASSET` FOREIGN KEY ( `IMAGE_ASSET_ID` ) REFERENCES `ASSET`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `MESSAGING_STATUS` ADD CONSTRAINT `MESSAGING_STATUS_ibfk_1` FOREIGN KEY ( `IMAGE_ASSET_ID` ) REFERENCES `IMAGE`( `IMAGE_ASSET_ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `MESSAGING_STATUS` ADD CONSTRAINT `MESSAGING_STATUS_ibfk_2` FOREIGN KEY ( `MESSAGING_SUBSCRIPTION_ID` ) REFERENCES `MESSAGING_SUBSCRIPTION`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `MESSAGING_SUBSCRIPTION_APPLICATIONS` ADD CONSTRAINT `MESSAGING_SUBSCRIPTION_APPLICATIONS_ibfk_2` FOREIGN KEY ( `APPLICATION_ID` ) REFERENCES `APPLICATION`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `MESSAGING_SUBSCRIPTION_APPLICATIONS` ADD CONSTRAINT `MESSAGING_SUBSCRIPTION_APPLICATIONS_ibfk_1` FOREIGN KEY ( `MESSAGING_SUBSCRIPTION_ID` ) REFERENCES `MESSAGING_SUBSCRIPTION`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `MESSAGING_SUBSCRIPTION_BLACKLIST` ADD CONSTRAINT `MESSAGING_SUBSCRIPTION_BLACKLIST_ibfk_2` FOREIGN KEY ( `SAP_ID` ) REFERENCES `CLINIC`( `ID` ) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `MESSAGING_SUBSCRIPTION_BLACKLIST` ADD CONSTRAINT `MESSAGING_SUBSCRIPTION_BLACKLIST_ibfk_1` FOREIGN KEY ( `MESSAGING_SUBSCRIPTION_ID` ) REFERENCES `MESSAGING_SUBSCRIPTION`( `ID` ) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `MESSAGING_SUBSCRIPTION_WHITELIST` ADD CONSTRAINT `MESSAGING_SUBSCRIPTION_WHITELIST_ibfk_1` FOREIGN KEY ( `MESSAGING_SUBSCRIPTION_ID` ) REFERENCES `MESSAGING_SUBSCRIPTION`( `ID` ) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `ML_DATASET_ITEM` ADD CONSTRAINT `FK_ML_DATASET_ITEM_ML_DATASET` FOREIGN KEY ( `DATASET_ID` ) REFERENCES `ML_DATASET`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_DATASET_REVIEW` ADD CONSTRAINT `FK_ML_DATASET_REVIEW_ML_DATASET` FOREIGN KEY ( `DATASET_ID` ) REFERENCES `ML_DATASET`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_LABEL_JOB` ADD CONSTRAINT `FK_ML_LABEL_JOB_ML_DATASET` FOREIGN KEY ( `DATASET_ID` ) REFERENCES `ML_DATASET`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_LABEL_JOB` ADD CONSTRAINT `FK_ML_LABEL_JOB_ML_LABELSET` FOREIGN KEY ( `LABELSET_ID` ) REFERENCES `ML_LABELSET`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_LABEL_JOB_ITEM` ADD CONSTRAINT `FK_ML_LABEL_JOB_ITEM_ML_DATASET_ITEM` FOREIGN KEY ( `DATASET_ITEM_ID` ) REFERENCES `ML_DATASET_ITEM`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_LABEL_JOB_ITEM` ADD CONSTRAINT `FK_ML_LABEL_JOB_ITEM_ML_LABEL_JOB` FOREIGN KEY ( `JOB_ID` ) REFERENCES `ML_LABEL_JOB`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_LABEL_JOB_ITEM_REVIEW` ADD CONSTRAINT `FK_ML_LABEL_JOB_ITEM_REVIEW_ML_DATASET_ITEM` FOREIGN KEY ( `DATASET_ITEM_ID` ) REFERENCES `ML_DATASET_ITEM`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_LABEL_JOB_ITEM_REVIEW` ADD CONSTRAINT `FK_ML_LABEL_JOB_ITEM_REVIEW_ML_LABEL_JOB` FOREIGN KEY ( `JOB_ID` ) REFERENCES `ML_LABEL_JOB`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_PREDICTION_REVIEW` ADD CONSTRAINT `FK_ML_PREDICTION_REVIEW_ASSET` FOREIGN KEY ( `IMAGE_ASSET_ID` ) REFERENCES `ASSET`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ML_PREDICTION_REVIEW` ADD CONSTRAINT `FK_ML_PREDICTION_REVIEW_ML_DATASET` FOREIGN KEY ( `DATASET_ID` ) REFERENCES `ML_DATASET`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `NORMAL_ANIMAL_SIZE` ADD CONSTRAINT `FK_NORMAL_ANIMAL_SIZE_SPECIES` FOREIGN KEY ( `SPECIES_ID` ) REFERENCES `SPECIES`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_ASSET_LARGE` FOREIGN KEY ( `ASSET_LARGE_ID` ) REFERENCES `ASSET`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_BREED_ID` FOREIGN KEY ( `SPECIES_ID`, `BREED_ID` ) REFERENCES `BREED`( `SPECIES_ID`, `BREED_ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_IMAGE` FOREIGN KEY ( `IMAGE_ID` ) REFERENCES `IMAGE`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_ANIMAL_SIZE` FOREIGN KEY ( `ANIMAL_SIZE_ID` ) REFERENCES `NORMAL_ANIMAL_SIZE`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_LIFE_STAGE` FOREIGN KEY ( `LIFE_STAGE_ID` ) REFERENCES `NORMAL_LIFE_STAGE`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_NORMAL_SHOT` FOREIGN KEY ( `SHOT_ID` ) REFERENCES `NORMAL_SHOT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_IMAGE` ADD CONSTRAINT `FK_NORMAL_IMAGE_SPECIES` FOREIGN KEY ( `SPECIES_ID` ) REFERENCES `SPECIES`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_LIFE_STAGE` ADD CONSTRAINT `FK_NORMAL_LIFE_STAGE_SPECIES` FOREIGN KEY ( `SPECIES_ID` ) REFERENCES `SPECIES`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_SHOT` ADD CONSTRAINT fk_normal_shot_shot FOREIGN KEY ( `SHOT_ID` ) REFERENCES `SHOT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `NORMAL_SHOT` ADD CONSTRAINT `FK_NORMAL_SHOT_SPECIES` FOREIGN KEY ( `SPECIES_ID` ) REFERENCES `SPECIES`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `OWNER` ADD CONSTRAINT `OWNER_ibfk_2` FOREIGN KEY ( `CLIENT_ID` ) REFERENCES `CLIENT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `OWNER` ADD CONSTRAINT `OWNER_ibfk_1` FOREIGN KEY ( `PATIENT_ID` ) REFERENCES `PATIENT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `PATIENT` ADD CONSTRAINT `IDX_PATIENT_FK3` FOREIGN KEY ( `SAP_ID` ) REFERENCES `CLINIC`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `PROVIDER_LEVEL` ADD CONSTRAINT `IDX_PROVIDER_LEVEL_FK0` FOREIGN KEY ( `PROVIDER_ID` ) REFERENCES `PROVIDER`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `RADIOLOGY_LOG` ADD CONSTRAINT `FK_RADIOLOGY_LOG_IMAGE` FOREIGN KEY ( `IMAGE_ID` ) REFERENCES `IMAGE`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `RADIOLOGY_LOG` ADD CONSTRAINT `FK_RADIOLOGY_LOG_PATIENT` FOREIGN KEY ( `PATIENT_ID` ) REFERENCES `PATIENT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `REQUEST_DETAILS` ADD CONSTRAINT `REQDET_FK` FOREIGN KEY ( `PATIENT_ID` ) REFERENCES `PATIENT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `REQUEST_DETAILS_LINK` ADD CONSTRAINT fk_request_details_link_request_details FOREIGN KEY ( `REQUEST_DETAILS_ID` ) REFERENCES `REQUEST_DETAILS`( `ID` ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `SERIES` ADD CONSTRAINT `IDX_SERIES_FK0` FOREIGN KEY ( `STUDY_ID` ) REFERENCES `STUDY`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `SHOT_CLASS_MINOR` ADD CONSTRAINT fk_shot_class_minor_shot_class_major FOREIGN KEY ( `SHOT_CLASS_MAJOR` ) REFERENCES `SHOT_CLASS_MAJOR`( `NAME` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `STUDY` ADD CONSTRAINT `IDX_STUDY_FK3` FOREIGN KEY ( `PATIENT_ID` ) REFERENCES `PATIENT`( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE authorities ADD CONSTRAINT fk_authorities_users FOREIGN KEY ( username ) REFERENCES users( username ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE dcm_component_field_mapping ADD CONSTRAINT `FK_dcm_component_field_mapping_1` FOREIGN KEY ( dcm_mapping_id ) REFERENCES dcm_im_mappings( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE dcm_component_field_mapping ADD CONSTRAINT `FK_dcm_component_field_mapping_2` FOREIGN KEY ( idx_component_id ) REFERENCES idx_dicom_components( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE dcm_component_im_mapping ADD CONSTRAINT `FK_dcm_component_im_mapping_1` FOREIGN KEY ( dcm_mapping_id ) REFERENCES dcm_im_mapping( `ID` ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE dcm_component_im_mapping ADD CONSTRAINT `FK_dcm_component_im_mapping_2` FOREIGN KEY ( idx_component_id ) REFERENCES idx_dicom_components( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

