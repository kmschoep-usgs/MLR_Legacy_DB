create table mlr_legacy_data.legacy_location
(legacy_location_id             bigserial               primary key
,agency_cd                      character(5)            not null
,site_no                        character(15)           not null
,station_nm                     character varying(50)   not null default ' '
,station_ix                     character varying(50)   not null default ' '
,lat_va                         character(11)           not null default ' '
,long_va                        character(12)           not null default ' '
,dec_lat_va                     numeric
,dec_long_va                    numeric
,coord_meth_cd                  character(1)            not null default ' '
,coord_acy_cd                   character(1)            not null default ' '
,coord_datum_cd                 character(10)           not null default ' '
,district_cd                    character(3)            not null default ' '
,land_net_ds                    character varying(23)   not null default ' '
,map_nm                         character varying(20)   not null default ' '
,country_cd                     character(2)            not null default ' '
,state_cd                       character(2)            not null default ' '
,county_cd                      character(3)            not null default ' '
,map_scale_fc                   character(7)            not null default ' '
,alt_va                         character(8)            not null default ' '
,alt_meth_cd                    character(1)            not null default ' '
,alt_acy_va                     character(3)            not null default ' '
,alt_datum_cd                   character(10)           not null default ' '
,huc_cd                         character varying(16)   not null default ' '
,agency_use_cd                  character(1)            not null default ' '
,basin_cd                       character(2)            not null default ' '
,site_tp_cd                     character varying(7)    not null default ' '
,topo_cd                        character(1)            not null default ' '
,data_types_cd                  character(30)           not null default ' '
,instruments_cd                 character(30)           not null default ' '
,site_rmks_tx                   character varying(50)   not null default ' '
,inventory_dt                   character(8)            not null default ' '
,drain_area_va                  character(8)            not null default ' '
,contrib_drain_area_va          character(8)            not null default ' '
,tz_cd                          character(6)            not null default ' '
,local_time_fg                  character(1)            not null default ' '
,gw_file_cd                     character(30)           not null default ' '
,construction_dt                character(8)            not null default ' '
,reliability_cd                 character(1)            not null default ' '
,aqfr_cd                        character(8)            not null default ' '
,nat_aqfr_cd                    character(10)           not null default ' '
,site_use_1_cd                  character(1)            not null default ' '
,site_use_2_cd                  character(1)            not null default ' '
,site_use_3_cd                  character(1)            not null default ' '
,water_use_1_cd                 character(1)            not null default ' '
,water_use_2_cd                 character(1)            not null default ' '
,water_use_3_cd                 character(1)            not null default ' '
,nat_water_use_cd               character(2)            not null default ' '
,aqfr_type_cd                   character(1)            not null default ' '
,well_depth_va                  character(8)            not null default ' '
,hole_depth_va                  character(8)            not null default ' '
,depth_src_cd                   character(1)            not null default ' '
,project_no                     character(12)           not null default ' '
,site_web_cd                    character(1)            not null default ' '
,site_cn                        character(8)            not null
,site_cr                        timestamp               not null
,site_mn                        character(8)            not null
,site_md                        timestamp               not null
,mcd_cd                         character(5)
,constraint legacy_location_ak
  unique (agency_cd, site_no)
);
alter table mlr_legacy_data.legacy_location owner to mlr_legacy_data;
